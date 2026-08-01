#!/usr/bin/env python3
"""Alignment analysis: ICD-10-CM chapter XVII (Q00-Q99) vs Mondo.

Produces the data behind the four workstreams:
  1. missing exactMatch candidates
  2. audit of existing (mostly Orphanet-derived) Q xrefs
  3. new-term candidates
  4. scope/exclusion policy buckets
"""
import re, csv, json, collections, os

D = os.path.dirname(os.path.abspath(__file__))
TMP = "/tmp"
EDIT = os.environ.get(
    "MONDO_EDIT", "/Users/cjm/worktrees/icd10cm/src/ontology/mondo-edit.obo")
OUT = os.environ.get("OUT_DIR", D)

# ---------------------------------------------------------------- ICD10CM ---
labels = {}
for row in csv.reader(open(f"{TMP}/q_label.tsv"), delimiter="\t"):
    if len(row) == 2:
        labels[row[0]] = row[1]

syns = collections.defaultdict(set)
for row in csv.reader(open(f"{TMP}/q_syn.tsv"), delimiter="\t"):
    if len(row) == 2:
        syns[row[0]].add(row[1])

parent = {}
children = collections.defaultdict(list)
for row in csv.reader(open(f"{TMP}/q_parent.tsv"), delimiter="\t"):
    if len(row) == 2:
        parent[row[0]] = row[1]
        children[row[1]].append(row[0])

ICD = sorted(labels)


def depth(c):
    d, seen = 0, set()
    while c in parent and c not in seen:
        seen.add(c)
        c = parent[c]
        d += 1
    return d


# ------------------------------------------------------------------ Mondo ---
class M:
    __slots__ = ("id", "name", "syn", "xrefs", "obs")

    def __init__(self, i):
        self.id, self.name, self.obs = i, None, False
        self.syn, self.xrefs = [], []


terms, cur = [], None
for line in open(EDIT):
    line = line.rstrip("\n")
    if line == "[Term]":
        cur = M(None)
        terms.append(cur)
        continue
    if cur is None:
        continue
    if m := re.match(r"^id: (MONDO:\d+)$", line):
        cur.id = m.group(1)
    elif m := re.match(r"^name: (.+)$", line):
        cur.name = m.group(1)
    elif line.startswith("is_obsolete: true"):
        cur.obs = True
    elif m := re.match(r'^synonym: "((?:[^"\\]|\\.)*)" (\w+)', line):
        cur.syn.append((m.group(1), m.group(2)))
    elif m := re.match(r"^xref: (ICD10CM:[^\s]+)(.*)$", line):
        cur.xrefs.append((m.group(1), m.group(2)))

terms = [t for t in terms if t.id]
live = [t for t in terms if not t.obs]
by_id = {t.id: t for t in terms}

# ------------------------------------------------------------ normalisation -
STOP = re.compile(
    r"\b(nos|nec|not elsewhere classified|not otherwise specified|unspecified)\b")


def base(s):
    s = s.lower().replace("&", " and ")
    s = STOP.sub(" ", s)
    s = re.sub(r"\(.*?\)", " ", s)
    s = re.sub(r"[^a-z0-9]+", " ", s)
    return " ".join(s.split())


# tier A: conservative. only drop 'congenital' and plural/possessive noise.
def normA(s):
    s = base(s)
    s = re.sub(r"\bcongenital(ly)?\b", " ", s)
    s = re.sub(r"\b(\w+?)s\b", r"\1", s)          # crude singularise
    return " ".join(s.split())


# tier B: also drop generic head nouns + reorder. catches "X of Y" vs "Y X".
HEAD = re.compile(
    r"\b(disease|disorder|malformation|deformation|deformity|anomaly|anomalie|"
    r"defect|condition|of|the|with|and|or|type|other|specified)\b")


def normB(s):
    s = HEAD.sub(" ", normA(s))
    return " ".join(sorted(set(s.split())))


mondo_A, mondo_B = collections.defaultdict(set), collections.defaultdict(set)
for t in live:
    forms = [(t.name, "name")] + [(s, sc) for s, sc in t.syn
                                  if sc in ("EXACT", "NARROW")]
    for s, sc in forms:
        if not s:
            continue
        mondo_A[normA(s)].add((t.id, s, sc))
        mondo_B[normB(s)].add((t.id, s, sc))

hp_A = collections.defaultdict(set)
for row in csv.reader(open(f"{TMP}/hp_lex.tsv"), delimiter="\t"):
    if len(row) == 2:
        hp_A[normA(row[1])].add((row[0], row[1]))

# ------------------------------------------------------- existing Q xrefs ---
# code -> list of (mondo_id, qualifier_string, obsolete)
xref_by_code = collections.defaultdict(list)
for t in terms:
    for code, qual in t.xrefs:
        if code.startswith("ICD10CM:Q"):
            xref_by_code[code].append((t.id, qual, t.obs))


def predicate_of(qual):
    """Semantic mapping predicate asserted on an xref, if any.

    Match the MONDO: qualifier exactly. Substring matching would conflate
    'equivalentToOther' and 'equivalentToUnspecified' with 'equivalentTo',
    and 'obsoleteEquivalentObsolete' with 'obsoleteEquivalent'.
    """
    tags = set(re.findall(r'source="MONDO:(\w+)"', qual))
    for tag in ("equivalentTo", "relatedTo", "obsoleteEquivalent"):
        if tag in tags:
            return tag
    if "mondoIsNarrowerThanSource" in tags:
        return "narrowerThanSource"
    if "mondoIsBroaderThanSource" in tags:
        return "broaderThanSource"
    if tags:
        # a MONDO: qualifier we do not treat as a mapping predicate
        # (equivalentToOther, otherHierarchy, source registries, ...)
        for t in sorted(tags):
            if t[0].islower():
                return f"other-mondo-qualifier:{t}"
    if "/btnt" in qual:
        return "orphanet-btnt"
    if "/specific" in qual:
        return "orphanet-specific"
    if "/e" in qual:
        return "orphanet-exact"
    # no predicate at all -- pure provenance
    if re.search(r'source="Orphanet:\d+"', qual):
        return "provenance-only:orphanet"
    if re.search(r'source="DOID:', qual):
        return "provenance-only:doid"
    if "source=" in qual:
        return "provenance-only:other"
    return "unqualified"


SEMANTIC = {"equivalentTo", "relatedTo", "obsoleteEquivalent",
            "narrowerThanSource", "broaderThanSource",
            "orphanet-btnt", "orphanet-specific", "orphanet-exact"}


# --------------------------------------------------------- classification ---
RESIDUAL = re.compile(
    r"\bunspecified\b|\bother specified\b|^other\b"
    r"|\bother\b.*\b(malformation|deformit|anomal|defect|reduction|disorder|"
    r"condition|specified)", re.I)
LAT = re.compile(r"\b(right|left|bilateral|unilateral)\b", re.I)

# A container label names a bucket of conditions, not a condition. Having ICD
# children does NOT make a code a container -- Q35 'Cleft palate' has children
# but is genuinely equivalent to MONDO:0016064. Only the label tells us.
CONTAINER = re.compile(
    r"^congenital (malformations?|deformities|deformity|anomal)"
    r"|^congenital .{0,40}\b(malformations|deformities|anomalies)\b"
    r"|, not elsewhere classified$"
    r"|\band similar\b"
    r"|^congenital absence, atresia and stenosis of"
    r"|,.*\band\b",                      # enumerations: 'X, Y and Z'
    re.I)
GEN_TAIL = re.compile(
    r"\s*\b(disease|disorder|malformation|abnormality)s?"
    r"(\s+or\s+disorders?)?$", re.I)


GEN_LEAD = re.compile(
    r"^(disease|disorder|malformation|abnormality)s?\s+of\s+(the\s+)?", re.I)


def is_generic(label):
    """True for whole-disease-area labels ('pleura disease or disorder').

    Strip the generic noun -- trailing ('lens disorder') or leading
    ('disorder of pleura') -- and ask what is left: one or two tokens means it
    only names an anatomical site or system. A specific disease that merely
    ends in 'disease' ('autosomal dominant polycystic kidney disease') leaves
    several qualifying tokens behind.
    """
    for pat in (GEN_TAIL, GEN_LEAD):
        stripped, n = pat.subn("", label)
        if n and len(stripped.split()) <= 2:
            return True
    return False


# 'A and B' with children: might be a 2-item container (Q56 'Indeterminate sex
# and pseudohermaphroditism') or a real compound disease. Route to REVIEW.
AMBIG_CONJ = re.compile(r"\band\b", re.I)

rows = []
for c in ICD:
    lab = labels[c]
    kids = children.get(c, [])
    dep = depth(c)
    nA = normA(lab)

    # laterality only counts if a sibling differs solely by side
    lat = False
    if LAT.search(lab):
        stripped = " ".join(LAT.sub(" ", nA).split())
        sibs = children.get(parent.get(c, ""), [])
        for s in sibs:
            if s != c and " ".join(LAT.sub(" ", normA(labels[s])).split()) == stripped:
                lat = True
                break

    ambig = False
    if "-" in c.split(":", 1)[1]:
        bucket = "BLOCK"                      # Q00-Q07 style chapter container
    elif RESIDUAL.search(lab):
        bucket = "RESIDUAL"
    elif CONTAINER.search(lab):
        bucket = "CONTAINER"
    elif lat:
        bucket = "LATERALITY"
    elif nA in hp_A and nA not in mondo_A:
        bucket = "PHENOTYPE"
    else:
        bucket = "DISEASE"
        # conjunction + children => possibly a 2-item container, flag it
        ambig = bool(kids and AMBIG_CONJ.search(lab))

    # match against Mondo, tiered, using ICD label + ICD synonyms
    cands = []
    for form in [lab] + sorted(syns.get(c, [])):
        for tier, table, norm in (("A", mondo_A, normA), ("B", mondo_B, normB)):
            k = norm(form)
            if k and k in table:
                for mid, ml, sc in table[k]:
                    cands.append((tier, mid, ml, sc, form))
        if cands and cands[0][0] == "A":
            break
    tier = cands[0][0] if cands else "-"
    # prefer a name match over a synonym match within the best tier
    # include the label in the key so ties are broken deterministically
    best = sorted([x for x in cands if x[0] == tier],
                  key=lambda x: (x[3] != "name", x[1], x[2]))[0] if cands else None

    ex = xref_by_code.get(c, [])
    preds = sorted({predicate_of(q) for _, q, _ in ex})

    rows.append(dict(
        icd=c, icd_label=lab, depth=dep, n_children=len(kids),
        bucket=bucket, ambiguous_conjunction="YES" if ambig else "",
        n_existing_xrefs=len(ex),
        existing_predicates=";".join(preds),
        existing_mondo=";".join(sorted({m for m, _, o in ex if not o})[:5]),
        match_tier=tier,
        match_mondo=best[1] if best else "",
        match_mondo_label=best[2] if best else "",
        match_via=best[3] if best else "",
        match_icd_form=best[4] if best else "",
        n_match_cands=len({x[1] for x in cands}),
        hp_hit=";".join(sorted({h for h, _ in hp_A.get(nA, set())})[:3]),
    ))

with open(f"{OUT}/q_codes_classified.tsv", "w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=list(rows[0]), delimiter="\t", lineterminator="\n")
    w.writeheader()
    w.writerows(rows)

# ------------------------------------------------------------------ report --
def tally(key, rs=rows):
    return collections.Counter(r[key] for r in rs)

print("=== BUCKETS (all 1067 Q codes) ===")
for k, v in tally("bucket").most_common():
    print(f"{k:12} {v}")

print("\n=== BUCKET x has-any-existing-xref ===")
cc = collections.Counter((r["bucket"], r["n_existing_xrefs"] > 0) for r in rows)
for (b, has), n in sorted(cc.items()):
    print(f"{b:12} {'mapped' if has else 'UNMAPPED':9} {n}")

print("\n=== match tier for UNMAPPED codes, by bucket ===")
cc = collections.Counter((r["bucket"], r["match_tier"])
                         for r in rows if r["n_existing_xrefs"] == 0)
for (b, t), n in sorted(cc.items()):
    print(f"{b:12} tier {t}  {n}")

print("\n=== existing xref predicate distribution (Q codes) ===")
pc = collections.Counter()
for c, ex in xref_by_code.items():
    for _, q, _ in ex:
        pc[predicate_of(q)] += 1
for k, v in pc.most_common():
    print(f"{k:22} {v}")

# ============================================================== workstreams ==
byicd = {r["icd"]: r for r in rows}

# -- 1. missing exactMatch candidates ----------------------------------------
# in-scope bucket, no existing xref, confident lexical hit, unambiguous
ex_cand = []
for r in rows:
    if r["bucket"] != "DISEASE" or r["n_existing_xrefs"]:
        continue
    if r["match_tier"] == "-" or not r["match_mondo"]:
        continue
    ml, il = r["match_mondo_label"], r["icd_label"]
    mname = by_id[r["match_mondo"]].name or ml
    # ICD says congenital, Mondo doesn't => Mondo term may also cover acquired
    asym = ("congenital" in il.lower()) and ("congenital" not in mname.lower())
    # Only downgrade on lossy tier-B matches. At tier A the strings already
    # agree closely, so 'X syndrome' vs 'X disease' is a real exact match --
    # the token-count test would otherwise misread short eponyms as generic.
    if r["match_tier"] == "B" and is_generic(mname) and not is_generic(il):
        proposed, flag = "skos:broadMatch", "generic Mondo parent"
    elif r["n_match_cands"] > 1:
        proposed, flag = "REVIEW", f"{r['n_match_cands']} Mondo candidates"
    elif r["match_tier"] == "B":
        # tier B discards word order and connectives, so 'X with Y' and
        # 'X/Y' collapse together. Always a curator call.
        proposed, flag = "skos:exactMatch", "tier B: lossy match, verify"
    elif asym:
        proposed, flag = "skos:exactMatch", "Mondo term may include acquired"
    else:
        proposed, flag = "skos:exactMatch", ""
    ex_cand.append(dict(
        icd=r["icd"], icd_label=il, mondo=r["match_mondo"], mondo_label=mname,
        tier=r["match_tier"], matched_icd_form=r["match_icd_form"],
        matched_mondo_form=ml, mondo_form=r["match_via"],
        proposed=proposed, review_flag=flag,
    ))
ex_cand.sort(key=lambda x: (x["proposed"] != "skos:exactMatch",
                            x["review_flag"] != "", x["tier"], x["icd"]))

# -- 2. audit of existing xrefs ----------------------------------------------
audit = []
for c, ex in xref_by_code.items():
    r = byicd.get(c)
    if not r:
        continue                      # xref to a code outside the Q chapter dump
    live_ms = [(m, q) for m, q, o in ex if not o]
    card = len({m for m, _ in live_ms})
    for m, q in live_ms:
        pred = predicate_of(q)
        t = by_id[m]
        lex = "match" if normA(t.name or "") == normA(r["icd_label"]) else (
            "syn-match" if any(normA(s) == normA(r["icd_label"])
                               for s, sc in t.syn if sc in ("EXACT", "NARROW"))
            else "no")
        # verdict
        if r["bucket"] in ("RESIDUAL", "BLOCK", "CONTAINER"):
            verdict = ("DEMOTE->broadMatch" if pred == "equivalentTo"
                       else "KEEP-as-broadMatch")
            why = f"ICD code is {r['bucket']}; cannot be an exact equivalent"
        elif r["bucket"] == "PHENOTYPE":
            verdict = "REVIEW-phenotype"
            why = "ICD code is an HPO-domain phenotype, not a disease"
        elif pred == "equivalentTo":
            verdict = "OK"
            why = "already curated"
        elif r["ambiguous_conjunction"]:
            verdict = "REVIEW"
            why = "conjunctive label with children; may be a 2-item container"
        elif card > 1:
            verdict = "KEEP-as-broadMatch"
            why = f"{card} Mondo terms share this code; Mondo is narrower"
        elif lex in ("match", "syn-match"):
            verdict = "PROMOTE->exactMatch"
            why = f"1:1 and label {lex}"
        else:
            verdict = "REVIEW"
            why = "1:1 but labels differ; needs curator"
        audit.append(dict(
            icd=c, icd_label=r["icd_label"], bucket=r["bucket"],
            mondo=m, mondo_label=t.name, predicate=pred,
            cardinality=card, lexical=lex, verdict=verdict, rationale=why,
            qualifier=q.strip()))
audit.sort(key=lambda x: (x["verdict"], x["icd"]))

# -- 3. new-term candidates --------------------------------------------------
# Exact matching misses spelling variants ('septo-optic' vs 'septooptic') and
# labels carrying an extra site qualifier. Score a trigram nearest neighbour so
# 'probably already in Mondo' is separated from 'genuinely absent'.
forms = []                                   # (mondo_id, label, normA)
for t in live:
    for s, sc in [(t.name, "name")] + [(s, sc) for s, sc in t.syn
                                       if sc in ("EXACT", "NARROW")]:
        if s:
            forms.append((t.id, s, normA(s)))

tok_ix = collections.defaultdict(list)
for i, (_, _, n) in enumerate(forms):
    for tok in set(n.split()):
        tok_ix[tok].append(i)


def trig(s):
    s = "  " + s.replace(" ", "") + "  "
    return {s[i:i + 3] for i in range(len(s) - 2)}


form_trig = {}


def nearest(nA, k=3):
    toks = set(nA.split())
    if not toks:
        return []
    # union postings of the rarest tokens to keep the candidate pool small
    pool = set()
    for tok in sorted(toks, key=lambda x: len(tok_ix.get(x, ()))):
        p = tok_ix.get(tok, ())
        if pool and len(pool) + len(p) > 8000:
            break
        pool.update(p)
        if len(pool) > 4000:
            break
    qt = trig(nA)
    scored = []
    for i in pool:
        if i not in form_trig:
            form_trig[i] = trig(forms[i][2])
        ft = form_trig[i]
        j = len(qt & ft) / len(qt | ft)
        if j >= 0.55:
            scored.append((j, forms[i][0], forms[i][1]))
    scored.sort(reverse=True)
    out, seen_ids = [], set()
    for j, mid, lab in scored:
        if mid not in seen_ids:
            seen_ids.add(mid)
            out.append((j, mid, lab))
        if len(out) == k:
            break
    return out


new_cand = []
for r in rows:
    if (r["bucket"] != "DISEASE" or r["n_existing_xrefs"]
            or r["match_tier"] != "-"):
        continue
    nn = nearest(normA(r["icd_label"]))
    new_cand.append(dict(
        icd=r["icd"], icd_label=r["icd_label"],
        icd_parent=parent.get(r["icd"], ""),
        icd_parent_label=labels.get(parent.get(r["icd"], ""), ""),
        # Score cannot assert existence: 'scrotal transposition' scores 0.71
        # against 'penoscrotal transposition', a different condition. The
        # neighbour column is a lead for the curator, never a verdict.
        verdict="REVIEW-NEIGHBOURS" if nn else "NO-CLOSE-MATCH",
        nearest_score=f"{nn[0][0]:.2f}" if nn else "",
        nearest_mondo=nn[0][1] if nn else "",
        nearest_label=nn[0][2] if nn else "",
        other_neighbours="; ".join(f"{m} {l} ({j:.2f})" for j, m, l in nn[1:]),
        synonyms="; ".join(sorted(syns.get(r["icd"], []))[:4])))
new_cand.sort(key=lambda x: (x["verdict"], x["icd"]))

# -- 4. exclusion list -------------------------------------------------------
excl = [dict(icd=r["icd"], icd_label=r["icd_label"], bucket=r["bucket"],
             hp_equivalent=r["hp_hit"],
             currently_xreffed="YES" if r["n_existing_xrefs"] else "")
        for r in rows if r["bucket"] in ("RESIDUAL", "LATERALITY", "PHENOTYPE", "BLOCK", "CONTAINER")]
excl.sort(key=lambda x: (x["bucket"], x["icd"]))


def dump(name, data):
    if not data:
        return
    with open(f"{OUT}/{name}", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(data[0]), delimiter="\t", lineterminator="\n")
        w.writeheader()
        w.writerows(data)
    print(f"  {name:38} {len(data)}")


print("\n=== OUTPUT FILES ===")
dump("01_proposed_exactmatch.tsv", ex_cand)
dump("02_xref_audit.tsv", audit)
dump("03_new_term_candidates.tsv", new_cand)
dump("04_exclusion_list.tsv", excl)
dump("00_q_codes_classified.tsv", rows)

print("\n=== AUDIT VERDICTS ===")
for k, v in collections.Counter(a["verdict"] for a in audit).most_common():
    print(f"{k:22} {v}")


#!/usr/bin/env python3
"""Detect probable *unmarked* misspelling synonyms in mondo.obo.

Strategy: within each MONDO class, a misspelling synonym is a near-duplicate
(edit distance 1, or a single adjacent transposition) of the class's own label
or another correctly-spelled synonym -- AFTER normalizing away legitimate
lexical variation (UK/US spelling, punctuation/hyphenation, roman<->arabic
numerals, singular/plural). If two names are identical after aggressive
normalization, the difference is a legitimate variant, NOT a typo.

Over-normalization only ever removes candidates (false negatives), never adds
false positives, so we normalize aggressively for the "is it explained?" test.
"""
import re
import sys
import unicodedata
from collections import defaultdict

def strip_accents(s: str) -> str:
    return "".join(c for c in unicodedata.normalize("NFKD", s)
                   if not unicodedata.combining(c))

OBO = sys.argv[1] if len(sys.argv) > 1 else "mondo.obo"

# ---- parse ----
terms = []  # list of dict(id, name, obsolete, synonyms=[(text,scope,stype)])
cur = None
syn_re = re.compile(r'^synonym:\s+"((?:[^"\\]|\\.)*)"\s+(\S+)(?:\s+(\S+))?')

with open(OBO, encoding="utf-8") as fh:
    for line in fh:
        line = line.rstrip("\n")
        if line == "[Term]":
            cur = {"id": None, "name": None, "obsolete": False, "synonyms": []}
            terms.append(cur)
            continue
        if line.startswith("[") and line != "[Term]":
            cur = None  # e.g. [Typedef]
            continue
        if cur is None:
            continue
        if line.startswith("id: "):
            cur["id"] = line[4:].strip()
        elif line.startswith("name: "):
            cur["name"] = line[6:].strip()
        elif line.startswith("is_obsolete: true"):
            cur["obsolete"] = True
        elif line.startswith("synonym: "):
            m = syn_re.match(line)
            if not m:
                continue
            text = m.group(1).replace('\\"', '"')
            scope = m.group(2)
            third = m.group(3)
            # third is a synonym-type id only if it does NOT start with '['
            stype = third if (third and not third.startswith("[")) else None
            cur["synonyms"].append((text, scope, stype))

terms = [t for t in terms if t["id"] and t["id"].startswith("MONDO:")]
print(f"parsed {len(terms)} MONDO terms", file=sys.stderr)

# ---- normalization ----
ROMAN = {"i":"1","ii":"2","iii":"3","iv":"4","v":"5","vi":"6","vii":"7",
         "viii":"8","ix":"9","x":"10","xi":"11","xii":"12"}

# UK/US and common spelling-convention normalizations (applied to lowered text).
_SUBS = [
    ("haemat", "hemat"), ("haem", "hem"), ("aemia", "emia"),
    ("oesophag", "esophag"), ("oedema", "edema"), ("coeliac", "celiac"),
    ("paediat", "pediat"), ("paed", "ped"), ("gynaec", "gynec"),
    ("orthopaed", "orthoped"), ("anaem", "anem"), ("leukaem", "leukem"),
    ("tumour", "tumor"), ("colour", "color"), ("behaviour", "behavior"),
    ("fibre", "fiber"), ("centre", "center"),
    ("isation", "ization"), ("ise", "ize"), ("yse", "yze"),
    # NB: no bare "oe"/"ae"/"ph" rules -- they fire mid-word (cardioectodermal,
    # hemangioendothelioma) and, interacting with hyphenation, create spurious
    # differences (false positives). Specific medical digraph rules above suffice.
]

_SUFFIX_PATS = [
    r"(osis|oses)$", r"(iasis|iases)$", r"(omata|oma)$", r"(itides|itis)$",
    r"(ae|a)$",                     # vagina/vaginae, vertebra/vertebrae
    r"(i|us)$",                     # nevus/nevi
    r"(ic|al|ar|ous|ary|ial)$",     # adjective<->noun (urethra/urethral, pelvis/pelvic)
    r"(es|s)$",                     # generic plural
]

def _canon_word(w: str) -> str:
    """Canonicalize a single word by stripping at most one inflectional/
    derivational suffix, then any remaining trailing vowels, so legitimate
    variants (Latin plurals, noun/adjective pairs) collapse to a common stem.
    Only used for the 'is this difference legitimate?' equality test, so
    over-collapsing only ever drops candidates (never adds false positives)."""
    if len(w) < 4:
        return w
    for pat in _SUFFIX_PATS:
        new = re.sub(pat, "", w)
        if new != w and len(new) >= 3:
            w = new
            break
    if len(w) > 4:
        w = re.sub(r"[aeiou]+$", "", w)
    return w

def _prep(s: str) -> str:
    s = strip_accents(s).lower().strip()
    for a, b in _SUBS:
        s = s.replace(a, b)
    return s

def norm_word(s: str) -> str:
    """Per-word morphological normal form (hyphen == space). Catches internal
    Latin-plural / noun-adjective variants like 'vaginal cancer'/'vagina cancer'."""
    s = _prep(s)
    words = re.findall(r"[a-z0-9]+", s)
    return "".join(_canon_word(ROMAN.get(w, w)) for w in words)

def norm_concat(s: str) -> str:
    """Separator-agnostic normal form (hyphen == space == nothing). Catches
    spacing/hyphenation and concatenation variants like 'Adams-Stokes'/'Adams
    Stokes' and 'argininosuccinicaciduria'/'argininosuccinic aciduria'."""
    s = _prep(s)
    s = re.sub(r"[^a-z0-9]+", "", s)  # drop ALL separators -> one token
    return _canon_word(s)

def norm_forms(s: str):
    return (norm_word(s), norm_concat(s))

def norm_light(s: str) -> str:
    """Light normalization for the typo edit-distance test."""
    s = s.lower().strip()
    s = re.sub(r"\s+", " ", s)
    return s

# ---- damerau-levenshtein with early cutoff ----
def dl_dist(a: str, b: str, cutoff: int = 2) -> int:
    la, lb = len(a), len(b)
    if abs(la - lb) > cutoff:
        return cutoff + 1
    prev2 = None
    prev = list(range(lb + 1))
    for i in range(1, la + 1):
        cur = [i] + [0] * lb
        rowmin = cur[0]
        for j in range(1, lb + 1):
            cost = 0 if a[i-1] == b[j-1] else 1
            v = min(prev[j] + 1, cur[j-1] + 1, prev[j-1] + cost)
            if (i > 1 and j > 1 and a[i-1] == b[j-2] and a[i-2] == b[j-1]):
                v = min(v, prev2[j-2] + 1)
            cur[j] = v
            if v < rowmin:
                rowmin = v
        if rowmin > cutoff:
            return cutoff + 1
        prev2, prev = prev, cur
    return prev[lb]

def is_transposition(a: str, b: str) -> bool:
    if len(a) != len(b):
        return False
    diff = [i for i in range(len(a)) if a[i] != b[i]]
    return len(diff) == 2 and diff[1] == diff[0] + 1 and a[diff[0]] == b[diff[1]] and a[diff[1]] == b[diff[0]]

def edit_char_classes(a: str, b: str):
    """Return set of chars involved in the single edit (for filtering digit/roman edits)."""
    # crude: symmetric difference of char multisets at aligned positions
    chars = set()
    # substitution case (equal length)
    if len(a) == len(b):
        for x, y in zip(a, b):
            if x != y:
                chars.add(x); chars.add(y)
    else:
        # indel: the extra char(s)
        longer, shorter = (a, b) if len(a) > len(b) else (b, a)
        # find first mismatch
        i = 0
        while i < len(shorter) and shorter[i] == longer[i]:
            i += 1
        if i < len(longer):
            chars.add(longer[i])
    return chars

DIGIT_ROMAN = set("0123456789")

candidates = []  # (term_id, term_name, syn_text, closest_name, closest_is_label, dist, kind)

for t in terms:
    if t["obsolete"]:
        continue
    label = t["name"]
    if not label:
        continue
    # reference names = label + all synonyms (we compare a syn against the OTHERS)
    ref = [("__label__", label)]
    for (text, scope, stype) in t["synonyms"]:
        ref.append((stype, text))

    # precompute both normal forms for every ref
    ref_norm = [(tag, txt, norm_word(txt), norm_concat(txt)) for (tag, txt) in ref]

    for (text, scope, stype) in t["synonyms"]:
        # skip already-typed non-plain synonyms and short/abbrev-like
        if stype in ("MISSPELLING", "ABBREVIATION", "DEPRECATED", "EXCLUDE"):
            continue
        light = norm_light(text)
        if len(light) < 6:
            continue
        # subtype numbering tail (e.g. "... 2A2", "type 1A"): captured for filtering
        m_tail = re.search(r"[0-9]+[a-z]*$", light)
        light_tail = m_tail.group(0) if m_tail else ""
        sw, sc = norm_forms(text)
        if not sc:
            continue
        # 1) explained as legitimate variant? either normal form matches a ref
        explained = False
        for (tag, rtxt, rw, rc) in ref_norm:
            if rtxt == text:
                continue
            if rw == sw or rc == sc:
                explained = True
                break
        if explained:
            continue
        # 2) typo test vs each other ref (light-normalized)
        best = None
        for (tag, rtxt, rw, rc) in ref_norm:
            if rtxt == text:
                continue
            rlight = norm_light(rtxt)
            if rlight == light:
                continue
            # reject subtype numbering differences (2A2 vs 2A2A, 1 vs 1A)
            m_rtail = re.search(r"[0-9]+[a-z]*$", rlight)
            rtail = m_rtail.group(0) if m_rtail else ""
            if light_tail != rtail:
                continue
            d = dl_dist(light, rlight, cutoff=1)
            transp = False
            if d > 1:
                transp = is_transposition(light, rlight)
                if not transp:
                    continue
            # filter: edits that are purely digit/roman changes = different entity
            ec = edit_char_classes(light, rlight)
            if ec & DIGIT_ROMAN:
                continue
            # filter: differ only by trailing 's' handled by strong-norm plural already,
            # but light strings may still: skip pure plural
            if light.rstrip("s") == rlight.rstrip("s"):
                continue
            kind = "transpose" if transp else "edit1"
            cand = (len(rlight), tag == "__label__", rtxt, kind)
            if best is None or (cand[1] and not best[1]):  # prefer label match
                best = cand
        if best is not None:
            _, is_label, closest, kind = best
            candidates.append((t["id"], label, text, closest, is_label, kind))

print(f"found {len(candidates)} candidate unmarked misspellings", file=sys.stderr)

# de-dup and sort: label-matches first (highest confidence)
candidates.sort(key=lambda c: (not c[4], c[1].lower()))
with open("candidates.tsv", "w", encoding="utf-8") as out:
    out.write("mondo_id\tterm_label\tsuspect_synonym\tclosest_correct_name\tclosest_is_label\tedit_kind\n")
    for c in candidates:
        out.write("\t".join([c[0], c[1], c[2], c[3], "label" if c[4] else "synonym", c[5]]) + "\n")

print("wrote candidates.tsv", file=sys.stderr)

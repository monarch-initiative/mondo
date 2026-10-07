#!/usr/bin/env python3
"""Final refinement: from classified TYPO rows, dedupe unordered pairs, drop
per-word plural morphology and subtype/complementation codes, split off UK/US
& umlaut-transliteration variants, and emit a clean genuine-typo table."""
import re, sys, unicodedata

def acc(s): return "".join(c for c in unicodedata.normalize("NFKD", s) if not unicodedata.combining(c))
def key(s): return re.sub(r"[^a-z0-9]+","", acc(s).lower())
def words(s): return re.findall(r"[a-z0-9]+", acc(s).lower())

def per_word_plural(a, b):
    wa, wb = words(a), words(b)
    if len(wa) != len(wb): return False
    diffs = [(x, y) for x, y in zip(wa, wb) if x != y]
    if len(diffs) != 1: return False
    x, y = diffs[0]
    return x == y + "s" or y == x + "s" or \
           (x.endswith("es") and x[:-2] == y) or (y.endswith("es") and y[:-2] == x) or \
           (x.endswith("es") and x[:-2]+"is" == y) or (y.endswith("es") and y[:-2]+"is" == x)

def subtype_code(a, b):
    ka, kb = key(a), key(b)
    # differing char adjacent to a digit (M6a/M6b, 1A/1B, 6/6A, 3/3a, type2a/2b)
    n = min(len(ka), len(kb))
    i = 0
    while i < n and ka[i] == kb[i]: i += 1
    # look at a small window around first divergence
    win = (ka[max(0,i-1):i+2] + kb[max(0,i-1):i+2])
    if any(c.isdigit() for c in win):
        return True
    # complementation/group letter codes on same class: cblA/cblB, group b/c, Etfa/Etfb
    wa, wb = words(a), words(b)
    if len(wa) == len(wb):
        diffs = [(x, y) for x, y in zip(wa, wb) if x != y]
        if len(diffs) == 1:
            x, y = diffs[0]
            if len(x) == len(y) and len(x) <= 4 and x[:-1] == y[:-1] and x[-1] != y[-1]:
                return True  # short code token differing only in last letter
    return False

# umlaut/eponym transliteration (o-umlaut->oe/o, etc.) and remaining UK/US
TRANSLIT = [(r"oe","o"),(r"ae","a"),(r"ue","u")]
UK2 = [(r"smoulder","smolder"),(r"ageing","aging"),(r"signalling","signaling"),
       (r"sabre","saber"),(r"oestr","estr"),(r"foetal","fetal")]
def translit_variant(a, b):
    def n(s):
        s = acc(s).lower()
        for x,y in UK2: s = re.sub(x,y,s)
        return re.sub(r"[^a-z0-9]+","",s)
    if n(a) == n(b): return True
    # umlaut pair: one has oe/ae/ue where other has o/a/u (Schoenberg/Schonberg,
    # Koenig/Konig, Moebius/Mobius, Loeffler/Loffler, Froehlich/Frohlich)
    def deumlaut(s):
        s = acc(s).lower()
        for x,y in TRANSLIT: s = re.sub(x,y,s)
        return re.sub(r"[^a-z0-9]+","",s)
    return deumlaut(a) == deumlaut(b)

rows = []
with open("classified.tsv", encoding="utf-8") as fh:
    next(fh)
    for line in fh:
        p = line.rstrip("\n").split("\t")
        if len(p) < 7 or p[0] != "TYPO": continue
        rows.append(p[1:6])  # mid,label,suspect,closest,match

seen = set(); typo = []; dropped = {"plural":[], "subtype":[], "translit":[]}
for mid, label, suspect, closest, match in rows:
    pair = tuple(sorted((key(suspect), key(closest))))
    if (mid, pair) in seen: continue
    seen.add((mid, pair))
    if per_word_plural(suspect, closest): dropped["plural"].append((label,suspect,closest)); continue
    if subtype_code(suspect, closest): dropped["subtype"].append((label,suspect,closest)); continue
    if translit_variant(suspect, closest): dropped["translit"].append((label,suspect,closest)); continue
    lk = key(label)
    if key(closest) == lk: correct, wrong, anch = closest, suspect, "label"
    elif key(suspect) == lk: correct, wrong, anch = suspect, closest, "label"
    else: correct, wrong, anch = closest, suspect, "synonym"
    typo.append((mid, label, correct, wrong, anch))

typo.sort(key=lambda r: (r[4] != "label", r[1].lower()))
print(f"genuine TYPO: {len(typo)} (label={sum(1 for r in typo if r[4]=='label')}, "
      f"synonym={sum(1 for r in typo if r[4]=='synonym')})", file=sys.stderr)
for k,v in dropped.items(): print(f"dropped[{k}]: {len(v)}", file=sys.stderr)
with open("typos_final.tsv","w",encoding="utf-8") as out:
    out.write("mondo_id\tterm_label\tcorrect_form\tmisspelled_synonym\tanchor\n")
    for r in typo: out.write("\t".join(r)+"\n")
with open("dropped_translit.tsv","w",encoding="utf-8") as out:
    out.write("term_label\tform_a\tform_b\n")
    for l,a,b in dropped["translit"]: out.write(f"{l}\t{a}\t{b}\n")

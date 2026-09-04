#!/usr/bin/env python3
"""Classify each flagged near-duplicate by WHAT the single edit is, so genuine
typos separate from legitimate variants (UK/US spelling, c/k, disk/disc,
acronym/subtype codes, morphology)."""
import re, sys, unicodedata
from collections import Counter

def acc(s): return "".join(c for c in unicodedata.normalize("NFKD", s) if not unicodedata.combining(c))

# UK/US and transliteration normalizations; if both sides equal after these,
# the difference is a legitimate spelling-convention variant, not a typo.
US_RULES = [
    (r"foetal", "fetal"), (r"oe", "e"), (r"ae", "e"), (r"our\b", "or"),
    (r"isation", "ization"), (r"ise\b", "ize"), (r"ising\b", "izing"),
    (r"isers?\b", "izer"), (r"yse\b", "yze"), (r"ysing\b", "yzing"),
    (r"aluminium", "aluminum"), (r"grey", "gray"), (r"sulph", "sulf"),
    (r"tumour", "tumor"), (r"humour", "humor"), (r"goitre", "goiter"),
    (r"centre", "center"), (r"fibre", "fiber"), (r"litre", "liter"),
    (r"haem", "hem"), (r"leuco", "leuko"), (r"oestr", "estr"),
    (r"caec", "cec"), (r"anaesth", "anesth"), (r"paediatr", "pediatr"),
    (r"gynaec", "gynec"), (r"orthopaed", "orthoped"), (r"praevia", "previa"),
    (r"naev", "nev"), (r"coeli", "celi"), (r"amoeb", "ameb"), (r"caen", "cen"),
]
def us(s):
    s = acc(s).lower()
    for a, b in US_RULES:
        s = re.sub(a, b, s)
    return re.sub(r"[^a-z0-9]+", "", s)

def caps_tokens(s):
    """Return set of all-caps acronym tokens (>=2 upper chars) in original text."""
    return set(re.findall(r"\b[A-Z][A-Z0-9]+\b", s))

def single_edit_chars(a, b):
    """Chars involved in the minimal edit between lowercased a,b (assumes dist<=1
    or transposition on the collapsed forms)."""
    a2 = re.sub(r"[^a-z0-9]+", "", acc(a).lower())
    b2 = re.sub(r"[^a-z0-9]+", "", acc(b).lower())
    if len(a2) == len(b2):
        diff = [(x, y) for x, y in zip(a2, b2) if x != y]
        return set(ch for pair in diff for ch in pair), a2, b2
    longer, shorter = (a2, b2) if len(a2) > len(b2) else (b2, a2)
    i = 0
    while i < len(shorter) and shorter[i] == longer[i]:
        i += 1
    return (set([longer[i]]) if i < len(longer) else set()), a2, b2

def classify(term_label, suspect, closest, is_label):
    # 1) UK/US spelling convention
    if us(suspect) == us(closest):
        return "UK_US_SPELLING"
    chars, a2, b2 = single_edit_chars(suspect, closest)
    # 2) disk/disc
    if ("disk" in suspect.lower()) != ("disk" in closest.lower()) and \
       ("disc" in suspect.lower()) != ("disc" in closest.lower()):
        return "DISK_DISC"
    # 3) c<->k substitution (phako/phaco, pycno/pykno, malako/malaco)
    if chars <= set("ck"):
        return "C_K_VARIANT"
    # 4) edit inside an all-caps acronym token that differs -> different code
    ct_s, ct_c = caps_tokens(suspect), caps_tokens(closest)
    if ct_s != ct_c:
        # the differing caps tokens are short codes (TRH/TRF, ASL/ASA, DEB/DDEB)
        sym = (ct_s | ct_c) - (ct_s & ct_c)
        if any(len(t) <= 6 for t in sym):
            return "ACRONYM_CODE"
    # 5) single trailing type letter/number (subtype code): e.g. "fever A"/"fever C",
    #    "Ib"/"Ic"; differing char is a lone letter after a space/digit
    if chars and chars <= set("abcdefghi") and len(chars) <= 2:
        # check if the differing letter is a standalone type token in either
        toks_s = suspect.lower().split()
        toks_c = closest.lower().split()
        if any(len(t) <= 2 and t.strip("()") in chars for t in toks_s + toks_c):
            return "SUBTYPE_CODE"
    # 6) i<->y (piri/pyri) common latinate variant
    if chars <= set("iy"):
        return "I_Y_VARIANT"
    return "TYPO"

def main():
    rows = []
    with open("candidates.tsv", encoding="utf-8") as fh:
        next(fh)
        for line in fh:
            p = line.rstrip("\n").split("\t")
            if len(p) < 6: continue
            mid, label, suspect, closest, is_label, kind = p[:6]
            cat = classify(label, suspect, closest, is_label == "label")
            rows.append((cat, mid, label, suspect, closest, is_label, kind))
    counts = Counter(r[0] for r in rows)
    print("=== category counts ===", file=sys.stderr)
    for c, n in counts.most_common():
        print(f"{n:5d}  {c}", file=sys.stderr)
    # write categorized output, TYPO first
    order = {"TYPO":0}
    rows.sort(key=lambda r: (order.get(r[0], 9), r[0], not (r[5]=="label"), r[2].lower()))
    with open("classified.tsv", "w", encoding="utf-8") as out:
        out.write("category\tmondo_id\tterm_label\tsuspect_synonym\tclosest_correct\tmatch\tedit\n")
        for r in rows:
            out.write("\t".join(r) + "\n")

if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Scan mondo-edit.obo for capitalised tokens that are likely proper nouns.

Output: a TSV `reports/candidate_proper_nouns.tsv` with one row per candidate
token, ordered by frequency. Columns:

    token   count   example_label   example_synonym

Heuristic: a token matches if it is `[A-Z][a-z]+` (≥2 letters, capitalised
first, mostly-lowercase rest). We strip the trailing `'s` to canonicalise
possessives ("Crohn's" -> "Crohn"). We exclude all-caps tokens (`ATP`,
`COL4A1`) and mixed-case alphanumeric gene-like tokens (`TGFBI`, `MYCBP2`).

Obsolete terms are excluded from the scan (no point seeding the list from
labels that are leaving the ontology).

Intended workflow: run this once, manually prune the TSV, then promote the
surviving tokens into `src/scripts/lexical_variant_proper_nouns.txt`.
"""

from __future__ import annotations

import csv
import re
import sys
from collections import defaultdict
from pathlib import Path

# Mid-label words we want to ignore even if capitalised — these are common
# acronyms or descriptors that happen to start with a capital but are not
# proper nouns. Add to this set as the curator finds new ones.
COMMON_NON_PROPER = {
    # Roman numerals (caught here so they don't pollute the candidate list)
    "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII",
}

# Hyphenated compound eponyms first ("Charcot-Marie-Tooth", "Boyadjiev-Jabs"),
# then individual capitalised tokens for whatever isn't inside a compound.
COMPOUND_RE = re.compile(r"\b[A-Z][a-z]+(?:-[A-Z][a-z]+)+\b")
TOKEN_RE = re.compile(r"\b[A-Z][a-z]+\b")
POSSESSIVE_RE = re.compile(r"'s$|’s$")

SYN_RE = re.compile(
    r'^synonym:\s*"((?:[^"\\]|\\.)*)"\s+(EXACT|RELATED|BROAD|NARROW)'
)


def extract_strings(path: Path):
    """Yield (kind, text) pairs for every name/synonym we want to scan."""
    is_term = False
    is_obsolete = False
    current_name = None
    pending = []
    with path.open(encoding="utf-8") as f:
        for line in f:
            line = line.rstrip("\n")
            if line in ("[Term]", "[Typedef]", "[Instance]"):
                if is_term and not is_obsolete:
                    for kind, text in pending:
                        yield kind, text
                is_term = (line == "[Term]")
                is_obsolete = False
                current_name = None
                pending = []
            elif line.startswith("name: "):
                current_name = line[6:].strip()
                pending.append(("name", current_name))
            elif line.startswith("synonym: "):
                m = SYN_RE.match(line)
                if m:
                    pending.append(("synonym", m.group(1)))
            elif line.strip() == "is_obsolete: true":
                is_obsolete = True
        if is_term and not is_obsolete:
            for kind, text in pending:
                yield kind, text


def candidate_tokens(text: str):
    """Yield candidate proper nouns: hyphenated compounds first, then any
    remaining single capitalised tokens that weren't already inside a
    compound. This avoids double-counting `Boyadjiev` and `Boyadjiev-Jabs`
    for the same surface form.
    """
    masked = list(text)
    for m in COMPOUND_RE.finditer(text):
        tok = m.group(0)
        # If every sub-piece would be filtered out as a common non-proper
        # noun, drop the whole compound too.
        pieces = tok.split("-")
        if all(p in COMMON_NON_PROPER for p in pieces):
            continue
        yield tok
        # Mask out the compound so the single-token pass doesn't re-emit
        # its constituents.
        for i in range(m.start(), m.end()):
            masked[i] = " "
    masked_text = "".join(masked)
    for tok in TOKEN_RE.findall(masked_text):
        tok = POSSESSIVE_RE.sub("", tok)
        if tok in COMMON_NON_PROPER:
            continue
        if len(tok) < 2:
            continue
        yield tok


def _load_curated_set(path: Path) -> set[str]:
    """Load the production proper-noun list, lowercased — same normalisation
    as the runtime matcher in lexical_variants.py."""
    if not path.exists():
        return set()
    nouns: set[str] = set()
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if line and not line.startswith("#"):
            nouns.add(line.lower())
    return nouns


def _is_covered(token: str, nouns: set[str]) -> bool:
    """Mirror of `_contains_proper_noun` in lexical_variants.py — match the
    candidate token (lowercased) against the curated set, then try the
    sub-pieces of a hyphenated compound."""
    low = token.lower()
    if low in nouns:
        return True
    if "-" in low:
        for sub in low.split("-"):
            if sub in nouns:
                return True
    return False


def main(argv=None):
    argv = argv or sys.argv[1:]
    obo_path = Path(argv[0]) if argv else Path("src/ontology/mondo-edit.obo")
    out_path = Path(argv[1]) if len(argv) > 1 else Path(
        "reports/candidate_proper_nouns.tsv"
    )
    curated_path = Path(__file__).parent / "lexical_variant_proper_nouns.txt"

    counts: dict[str, int] = defaultdict(int)
    example_label: dict[str, str] = {}
    example_syn: dict[str, str] = {}
    for kind, text in extract_strings(obo_path):
        for tok in candidate_tokens(text):
            counts[tok] += 1
            if kind == "name" and tok not in example_label:
                example_label[tok] = text
            elif kind == "synonym" and tok not in example_syn:
                example_syn[tok] = text

    curated = _load_curated_set(curated_path)

    out_path.parent.mkdir(parents=True, exist_ok=True)
    with out_path.open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f, delimiter="\t")
        w.writerow(["token", "count", "covered", "example_label", "example_synonym"])
        for tok, c in sorted(counts.items(), key=lambda kv: (-kv[1], kv[0])):
            covered = "yes" if _is_covered(tok, curated) else "no"
            w.writerow([tok, c, covered, example_label.get(tok, ""), example_syn.get(tok, "")])
    covered_count = sum(1 for tok in counts if _is_covered(tok, curated))
    print(
        f"wrote {len(counts)} candidate tokens to {out_path} "
        f"({covered_count} already covered, {len(counts) - covered_count} new)",
        file=sys.stderr,
    )


if __name__ == "__main__":
    main()

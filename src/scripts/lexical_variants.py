#!/usr/bin/env python3
"""Generate safe lexical variants of MONDO term labels as EXACT synonyms.

See https://github.com/monarch-initiative/mondo/issues/10259 for the rule set.

The script operates on the mondo-edit.obo file in-place (or to a separate
output) and is designed to be idempotent: each pipeline run first removes any
synonym whose ONLY source is MONDO:LexicalVariation, then regenerates the full
set from the current labels. This means rule updates flow through cleanly.

Rules implemented (see issue for rationale):

  R1  Arabic <-> Roman numerals after "type" (suffix)
  R2  Arabic <-> Roman numerals after ", type" (suffix)
  R3  Comma-drop before "type N"  (X, type N -> X type N)
  R4  Hyphen <-> space in "X-linked" / "Y-linked"
  R5  Conservative X-linked / Y-linked reorder (single-comma form)
  R6  Hyphen <-> space between "type" and numeral
  R7  Susceptibility reorder (X[,] susceptibility <-> susceptibility to X)
  R8  British <-> American spelling (closed list)
  R9  Diacritic stripping (eponyms)
  RL  Lowercase variant of the label and every other generated variant

Excluded by design: R11-R15 from the issue (paren qualifiers, gene-related
rewrites, open-ended hyphenation, "disease of X" reorder, abbreviation
expansion). Add new rules by appending a function to GENERATOR_RULES.

Usage
-----

    python lexical_variants.py --input mondo-edit.obo --output mondo-edit.obo \
                               --purge --generate

    # dry-run report:
    python lexical_variants.py --input mondo-edit.obo --report out.tsv

The default behaviour is purge + generate writing back to the same file.
"""

from __future__ import annotations

import argparse
import csv
import re
import sys
import unicodedata
from pathlib import Path
from typing import Callable, Iterable, List, Optional, Tuple

LEX_SOURCE = "MONDO:LexicalVariation"

# Longest-first so the alternation in regexes matches greedily.
ROMAN_NUMERALS = ["XII", "XI", "X", "IX", "VIII", "VII", "VI", "V", "IV",
                  "III", "II", "I"]
INT_TO_ROMAN = {1: "I", 2: "II", 3: "III", 4: "IV", 5: "V", 6: "VI", 7: "VII",
                8: "VIII", 9: "IX", 10: "X", 11: "XI", 12: "XII"}
ROMAN_TO_INT = {v: k for k, v in INT_TO_ROMAN.items()}
ROMAN_ALT = "|".join(ROMAN_NUMERALS)
NUM_ALT = r"(?:\d{1,2}|" + ROMAN_ALT + r")"

# Closed British/American substitution list (from the issue text). Apply as
# whole-token substrings (case-insensitive) to avoid open ae->e / oe->e rules
# that break species names.
BRITISH_AMERICAN: List[Tuple[str, str]] = [
    ("tumour", "tumor"),
    ("leukaemia", "leukemia"),
    ("anaemia", "anemia"),
    ("haemorrhage", "hemorrhage"),
    ("haematology", "hematology"),
    ("haematological", "hematological"),
    ("haemato", "hemato"),
    ("haemo", "hemo"),
    ("oesophag", "esophag"),
    ("paediatric", "pediatric"),
    ("coeliac", "celiac"),
    ("oedema", "edema"),
    ("dyspnoea", "dyspnea"),
    ("diarrhoea", "diarrhea"),
    ("foetal", "fetal"),
]

# ---------------------------------------------------------------------------
# Rule functions: (label) -> list[(variant, rule_id)]
# ---------------------------------------------------------------------------


def _to_int(token: str) -> int:
    return ROMAN_TO_INT[token] if token in ROMAN_TO_INT else int(token)


def rule_r1_type_arabic_roman(label: str) -> List[Tuple[str, str]]:
    out: List[Tuple[str, str]] = []
    m = re.search(r"(?<![A-Za-z0-9])type (\d{1,2})$", label)
    if m and 1 <= int(m.group(1)) <= 12:
        out.append((label[: m.start(1)] + INT_TO_ROMAN[int(m.group(1))], "R1"))
    m = re.search(r"(?<![A-Za-z0-9])type (" + ROMAN_ALT + r")$", label)
    if m:
        out.append((label[: m.start(1)] + str(ROMAN_TO_INT[m.group(1)]), "R1"))
    return out


# Roman alternation for R1b: drop standalone "X" because trailing X in MONDO
# labels is dominated by chromosome-X usage (trisomy X, monosomy X, …) rather
# than roman 10. The other single-letter romans (I, V) are safe at suffix.
ROMAN_ALT_R1B = "|".join([r for r in ROMAN_NUMERALS if r != "X"])


def rule_r1b_suffix_arabic_roman(label: str) -> List[Tuple[str, str]]:
    """Suffix-anchored arabic <-> roman without requiring a 'type ' prefix.

    Catches forms like 'glycogen storage disease I', 'orofaciodigital
    syndrome V', 'Fanconi anemia complementation group V'. Single-letter
    trailing X is excluded — see ROMAN_ALT_R1B.
    """
    out: List[Tuple[str, str]] = []
    m = re.search(r"(?<![A-Za-z0-9])(\d{1,2})$", label)
    if m and 1 <= int(m.group(1)) <= 12:
        out.append((label[: m.start(1)] + INT_TO_ROMAN[int(m.group(1))], "R1b"))
    m = re.search(r"(?<![A-Za-z0-9])(" + ROMAN_ALT_R1B + r")$", label)
    if m:
        out.append((label[: m.start(1)] + str(ROMAN_TO_INT[m.group(1)]), "R1b"))
    return out


def rule_r2_comma_type_arabic_roman(label: str) -> List[Tuple[str, str]]:
    out: List[Tuple[str, str]] = []
    m = re.search(r",\s*type (\d{1,2})$", label)
    if m and 1 <= int(m.group(1)) <= 12:
        out.append((label[: m.start(1)] + INT_TO_ROMAN[int(m.group(1))], "R2"))
    m = re.search(r",\s*type (" + ROMAN_ALT + r")$", label)
    if m:
        out.append((label[: m.start(1)] + str(ROMAN_TO_INT[m.group(1)]), "R2"))
    return out


def rule_r3_comma_drop_type(label: str) -> List[Tuple[str, str]]:
    out: List[Tuple[str, str]] = []
    m = re.search(r"(.*),\s*type (" + NUM_ALT + r")$", label)
    if m:
        out.append((f"{m.group(1)} type {m.group(2)}", "R3"))
    return out


def rule_r4_xlinked_hyphen_space(label: str) -> List[Tuple[str, str]]:
    # Case-insensitive on [XxYy] so future-proof against labels that happen
    # to use lowercase "x-linked". The backreference preserves the original
    # case of the matched character.
    out: List[Tuple[str, str]] = []
    if re.search(r"\b([XxYy])-linked\b", label):
        out.append((re.sub(r"\b([XxYy])-linked\b", r"\1 linked", label), "R4"))
    if re.search(r"\b([XxYy]) linked\b", label):
        out.append((re.sub(r"\b([XxYy]) linked\b", r"\1-linked", label), "R4"))
    return out


# Closed list of cell-type tokens that participate in hyphen <-> space
# variation. Keep this list tight; widening to arbitrary single-letter
# prefixes ("E-cell", "U-cell"…) would invent terms that don't exist.
CELL_TYPE_TOKENS = ["T", "B", "NK"]
CELL_TYPE_ALT = "|".join(CELL_TYPE_TOKENS)


def rule_r10_celltype_hyphen_space(label: str) -> List[Tuple[str, str]]:
    """`T-cell` <-> `T cell` and the same for B-cell / NK-cell.

    When a label contains the token multiple times (e.g. "T-cell and NK-cell
    non-Hodgkin lymphoma") all occurrences are switched in one pass, so we
    generate one normalised variant per direction — no combinatorial blow-up.
    """
    out: List[Tuple[str, str]] = []
    pat_h = re.compile(r"\b(" + CELL_TYPE_ALT + r")-cell\b")
    pat_s = re.compile(r"\b(" + CELL_TYPE_ALT + r") cell\b")
    if pat_h.search(label):
        out.append((pat_h.sub(r"\1 cell", label), "R10"))
    if pat_s.search(label):
        out.append((pat_s.sub(r"\1-cell", label), "R10"))
    return out


def rule_r5_xlinked_reorder(label: str) -> List[Tuple[str, str]]:
    out: List[Tuple[str, str]] = []
    # X, X-linked  ->  X-linked X    (only when single comma at the boundary)
    m = re.match(r"^([^,]+),\s+([XY])-linked$", label)
    if m:
        out.append((f"{m.group(2)}-linked {m.group(1)}", "R5"))
    # X-linked X  ->  X, X-linked    (only when X contains no comma)
    m = re.match(r"^([XY])-linked (.+)$", label)
    if m and "," not in m.group(2):
        out.append((f"{m.group(2)}, {m.group(1)}-linked", "R5"))
    return out


def rule_r6_type_hyphen_space(label: str) -> List[Tuple[str, str]]:
    out: List[Tuple[str, str]] = []
    # "type N" -> "type-N" everywhere it appears as a coherent token pair
    pat_space = re.compile(r"\btype (" + NUM_ALT + r")(?![A-Za-z0-9])")
    if pat_space.search(label):
        out.append((pat_space.sub(r"type-\1", label), "R6"))
    pat_hyphen = re.compile(r"\btype-(" + NUM_ALT + r")(?![A-Za-z0-9])")
    if pat_hyphen.search(label):
        out.append((pat_hyphen.sub(r"type \1", label), "R6"))
    return out


def rule_r7_susceptibility(label: str) -> List[Tuple[str, str]]:
    out: List[Tuple[str, str]] = []
    m = re.match(r"^(.+?),\s+susceptibility$", label)
    if m:
        out.append((f"susceptibility to {m.group(1)}", "R7"))
    else:
        m = re.match(r"^(.+?)\s+susceptibility$", label)
        if m:
            out.append((f"susceptibility to {m.group(1)}", "R7"))
    m = re.match(r"^susceptibility to (.+)$", label)
    if m:
        out.append((f"{m.group(1)}, susceptibility", "R7"))
        out.append((f"{m.group(1)} susceptibility", "R7"))
    return out


def _replace_preserve_case(pattern: str, repl: str, text: str) -> str:
    """Like re.sub but preserves the case of the first character of each
    match (so "Tumour" -> "Tumor" instead of "tumor")."""
    def _sub(m: "re.Match[str]") -> str:
        match = m.group(0)
        if match and match[0].isupper():
            return repl[:1].upper() + repl[1:]
        return repl
    return re.sub(pattern, _sub, text, flags=re.IGNORECASE)


def rule_r8_british_american(label: str) -> List[Tuple[str, str]]:
    out: List[Tuple[str, str]] = []
    for brit, amer in BRITISH_AMERICAN:
        # Anchor at a word boundary at the START of the stem so that
        # mid-word matches like "oesophag" inside "gastroesophageal" do not
        # match and accidentally drop a character.
        brit_pat = r"\b" + re.escape(brit)
        amer_pat = r"\b" + re.escape(amer)
        if re.search(brit_pat, label, flags=re.IGNORECASE):
            new = _replace_preserve_case(brit_pat, amer, label)
            if new != label:
                out.append((new, "R8"))
        if re.search(amer_pat, label, flags=re.IGNORECASE):
            new = _replace_preserve_case(amer_pat, brit, label)
            if new != label:
                out.append((new, "R8"))
    return out


def rule_r9_diacritics(label: str) -> List[Tuple[str, str]]:
    nfkd = unicodedata.normalize("NFKD", label)
    stripped = "".join(c for c in nfkd if not unicodedata.combining(c))
    if stripped != label:
        return [(stripped, "R9")]
    return []


GENERATOR_RULES: List[Callable[[str], List[Tuple[str, str]]]] = [
    rule_r1_type_arabic_roman,
    rule_r1b_suffix_arabic_roman,
    rule_r2_comma_type_arabic_roman,
    rule_r3_comma_drop_type,
    rule_r4_xlinked_hyphen_space,
    rule_r5_xlinked_reorder,
    rule_r6_type_hyphen_space,
    rule_r7_susceptibility,
    rule_r8_british_american,
    rule_r9_diacritics,
    rule_r10_celltype_hyphen_space,
]


def generate_variants(label: str) -> List[Tuple[str, str]]:
    """Apply all rules to the label, then add lowercase forms.

    Returns a deduplicated list of (variant, rule_id). Rule_id reflects the
    rule chain (e.g. "R1+RL" for the lowercase of an arabic->roman variant).
    """
    label = label.strip()
    seen = {label}
    variants: List[Tuple[str, str]] = []

    for rule in GENERATOR_RULES:
        for v, rid in rule(label):
            v = v.strip()
            if v and v not in seen:
                seen.add(v)
                variants.append((v, rid))

    extras: List[Tuple[str, str]] = []
    for v, rid in [(label, "LABEL")] + variants:
        low = v.lower()
        if low != v and low not in seen:
            seen.add(low)
            extras.append((low, "RL" if rid == "LABEL" else f"{rid}+RL"))
    return variants + extras


# ---------------------------------------------------------------------------
# OBO file handling. We intentionally do line-based parsing instead of pulling
# in pronto/oaklib: it's predictable, preserves curator-authored whitespace and
# tag ordering, and downstream `make NORM` handles canonicalisation.
# ---------------------------------------------------------------------------

# `synonym: "<text>" SCOPE [<type>] [<source list>]`
SYN_RE = re.compile(
    r'^synonym:\s*"((?:[^"\\]|\\.)*)"\s+'
    r"(EXACT|RELATED|BROAD|NARROW)"
    r"(?:\s+([A-Z_]+))?"
    r"\s*\[([^\]]*)\]"
)


def read_stanzas(path: Path) -> List[List[str]]:
    """Return the obo file as a list of stanzas. Each stanza is a list of
    lines. The first stanza is the file preamble; subsequent stanzas begin
    with `[Term]`, `[Typedef]`, or `[Instance]`.
    """
    stanzas: List[List[str]] = [[]]
    with path.open(encoding="utf-8") as f:
        for line in f:
            line = line.rstrip("\n")
            if line in ("[Term]", "[Typedef]", "[Instance]"):
                stanzas.append([line])
            else:
                stanzas[-1].append(line)
    return stanzas


def write_stanzas(path: Path, stanzas: List[List[str]]) -> None:
    with path.open("w", encoding="utf-8") as f:
        for stanza in stanzas:
            for line in stanza:
                f.write(line + "\n")


def _stanza_field(stanza: List[str], tag: str) -> Optional[str]:
    prefix = f"{tag}: "
    for ln in stanza:
        if ln.startswith(prefix):
            return ln[len(prefix):].strip()
    return None


def _is_term(stanza: List[str]) -> bool:
    return bool(stanza) and stanza[0] == "[Term]"


def _is_obsolete(stanza: List[str]) -> bool:
    return any(ln.strip() == "is_obsolete: true" for ln in stanza)


# Terms in these subsets are still live but flagged for upcoming removal.
# Generating lexical variants on them just churns the report when they get
# obsoleted in the next release.
SKIP_SUBSETS = frozenset({"obsoletion_candidate"})


def _has_skip_subset(stanza: List[str]) -> bool:
    for ln in stanza:
        if ln.startswith("subset: "):
            name = ln[len("subset: "):].split()[0].split("{")[0].strip()
            if name in SKIP_SUBSETS:
                return True
    return False


def _existing_synonym_strings(stanza: List[str]) -> set:
    out = set()
    for ln in stanza:
        m = SYN_RE.match(ln)
        if m:
            out.add(m.group(1))
    return out


def _parse_sources(raw: str) -> List[str]:
    return [s.strip() for s in raw.split(",") if s.strip()]


def purge_lex_only(stanza: List[str]) -> Tuple[List[str], int]:
    """Drop synonym lines whose source list is exactly [MONDO:LexicalVariation]."""
    out: List[str] = []
    removed = 0
    for ln in stanza:
        m = SYN_RE.match(ln)
        if m and _parse_sources(m.group(4)) == [LEX_SOURCE]:
            removed += 1
            continue
        out.append(ln)
    return out, removed


def _escape_synonym_text(text: str) -> str:
    return text.replace("\\", "\\\\").replace('"', '\\"')


def insert_synonym_lines(stanza: List[str], new_lines: List[str]) -> List[str]:
    """Insert new synonym lines after the last existing synonym, falling back
    to after `def:` then `name:`. Order within the new block is preserved.
    """
    if not new_lines:
        return stanza
    insert_idx = None
    for i, ln in enumerate(stanza):
        if ln.startswith("synonym: "):
            insert_idx = i + 1
    if insert_idx is None:
        for i, ln in enumerate(stanza):
            if ln.startswith("def: "):
                insert_idx = i + 1
                break
    if insert_idx is None:
        for i, ln in enumerate(stanza):
            if ln.startswith("name: "):
                insert_idx = i + 1
                break
    if insert_idx is None:
        insert_idx = len(stanza)
    return stanza[:insert_idx] + new_lines + stanza[insert_idx:]


def generate_for_stanza(
    stanza: List[str],
) -> Tuple[List[str], List[Tuple[str, str, str]]]:
    """Return (modified stanza, list of (term_id, variant, rule_id)).

    Obsolete and non-Term stanzas are passed through unchanged.
    """
    if not _is_term(stanza) or _is_obsolete(stanza) or _has_skip_subset(stanza):
        return stanza, []
    label = _stanza_field(stanza, "name")
    term_id = _stanza_field(stanza, "id")
    if not label or not term_id:
        return stanza, []

    existing = _existing_synonym_strings(stanza)
    existing.add(label)

    added: List[str] = []
    report_rows: List[Tuple[str, str, str]] = []
    for variant, rule_id in generate_variants(label):
        if variant in existing:
            continue
        existing.add(variant)
        esc = _escape_synonym_text(variant)
        added.append(f'synonym: "{esc}" EXACT [{LEX_SOURCE}]')
        report_rows.append((term_id, variant, rule_id))

    return insert_synonym_lines(stanza, added), report_rows


# ---------------------------------------------------------------------------
# Pipeline driver
# ---------------------------------------------------------------------------


def run(
    input_path: Path,
    output_path: Path,
    do_purge: bool,
    do_generate: bool,
    report_path: Optional[Path],
) -> None:
    stanzas = read_stanzas(input_path)

    purged_total = 0
    generated_total = 0
    report_rows: List[Tuple[str, str, str, str]] = []

    new_stanzas: List[List[str]] = []
    for stanza in stanzas:
        if do_purge and _is_term(stanza):
            stanza, removed = purge_lex_only(stanza)
            purged_total += removed
        if do_generate and _is_term(stanza):
            label = _stanza_field(stanza, "name") or ""
            stanza, rows = generate_for_stanza(stanza)
            generated_total += len(rows)
            for term_id, variant, rule_id in rows:
                report_rows.append((term_id, label, variant, rule_id))
        new_stanzas.append(stanza)

    write_stanzas(output_path, new_stanzas)
    print(
        f"[lexical_variants] purged={purged_total} generated={generated_total} "
        f"wrote={output_path}",
        file=sys.stderr,
    )

    if report_path is not None:
        report_path.parent.mkdir(parents=True, exist_ok=True)
        with report_path.open("w", encoding="utf-8", newline="") as f:
            w = csv.writer(f, delimiter="\t")
            w.writerow(["term_id", "label", "generated_synonym", "rule_id"])
            w.writerows(report_rows)
        print(f"[lexical_variants] report -> {report_path}", file=sys.stderr)


def main(argv: Optional[List[str]] = None) -> int:
    p = argparse.ArgumentParser(
        description="Generate / refresh safe lexical-variant EXACT synonyms in mondo-edit.obo"
    )
    p.add_argument("--input", "-i", type=Path, required=True,
                   help="Input OBO file (typically src/ontology/mondo-edit.obo)")
    p.add_argument("--output", "-o", type=Path, default=None,
                   help="Output OBO file. Defaults to --input (overwrite).")
    p.add_argument("--purge", action="store_true",
                   help="Remove existing synonyms whose only source is "
                        f"{LEX_SOURCE}.")
    p.add_argument("--generate", action="store_true",
                   help="Generate new variants from current labels.")
    p.add_argument("--report", type=Path, default=None,
                   help="Optional TSV with (term_id, label, generated, rule_id).")
    args = p.parse_args(argv)

    # Default: do both.
    if not args.purge and not args.generate:
        args.purge = True
        args.generate = True

    output = args.output if args.output is not None else args.input
    run(args.input, output, args.purge, args.generate, args.report)
    return 0


if __name__ == "__main__":
    sys.exit(main())

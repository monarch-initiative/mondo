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

    The trailing token must be preceded by whitespace or start-of-string —
    `(?<!\\S)` — so compound suffixes like 'grade 1/2' or '2,3' don't get
    their last numeral half-converted.
    """
    out: List[Tuple[str, str]] = []
    m = re.search(r"(?<!\S)(\d{1,2})$", label)
    if m and 1 <= int(m.group(1)) <= 12:
        out.append((label[: m.start(1)] + INT_TO_ROMAN[int(m.group(1))], "R1b"))
    m = re.search(r"(?<!\S)(" + ROMAN_ALT_R1B + r")$", label)
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
    # Unidirectional: only fold `type-N` -> `type N`. The reverse direction
    # (`type N` -> `type-N`) was generating noise; curator preference is the
    # space form as canonical.
    out: List[Tuple[str, str]] = []
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


# ---------------------------------------------------------------------------
# Lowercase-skip filters. These suppress the RL chain for strings that
# would read poorly in fully-lowercased form: eponyms (Crohn, Ullrich, …)
# and multi-character Roman numerals (II, III, IV, …).
# ---------------------------------------------------------------------------

# Romans to refuse to lowercase. Two cases:
#   (1) multi-character romans anywhere — never want `type ii`, `type iii`,
#       `complex iv`, etc.
#   (2) single-letter I/V/X preceded by an indicator word (`type`, `stage`,
#       `grade`, `class`, `complex`, `factor`, `group`) — when the context
#       names the numeral explicitly, the single letter is a roman and
#       lowercasing it reads as broken.
# Single-letter I/V/X *without* an indicator prefix still lowercases — that
# protects useful matches like `x chromosome`, `factor v leiden` text where
# the letter is part of a name, not a numeral. (`factor V` standalone would
# also fire via the indicator branch.)
_INDICATOR_ALT = r"type|stage|grade|class|complex|factor|group"
# Three branches:
#   - Multi-char romans anywhere (incl. trailing letters: IIa, IIx, IIIb…).
#   - Single-letter I/V/X preceded by an indicator word (type|stage|…).
#   - Single-letter I or V at the END of the variant: in MONDO this is
#     dominated by genuine roman usage (`glycogen storage disease I`,
#     `orofaciodigital syndrome V`, and any arabic->roman output from R1b
#     ending in `I`/`V`). Trailing `X` is intentionally excluded — that
#     suffix is dominated by chromosome usage (`trisomy X`, `monosomy X`).
MULTICHAR_ROMAN_RE = re.compile(
    r"\b(?:II|III|IV|VI|VII|VIII|IX|XI|XII)[a-z]*\b"
    r"|\b(?:" + _INDICATOR_ALT + r")\s+[IVXivx]\b"
    r"|\b[IV]$"
)

# Token split for proper-noun checks. Hyphens are kept INSIDE tokens so
# compound eponyms like `Boyadjiev-Jabs` survive as a single token; the
# matcher then also tries the sub-tokens, so either form may sit in the
# curated list. Apostrophes survive too — we strip a trailing `'s` at
# lookup time so `Crohn's` matches `Crohn`.
_TOKEN_SPLIT_RE = re.compile(r"[\s/,()\[\];:.]+")
_POSSESSIVE_RE = re.compile(r"(?:'s|’s)$")

PROPER_NOUN_FILE = Path(__file__).parent / "lexical_variant_proper_nouns.txt"


def _load_proper_nouns(path: Path = PROPER_NOUN_FILE) -> frozenset:
    """Load the proper-noun list, normalised to lowercase so the matcher
    can do case-insensitive comparison (e.g. label `Charcot-Marie-tooth`
    with a stray lowercase `t` still suppresses the lowercase chain)."""
    if not path.exists():
        return frozenset()
    nouns = set()
    with path.open(encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            nouns.add(line.lower())
    return frozenset(nouns)


_PROPER_NOUNS_CACHE: Optional[frozenset] = None


def _proper_nouns() -> frozenset:
    global _PROPER_NOUNS_CACHE
    if _PROPER_NOUNS_CACHE is None:
        _PROPER_NOUNS_CACHE = _load_proper_nouns()
    return _PROPER_NOUNS_CACHE


def _contains_proper_noun(text: str) -> bool:
    nouns = _proper_nouns()  # already lowercased at load time
    if not nouns:
        return False
    for tok in _TOKEN_SPLIT_RE.split(text):
        if not tok:
            continue
        tok = _POSSESSIVE_RE.sub("", tok).lower()
        if tok in nouns:
            return True
        # Hyphenated token: also try each component, so a curated list
        # containing either the compound (`Boyadjiev-Jabs`) or the pieces
        # (`Sertoli`, `Leydig`) will fire on `Sertoli-Leydig cell tumor`.
        if "-" in tok:
            for sub in tok.split("-"):
                sub = _POSSESSIVE_RE.sub("", sub)
                if sub in nouns:
                    return True
    return False


def _should_skip_lowercase(text: str) -> bool:
    if MULTICHAR_ROMAN_RE.search(text):
        return True
    if _contains_proper_noun(text):
        return True
    return False


def _has_miscased_proper_noun(text: str) -> bool:
    """True if `text` contains a token that case-insensitively matches a
    curated proper noun but is not in its canonical (capital-first) form.

    Used to suppress non-RL rule outputs that would PROPAGATE a mis-cased
    eponym from a quirky source label — e.g. R8 turning the existing
    `ovarian sertoli-stromal cell tumor` into `… tumour` and dragging the
    lowercase `sertoli` into a new generated synonym.
    """
    nouns = _proper_nouns()
    if not nouns:
        return False
    for tok in _TOKEN_SPLIT_RE.split(text):
        if not tok:
            continue
        bare = _POSSESSIVE_RE.sub("", tok)
        if not bare:
            continue
        low = bare.lower()
        if low in nouns and not bare[:1].isupper():
            return True
        if "-" in bare:
            for sub in bare.split("-"):
                sub = _POSSESSIVE_RE.sub("", sub)
                if not sub:
                    continue
                if sub.lower() in nouns and not sub[:1].isupper():
                    return True
    return False


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
            if not v or v in seen:
                continue
            # Don't propagate a mis-cased eponym from a quirky source label.
            if _has_miscased_proper_noun(v):
                continue
            seen.add(v)
            variants.append((v, rid))

    extras: List[Tuple[str, str]] = []
    for v, rid in [(label, "LABEL")] + variants:
        if _should_skip_lowercase(v):
            continue
        # R1b is the only rule that PRODUCES a trailing single-letter roman
        # from a trailing arabic numeral (`…, 10` -> `…, X`). The general
        # filter intentionally lets trailing single-letter X lowercase
        # (chromosome contexts), but in this provenance the X is definitely
        # a roman, so block the chain.
        if rid == "R1b" and re.search(r"\b[IVX]$", v):
            continue
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

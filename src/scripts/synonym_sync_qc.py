"""QC check for Mondo update-synonyms-sync output.

Verifies two invariants between a pre-sync and post-sync OBO file:

  Pass 1 (line-diff check). The only lines that changed are `synonym:`
  lines. Any other +/- line in `git diff` is a violation — the sync target
  must not touch anything besides synonyms.

  Pass 2 (structural check). The set of (term_id, synonym_literal) pairs is
  unchanged. No synonyms were added or removed. On synonyms that exist on
  both sides, attributes (scope, synonym-type modifier, xref provenance,
  trailing axiom annotations) may differ — those are categorized and
  reported but are not violations.

Usage:
  # compare a file with local changes to its HEAD version in git
  qc_synonym_sync.py [-r PATH] FILE

  # compare a file as committed at REF vs its parent (REF~1)
  qc_synonym_sync.py [-r PATH] --ref REF FILE

  # compare two files directly
  qc_synonym_sync.py [-r PATH] PRE_FILE POST_FILE

Exit status: 0 if both checks pass, 1 if not.
"""

import atexit
import os
import subprocess
import sys
import tempfile
from collections import Counter, defaultdict
from dataclasses import dataclass
from typing import Literal, NamedTuple, TypeAlias

import click
import curies
import fastobo
import fastobo.term


SYNONYM_PREFIX = ("-synonym: ", "+synonym: ")


class SynonymKey(NamedTuple):
    # MONDO:nnnnnnn
    term_id: str

    # the synonym string itself
    literal: str


@dataclass(frozen=True)
class SynonymRecord:
    # one of "EXACT" | "NARROW" | "BROAD" | "RELATED"
    scope: str

    # synonym-type modifier (e.g. "ABBREVIATION"), or None
    type: str | None

    # sorted provenance xrefs, e.g. ("DOID:1234", "OMIM:5678")
    xrefs: tuple[str, ...]

    # Trailing axiom annotations (the `{key="value"}` block on a synonym
    # line, e.g. `{OMO:0002001="..."}`) are not exposed by fastobo < 0.14.
    # The lines that would implement detection for changes to those
    # annotations are commented out below and elsewhere in this script
    # with the prefix `# fastobo 0.14 # `. When ODK ships fastobo >= 0.14,
    # those lines can be uncommented to enable the
    # trailing_annotation_change category.
    # fastobo 0.14 # qualifiers: tuple[str, ...]


Violation: TypeAlias = tuple[Literal["added", "deleted"], SynonymKey, SynonymRecord]
Modification: TypeAlias = tuple[SynonymKey, SynonymRecord, SynonymRecord]


def materialize_at_ref(path: str, ref: str) -> str:
    """Write `git show {ref}:{path}` to a tempfile and return its path.

    Resolves `path` to a repo-root-relative path via `git ls-files
    --full-name` so the script works regardless of the current working
    directory inside the repo.
    """
    ls = subprocess.run(
        ["git", "ls-files", "--error-unmatch", "--full-name", path],
        capture_output=True,
        text=True,
    )
    if ls.returncode != 0:
        sys.exit(f"git ls-files failed for {path}: {ls.stderr.strip()}")
    repo_relative_path = ls.stdout.strip()

    r = subprocess.run(
        ["git", "show", f"{ref}:{repo_relative_path}"],
        capture_output=True,
        text=True,
    )
    if r.returncode != 0:
        sys.exit(f"git show {ref}:{repo_relative_path} failed: {r.stderr.strip()}")
    safe_ref = ref.replace("/", "-").replace("~", "-").replace("^", "-")
    tmp = tempfile.NamedTemporaryFile(
        mode="w", suffix=".obo", delete=False, prefix=f"qc-syn-{safe_ref}-"
    )
    tmp.write(r.stdout)
    tmp.close()

    # Remove temp file when script exits
    atexit.register(os.unlink, tmp.name)
    return tmp.name


def pass1_diff_confined(pre_path: str, post_path: str) -> list[str]:
    """Return non-synonym +/- lines found in the diff."""
    diff = subprocess.run(
        ["git", "diff", "--no-index", "-U0", pre_path, post_path],
        capture_output=True,
        text=True,
    ).stdout
    non_synonym_changes: list[str] = []
    for line in diff.splitlines():
        if line.startswith(("---", "+++")):
            continue
        if line.startswith(("-", "+")) and not line.startswith(SYNONYM_PREFIX):
            non_synonym_changes.append(line)
    return non_synonym_changes


def extract_synonyms(
    path: str,
) -> tuple[dict[SynonymKey, SynonymRecord], dict[str, str]]:
    """Return ({SynonymKey: SynonymRecord}, {term_id: name}) for `path`.

    The second map carries each term's authoritative `name:` label for
    report rendering — the QC logic itself uses only the synonym map.
    """
    synonyms: dict[SynonymKey, SynonymRecord] = {}
    term_labels: dict[str, str] = {}
    doc = fastobo.load(path)
    for frame in doc:
        if not isinstance(frame, fastobo.term.TermFrame):
            continue
        term_id = str(frame.id)
        for clause in frame:
            if isinstance(clause, fastobo.term.NameClause):
                term_labels[term_id] = clause.name
                continue
            if not isinstance(clause, fastobo.term.SynonymClause):
                continue
            syn = clause.synonym
            key = SynonymKey(term_id, syn.desc)
            if key in synonyms:
                raise ValueError(
                    f"duplicate synonym in {path}: {key} appears with "
                    f"multiple synonym clauses on the same term"
                )
            synonyms[key] = SynonymRecord(
                scope=syn.scope,
                type=str(syn.type) if syn.type is not None else None,
                xrefs=tuple(sorted(str(x.id) for x in syn.xrefs)),
                # fastobo 0.14 # qualifiers=tuple(
                # fastobo 0.14 #     sorted(f"{q.key}={q.value}" for q in (clause.qualifiers or []))
                # fastobo 0.14 # ),
            )
    return synonyms, term_labels


def pass2_structural(
    pre: dict[SynonymKey, SynonymRecord],
    post: dict[SynonymKey, SynonymRecord],
) -> tuple[list[Violation], dict[str, list[Modification]]]:
    """Return (violations, modifications)."""
    pre_keys = set(pre)
    post_keys = set(post)
    violations: list[Violation] = []
    for key in sorted(pre_keys - post_keys):
        violations.append(("deleted", key, pre[key]))
    for key in sorted(post_keys - pre_keys):
        violations.append(("added", key, post[key]))

    modifications: dict[str, list[Modification]] = defaultdict(list)
    for key in sorted(pre_keys & post_keys):
        a, b = pre[key], post[key]
        if a == b:
            continue
        if a.scope != b.scope:
            modifications["scope_change"].append((key, a, b))
        if a.type != b.type:
            modifications["modifier_change"].append((key, a, b))
        if a.xrefs != b.xrefs:
            modifications["provenance_change"].append((key, a, b))
        # fastobo 0.14 # if a.qualifiers != b.qualifiers:
        # fastobo 0.14 #     modifications["trailing_annotation_change"].append((key, a, b))
    return violations, modifications


def provenance_breakdown(
    provenance_entries: list[Modification],
) -> tuple[Counter[str], Counter[str]]:
    """Per-source-prefix add/drop counts across provenance_change events.

    URL xrefs (e.g. https://orcid.org/...) parse as prefix "http" or
    "https" via curies — they show up in the report under those buckets
    rather than as a single combined "<url>" bucket.
    """
    added: Counter[str] = Counter()
    dropped: Counter[str] = Counter()
    for _, a, b in provenance_entries:
        a_set = set(a.xrefs)
        b_set = set(b.xrefs)
        for x in b_set - a_set:
            added[curies.ReferenceTuple.from_curie(x).prefix] += 1
        for x in a_set - b_set:
            dropped[curies.ReferenceTuple.from_curie(x).prefix] += 1
    return added, dropped


CATEGORY_FIELDS = {
    "scope_change": ["scope"],
    "modifier_change": ["type"],
    "provenance_change": ["xrefs"],
    # fastobo 0.14 # "trailing_annotation_change": ["qualifiers"],
}


def synonym_obo_line(literal: str, record: SynonymRecord) -> str:
    """Reconstruct an OBO `synonym:` line from a SynonymRecord."""
    parts: list[str] = [f'"{literal}"', record.scope]
    if record.type is not None:
        parts.append(record.type)
    parts.append("[" + ", ".join(record.xrefs) + "]")
    # fastobo 0.14 # if record.qualifiers:
    # fastobo 0.14 #     parts.append("{" + ", ".join(record.qualifiers) + "}")
    return "synonym: " + " ".join(parts)


def fmt_record(r: SynonymRecord, fields: list[str]) -> str:
    parts = []
    for f in fields:
        v = getattr(r, f)
        if isinstance(v, tuple):
            v = list(v)
        parts.append(f"{f}={v}")
    return " ".join(parts)


STDOUT_DETAIL_CAP = 10


def build_summary_markdown(
    label: str,
    non_synonym_changes: list[str],
    violations: list[Violation],
    modifications: dict[str, list[Modification]],
) -> str:
    """Pass/fail status and category counts only — no per-entry listings."""
    out = []
    out.append("# Synonym sync QC report")
    out.append("")
    out.append(f"`{label}`")
    out.append("")

    pass1 = (
        "PASS"
        if not non_synonym_changes
        else f"**FAIL** — number of non-synonym line changes: {len(non_synonym_changes)}"
    )
    pass2 = (
        "PASS"
        if not violations
        else f"**FAIL** — number of synonym add/delete events: {len(violations)}"
    )
    n_modifications = sum(len(v) for v in modifications.values())
    out += [
        f"- **Pass 1** (diff confined to `synonym:` lines): {pass1}",
        f"- **Pass 2** (`(term_id, literal)` set invariant): {pass2}",
        f"- **Number of modifications on existing synonyms**: {n_modifications}",
        "",
    ]

    out.append("## Modifications by category")
    out.append("")
    out.append("| Category | Count |")
    out.append("|---|---:|")
    for cat in (
        "scope_change",
        "modifier_change",
        "provenance_change",
        # fastobo 0.14 # "trailing_annotation_change",
    ):
        out.append(f"| {cat} | {len(modifications.get(cat, []))} |")
    out.append("")

    if modifications.get("provenance_change"):
        added, dropped = provenance_breakdown(modifications["provenance_change"])
        all_prefixes = sorted(set(added) | set(dropped))
        out.append("## Provenance xref changes by source prefix")
        out.append("")
        out.append("| Prefix | Added | Dropped |")
        out.append("|---|---:|---:|")
        for pfx in all_prefixes:
            out.append(f"| `{pfx}` | {added.get(pfx, 0)} | {dropped.get(pfx, 0)} |")
        out.append("")

    return "\n".join(out)


def build_report_markdown(
    label: str,
    non_synonym_changes: list[str],
    violations: list[Violation],
    modifications: dict[str, list[Modification]],
    term_labels: dict[str, str],
) -> str:
    """Full report: summary plus per-entry listings for every section."""
    out = [
        build_summary_markdown(label, non_synonym_changes, violations, modifications),
        "## Pass 1: non-synonym line changes",
        "",
    ]
    if not non_synonym_changes:
        out.append("No non-synonym lines changed.")
    else:
        out.append("<details>")
        out.append(f"<summary>Show {len(non_synonym_changes)} lines</summary>")
        out.append("")
        out.append("```diff")
        out.extend(non_synonym_changes)
        out.append("```")
        out.append("")
        out.append("</details>")
    out.append("")

    out.append("## Pass 2: synonym additions and deletions")
    out.append("")
    if not violations:
        out.append("No synonyms were added or removed.")
    else:
        out.append("<details>")
        out.append(f"<summary>Show {len(violations)} entries</summary>")
        out.append("")
        out.append("| Action | Term | Label | Synonym |")
        out.append("|---|---|---|---|")
        for cat, key, _ in violations:
            term, lit = key
            out.append(
                f"| {cat} | `{term}` | {term_labels.get(term, '')} | {lit} |"
            )
        out.append("")
        out.append("</details>")
    out.append("")

    for cat, fields in CATEGORY_FIELDS.items():
        entries = modifications.get(cat, [])
        if not entries:
            continue
        out.append("<details>")
        out.append(f"<summary>{cat} ({len(entries)})</summary>")
        out.append("")
        for key, a, b in entries:
            term, lit = key
            out.append(f"**`{term}`** _{term_labels.get(term, '')}_")
            out.append(f"- `{synonym_obo_line(lit, b)}`")
            out.append("")
            out.append("```diff")
            out.append(f"- {fmt_record(a, fields)}")
            out.append(f"+ {fmt_record(b, fields)}")
            out.append("```")
            out.append("")
        out.append("</details>")
        out.append("")

    return "\n".join(out)


@click.command(help="QC check for Mondo update-synonyms-sync output.")
@click.argument("file_a", type=click.Path(exists=True, dir_okay=False))
@click.argument("file_b", type=click.Path(exists=True, dir_okay=False), required=False)
@click.option(
    "-r",
    "--report",
    metavar="PATH",
    type=click.Path(dir_okay=False, writable=True),
    help="write the full markdown report (status + per-entry listings) to PATH",
)
@click.option(
    "-s",
    "--summary",
    metavar="PATH",
    type=click.Path(dir_okay=False, writable=True),
    help="write a markdown summary (status + category counts only) to PATH",
)
@click.option(
    "--ref",
    metavar="REF",
    help="compare REF:FILE_A vs REF~1:FILE_A (single-file mode only)",
)
def main(
    file_a: str,
    file_b: str | None,
    report: str | None,
    summary: str | None,
    ref: str | None,
) -> None:
    if ref is not None and file_b is not None:
        sys.exit("--ref cannot be combined with two file arguments")

    if ref is not None:
        pre_path = materialize_at_ref(file_a, f"{ref}~1")
        post_path = materialize_at_ref(file_a, ref)
        label = f"{ref}~1:{file_a} -> {ref}:{file_a}"
    elif file_b is None:
        pre_path = materialize_at_ref(file_a, "HEAD")
        post_path = file_a
        label = f"HEAD:{file_a} -> {file_a}"
    else:
        pre_path = file_a
        post_path = file_b
        label = f"{file_a} -> {file_b}"

    print(f"QC report: {label}")
    print()

    print("Pass 1 - diff confined to synonym lines:")
    non_synonym_changes = pass1_diff_confined(pre_path, post_path)
    if non_synonym_changes:
        print(f"  FAIL — number of non-synonym +/- lines: {len(non_synonym_changes)}")
        for ln in non_synonym_changes[:STDOUT_DETAIL_CAP]:
            print(f"    {ln}")
        if len(non_synonym_changes) > STDOUT_DETAIL_CAP:
            extra = len(non_synonym_changes) - STDOUT_DETAIL_CAP
            print(f"    ... {extra} more (see --report for full listing)")
    else:
        print("  PASS")
    print()

    print("Loading OBO files (fastobo)...")
    pre_synonyms, _ = extract_synonyms(pre_path)
    post_synonyms, post_labels = extract_synonyms(post_path)
    print(f"  pre:  {len(pre_synonyms)} synonyms")
    print(f"  post: {len(post_synonyms)} synonyms")
    print()

    print("Pass 2 - (term_id, literal) set invariant:")
    violations, modifications = pass2_structural(pre_synonyms, post_synonyms)
    if violations:
        violation_counts = Counter(v[0] for v in violations)
        print(f"  FAIL — number of synonym add/delete events: {len(violations)}")
        for cat, n in sorted(violation_counts.items()):
            print(f"    {cat:10s} {n}")
        for cat, key, _ in violations[:STDOUT_DETAIL_CAP]:
            term, lit = key
            print(f'    [{cat}] {term} "{lit}"')
        if len(violations) > STDOUT_DETAIL_CAP:
            extra = len(violations) - STDOUT_DETAIL_CAP
            print(f"    ... {extra} more (see --report for full listing)")
    else:
        print("  PASS")
    print()

    n_modifications = sum(len(v) for v in modifications.values())
    print(f"Number of modifications to existing synonyms: {n_modifications}")
    for cat in (
        "scope_change",
        "modifier_change",
        "provenance_change",
        # fastobo 0.14 # "trailing_annotation_change",
    ):
        print(f"  {cat:30s} {len(modifications.get(cat, []))}")

    if modifications.get("provenance_change"):
        added, dropped = provenance_breakdown(modifications["provenance_change"])
        all_prefixes = sorted(set(added) | set(dropped))
        print()
        print("Provenance xref breakdown (per source prefix):")
        print(f"  {'prefix':30s} {'added':>8s} {'dropped':>8s}")
        for pfx in all_prefixes:
            print(f"  {pfx:30s} {added.get(pfx, 0):>8d} {dropped.get(pfx, 0):>8d}")

    if summary:
        with open(summary, "w") as f:
            f.write(
                build_summary_markdown(
                    label, non_synonym_changes, violations, modifications,
                )
            )
        print()
        print(f"Markdown summary written to {summary}")

    if report:
        with open(report, "w") as f:
            f.write(
                build_report_markdown(
                    label, non_synonym_changes, violations, modifications,
                    post_labels,
                )
            )
        print()
        print(f"Full markdown report written to {report}")

    if non_synonym_changes or violations:
        sys.exit(1)


if __name__ == "__main__":
    main()

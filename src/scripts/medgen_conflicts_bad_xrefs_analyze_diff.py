"""MedGen conflicts: updates QC analysis

QC analysis for updates to mondo-edit.obo concerning removal of xrefs due to MedGen conflicts.

See also:
- GH issue: https://github.com/monarch-initiative/mondo-ingest/issues/273
"""
from argparse import ArgumentParser
from collections import Counter
from pathlib import Path

import pandas as pd

SCRIPTS_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPTS_DIR.parent.parent
TMP_DIR = PROJECT_DIR / "src" / "ontology" / "tmp"
INPUT_FILE = str(TMP_DIR / "mondo-edit.obo.tmp.diff")
OUTPUT_FILE = str(TMP_DIR / "report-qc-medgen-conflicts-update-diff.tsv")


def run(input_file: str = INPUT_FILE, output_file: str = OUTPUT_FILE):
    """Run analysis and generate output"""
    report = {}

    # Read diff
    with open(input_file) as f:
        lines = f.readlines()

    # Remove hashes, leaving only the edited lines themselves
    lines = [l for l in lines if l.startswith('<') or l.startswith('>')]

    # Report: How many lines added/removed
    report['n_lines_removed'] = len([x for x in lines if x.startswith('<')])
    # report['n_lines_added'] = len([x for x in lines if x.startswith('>')])  # 0

    # Remove '< ' / '> '
    lines = [x[2:] for x in lines]

    # Report: How many xrefs / non-xrefs removed
    xref_removals = [l for l in lines if l.startswith('xref')]
    report['n_xrefs_removed'] = len(xref_removals)
    non_xref_removals = [l for l in lines if not l.startswith('xref')]
    report['n_non_xrefs_removals'] = len(non_xref_removals)

    # Report: Non-xref removals detailes
    report['non_xref_removals_content'] = ''
    for l in non_xref_removals:
        report['non_xref_removals_content'] += l

    # Report: Non MedGen xrefs removed that got tagged because UMLS was a source
    non_umls_removals = [x for x in xref_removals if not x.startswith('xref: UMLS')]
    report['n_xrefs_removed_cuz_umls_was_a_source'] = len(non_umls_removals)

    # Report: Number of MedGen xrefs removed
    umls_removals = [x for x in xref_removals if x.startswith('xref: UMLS')]
    report['n_umls_removals'] = len(umls_removals)

    # Report: MedGen xref deletions on multiple Mondo IDs
    cui_removal_counts = {}
    for l in umls_removals:
        parts = l.split(' ')
        cui = parts[1]
        if cui not in cui_removal_counts:
            cui_removal_counts[cui] = 0
        cui_removal_counts[cui] += 1
    n_removal_frequency = Counter(cui_removal_counts.values())
    for k, v in n_removal_frequency.items():
        report[f'n_single_cui_removed_from_xrefs_n_times__{k}'] = v

    # Saved
    df = pd.DataFrame([{'metric_name': k, 'val': v}  for k, v in report.items()])
    df.to_csv(output_file, sep='\t', index=False)

def cli():
    """Command line interface."""
    parser = ArgumentParser(
        prog='MedGen conflicts: updates QC analysis',
        description='QC analysis for updates to mondo-edit.obo concerning removal of xrefs due to MedGen conflicts')
    parser.add_argument(
        '-i', '--input-file', default=INPUT_FILE, help='Diff of mondo-edit.obo and mondo-edit.obo.tmp')
    parser.add_argument(
        '-o', '--output-file', default=OUTPUT_FILE, help='Analysis results')
    run(**vars(parser.parse_args()))


if __name__ == '__main__':
    cli()

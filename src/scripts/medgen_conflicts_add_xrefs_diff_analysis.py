"""MedGen conflicts: Additions analysis

QC analysis of diff of additions from (a) ingest and from (b) curated conflicts. Expect (b) to be 100% subset of (a).

See also:
- GH issue: https://github.com/monarch-initiative/mondo-ingest/issues/273
"""
from argparse import ArgumentParser
from pathlib import Path
from typing import Set

import pandas as pd

SCRIPTS_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPTS_DIR.parent.parent
TMP_DIR = PROJECT_DIR / "src" / "ontology" / "tmp"
TEMPLATES_DIR = PROJECT_DIR / "src" / "templates"
INPUT_FILE_INGEST = TEMPLATES_DIR / 'ROBOT_addMedGen_fromIngest.tsv'
INPUT_FILE_CONFLICTS = TEMPLATES_DIR / 'ROBOT_addMedGen_fromConflictResolution.tsv'
OUTPUT_FILE = str(TMP_DIR / "report-qc-medgen-conflicts-adds-diff.tsv")


terms_from_file = lambda x: set([x.split(':')[1] for x in pd.read_csv(x, sep='\t', skiprows=1)['A oboInOwl:hasDbXref']])

def run(
    input_from_ingest: str = INPUT_FILE_INGEST, input_from_conflicts = INPUT_FILE_CONFLICTS,
    output_file: str = OUTPUT_FILE
):
    """Run analysis and generate output"""
    ingest: Set[str] = terms_from_file(input_from_ingest)
    conflicts: Set[str] = terms_from_file(input_from_conflicts)
    out_df_ingest = pd.DataFrame({'in_ingest_not_in_conflicts': list(ingest - conflicts)})  # n=35,567
    out_df_conflicts = pd.DataFrame({'in_conflicts_not_in_ingest': list(conflicts - ingest)})  # n=278
    out_df = pd.concat([out_df_conflicts, out_df_ingest]).sort_values('in_conflicts_not_in_ingest', ascending=False)
    out_df.to_csv(output_file, sep='\t', index=False)

def cli():
    """Command line interface."""
    parser = ArgumentParser(
        prog='MedGen conflicts: Additions analysis',
        description='QC analysis of diff of additions from (a) ingest and from (b) curated conflicts. Expect (b) to be '
                    '100% subset of (a).')
    parser.add_argument(
        '-i', '--input-from-ingest', default=INPUT_FILE_INGEST,
        help='Robot template for xref additions stemming from MedGen ingest.')
    parser.add_argument(
        '-c', '--input-from-conflicts', default=INPUT_FILE_CONFLICTS,
        help='Robot template for xref additions stemming curated conflicts file.')
    parser.add_argument(
        '-o', '--output-file', default=OUTPUT_FILE, help='Analysis results')
    run(**vars(parser.parse_args()))


if __name__ == '__main__':
    cli()

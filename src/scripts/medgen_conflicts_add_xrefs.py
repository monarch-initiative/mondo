"""MedGen conflicts: Add new xrefs

From excel file containing workseets about MedGen conflicts, following removal of xrefs, create a robot template that
will be used to add xrefs.

See also:
- GH issue: https://github.com/monarch-initiative/mondo-ingest/issues/273
- Megan Kane's source files including readme.txt that goes over each sheet:
  https://github.com/monarch-initiative/mondo-ingest/issues/273#issuecomment-1632774012
"""
from argparse import ArgumentParser
from copy import copy
from pathlib import Path
from typing import Dict, List

import pandas as pd

SCRIPTS_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPTS_DIR.parent.parent
ONTOLOGY_DIR = PROJECT_DIR / "src" / "ontology"
TEMPLATES_DIR = PROJECT_DIR / "src" / "templates"
TMP_DIR = ONTOLOGY_DIR / "tmp"
INPUT_FILE = str(TMP_DIR / "July2023_CUIReports_FromMedGentoMondo.xlsx")
OUTPUT_FILE = str(TEMPLATES_DIR / "ROBOT_addMedGen_fromConflictResolution.tsv")


def _prefixed_id_rows_from_common_df(source_df: pd.DataFrame, mondo_col='mondo_id', xref_col='xref_id') -> List[Dict]:
    """From worksheets having same common format, get prefixed xrefs for the namespaces we're looking to cover

    Note: This same exact function is used in:
    - mondo repo: medgen_conflicts_add_xrefs.py
    - medgen repo: mondo_robot_template.py"""
    df = copy(source_df)
    df[xref_col] = df[xref_col].apply(
        lambda x: f'MEDGENCUI:{x}' if x.startswith('CN')  # "CUI Novel"
        else f'UMLS:{x}' if x.startswith('C')  # CUI: will be created twice: one for MEDGENCUI, one for UMLS
        else f'MEDGEN:{x}')  # UID
    rows = df.to_dict('records')
    rows2 = [{mondo_col: x[mondo_col], xref_col: x[xref_col].replace('UMLS', 'MEDGENCUI')} for x in rows if
             x[xref_col].startswith('UMLS')]
    return rows + rows2


def run(input_file: str = INPUT_FILE, output_file: str = OUTPUT_FILE):
    """Create robot template"""
    rows: List[Dict] = []
    book = pd.ExcelFile(input_file)

    # Sheet 1/5: Bad_CNxRefs_withCUI
    # - summary: MedGen team has suggested us better mappings to use on these Mondo IDs.
    # - recommended action: Add xrefs
    df = book.parse("Bad_CNxRefs_withCUI").rename(columns={'medgen_xref_current': 'xref_id'})
    del df['mondo_xref_bad']
    rows += _prefixed_id_rows_from_common_df(df)

    # Sheet 2/5: WrongCUIxref_withCurrCUI
    # - summary: MedGen team has suggested us better mappings to use on these Mondo IDs.
    # - recommended action: Add xrefs
    df = book.parse("WrongCUIxref_withCurrCUI").rename(columns={'medgen_xref_current': 'xref_id'})
    del df['mondo_xref_bad']
    rows += _prefixed_id_rows_from_common_df(df)

    # Sheet 3/5: 1MondoID_to1CUI
    # - summary: MedGen has identified better Mondo IDs to map to these CUIs. 
    # - recommended action: Add xrefs
    df = book.parse(">1MondoID_to1CUI").rename(columns={'mondo_id2(MedGen)': 'mondo_id', 'UMLS_CUI': 'xref_id'})
    del df['mondo_id(Mondo)']
    rows += _prefixed_id_rows_from_common_df(df)

    # Sheet 4/5: Mondo_MedGen_CUImismatch_1Mondo
    # - summary: We have Mondo terms that have xrefs to multiple MedGen CUIs. Only 1 of them should be left in.
    # - recommended action: Nothing. Removals done in previous step. Good xref ref'ed in sheet still exists.
    pass

    # Sheet 5/5: MondoXrefs_NotinMedGen
    # - summary: These terms do not exist in MedGen.
    # - recommended action: Nothing. Removals done in previous step. No other actions from this sheet.
    pass

    # Output: List of CUIs of bad xrefs
    out_df = pd.DataFrame(rows).sort_values(['xref_id', 'mondo_id']).drop_duplicates()
    out_df['mondo_id'] = out_df['mondo_id'].apply(lambda x: x.replace('_', ':'))
    out_df = pd.concat([pd.DataFrame([{'mondo_id': 'ID', 'xref_id': 'A oboInOwl:hasDbXref'}]), out_df])
    out_df.to_csv(output_file, index=False, sep='\t')

def cli():
    """Command line interface."""
    parser = ArgumentParser(
        prog='MedGen conflicts: Add new xrefs',
        description='From excel file containing workseets about MedGen conflicts, following removal of xrefs, create a '
                    'robot template that will be used to add xrefs.')
    parser.add_argument(
        '-i', '--input-file', default=INPUT_FILE, help='Excel file containing conflitcs sheets')
    parser.add_argument(
        '-o', '--output-file', default=OUTPUT_FILE, help='ROBOT template to be used to add xrefs')
    run(**vars(parser.parse_args()))


if __name__ == '__main__':
    cli()

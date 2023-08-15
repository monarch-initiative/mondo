"""MedGen conflicts: Add new xrefs

From excel file containing workseets about MedGen conflicts, following removal of xrefs, create a robot template that
will be used to add xrefs.

See also:
- GH issue: https://github.com/monarch-initiative/mondo-ingest/issues/273
- Megan Kane's source files including readme.txt that goes over each sheet:
  https://github.com/monarch-initiative/mondo-ingest/issues/273#issuecomment-1632774012
"""
from argparse import ArgumentParser
from pathlib import Path
from typing import Dict, List

import pandas as pd

SCRIPTS_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPTS_DIR.parent.parent
ONTOLOGY_DIR = PROJECT_DIR / "src" / "ontology"
TMP_DIR = ONTOLOGY_DIR / "tmp"
TEMPLATES_DIR = ONTOLOGY_DIR / "templates"
INPUT_FILE = str(TMP_DIR / "July2023_CUIReports_FromMedGentoMondo.xlsx")
OUTPUT_FILE = str(TEMPLATES_DIR / "ROBOT_addMedGen_fromConflictResolution.tsv")


def run(input_file: str = INPUT_FILE, output_file: str = OUTPUT_FILE):
    """Create robot template"""
    rows: List[Dict] = []
    book = pd.ExcelFile(input_file)

    # TODO: for each sheet, for each replacement, {mondo_id: ID, umls_id: ID}
    #  - convert to_dict(), drop the column not needed, and rename columns?
    # Sheet 1/5: Bad_CNxRefs_withCUI
    # - summary: MedGen team has suggested us better mappings to use on these Mondo IDs.
    # - recommended action:
    df = book.parse("Bad_CNxRefs_withCUI")
    pass

    # Sheet 2/5: WrongCUIxref_withCurrCUI
    # - summary: MedGen team has suggested us better mappings to use on these Mondo IDs.
    # - recommended action:
    df = book.parse("WrongCUIxref_withCurrCUI")
    pass

    # Sheet 3/5: 1MondoID_to1CUI
    # - summary: MedGen has identified better Mondo IDs to map to these CUIs. 
    # - recommended action:
    df = book.parse(">1MondoID_to1CUI")
    pass

    # Sheet 4/5: Mondo_MedGen_CUImismatch_1Mondo
    # - summary: We have Mondo terms that have xrefs to multiple MedGen CUIs. Only 1 of them should be left in.
    # - recommended action: Nothing. Removals done in previous step. Good xref ref'ed in sheet still exists.
    pass

    # Sheet 5/5: MondoXrefs_NotinMedGen
    # - summary: These terms do not exist in MedGen.
    # - recommended action: Nothing. Removals done in previous step. No other actions from this sheet.
    pass

    # Output: List of CUIs of bad xrefs
    out_df = pd.DataFrame([{'mondo_id': 'ID', 'umls_id': 'A oboInOwl:hasDbXref'}] + rows)
    out_df.to_csv(output_file, index=False, header=False)

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

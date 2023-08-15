"""MedGen conflicts: Collate bad medgen xrefs

From excel file containing workseets about MedGen conflicts, create a text file that lists all the bad CUIs for xrefs
that need to be removed from Mondo.

See also:
- GH issue: https://github.com/monarch-initiative/mondo-ingest/issues/273
- Megan Kane's source files including readme.txt that goes over each sheet:
  https://github.com/monarch-initiative/mondo-ingest/issues/273#issuecomment-1632774012
"""
from argparse import ArgumentParser
from pathlib import Path
from typing import List, Set, Union

import pandas as pd

SCRIPTS_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPTS_DIR.parent.parent
TMP_DIR = PROJECT_DIR / "src" / "ontology" / "tmp"
INPUT_FILE = str(TMP_DIR / "July2023_CUIReports_FromMedGentoMondo.xlsx")
OUTPUT_FILE = str(TMP_DIR / "bad-medgen-xrefs.txt")


def run(input_file: str = INPUT_FILE, output_file: str = OUTPUT_FILE):
    """Collate conflicts into single text file"""
    book = pd.ExcelFile(input_file)
    bad_xref_cuis: Set[Union[str, int]] = set()

    # Sheet 1/5: Bad_CNxRefs_withCUI
    # - summary: MedGen team has suggested us better mappings to use on these Mondo IDs.
    # - recommended action: For Mondo terms identified in "mondo_id", remove the xrefs identified in "mondo_xref_bad".
    df = book.parse("Bad_CNxRefs_withCUI")
    bad_xref_cuis.update(df['mondo_xref_bad'].tolist())

    # Sheet 2/5: WrongCUIxref_withCurrCUI
    # - summary: MedGen team has suggested us better mappings to use on these Mondo IDs.
    # - recommended action: For Mondo terms identified in "mondo_id", remove the xrefs identified in "mondo_xref_bad".
    df = book.parse("WrongCUIxref_withCurrCUI")
    bad_xref_cuis.update(df['mondo_xref_bad'].tolist())

    # Sheet 3/5: 1MondoID_to1CUI
    # - summary: MedGen has identified better Mondo IDs to map to these CUIs. 
    # - recommended action: For terms in the "mondo_id(Mondo)" column, remove xrefs identified in the "UMLS_CUI" column.
    df = book.parse(">1MondoID_to1CUI")
    bad_xref_cuis.update(df['UMLS_CUI'].tolist())

    # Sheet 4/5: Mondo_MedGen_CUImismatch_1Mondo
    # - summary: We have Mondo terms that have xrefs to multiple MedGen CUIs. Only 1 of them should be left in.
    # - recommended action: Remove incorrect xrefs; the ones not identified in the "MedGenCUI" column.
    df = book.parse("Mondo_MedGen_CUImismatch_1Mondo")
    to_remove = list(df.apply(
        lambda row: [x for x in row['medgen_query'].split(' OR ')
                     if 'MONDO' not in x
                     and x != row['MedGenCUI']][0], axis=1))
    bad_xref_cuis.update(to_remove)

    # Sheet 5/5: MondoXrefs_NotinMedGen
    # - summary: These terms do not exist in MedGen.
    # - recommended action: Remove these xrefs.
    df = book.parse("MondoXrefs_NotinMedGen")
    bad_xref_cuis.update(df['ref_target'].tolist())

    # Convert to strings and sort
    bad_xref_cuis: List[str] = sorted([str(x) for x in bad_xref_cuis])

    # Output: List of CUIs of bad xrefs
    out_df = pd.DataFrame(bad_xref_cuis, columns=['bad_xref_cuis'])
    out_df.to_csv(output_file, index=False, header=False)

def cli():
    """Command line interface."""
    parser = ArgumentParser(
        prog='MedGen conflicts: Collate bad medgen xrefs',
        description='From excel file containing workseets about MedGen conflicts, create a text file that lists all '
                    'the bad CUIs for xrefs that need to be removed from Mondo.')
    parser.add_argument(
        '-i', '--input-file', default=INPUT_FILE, help='Excel file containing conflitcs sheets')
    parser.add_argument(
        '-o', '--output-file', default=OUTPUT_FILE, help='Txt file to contain CUIs for bad xrefs')
    run(**vars(parser.parse_args()))


if __name__ == '__main__':
    cli()

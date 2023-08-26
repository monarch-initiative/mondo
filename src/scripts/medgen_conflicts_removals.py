"""MedGen conflicts: Removals

From excel file containing workseets about MedGen conflicts, create a new mondo-edit.obo that has bad xrefs removed.
Also remove MEDGEN: xrefs and axiom annotations.

TODO: Ideally would refactor this to OAK, if its possible. SqlImplementation. Query classes. Can OAK actually write itself back out? Can serialize back to OBO after?

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
ONTOLOGY_DIR = PROJECT_DIR / "src" / "ontology"
TMP_DIR = ONTOLOGY_DIR / "tmp"
INPUT_CONFLICTS = str(TMP_DIR / "July2023_CUIReports_FromMedGentoMondo.xlsx")
INPUT_OBO = str(ONTOLOGY_DIR / "mondo-edit.obo")
OUTPUT_FILE = str(TMP_DIR / "mondo-edit.obo.tmp")


def collate_xref_removals(input_file: str = INPUT_CONFLICTS) -> List[str]:
    """Collate xref removals"""
    book = pd.ExcelFile(input_file)
    bad_xref_ids: Set[Union[str, int]] = set()

    # Sheet 1/5: Bad_CNxRefs_withCUI
    # - summary: MedGen team has suggested us better mappings to use on these Mondo IDs.
    # - recommended action: For Mondo terms identified in "mondo_id", remove the xrefs identified in "mondo_xref_bad".
    df = book.parse("Bad_CNxRefs_withCUI")
    bad_xref_ids.update(df['mondo_xref_bad'].tolist())

    # Sheet 2/5: WrongCUIxref_withCurrCUI
    # - summary: MedGen team has suggested us better mappings to use on these Mondo IDs.
    # - recommended action: For Mondo terms identified in "mondo_id", remove the xrefs identified in "mondo_xref_bad".
    df = book.parse("WrongCUIxref_withCurrCUI")
    bad_xref_ids.update(df['mondo_xref_bad'].tolist())

    # Sheet 3/5: 1MondoID_to1CUI
    # - summary: MedGen has identified better Mondo IDs to map to these CUIs.
    # - recommended action: For terms in the "mondo_id(Mondo)" column, remove xrefs identified in the "UMLS_CUI" column.
    df = book.parse(">1MondoID_to1CUI")
    bad_xref_ids.update(df['UMLS_CUI'].tolist())

    # Sheet 4/5: Mondo_MedGen_CUImismatch_1Mondo
    # - summary: We have Mondo terms that have xrefs to multiple MedGen CUIs. Only 1 of them should be left in.
    # - recommended action: Remove incorrect xrefs; the ones not identified in the "MedGenCUI" column.
    df = book.parse("Mondo_MedGen_CUImismatch_1Mondo")
    to_remove = list(df.apply(
        lambda row: [x for x in row['medgen_query'].split(' OR ')
                     if 'MONDO' not in x
                     and x != row['MedGenCUI']][0], axis=1))
    bad_xref_ids.update(to_remove)

    # Sheet 5/5: MondoXrefs_NotinMedGen
    # - summary: These terms do not exist in MedGen.
    # - recommended action: Remove these xrefs.
    df = book.parse("MondoXrefs_NotinMedGen")
    bad_xref_ids.update(df['ref_target'].tolist())

    # Convert to strings and sort
    bad_xref_ids: List[str] = sorted([str(x) for x in bad_xref_ids])
    return bad_xref_ids


def run(input_conflicts: str = INPUT_CONFLICTS, input_obo: str = INPUT_OBO, output: str = OUTPUT_FILE):
    """Run"""
    # Vars
    exceptions = ['MONDO:preferredExternal', 'https://orcid.org']
    new_lines = []
    with open(input_obo, 'r') as f:
        lines = f.readlines()
    bad_xref_ids: List[str] = collate_xref_removals(input_conflicts)

    i = 0
    # Modifications
    for line in lines:
        if line.startswith('xref: UMLS:') and line.split()[1].replace('UMLS:', '') in bad_xref_ids:
            continue  # don't add to new file; effectively remove
        elif (line.startswith('xref: MEDGEN:') or line.startswith('xref: MedGen:')
              and not any([x in line for x in exceptions])):
            i+=1
            continue  # don't add to new file; effectively remove
        # Not implementating this since there was only 1 case and it was handled in the first condition
        # elif 'source="MEDGEN' in line or 'source="MedGen' in line:
        #     # Handle different cases:
        #     #  (i) it's the only annotation,
        #     #  (ii) multiple annotations, last entry,
        #     #  (ii) multiple annotations, non-last-entry
        new_lines.append(line)

    # Write new file
    with open(output, 'w') as f:
        f.writelines(new_lines)


def cli():
    """Command line interface."""
    parser = ArgumentParser(
        prog='MedGen conflicts: Removals',
        description='From excel file containing workseets about MedGen conflicts, create a new mondo-edit.obo that has'
                    ' bad xrefs removed. Also remove MEDGEN: xrefs and axiom annotations.')
    parser.add_argument(
        '-i', '--input-conflicts', default=INPUT_CONFLICTS, help='Excel file containing conflitcs sheets')
    parser.add_argument(
        '-I', '--input-obo', default=INPUT_OBO, help='OBO file to update')
    parser.add_argument(
        '-o', '--output', default=OUTPUT_FILE, help='A new version of mondo-edit.obo')
    run(**vars(parser.parse_args()))


if __name__ == '__main__':
    cli()

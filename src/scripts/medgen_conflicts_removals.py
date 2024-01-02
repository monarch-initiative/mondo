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
from typing import Dict, List, Set, Tuple, Union

import pandas as pd

SCRIPTS_DIR = Path(__file__).parent
PROJECT_DIR = SCRIPTS_DIR.parent.parent
ONTOLOGY_DIR = PROJECT_DIR / "src" / "ontology"
TMP_DIR = ONTOLOGY_DIR / "tmp"
INPUT_CONFLICTS = str(TMP_DIR / "July2023_CUIReports_FromMedGentoMondo.xlsx")
INPUT_OBO = str(ONTOLOGY_DIR / "mondo-edit.obo")
OUTPUT_FILE = str(TMP_DIR / "mondo-edit.obo.tmp")
XREF_REMOVAL_EXCEPTION_TOKENS = ['MONDO:preferredExternal', 'https://orcid.org']
NAMESPACES = ['UMLS', 'MEDGEN', 'MedGen']


def collate_xref_removals(input_file: str = INPUT_CONFLICTS) -> Tuple[List[str], Dict[str, List[str]]]:
    """Collate xref removals"""
    book = pd.ExcelFile(input_file)
    bad_medgen_ids: Set[Union[str, int]] = set()
    bad_xrefs_by_mondo_id: Dict[str, List[str]] = {}

    # Sheet 1/5: Bad_CNxRefs_withCUI
    # - summary: MedGen team has suggested us better mappings to use on these Mondo IDs (use CUIs instead of CNs)
    # - recommended action: For Mondo terms identified in "mondo_id", remove the xrefs identified in "mondo_xref_bad".
    df = book.parse("Bad_CNxRefs_withCUI")
    for _, row in df.iterrows():
        bad_xrefs_by_mondo_id.setdefault(row['mondo_id'], []).append(row['mondo_xref_bad'])

    # Sheet 2/5: WrongCUIxref_withCurrCUI
    # - summary: MedGen team has suggested us better mappings to use on these Mondo IDs (replace bad CUIs)
    # - recommended action: For Mondo terms identified in "mondo_id", remove the xrefs identified in "mondo_xref_bad".
    df = book.parse("WrongCUIxref_withCurrCUI")
    for _, row in df.iterrows():
        bad_xrefs_by_mondo_id.setdefault(row['mondo_id'], []).append(row['mondo_xref_bad'])

    # Sheet 3/5: 1MondoID_to1CUI
    # - summary: MedGen has identified better Mondo IDs to map to these CUIs.
    # - recommended action: For terms in the "mondo_id(Mondo)" column, remove xrefs identified in the "UMLS_CUI" column.
    df = book.parse(">1MondoID_to1CUI")
    for _, row in df.iterrows():
        bad_xrefs_by_mondo_id.setdefault(row['mondo_id(Mondo)'], []).append(row['UMLS_CUI'])

    # Sheet 4/5: Mondo_MedGen_CUImismatch_1Mondo
    # - summary: We have Mondo terms that have xrefs to multiple MedGen CUIs. Only 1 of them should be left in.
    # - recommended action: Remove incorrect xrefs; the ones not identified in the "MedGenCUI" column.
    df = book.parse("Mondo_MedGen_CUImismatch_1Mondo")
    for _, row in df.iterrows():
        to_remove = [x for x in row['medgen_query'].split(' OR ') if 'MONDO' not in x and x != row['MedGenCUI']][0]
        bad_xrefs_by_mondo_id.setdefault(row['mondo_id'], []).append(to_remove)


    # Sheet 5/5: MondoXrefs_NotinMedGen
    # - summary: These terms do not exist in MedGen.
    # - recommended action: Remove these xrefs.
    df = book.parse("MondoXrefs_NotinMedGen")
    bad_medgen_ids.update(df['ref_target'].tolist())
    bad_medgen_ids: List[str] = sorted([str(x) for x in bad_medgen_ids])

    # Properly format CURIEs
    bad_xrefs_by_mondo_id2: Dict[str, List[str]] = {}
    for k, v in bad_xrefs_by_mondo_id.items():
        bad_xrefs_by_mondo_id2[k.replace('_', ':')] = v

    return bad_medgen_ids, bad_xrefs_by_mondo_id2


def run(input_conflicts: str = INPUT_CONFLICTS, input_obo: str = INPUT_OBO, output: str = OUTPUT_FILE):
    """Run"""
    new_lines = []
    with open(input_obo, 'r') as f:
        lines = f.readlines()
    bad_medgen_ids, bad_xrefs_by_mondo_id = collate_xref_removals(input_conflicts)

    # Remove bad xrefs
    current_mondo_id = None
    for line in lines:
        if line.startswith('id: MONDO:'):
            current_mondo_id = line.split()[1]

        # Don't remove line if it is not recognized as a bad xref
        if (current_mondo_id not in bad_xrefs_by_mondo_id
            or not line.startswith('xref: ')
            or not any([line.split()[1].startswith(x) for x in NAMESPACES])):
            new_lines.append(line)
            continue

        # All lines past this point will be xrefs
        xref_curie = line.split()[1]
        prefix, unprefixed_id = xref_curie.split(':')

        # Remove xrefs to MedGen IDs that don't exist
        if prefix in NAMESPACES and unprefixed_id in bad_medgen_ids:
            continue
        # Remove if this xref for this Mondo term is marked as bad
        elif unprefixed_id in bad_xrefs_by_mondo_id[current_mondo_id]:
            continue
        # Else: xref is good; keep the line
        new_lines.append(line)

        # XREF_REMOVAL_EXCEPTION_TOKENS: Not using since was only 1 case and it was handled by another condition
        # prefix = xref_id.split(':')[0]
        # if prefix in ['MedGen', 'MEDGEN'] and any([x in line for x in XREF_REMOVAL_EXCEPTION_TOKENS]):
        #     new_lines.append(line)
        #     continue
        # elif 'source="MEDGEN' in line or 'source="MedGen' in line:
        #     # Handle different cases:
        #     #  (i) it's the only annotation,
        #     #  (ii) multiple annotations, last entry,
        #     #  (ii) multiple annotations, non-last-entry

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

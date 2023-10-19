import logging
from typing import List, Tuple
from oaklib import get_adapter
from oaklib.datamodels.vocabulary import IS_A, PART_OF
from pathlib import Path
import csv
import click
import pandas as pd
import numpy as np

ONT_DIR = Path(__file__).resolve().parents[1] / "ontology"
TMP_DIR = Path.joinpath(ONT_DIR, "tmp")
RETAINS_ANCESTOR = "RETAINS_ANCESTOR"
RETAINS_PARENT = "RETAINS_PARENT"
LEAVES_THE_BRANCH = "Leaves the branch"
ORPHANED = "Orphaned"
STAYS_IN_THE_BRANCH = "Stays in branch"
UNDEFINED = "Undefined"
DISEASE = "MONDO:0000001"
HUMAN_DISEASE = "MONDO:0700096"
DISEASE_LABELED = "MONDO:0000001->disease"
HUMAN_DISEASE_LABELED = "MONDO:0700096->human disease"
DISEASES_SET = {DISEASE, HUMAN_DISEASE, DISEASE_LABELED, HUMAN_DISEASE_LABELED}
# Define the column names for the output file
COLUMN_NAMES = [
    "Branch reviewed ID",
    "Children of the obsoletion candidate ID",
    "Children of the obsoletion candidate label",
    "Children of the obsoletion candidate Definition",
    "Parent to be obsoleted",
    "Other direct parents in Branch",
    "Other direct parents NOT in Branch",
    "Ancestor inside the branch",
    "Ancestor outside the branch",
    "AffectedStatus",
]


logger = logging.getLogger(__name__)


@click.group()
@click.option("-v", "--verbose", count=True)
@click.option("-q", "--quiet")
def main(verbose: int, quiet: bool):
    """
    CLI for custom mondo diff.

    :param verbose: Verbosity while running.
    :param quiet: Boolean to be quiet or verbose.
    """
    if verbose >= 2:
        logger.setLevel(level=logging.DEBUG)
    elif verbose == 1:
        logger.setLevel(level=logging.INFO)
    else:
        logger.setLevel(level=logging.WARNING)
    if quiet:
        logger.setLevel(level=logging.ERROR)


@main.command()
@click.option("-i", "--input", help="DB file to be compared.")
@click.option("-b", "--branch-id-file", help="TSV with one column of obsoletion CURIEs")
@click.option("-m", "--main-db", help="DB source file.")
@click.option("-o", "--output-file", help="Path to report file")
def create_custom_mondo_diff(
    input, branch_id_file, main_db, output_file
):
    OI_COMPARE = get_adapter(f"sqlite:{input}")
    OI_MAIN = get_adapter(f"sqlite:{main_db}")
    
    all_compare_obsoletes = set(OI_COMPARE.obsoletes())
    all_main_obsoletes = set(OI_MAIN.obsoletes())

    diff_obsoletes = all_main_obsoletes - all_compare_obsoletes
    print('** Obsoletes')
    print(len(diff_obsoletes)) # Expect 35
    print(diff_obsoletes)


    # If a file containing branch_ids is provided
    if branch_id_file:
        with open(branch_id_file, "r") as f:
            reader = csv.reader(f, delimiter="\t")
            # Store the first element of each row in the branch_ids list
            branch_ids = [row[0] for row in reader]
            # print('\n---\nBIDs: ', len(branch_ids)) # EXpect 39 branch_ids
            # print(branch_ids)
    else:
        raise (
            ValueError(
                "Please provide a `--branch-id-file` to get results."
            )
        )

    # Create a dictionary where each key is a branch_id and the value is a set of its descendants
    # previous_branch_descendants_dict = {
    #     id: set(OI_COMPARE.descendants(start_curies=id, predicates=[IS_A, PART_OF]))
    #     for id in branch_ids
    # }

    children_of_obsoletion_candidate = set()
    
    children_of_obsoletion_candidate_parents_relationship = set(
                OI_COMPARE.relationships(
                    subjects=children_of_obsoletion_candidate,
                    predicates=[IS_A, PART_OF],
                )
            )


    # Get previous parents for MONDO:0018532, Note, the actual parent is also returned in the list
    parents_of_child = (
                    set(
                        get_immediate_parent(
                            curie='MONDO:0018532', # Replace this with iteration of "diff_obsoletes"
                            relationships=children_of_obsoletion_candidate_parents_relationship,
                        )
                    )
                    - diff_obsoletes
    ) 
    print("\n** Prev Parents for MONDO:0018532", parents_of_child)


    # for k,v in previous_branch_descendants_dict.items():
    #     if k == 'MONDO:0045024': # MONDO:0045024 (cancer or benign tumor) with obsoletion candidate MONDO:0018532
    #         print('\n--\n** PBDD: ')
    #         print(k,v)


    # Let's also create a Markdown file
    # List of classes that changed their parents, ID, label, old parent(s), new parents(s)
    

def get_immediate_parent(curie: str, relationships: List[Tuple[str]]):
        return [t[2] for t in relationships if t[0] == curie and t[1] in [IS_A, PART_OF]]


if __name__ == "__main__":
    main()
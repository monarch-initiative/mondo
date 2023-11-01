import logging
from typing import List, Tuple
from oaklib import get_adapter
from oaklib.datamodels.vocabulary import IS_A, PART_OF
from pathlib import Path
import csv
import click
import pandas as pd
import numpy as np
import sys
from typing import Type
import json


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
    "Curie Obsoleted",
    "Label",
    "Previous Parent(s)",
    "Branch(es)",
    "Current Parent(s)",
    "Current Branch(es)"
]


logger = logging.getLogger(__name__)


@click.group()
@click.option("-v", "--verbose", count=True, help="The count of occurrences of 'v' sets logging level, e.g. -vv sets DEBUG level.")
@click.option("-q", "--quiet", is_flag=True, help="Overrides verbose option and sets logging level to ERROR only.")
def main(verbose: int, quiet: bool):
    """
    CLI for custom mondo diff.

    :param verbose: Verbosity for logging messages.
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

    logging.basicConfig(level=logger.getEffectiveLevel(), format='%(asctime)s - %(name)s - %(levelname)s: %(message)s', datefmt="%Y-%m-%d %H:%M:%S")
    


@main.command()
@click.option("-m", "--mainbase-db", required=True, help="DB file (version from PR).")
@click.option("-c", "--currentbase-db", required=True, help="DB file to be compared to (last released version).")
@click.option("-b", "--branch-id-file", required=True, help="TSV with one column of CURIEs of the ontology branches.")
@click.option("-o", "--output-file", help="Path to report file")
def create_custom_mondo_diff(mainbase_db, currentbase_db, branch_id_file, output_file):
    logger = logging.getLogger("custom-mondo-diff")
    logger.info("Connecting to local ontology sources...")
    
    # Create db adapters
    global OI_MAINBASE 
    global OI_CURRENTBASE

    OI_MAINBASE = get_adapter(f"sqlite:{mainbase_db}") #mondo-mainbase.db, version from PR
    OI_CURRENTBASE = get_adapter(f"sqlite:{currentbase_db}") #mondo-currentbase.db, last released version

    # Read file of branch IDs
    branch_ids = get_branch_ids(branch_id_file)

    # Create dict of branch_id and descendants
    global latest_version_branch_descendants_dict
    latest_version_branch_descendants_dict = get_all_branch_descendants(branch_ids, OI_MAINBASE)
    global previous_version_branch_descendants_dict
    previous_version_branch_descendants_dict = get_all_branch_descendants(branch_ids, OI_CURRENTBASE)
    
    # Get Obsoletes between ontology versions
    obsoletes_between_versions = get_obsoletes_between_versions(OI_MAINBASE, OI_CURRENTBASE)
    logger.debug(f"Number of Obsoletes between versions: {len(obsoletes_between_versions)}")
    
    # Get all children for each newly obsolete class as found in the OI_CURRENTBASE (last/previous ontology version)
    all_direct_children_of_newly_obsoleted_classes = get_all_direct_children(obsoletes_between_versions, OI_CURRENTBASE)
    logger.debug(f"Number of all direct children of obsoletes between versions: {len(all_direct_children_of_newly_obsoleted_classes)}")

    # Analze obsolete classes (latest and previous parents and branches)
    all_data = analyze_classes(all_direct_children_of_newly_obsoleted_classes)

    # Save file of branch analysis of obsolete classes
    create_report_file(all_data, output_file)


def get_branch_ids(branch_id_filename: str) -> list[str]:
    """
    Read in TSV file of branch IDs formatted as CURIEs.

    :param branch_id_filename: Relative path to file containing curies as 'root's for the branches.
    """
    branch_ids = None
    try:
        with open(branch_id_filename, "r") as f:
            reader = csv.reader(f, delimiter="\t")
            branch_ids = [row[0] for row in reader]
            # logger.debug(f"\n**Branch IDs: {len(branch_ids)}") # Expect 39 branch_ids, # Convert to unit test
    except:
        raise (IOError(f"Unable to read file {branch_id_filename}"))
 
    return branch_ids


# Forward declaration for the SqlImplementation class
class SqlImplementation:
    pass

def get_all_branch_descendants(curies: list, db_adapter: Type[SqlImplementation] = SqlImplementation()) ->dict:
    """
    Creates a list of dictionaries where the key is the curie for the branch and value is a list of child curies in the branch.
    
    :param curies: A list of CURIES.
    :param db: SQLite adapter.
    :return branch_descendants_dict: A dictionary where the branch curie is the key and it's descendants are a list of curies. 
    Example: {"branch_1": ["1","2","3],"branch_2": ["4","5","1"]}
    """
    branch_descendants_dict = {
        id: set(db_adapter.descendants(start_curies=id, predicates=[IS_A, PART_OF]))
        for id in curies
    }
    #Debug --> convert to unit test
    # print(len(branch_descendants_dict.keys())) # Expect 39 branches

    return branch_descendants_dict


def get_obsoletes_between_versions(OI_MAINBASE, OI_CURRENTBASE) -> set:
    """
    Get a set of obsolete two between two versions on an ontology.
    For current testing, OI_MAINBASE this is from 'issue-6739' branch and expect 35 new obsoletes in comparison.
    :param OI_MAINBASE: db from most recent version from PR branch
    :param OI_CURRENTBASE: db from last released version
    """
    mainbase_obsoletes = set(OI_MAINBASE.obsoletes())
    comparebase_obsoletes = set(OI_CURRENTBASE.obsoletes())

    newly_obsoleted_classes = mainbase_obsoletes - comparebase_obsoletes
    #TODO: Convert to unit test
    # logger.debug(len(newly_obsoleted_classes)) # Expect 35 comparing main to changes in 'issue-6739'
    return newly_obsoleted_classes
    

def get_all_direct_parents(curie: str, db_adapter: Type[SqlImplementation] = SqlImplementation()):
    """
    Given a CURIE and a database adapter, get all direct parents for an ontology class.

    :param curie: An ontology CURIE.
    :param db_adapter: A SQLite adapter.
    """
    direct_parents = set()

    parent_relationships = list(
        db_adapter.relationships(subjects=[curie], predicates=[IS_A, PART_OF])
    )

    direct_parents.update(
            set(
                _get_immediate_parent(
                    curie=curie,
                    relationships=parent_relationships,
                )
            )
        )
    
    direct_parent_curies_labels = map_labels_to_curies(direct_parents)
    return direct_parent_curies_labels


def _get_immediate_parent(curie: str, relationships: List[Tuple[str]]):
        return [t[2] for t in relationships if t[0] == curie and t[1] in [IS_A, PART_OF]]

def map_labels_to_curies(curies):
    """
    Map a list of curies to their class labels.

    :param curies: A list of curies.
    """
    curies_labels_map = map(_get_labels, curies)
    curies_labels_list = list(curies_labels_map)
    mapped_curies_labels = list(zip(curies, curies_labels_list))
    
    return mapped_curies_labels


def _get_labels(curie):
    return OI_CURRENTBASE.label(curie)


def get_all_direct_children(obsolete_classes: set, db_adapter: Type[SqlImplementation] = SqlImplementation()) -> set:
    """
    Get all direct children for a class.
    
    :param curies: A set of curies that represents the newly obsoleted classes between the two ontology versions being compared. 
    :param db_adapter: SQLite adapter.
    """
    all_children_of_newly_obsoleted_classes = set()
    
    obsolete_class_relationships = list(
        db_adapter.relationships(objects=obsolete_classes, predicates=[IS_A, PART_OF])
    )
    
    for obsolete_class in obsolete_classes:
        direct_children_of_obsolete_class = set()
        
        direct_children_of_obsolete_class.update(
            set(
                _get_immediate_children(
                    curie=obsolete_class,
                    relationships=obsolete_class_relationships,
                )
            )
        )
        all_children_of_newly_obsoleted_classes.update(direct_children_of_obsolete_class)
    return all_children_of_newly_obsoleted_classes


def _get_immediate_children(curie: str, relationships: List[Tuple[str]]) -> List[Tuple[str]]:
    """
    Helper method to get direct children of the obsoleted class by extracting relationships
    in the form of (child, subClassOf, parent), e.g. "('MONDO:0020560', 'rdfs:subClassOf', 'MONDO:0016708')"
    (where the parent is the obsoleted class) from the set of all descendant relationships 
    for the given class for the specified predicates (IS_A, PART_OF).
    
    :param curie: A curie for the obsoleted class.
    :param relationships: A list of tuples of all relationships of the curie for the specified predicates.
    """
    return [t[0] for t in relationships if t[2] == curie and t[1] in [IS_A, PART_OF]]


def get_branches(curie: str, branch_descendants_dict: dict) -> list[tuple]:
    """
    Get branch curies and labels the curie belongs to.

    :param curie: 
    """
    branch_curies = []
    for k,v in branch_descendants_dict.items():
        if curie in v:
            branch_curies.append(k)
    
    branch_curies_labels = map_labels_to_curies(branch_curies)
    return branch_curies_labels


def analyze_classes(curies: set) -> list:
    """
    Get all report data, child class label, parents in currentbase and mainbase, branches.
    :param curies: A set of curies.
    """
    all_class_data = []
    
    for curie in curies:
        previous_parent_curies = get_all_direct_parents(curie, OI_CURRENTBASE)
        latest_parent_curies = get_all_direct_parents(curie, OI_MAINBASE)
        
        previous_branches = get_branches(curie, previous_version_branch_descendants_dict)
        latest_branches = get_branches(curie, latest_version_branch_descendants_dict)

        branch_assignment_status = set(previous_branches).symmetric_difference(set(latest_branches))

        class_data = {
            "curie": curie, 
            "label": OI_CURRENTBASE.label(curie),
            "previous_parent_curies": previous_parent_curies,
            "latest_parent_curies": latest_parent_curies,
            "added_parent_curies": set(latest_parent_curies) - set(previous_parent_curies),
            "removed_parent_curies": list(set(previous_parent_curies) - set(latest_parent_curies)),
            "previous_branches": previous_branches,
            "latest_branches": latest_branches,
            "is_branch_assignment_changed": bool(branch_assignment_status),
            "added_branches": set(latest_branches) - set(previous_branches),
            "removed_branches": set(previous_branches) - set(latest_branches),
        }
        all_class_data.append(class_data)

    # logger.debug(json.dumps(all_class_data))
    return all_class_data


def create_report_file(data, output_file):
    """
    Print the data to a file.
    :param data: The data object
    :param output_file: The filename for the report data.
    """    
    # Extract the keys from the first dictionary to use as fieldnames
    fieldnames = data[0].keys()

    # Format list values for saving to file
    for col_name in list(fieldnames - ["curie", "label", "is_branch_assignment_changed"]):
        for item in data:
            item[col_name] = ", ".join([f"{label}({curie})" for curie, label in item[col_name]])

    # Write the data to the TSV file
    with open(output_file, "w", newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames, delimiter=',')
        
        # Write the header row
        writer.writeheader()

        # Write the data rows
        writer.writerows(data)


if __name__ == "__main__":
    main()

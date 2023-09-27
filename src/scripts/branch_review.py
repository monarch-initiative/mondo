import logging
from typing import List, Tuple
from oaklib import get_adapter
from oaklib.datamodels.vocabulary import IS_A, PART_OF
from pathlib import Path
import csv
import click
from itertools import chain

ONT_DIR = Path(__file__).resolve().parents[1] / "ontology"
RESOURCE = Path.joinpath(ONT_DIR, "mondo.db")
OI = get_adapter(f"sqlite:///{RESOURCE}")
RETAINS_ANCESTOR = "RETAINS_ANCESTOR"
RETAINS_PARENT = "RETAINS_PARENT"
LEFT_THIS_BRANCH = "LEFT_THIS_BRANCH"
ORPHANED = "ORPHANED"


logger = logging.getLogger(__name__)


@click.group()
@click.option("-v", "--verbose", count=True)
@click.option("-q", "--quiet")
def main(verbose: int, quiet: bool):
    """
    CLI for umls-ingest.

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
@click.option("-b", "--branch-id", help="Branch ID")
@click.option("-B", "--branch-id-file", help="TSV with one column of obsoletion CURIEs")
@click.option(
    "-f",
    "--obsoletion-candidates-file",
    help="TSV with one column of obsoletion CURIEs",
)
@click.option("-o", "--output-file", help="Path to report file")
def create_review_table(
    branch_id, branch_id_file, obsoletion_candidates_file, output_file
):
    # Open the TSV file and read it into a list
    with open(obsoletion_candidates_file, "r") as f:
        reader = csv.reader(f, delimiter="\t")
        # Store the first element of each row in the obsoletion_candidates list
        obsoletion_candidates = [row[0] for row in reader]
    
    # If branch_id is not provided
    if branch_id is None:
        # If a file containing branch_ids is provided
        if branch_id_file:
            with open(branch_id_file, "r") as f:
                reader = csv.reader(f, delimiter="\t")
                # Store the first element of each row in the branch_ids list
                branch_ids = [row[0] for row in reader]
        else:
            # Raise an error if neither branch_id nor branch_id_file is provided
            raise (
                ValueError(
                    "Please provide either `--branch-id` OR `--branch-id-file` to get results."
                )
            )
    else:
        # If branch_id is provided, store it in a list
        branch_ids = [branch_id]
    
    # Create a dictionary where each key is a branch_id and the value is a set of its descendants
    branch_descendants_dict = {
        id: set(OI.descendants(start_curies=id, predicates=[IS_A, PART_OF]))
        for id in branch_ids
    }
    
    # Get the relationships of the obsoletion candidates
    affected_ids_relationships = list(
        OI.relationships(subjects=obsoletion_candidates, predicates=[IS_A, PART_OF])
    )
    
    # Define the column names for the output file
    column_names = [
        "BranchID",
        "AffectedDisease",
        "AffectedDiseaseLabel",
        "AffectedDiseaseDefinition",
        "ObsoleteParents",
        "ParentInsideBranch",
        "ParentsOutsideBranch",
        "AncestorsInsideBranch",
        "AncestorsOutsideBranch",
        "AffectedStatus",
    ]
    
    # Open the output file in write mode
    with open(output_file, "w", newline="") as csvfile:
        writer = csv.writer(csvfile, delimiter="\t")
        # Write the column names to the output file
        writer.writerow(column_names)  
    
        # Convert the obsoletion_candidates list to a set for faster operations
        obsoletion_candidates_set = set(obsoletion_candidates)
    
        # For each branch_id
        for branch_id in branch_ids:
            # Get the intersection of obsoletion candidates and descendants of the current branch_id
            obsoletion_candidates_branch = (
                branch_descendants_dict[branch_id] & obsoletion_candidates_set
            )
            # Get the relationships of the obsoletion candidates in the current branch
            obsoletion_candidates_branch_relationships = list(
                OI.relationships(
                    subjects=obsoletion_candidates_branch, predicates=[IS_A, PART_OF]
                )
            )
    
            # Get the mondo_ids affected by the obsoletion candidates in the current branch
            affected_mondo_ids = set(
                chain.from_iterable(
                    get_children_from_relations(
                        curie=id,
                        relationships=obsoletion_candidates_branch_relationships,
                    )
                    for id in obsoletion_candidates_branch
                )
            )

            # If there are affected mondo_ids
            if affected_mondo_ids:
                # For each affected mondo_id
                for affected_mondo_id in affected_mondo_ids:
                    # Get the parents of the current affected mondo_id
                    parents_of_affected_mondo_id = set(
                        get_parent_from_relations(
                            affected_mondo_id,
                            affected_ids_relationships,
                        )
                    )
            
                    # Filter out the obsoletion candidates from the parents of the current affected mondo_id
                    filtered_parents_of_obsolete_candidate = (
                        parents_of_affected_mondo_id
                        - obsoletion_candidates_set
                    )
            
                    # Get the ancestors of the current affected mondo_id
                    ancestors_of_obsolete_candidate = set(
                        OI.ancestors([affected_mondo_id], predicates=[IS_A, PART_OF])
                    )
            
                    # Get the descendants of the current branch_id
                    branch_descendants_set = branch_descendants_dict[branch_id]
            
                    # Get the intersection of parents of the current affected mondo_id and the descendants of the current branch_id
                    parents_inside_branch = (
                        parents_of_affected_mondo_id
                        & branch_descendants_set
                    )
            
                    # Get the difference between parents of the current affected mondo_id and the parents inside the branch
                    parents_outside_branch = (
                        parents_of_affected_mondo_id
                        - parents_inside_branch
                    )
            
                    # Get the intersection of ancestors of the current affected mondo_id and the descendants of the current branch_id
                    ancestors_inside_branch = (
                        ancestors_of_obsolete_candidate
                        & branch_descendants_set
                    )
            
                    # Get the difference between ancestors of the current affected mondo_id and the ancestors inside the branch
                    ancestors_outside_branch = (
                        ancestors_of_obsolete_candidate
                        - ancestors_inside_branch
                    )
            
                    # Set the default affected status to RETAINS_ANCESTOR
                    affected_status = RETAINS_ANCESTOR
            
                    # If there are no ancestors of the current affected mondo_id, set the affected status to ORPHANED
                    if len(ancestors_of_obsolete_candidate) == 0:
                        affected_status = ORPHANED
                    # If there are no ancestors inside the branch, set the affected status to LEFT_THIS_BRANCH
                    elif len(ancestors_inside_branch) == 0:
                        affected_status = LEFT_THIS_BRANCH
                    # If there are parents inside the branch, set the affected status to RETAINS_PARENT
                    elif len(parents_inside_branch) > 0:
                        affected_status = RETAINS_PARENT
                    # If there are ancestors outside the branch, keep the affected status as it is
                    elif len(ancestors_outside_branch) > 0:
                        pass
            
                    # Convert the sets to strings for writing to the output file
                    parents_inside_branch_list = stringify(parents_inside_branch)
                    parents_outside_branch_list = stringify(parents_outside_branch)
                    ancestors_inside_branch_list = stringify(ancestors_inside_branch)
                    ancestors_outside_branch_list = stringify(ancestors_outside_branch)
                    filtered_parents_of_obsolete_candidate_list = stringify(
                        filtered_parents_of_obsolete_candidate
                    )

                    data = [
                        branch_id,
                        affected_mondo_id,
                        OI.label(affected_mondo_id),
                        OI.definition(affected_mondo_id),
                        filtered_parents_of_obsolete_candidate_list,
                        parents_inside_branch_list,
                        parents_outside_branch_list,
                        ancestors_inside_branch_list,
                        ancestors_outside_branch_list,
                        affected_status,
                    ]

                    writer.writerow(data)  # writing the data


def get_children_from_relations(curie: str, relationships: List[Tuple[str]]):
    return [t[0] for t in relationships if t[2] == curie and t[1] in [IS_A, PART_OF]]


def get_parent_from_relations(curie: str, relationships: List[Tuple[str]]):
    return [t[2] for t in relationships if t[0] == curie and t[1] in [IS_A, PART_OF]]


def stringify(item: List[Tuple]):
    if OI.labels(item) is not None:
        result = " | ".join("->".join(map(str, t)) for t in OI.labels(item))

    else:
        result = ""
    return result


if __name__ == "__main__":
    main()

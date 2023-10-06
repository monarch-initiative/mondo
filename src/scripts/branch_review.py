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
RESOURCE = Path.joinpath(TMP_DIR, "mondo-branchreview.db")
RETAINS_ANCESTOR = "RETAINS_ANCESTOR"
RETAINS_PARENT = "RETAINS_PARENT"
LEAVES_THE_BRANCH = "Leaves the branch"
ORPHANED = "Orphaned"
STAYS_IN_THE_BRANCH = "Stays in branch"
UNDEFINED = "Undefined"
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
@click.option("-i", "--input", default=RESOURCE, help="DB source file.")
@click.option("-b", "--branch-id", help="Branch ID")
@click.option("-B", "--branch-id-file", help="TSV with one column of obsoletion CURIEs")
@click.option(
    "-f",
    "--obsoletion-candidates-file",
    help="TSV with one column of obsoletion CURIEs",
)
@click.option("-o", "--output-file", help="Path to report file")
def create_review_table(
    branch_id, branch_id_file, obsoletion_candidates_file, output_file, input=RESOURCE
):
    OI = get_adapter(f"sqlite:{input}")
    all_obsoletes = set(OI.obsoletes())

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

    

    # Open the output file in write mode
    with open(output_file, "w", newline="") as csvfile:
        writer = csv.writer(csvfile, delimiter="\t")
        # Write the column names to the output file
        writer.writerow(COLUMN_NAMES)

        # Convert the obsoletion_candidates list to a set for faster operations
        obsoletion_candidates_set = set(obsoletion_candidates)

        # Get the relationships of the obsoletion candidates in the current branch
        obsoletion_candidates_children_relationships = list(
            OI.relationships(
                objects=obsoletion_candidates_set, predicates=[IS_A, PART_OF]
            )
        )

        # For each branch_id
        for branch_id in branch_ids:
            # Get the descendants of the current branch_id
            branch_descendants_set = branch_descendants_dict[branch_id]
            obsoletion_candidate_child_of_branch = (
                branch_descendants_set & obsoletion_candidates_set
            )

            children_of_obsoletion_candidate = set()

            for obsoletion_candidate in obsoletion_candidate_child_of_branch:
                # Column E: Parent to be obsoleted == obsoletion_candidate
                children_of_obsoletion_candidate.update(
                    set(
                        get_immediate_children(
                            curie=obsoletion_candidate,
                            relationships=obsoletion_candidates_children_relationships,
                        )
                    )
                )

        children_of_obsoletion_candidate_parents_relationship = set(
            OI.relationships(
                subjects=children_of_obsoletion_candidate,
                predicates=[IS_A, PART_OF],
            )
        )

        children_also_obsoletion_candidates = (
            children_of_obsoletion_candidate & obsoletion_candidate_child_of_branch
        )

        for child in children_of_obsoletion_candidate:
            # Column B: Children of ObsoleteCandidate == child
            parents_of_child = (
                set(
                    get_immediate_parent(
                        curie=child,
                        relationships=children_of_obsoletion_candidate_parents_relationship,
                    )
                )
                - all_obsoletes
            )

            # These are parents that need to be obsoleted
            relevant_obsoletion_parents_in_branch = (
                parents_of_child & obsoletion_candidate_child_of_branch
            )
            # if child == "MONDO:0013310":
            #     import pdb; pdb.set_trace()

            # parents_of_child.difference_update(obsoletion_candidate_child_of_branch)

            # Column F: Other direct parents in Branch = other_parents_in_branch
            other_parents_in_branch = parents_of_child & branch_descendants_set

            # Column G: Other direct parents NOT in Branch = other_parents_not_in_branch
            other_parents_not_in_branch = parents_of_child - other_parents_in_branch

            all_ancestors = (
                set(
                    OI.ancestors(
                        [child], predicates=[IS_A, PART_OF], method="ENTAILMENT"
                    )
                )
                # - parents_of_child
                - {child}
            )
            all_ancestors = {
                anc for anc in all_ancestors if str(anc).startswith("MONDO:")
            }

            # all_ancestors.difference_update(obsoletion_candidate_child_of_branch)

            # Column H: Ancestor inside the branch = all_mondo_ancestors_in_branch
            all_ancestors_in_branch = all_ancestors & branch_descendants_set

            # Column I: Ancestor outside the branch = all_mondo_ancestors_outside_branch
            all_ancestors_outside_branch = all_ancestors - all_ancestors_in_branch

            # if child == "MONDO:0013310":
            #     import pdb; pdb.set_trace()

            other_parents_in_branch = add_obsoleted_label(
                other_parents_in_branch, obsoletion_candidates_set
            )
            other_parents_not_in_branch = add_obsoleted_label(
                other_parents_not_in_branch, obsoletion_candidates_set
            )
            all_ancestors_in_branch = add_obsoleted_label(
                all_ancestors_in_branch, obsoletion_candidates_set
            )
            all_ancestors_outside_branch = add_obsoleted_label(
                all_ancestors_outside_branch, obsoletion_candidates_set
            )
            relevant_obsoletion_parents_in_branch = add_obsoleted_label(
                relevant_obsoletion_parents_in_branch, obsoletion_candidates_set
            )

            # # Column J: Affected Status = status
            # status = ""
            # if len(other_parents_in_branch) > 0 and any(
            #     " - TO_BE_OBSOLETED" not in parent for parent in other_parents_in_branch
            # ):
            #     status = STAYS_IN_THE_BRANCH
            # elif (
            #     len(other_parents_in_branch) == 0
            #     or all(
            #         " - TO_BE_OBSOLETED" in parent for parent in other_parents_in_branch
            #     )
            # ) and (
            #     len(other_parents_not_in_branch) > 0
            #     and any(
            #         " - TO_BE_OBSOLETED" not in parent
            #         for parent in other_parents_not_in_branch
            #     )
            # ):
            #     status = LEAVES_THE_BRANCH
            # elif (
            #     len(other_parents_in_branch) == 0
            #     or all(
            #         " - TO_BE_OBSOLETED" in parent for parent in other_parents_in_branch
            #     )
            # ) and (
            #     len(other_parents_not_in_branch) == 0
            #     or all(
            #         " - TO_BE_OBSOLETED" in parent
            #         for parent in other_parents_not_in_branch
            #     )
            # ):
            #     status = ORPHANED
            # else:
            #     status = UNDEFINED

            # Convert the sets to strings for writing to the output file
            other_parents_in_branch_list = stringify(other_parents_in_branch, OI)
            other_parents_not_in_branch_list = stringify(other_parents_not_in_branch, OI)
            all_mondo_ancestors_in_branch_list = stringify(all_ancestors_in_branch, OI)
            all_mondo_ancestors_outside_branch_list = stringify(
                all_ancestors_outside_branch, OI
            )
            relevant_obsoletion_parents_list = stringify(
                relevant_obsoletion_parents_in_branch, OI
            )
            # parents_of_child_list = stringify(parents_of_child)

            child_label = OI.label(child)
            child_defn = OI.definition(child)
            if child in children_also_obsoletion_candidates:
                child = add_obsoleted_label({child}, obsoletion_candidates_set).pop()

            data = [
                branch_id,
                child,
                child_label,
                child_defn,
                relevant_obsoletion_parents_list,
                other_parents_in_branch_list,
                other_parents_not_in_branch_list,
                all_mondo_ancestors_in_branch_list,
                all_mondo_ancestors_outside_branch_list,
                "",
            ]

            writer.writerow(data)  # writing the data


def get_immediate_parent(curie: str, relationships: List[Tuple[str]]):
    return [t[2] for t in relationships if t[0] == curie and t[1] in [IS_A, PART_OF]]


def get_immediate_children(curie: str, relationships: List[Tuple[str]]):
    return [t[0] for t in relationships if t[2] == curie and t[1] in [IS_A, PART_OF]]


def add_obsoleted_label(all_ancestors, obsoletion_candidates_set):
    return {
        ancestor + " - TO_BE_OBSOLETED"
        if ancestor in obsoletion_candidates_set
        else ancestor
        for ancestor in all_ancestors
    }


def stringify(item: List[Tuple], OI):
    obsoletion_string = " - TO_BE_OBSOLETED"
    
    # Create a dictionary with obsolete items as keys and normalized items as values
    normalized_obsolete_items_dict = {i: i.replace(obsoletion_string, "") for i in item if obsoletion_string in i}

    # Update item list by replacing obsolete items with their normalized versions
    item = [normalized_obsolete_items_dict.get(i, i) for i in item]

    labeled_terms = list(OI.labels(item)) if OI.labels(item) is not None else []

    obsolete_added_label_terms = []

    # Iterate over labeled_terms list
    for term in labeled_terms:
        # If the term[0] exists as a key in the dictionary
        if term[0] in normalized_obsolete_items_dict.values():
            # Replace the term with the corresponding value from the dictionary
            key = [k for k in normalized_obsolete_items_dict.keys() if term[0] in k][0]
            obsolete_added_label_terms.append((key, term[1]))
        else:
            obsolete_added_label_terms.append(term)

    result = " | ".join("->".join(map(str, t)) for t in obsolete_added_label_terms)
    return result

@main.command()
@click.option("-i", "--input", help="branch review files to be combined.", multiple=True)
@click.option("-o", "--output-file", help="Path to report file")
def relax_and_reason(input, output_file):
    df1 = pd.read_csv(input[0], sep="\t", low_memory=False)
    df2 = pd.read_csv(input[1], sep="\t", low_memory=False)
    if len(df1) > len(df2):
        df_larger = df1
        df_smaller = df2
    elif len(df1) < len(df2):
        df_larger = df2
        df_smaller = df1
    else:
        df_larger = df1
        df_smaller = df2

    df_uncommon:pd.DataFrame = pd.DataFrame(columns=COLUMN_NAMES)

    for row in df_smaller.iterrows():
        branch_id = row[1][COLUMN_NAMES[0]]
        child_id = row[1][COLUMN_NAMES[1]]
        relevant_obsoletion_parents_list_1 = {x.strip() for x in str(row[1][COLUMN_NAMES[4]]).split("|")}
        other_parents_in_branch_list_1 = {x.strip() for x in str(row[1][COLUMN_NAMES[5]]).split("|")}
        other_parents_not_in_branch_list_1 = {x.strip() for x in str(row[1][COLUMN_NAMES[6]]).split("|")}
        all_mondo_ancestors_in_branch_list_1 = {x.strip() for x in str(row[1][COLUMN_NAMES[7]]).split("|")}
        all_mondo_ancestors_outside_branch_list_1 = {x.strip() for x in str(row[1][COLUMN_NAMES[8]]).split("|")}

        condition_1 = df_larger[COLUMN_NAMES[0]] == branch_id
        condition_2 = df_larger[COLUMN_NAMES[1]] == child_id
        corresp_row_df_larger = df_larger.loc[condition_1 & condition_2]
        if not corresp_row_df_larger.empty:
            relevant_obsoletion_parents_list_2 = {x.strip() for x in str(corresp_row_df_larger[COLUMN_NAMES[4]].values[0]).split("|")}
            other_parents_in_branch_list_2 = {x.strip() for x in str(corresp_row_df_larger[COLUMN_NAMES[5]].values[0]).split("|")}
            other_parents_not_in_branch_list_2 = {x.strip() for x in str(corresp_row_df_larger[COLUMN_NAMES[6]].values[0]).split("|")}
            all_mondo_ancestors_in_branch_list_2 = {x.strip() for x in str(corresp_row_df_larger[COLUMN_NAMES[7]].values[0]).split("|")}
            all_mondo_ancestors_outside_branch_list_2 = {x.strip() for x in str(corresp_row_df_larger[COLUMN_NAMES[8]].values[0]).split("|")}

            relevant_obsoletion_parents_list_merged = relevant_obsoletion_parents_list_1 | relevant_obsoletion_parents_list_2
            other_parents_in_branch_list_merged = other_parents_in_branch_list_1 | other_parents_in_branch_list_2
            other_parents_not_in_branch_list_merged = other_parents_not_in_branch_list_1 | other_parents_not_in_branch_list_2
            all_mondo_ancestors_in_branch_list_merged = all_mondo_ancestors_in_branch_list_1 | all_mondo_ancestors_in_branch_list_2
            all_mondo_ancestors_outside_branch_list_merged = all_mondo_ancestors_outside_branch_list_1 | all_mondo_ancestors_outside_branch_list_2
            df_larger.loc[corresp_row_df_larger.index, [COLUMN_NAMES[4], COLUMN_NAMES[5], COLUMN_NAMES[6], COLUMN_NAMES[7], COLUMN_NAMES[8]]] = [
                " | ".join(relevant_obsoletion_parents_list_merged),
                " | ".join(other_parents_in_branch_list_merged),
                " | ".join(other_parents_not_in_branch_list_merged),
                " | ".join(all_mondo_ancestors_in_branch_list_merged),
                " | ".join(all_mondo_ancestors_outside_branch_list_merged)
                ]

            # Column J: Affected Status = status
            status = ""
            if len(other_parents_in_branch_list_merged) > 0 and any(
                " - TO_BE_OBSOLETED" not in parent for parent in other_parents_in_branch_list_merged
            ):
                status = STAYS_IN_THE_BRANCH
            elif (
                len(other_parents_in_branch_list_merged) == 0
                or all(
                    " - TO_BE_OBSOLETED" in parent for parent in other_parents_in_branch_list_merged
                )
            ) and (
                len(other_parents_not_in_branch_list_merged) > 0
                and any(
                    " - TO_BE_OBSOLETED" not in parent
                    for parent in other_parents_not_in_branch_list_merged
                )
            ):
                status = LEAVES_THE_BRANCH
            elif (
                len(other_parents_in_branch_list_merged) == 0
                or all(
                    " - TO_BE_OBSOLETED" in parent for parent in other_parents_in_branch_list_merged
                )
            ) and (
                len(other_parents_not_in_branch_list_merged) == 0
                or all(
                    " - TO_BE_OBSOLETED" in parent
                    for parent in other_parents_not_in_branch_list_merged
                )
            ):
                status = ORPHANED
            else:
                status = UNDEFINED

            df_larger.loc[corresp_row_df_larger.index, [COLUMN_NAMES[9]]] = [status]
        else:

            df_uncommon = df_uncommon._append(row[1].to_frame().T, ignore_index=True)

    df_larger = df_larger._append(df_uncommon, ignore_index=True)
    df_larger = df_larger.drop_duplicates().fillna("")
    df_larger.to_csv(output_file, sep="\t", index=False)


if __name__ == "__main__":
    main()

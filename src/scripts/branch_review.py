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
        obsoletion_candidates = [row[0] for row in reader]

    if branch_id is None:
        if branch_id_file:
            with open(branch_id_file, "r") as f:
                reader = csv.reader(f, delimiter="\t")
                branch_ids = [row[0] for row in reader]
        else:
            raise (
                ValueError(
                    "Please provide either `--branch-id` OR `--branch-id-file` to get results."
                )
            )
    else:
        branch_ids = [branch_id]

    branch_descendants_dict = {
        id: list(OI.descendants(start_curies=id, predicates=[IS_A, PART_OF]))
        for id in branch_ids
    }
    obsoletion_candidates_relationships = list(
        OI.relationships(subjects=obsoletion_candidates, predicates=[IS_A, PART_OF])
    )
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
    with open(output_file, "w", newline="") as csvfile:
        writer = csv.writer(csvfile, delimiter="\t")
        writer.writerow(column_names)  # writing the headers

        for branch_id in branch_ids:
            # all classes of obsoletion_candidate_list that are descendants of branch_id
            obsoletion_candidates_branch = set(
                branch_descendants_dict[branch_id]
            ).intersection(set(obsoletion_candidates))
            obsoletion_candidates_branch_relationships = list(
                OI.relationships(
                    subjects=obsoletion_candidates_branch, predicates=[IS_A, PART_OF]
                )
            )

            affected_mondo_ids = list(
                chain.from_iterable(
                    get_children_from_relations(
                        curie=id,
                        relationships=obsoletion_candidates_branch_relationships,
                    )
                    for id in obsoletion_candidates_branch
                )
            )

            if len(affected_mondo_ids) > 0:
                for obsoletion_candidate in affected_mondo_ids:
                    parent_of_obsolete_candidate = get_parent_from_relations(
                        obsoletion_candidate,
                        obsoletion_candidates_relationships,
                    )

                    filtered_parent_of_obsolete_candidate = [
                        x
                        for x in parent_of_obsolete_candidate
                        if x not in affected_mondo_ids
                    ]
                    filtered_parent_of_obsolete_candidate = [
                        i for i in filtered_parent_of_obsolete_candidate if i not in obsoletion_candidates
                    ]

                    ancestors_of_obsolete_candidate = list(
                        OI.ancestors([obsoletion_candidate], predicates=[IS_A, PART_OF])
                    )
                    filtered_ancestor_of_obsolete_candidate = [
                        x
                        for x in ancestors_of_obsolete_candidate
                        if x not in affected_mondo_ids and x.startswith("MONDO:")
                    ]

                    parents_inside_branch = list(
                        set(filtered_parent_of_obsolete_candidate)
                        & set(branch_descendants_dict[branch_id])
                    )
                    parents_inside_branch = [
                        i for i in parents_inside_branch if i not in obsoletion_candidates
                    ]

                    parents_outside_branch = [
                        x
                        for x in filtered_parent_of_obsolete_candidate
                        if x not in parents_inside_branch
                    ]
                    parents_outside_branch = [
                        i for i in parents_outside_branch if i not in obsoletion_candidates
                    ]

                    ancestors_inside_branch = list(
                        set(filtered_ancestor_of_obsolete_candidate)
                        & set(branch_descendants_dict[branch_id])
                    )
                    ancestors_inside_branch = [
                        i for i in ancestors_inside_branch if i not in obsoletion_candidates
                    ]

                    ancestors_outside_branch = [
                        x
                        for x in filtered_ancestor_of_obsolete_candidate
                        if x not in ancestors_inside_branch
                    ]

                    ancestors_outside_branch = [
                        i for i in ancestors_outside_branch if i not in obsoletion_candidates
                    ]

                    affected_status = RETAINS_ANCESTOR
                    if len(filtered_ancestor_of_obsolete_candidate) == 0:
                        affected_status = ORPHANED
                    elif len(ancestors_inside_branch) == 0:
                        affected_status = LEFT_THIS_BRANCH
                    elif len(parents_inside_branch) > 0:
                        affected_status = RETAINS_PARENT
                    elif len(ancestors_outside_branch) > 0:
                        pass

                    parents_inside_branch_list = stringify(parents_inside_branch)
                    parents_outside_branch_list = stringify(parents_outside_branch)
                    ancestors_inside_branch_list = stringify(ancestors_inside_branch)
                    ancestors_outside_branch_list = stringify(ancestors_outside_branch)
                    filtered_parent_of_obsolete_candidate_list = stringify(
                        filtered_parent_of_obsolete_candidate
                    )

                    data = [
                        branch_id,
                        obsoletion_candidate,
                        OI.label(obsoletion_candidate),
                        OI.definition(obsoletion_candidate),
                        filtered_parent_of_obsolete_candidate_list,
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

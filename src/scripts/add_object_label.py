import csv
from typing import TextIO

import click
from sssom.parsers import parse_sssom_table
from sssom.writers import write_table

SSSOM_FILE = "../ontology/tmp/mondo.sssom.tsv"
OBJECT_LABELS_FILE = "../ontology/tmp/mondo-labels.tsv"
OBJECT_LABEL_COLUMN = "object_label"
OBJECT_ID_COLUMN = "object_id"

input_argument = click.argument("input", required=True, type=click.Path(exists=True))
output_option = click.option(
    "-o",
    "--output",
    help="Path of SSSOM output file.",
    type=click.File(mode="w"),
    default=SSSOM_FILE,
)


@click.group()
def main():
    """Run the CLI."""
    pass


@main.command()
@input_argument
@output_option
def run(input: str = SSSOM_FILE, output: TextIO = SSSOM_FILE):
    """Populate object_label from mondo-ingest."""
    msdf = parse_sssom_table(input)
    with open(OBJECT_LABELS_FILE) as fd:
        reader = csv.DictReader(fd, delimiter="\t")
        labels_by_id = {row["id"]: row["label"] for row in reader}

    # Condition to check if OBJECT_LABEL_COLUMN is empty
    is_empty = msdf.df[OBJECT_LABEL_COLUMN].isnull() | (
        msdf.df[OBJECT_LABEL_COLUMN] == ""
    )

    # Apply the function only where OBJECT_LABEL_COLUMN is empty
    msdf.df.loc[is_empty, OBJECT_LABEL_COLUMN] = msdf.df.loc[
        is_empty, OBJECT_ID_COLUMN
    ].apply(lambda x: labels_by_id.get(x, ""))

    write_table(msdf=msdf, file=output)


if __name__ == "__main__":
    main()

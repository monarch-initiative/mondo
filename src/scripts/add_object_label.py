from typing import TextIO
from sssom.parsers import parse_sssom_table
from oaklib import OntologyResource
from oaklib.implementations import SqlImplementation
import click
import sys
from sssom.writers import write_table

SSSOM_FILE = "../ontology/tmp/mondo.sssom.tsv"
RESOURCE = "../ontology/tmp/mondo-ingest.db"
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
def run(input: str = SSSOM_FILE, output: TextIO =SSSOM_FILE):
    """Get object_label from resource via oaklib."""
    msdf = parse_sssom_table(input)
    ontology_resource = OntologyResource(slug=RESOURCE, local=True)
    oi = SqlImplementation(ontology_resource)
    if OBJECT_LABEL_COLUMN not in msdf.df.columns:
        msdf.df[OBJECT_LABEL_COLUMN] = msdf.df[OBJECT_ID_COLUMN].apply(lambda x: oi.label(x))
        write_table(msdf=msdf,file=output)

if __name__ == "__main__":
    main()
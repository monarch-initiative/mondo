from typing import TextIO
from sssom.parsers import parse_sssom_table
from oaklib import OntologyResource
from oaklib.implementations import SqlImplementation
import click
import sys
from sssom.writers import write_table

SSSOM_FILE = "../ontology/tmp/mondo.sssom.tsv"
RESOURCE = "../ontology/tmp/mondo-ingest.db"

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
    # msdf.df.to_csv("test.tsv", sep="\t", index=False)
    # import pdb; pdb.set_trace()
    ontology_resource = OntologyResource(slug=RESOURCE, local=True)
    oi = SqlImplementation(ontology_resource)
    msdf.df['object_label'] = msdf.df['object_id'].apply(lambda x: oi.label(x))
    write_table(msdf=msdf,file=output)

if __name__ == "__main__":
    main()
"""MedGen conflicts: generate removal command

From a list of bad MedGen xrefs, generate a grep command to remove them from Mondo.

See also:
- GH issue: https://github.com/monarch-initiative/mondo-ingest/issues/273
"""
from argparse import ArgumentParser


def run(input_file: str, output_file: str, target: str, target_new: str):
    """Create grep command"""
    bad_xref_cuis = []
    with open(input_file, "r") as file:
        for line in file:
            bad_xref_cuis.append(line.strip())

    output_file2 = output_file.replace('.txt', '-grep-command.sh')
    command_string = "grep -v "
    for s in bad_xref_cuis:
        command_string += f'-e "xref: UMLS:{s}" '
    command_string += f"{target} > {target_new}\n"
    with open(output_file2, "w") as file:
        file.write(command_string)

def cli():
    """Command line interface."""
    parser = ArgumentParser(
        prog='MedGen conflicts: generate removal command',
        description='From a list of bad MedGen xrefs, generate a grep command to remove them from Mondo.')
    parser.add_argument(
        '-i', '--input-file', help='Txt file containing CUIs for bad xrefs')
    parser.add_argument(
        '-o', '--output-file', help='ShellScript file containing grep command')
    parser.add_argument(
        '-t', '--target', help='Target file to use grep on')
    parser.add_argument(
        '-T', '--target-new', help='New file to create when running the command')
    run(**vars(parser.parse_args()))


if __name__ == '__main__':
    cli()

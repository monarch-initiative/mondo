"""Updates exclusion reasons enum: src/schema/mondo.yaml

Resources:
- Source CSV: https://docs.google.com/spreadsheets/d/18V-_j4b22LzCytxFEM3pBEl6-_ODJY06gpUwH0F6JVY/edit#gid=1644570180

Instructions:
1. Save the 'exclusion code and definitions' tab from the above GoogleSheet as `src/scripts/exclusion_reasons.csv`
2. From `src/ontology/`, run: `sh run.sh make update-exclusion-reasons`
"""
import os
import re
from argparse import ArgumentParser
from pathlib import Path
from typing import Dict

import pandas as pd
import yaml


GSHEETS_URL = 'https://docs.google.com/spreadsheets/d/18V-_j4b22LzCytxFEM3pBEl6-_ODJY06gpUwH0F6JVY/edit#gid=1644570180'
PROJECT_DIR = Path(os.path.dirname(__file__)).parent.parent
SHEET_YML_MAPPINGS = {
	'code_name': 'title',
	'definitions': 'description',
	'notes': 'notes',
	'examples': 'examples',
	'exclude_children': 'exclude_children',
}
DEFAULTS = {
	'input_path_exclusion_reasons': os.path.join(PROJECT_DIR, 'src', 'scripts', 'exclusion_reasons.csv'),
	'input_path_mondo_schema': os.path.join(PROJECT_DIR, 'src', 'schema', 'mondo.yaml'),
}


def run(input_path_exclusion_reasons: str, input_path_mondo_schema: str):
	"""Runs script"""
	# Load updated exclusions
	# - Drops all rows where all cells are empty
	df = pd.read_csv(input_path_exclusion_reasons).dropna(axis=0, how='all').fillna('')
	# - Format to remove whitespace, leading indentation markers, and unneeded MONDO prefix
	#   The first of these replacements is redundant w/ the second, but it is here as a failsafe in case MONDO: is
	#   removed in the future. It does require that there be a space after any - characters, though, so something like
	#   ---excludeNonDisease without a space before the exclusion name would not be captured.
	df['codes'] = df['codes'].apply(lambda x: re.sub('.*- ', '', x))
	df['codes'] = df['codes'].apply(lambda x: re.sub('.*MONDO:', '', x))
	# - Strip all whitespace
	df = df.apply(lambda x: x.str.strip() if x.dtype == 'object' else x)

	# Load current exclusions
	with open(input_path_mondo_schema, 'r') as stream:
		mondo_schema = yaml.safe_load(stream)
	exclusion_dicts: Dict[str, Dict[str, str]] = mondo_schema['enums']['entity_type_enum']['permissible_values']

	# Delete: Any schema enum items not located in GoogleSheet source of truth
	obsoleted_exclusion_reasons = [x for x in exclusion_dicts if x not in set(df['codes'])]
	for item in obsoleted_exclusion_reasons:
		del exclusion_dicts[item]

	# Updates
	for _index, row in df.iterrows():
		exclusion_reason_name = row['codes']
		row_d = {k: v for k, v in row.to_dict().items() if k != 'codes'}
		if exclusion_reason_name not in exclusion_dicts:
			exclusion_dicts[exclusion_reason_name] = {}
		for k, v in row_d.items():
			target_field = SHEET_YML_MAPPINGS.get(k, k)
			exclusion_dicts[exclusion_reason_name][target_field] = v

	# Save
	mondo_schema['enums']['entity_type_enum']['permissible_values'] = exclusion_dicts
	with open(input_path_mondo_schema, 'w') as stream:
		yaml.safe_dump(mondo_schema, stream, sort_keys=False)


def cli():
	"""Command line interface."""
	package_description = \
		'Updates LinkML Mondo schema exclusion reasons enum from GoogleSheet CSV export.'
	parser = ArgumentParser(description=package_description)

	parser.add_argument(
		'-e', '--input-path-exclusion-reasons', required=False, default=DEFAULTS['input_path_exclusion_reasons'],
		help='Path to source exclusion reasons CSV to update from.')
	parser.add_argument(
		'-s', '--input-path-mondo-schema', required=False, default=DEFAULTS['input_path_mondo_schema'],
		help='Path to Mondo LinkML schema `.yml` which contains exclusion reasons enum to be updated')
	kwargs = parser.parse_args()
	d: Dict = vars(kwargs)

	# Validate
	if not os.path.exists(d['input_path_exclusion_reasons']):
		raise FileNotFoundError(
			f'{d["input_path_exclusion_reasons"]}: Download from {GSHEETS_URL} and save CSV at this path.')

	run(**d)


if __name__ == '__main__':
	cli()

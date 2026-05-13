#!/usr/bin/env python
# coding: utf-8

"""
author: Nico Matentzoglu, 15 March 2021
"""

import os
import re
from datetime import datetime

from argparse import ArgumentParser
import yaml

from sssom.util import sort_df_rows_columns
from sssom.parsers import (
    from_sssom_dataframe,
    split_dataframe_by_prefix,
    parse_sssom_table,
)
from sssom.writers import write_tables
from sssom.constants import SEMAPV

import logging

parser = ArgumentParser()
parser.add_argument(
    "-s", "--sssom_tsv", dest="sssom_tsv_path", help="SSSOM file", metavar="FILE"
)
parser.add_argument(
    "-m",
    "--sssom_metadata",
    dest="sssom_metadata_path",
    help="SSSOM metadata file",
    metavar="FILE",
)
parser.add_argument("-o", "--output-dir", dest="tsv_out_path", help="Output directory")
args = parser.parse_args()

sssom_file = args.sssom_tsv_path
metadata_file = args.sssom_metadata_path
mapping_dir = args.tsv_out_path


def reconcile_curie(pre_orig):
    if re.match(r".*__[0-9]$", pre_orig):
        print(f"{pre_orig} non standard prefix, reconciling")
        pre = pre_orig[:-3]
    else:
        pre = pre_orig
    return pre


def replace_temporary_prefixes(prefixes, df):
    for pre_orig in prefixes:
        pre = reconcile_curie(pre_orig)
        if pre != pre_orig:
            print(f"Replacing temporary curie {pre_orig} with {pre}")
            logging.warning(f"Replacing temporary curie {pre_orig} with {pre}")
            df["object_id"] = df["object_id"].str.replace(pre_orig + ":", pre + ":")
            df["subject_id"] = df["subject_id"].str.replace(pre_orig + ":", pre + ":")
    return df


def read_metadata(filename):
    """
    Reading metadata file (yaml) that is supplied separately from a tsv
    :param filename: location of file
    :return: two objects, a metadata and a curie_map object
    """
    meta = {}
    curie_map = {}
    with open(filename, "r") as stream:
        try:
            m = yaml.safe_load(stream)
            if "curie_map" in m:
                curie_map = m["curie_map"]
            m.pop("curie_map", None)
            meta = m
        except yaml.YAMLError as exc:
            print(exc)
    return meta, curie_map


meta, curie_map = read_metadata(metadata_file)
msdf_main = parse_sssom_table(sssom_file)
msdf_main.df["mapping_justification"] = SEMAPV.ManualMappingCuration.value
relations_allowed = meta["relations"]


subject_prefixes = set(
    msdf_main.df["subject_id"].str.split(pat=":", n=1, expand=True)[0]
)
object_prefixes = set(msdf_main.df["object_id"].str.split(pat=":", n=1, expand=True)[0])
relations = set(msdf_main.df["predicate_id"])

msdf_main.df = replace_temporary_prefixes(subject_prefixes, msdf_main.df)
msdf_main.df = replace_temporary_prefixes(object_prefixes, msdf_main.df)
global_metadata = meta["global_metadata"]
new_msdf = from_sssom_dataframe(
    msdf_main.df, prefix_map=msdf_main.prefix_map, meta=global_metadata
)
today = datetime.today().strftime("%Y-%m-%d")

splitted = split_dataframe_by_prefix(
    new_msdf, ["MONDO"], object_prefixes, relations_allowed
)
for msdf in splitted:
    fromS = msdf.split("_")[0].upper()
    toS = msdf.split("_")[2].upper()
    m = splitted[msdf].metadata
    m[
        "mapping_set_version"
    ] = f"http://purl.obolibrary.org/obo/mondo/releases/{today}/mappings/{msdf}.sssom.tsv"
    m[
        "mapping_set_id"
    ] = f"http://purl.obolibrary.org/obo/mondo/mappings/{msdf}.sssom.tsv"

    for source_metadata in meta["source_metadata"]:
        if source_metadata["from"] == fromS and source_metadata["to"] == toS:
            if "metadata" in source_metadata:
                for item in source_metadata["metadata"]:
                    m[item] = source_metadata["metadata"][item]
    splitted[msdf].metadata = m
    splitted[msdf].df = sort_df_rows_columns(
        splitted[msdf].df, by_columns=True, by_rows=True
    )

write_tables(splitted, mapping_dir)


def metadata_referenced_prefixes(metadata, known_prefixes):
    """Return prefixes referenced as `prefix:id` in any metadata value."""
    referenced = set()
    for value in metadata.values():
        values = value if isinstance(value, list) else [value]
        for v in values:
            if not isinstance(v, str) or v.startswith(("http://", "https://")):
                continue
            prefix = v.split(":", 1)[0]
            if prefix in known_prefixes:
                referenced.add(prefix)
    return referenced


def patch_curie_map(file_path, missing_prefixes, curie_map):
    """Insert any missing prefix declarations into the file's curie_map block.

    sssom 0.4.0 derives the on-disk curie_map from data columns only, so
    prefixes that appear only in metadata slots (e.g. subject_source:
    infores:mondo) get silently dropped. This patches the file in place.
    """
    if not missing_prefixes:
        return
    with open(file_path, "r") as f:
        lines = f.readlines()

    cm_start = None
    cm_end = None
    for i, line in enumerate(lines):
        if line.rstrip() == "# curie_map:":
            cm_start = i + 1
            continue
        if cm_start is not None and not line.startswith("#   "):
            cm_end = i
            break
    if cm_start is None or cm_end is None:
        return

    block = lines[cm_start:cm_end]
    declared = set()
    for entry in block:
        match = re.match(r"^#   ([^:]+):\s", entry)
        if match:
            declared.add(match.group(1))
    to_add = [p for p in missing_prefixes if p not in declared]
    if not to_add:
        return
    for prefix in to_add:
        block.append(f"#   {prefix}: {curie_map[prefix]}\n")
    block.sort()
    new_lines = lines[:cm_start] + block + lines[cm_end:]
    with open(file_path, "w") as f:
        f.writelines(new_lines)


for msdf_name, msdf in splitted.items():
    file_path = os.path.join(mapping_dir, f"{msdf_name}.sssom.tsv")
    if not os.path.exists(file_path):
        continue
    needed = metadata_referenced_prefixes(msdf.metadata, curie_map)
    patch_curie_map(file_path, needed, curie_map)

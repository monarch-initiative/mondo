#!/usr/bin/env python
# coding: utf-8

"""
author: Nico Matentzoglu, 15 March 2021
"""

import os
import re
from pathlib import Path
from datetime import datetime

import pandas as pd
from argparse import ArgumentParser
import yaml

from sssom.util import read_pandas
from sssom.parsers import from_sssom_dataframe, split_dataframe_by_prefix
from sssom.writers import write_table, write_tables

import logging

parser = ArgumentParser()
parser.add_argument("-s", "--sssom_tsv", dest="sssom_tsv_path", help="SSSOM file", metavar="FILE")
parser.add_argument("-m", "--sssom_metadata", dest="sssom_metadata_path", help="SSSOM metadata file", metavar="FILE")
parser.add_argument("-o", "--output-dir", dest="tsv_out_path", help="Output directory")
args = parser.parse_args()

sssom_file=args.sssom_tsv_path
metadata_file=args.sssom_metadata_path
mapping_dir=args.tsv_out_path


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
        if pre!=pre_orig:
            print(f"Replacing temporary curie {pre_orig} with {pre}")
            logging.warning(f"Replacing temporary curie {pre_orig} with {pre}")
            df['object_id'] = df['object_id'].str.replace(pre_orig+":",pre+":")
            df['subject_id'] = df['subject_id'].str.replace(pre_orig+":",pre+":")
    return df

def read_metadata(filename):
    """
    Reading metadata file (yaml) that is supplied separately from a tsv
    :param filename: location of file
    :return: two objects, a metadata and a curie_map object
    """
    meta = {}
    curie_map = {}
    with open(filename, 'r') as stream:
        try:
            m = yaml.safe_load(stream)
            if "curie_map" in m:
                curie_map = m['curie_map']
            m.pop('curie_map', None)
            meta = m
        except yaml.YAMLError as exc:
            print(exc)
    return meta, curie_map

meta, curie_map=read_metadata(metadata_file)
df=read_pandas(sssom_file)
df["match_type"]="HumanCurated"

subject_prefixes_allowed = meta['subject_prefixes']
relations_allowed = meta['relations']

subject_prefixes=set(df['subject_id'].str.split(':', 1, expand=True)[0])
object_prefixes=set(df['object_id'].str.split(':', 1, expand=True)[0])
relations=set(df['predicate_id'])

df = replace_temporary_prefixes(subject_prefixes, df)
df = replace_temporary_prefixes(object_prefixes, df)
global_metadata=meta['global_metadata']

msdf = from_sssom_dataframe(df, prefix_map=curie_map, meta=global_metadata)
today = datetime.today().strftime('%Y-%m-%d')

splitted = split_dataframe_by_prefix(msdf,subject_prefixes_allowed,object_prefixes, relations_allowed)
for msdf in splitted:
    fromS = msdf.split("_")[0].upper()
    toS = msdf.split("_")[2].upper()
    m = splitted[msdf].metadata
    m['mapping_set_version']=f"http://purl.obolibrary.org/obo/mondo/releases/{today}/mappings/{msdf}.sssom.tsv"
    m['mapping_set_id']=f"http://purl.obolibrary.org/obo/mondo/mappings/{msdf}.sssom.tsv"

    for source_metadata in meta['source_metadata']:
        if source_metadata["from"]==fromS and source_metadata["to"]==toS:
            if 'metadata' in source_metadata:
                for item in source_metadata['metadata']:
                    m[item]=source_metadata['metadata'][item]
    splitted[msdf].metadata = m
write_tables(splitted,mapping_dir)

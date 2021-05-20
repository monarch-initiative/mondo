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

from sssom.datamodel_util import read_pandas, read_metadata
from sssom.parsers import from_dataframe
from sssom.writers import write_tsv

import logging

parser = ArgumentParser()
parser.add_argument("-s", "--sssom_tsv", dest="sssom_tsv_path", help="SSSOM file", metavar="FILE")
parser.add_argument("-m", "--sssom_metadata", dest="sssom_metadata_path", help="SSSOM metadata file", metavar="FILE")
parser.add_argument("-o", "--output-dir", dest="tsv_out_path", help="Output directory")
args = parser.parse_args()

sssom_file=args.sssom_tsv_path
metadata_file=args.sssom_metadata_path
mapping_dir=args.tsv_out_path

meta, curie_map=read_metadata(metadata_file)
meta["mapping_date"]=datetime.now().strftime("%Y-%m-%d")
df=read_pandas(sssom_file)
df["match_type"]="HumanCurated"

subject_prefixes=set(df['subject_id'].str.split(':', 1, expand=True)[0])
object_prefixes=set(df['object_id'].str.split(':', 1, expand=True)[0])
#object_prefixes.remove("MONDO")
relations=set(df['predicate_id'])

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

df = replace_temporary_prefixes(subject_prefixes, df)
df = replace_temporary_prefixes(object_prefixes, df)

for pre_subj in subject_prefixes:
    for pre_obj in object_prefixes:
        for rel in relations:
            relpre=rel.split(":")[0]
            relppost=rel.split(":")[1]
            sssom_file=os.path.join(mapping_dir,f"{pre_subj.lower()}_{relppost.lower()}_{pre_obj.lower()}.sssom.tsv")
    
            dfs=df[(df['subject_id'].str.startswith(pre_subj+":")) 
                   & (df['predicate_id'] == rel) 
                   & (df['object_id'].str.startswith(pre_obj+":"))]
            if pre_subj in curie_map and pre_obj in curie_map and len(dfs)>0:
                cm = {pre_subj: curie_map[pre_subj], pre_obj: curie_map[pre_obj], relpre: curie_map[relpre]}
                msdf=from_dataframe(dfs,curie_map=cm,meta=meta)
                write_tsv(msdf=msdf,filename=sssom_file)
                print(f"Writing {sssom_file} complete!")
            else:
                print(f"Not creating {sssom_file} because there is a missing prefix ({pre_subj}, {pre_obj}), or no matches ({len(dfs)} matches found)")
    

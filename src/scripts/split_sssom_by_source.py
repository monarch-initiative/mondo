#!/usr/bin/env python
# coding: utf-8

"""
author: Nico Matentzoglu, 15 March 2021
"""

import pandas as pd
from pathlib import Path
from argparse import ArgumentParser

def get_dataframe(tsv):
    try:
        df = pd.read_csv(tsv,sep="\t")
        df["source"]=mondo_patterns_iri+Path(tsv).stem
        return df
    except pd.errors.EmptyDataError:
        print("WARNING! ", tsv, " is empty and has been skipped.")
    return pd.DataFrame(columns=['defined_class','pattern'])

parser = ArgumentParser()
parser.add_argument("-s", "--sssom_tsv", dest="sssom_tsv_path", help="SSSOM file", metavar="FILE")
parser.add_argument("-o", "--output", dest="tsv_out_path", help="Output file", metavar="FILE")
args = parser.parse_args()

df = get_dataframe(sssom_tsv_path)

print(df.head())

df.to_csv(args.tsv_out_path,sep="\t",index=False)


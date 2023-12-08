#!/usr/bin/env python
# coding: utf-8

"""
author: Nico Matentzoglu, 26 August 2020
"""

import pandas as pd
from pathlib import Path
from argparse import ArgumentParser

mondo_patterns_iri = "http://purl.obolibrary.org/obo/mondo/patterns/"


def get_dataframe(tsv):
    try:
        df = pd.read_csv(tsv, sep="\t")
        df["pattern"] = mondo_patterns_iri + Path(tsv).stem + ".yaml"
        return df[["defined_class", "pattern"]]
    except pd.errors.EmptyDataError:
        print("WARNING! ", tsv, " is empty and has been skipped.")
    return pd.DataFrame(columns=["defined_class", "pattern"])


parser = ArgumentParser()
parser.add_argument(
    "-d",
    "--dosdp-tsv",
    action="append",
    dest="dosdp_tsvs",
    help="The set of mapping suggestions to be merged.",
)
parser.add_argument(
    "-o", "--output", dest="tsv_out_path", help="Output file", metavar="FILE"
)
args = parser.parse_args()

merge = []
merge.append(
    pd.DataFrame(
        {"defined_class": ["ID"], "pattern": ["AI dc:conformsTo"]},
        columns=["defined_class", "pattern"],
    )
)
merge.extend([get_dataframe(f) for f in args.dosdp_tsvs])

df = pd.concat(merge)
df.reset_index(drop=True, inplace=True)

print(df.head())

df.to_csv(args.tsv_out_path, sep="\t", index=False)

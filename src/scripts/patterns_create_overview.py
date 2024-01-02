#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Oct 8 14:24:37 2018

@author: Nicolas Matentzoglu
"""

import os
import sys
import yaml
import re
import pandas as pd


### Configuration

pattern_dirs = sys.argv[1]
matches_dir = sys.argv[2]
md_file = sys.argv[3]

# pattern_dir="/ws/upheno/src/patterns/dosdp-dev"
# md_file=pattern_dir+"/README.md"
pattern_matches_location = "https://raw.githubusercontent.com/monarch-initiative/mondo/master/src/patterns/data/matches"
pattern_matches_location_gh = (
    "https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches"
)

lines = []

lines.append("# Pattern directory")
lines.append("This is a listing of all the patterns hosted as part of this directory")
lines.append("")

i = 0

for pattern_dir in pattern_dirs.split("|"):
    lines.append("## Patterns in {}".format(os.path.basename(pattern_dir)))
    files = os.listdir(pattern_dir)
    files.sort()

    for filename in files:
        print("Processing %s" % filename)
        if filename.endswith(".yaml"):
            f_path = os.path.join(pattern_dir, filename)
            f = open(f_path)
            try:
                y = yaml.load(f, Loader=yaml.FullLoader)
                fn = os.path.basename(filename)
                splitted = " ".join(
                    re.sub(
                        "([A-Z][a-z]+)", r" \1", re.sub("([A-Z]+)", r" \1", fn)
                    ).split()
                ).replace(".yaml", "")
                splitted = splitted.lower().capitalize()
                variables = ""
                classes = ""
                contributors = ""

                for v in y["vars"]:
                    # vs = re.sub("[^0-9a-zA-Z _]", "", y['vars'][v])
                    vsv = re.sub("[']", "", y["vars"][v])
                    variables = variables + v
                    if vsv in y["classes"]:
                        variables = variables + " (" + y["classes"][vsv] + ")"
                    variables = variables + ", "

                for v in y["classes"]:
                    cid = y["classes"][v]
                    classes = classes + cid + ", "

                if "contributors" in y:
                    for v in y["contributors"]:
                        contributors = (
                            contributors
                            + "["
                            + re.sub("https[:][/][/]orcid[.]org[/]", "", v)
                            + "]("
                            + v
                            + "), "
                        )

                examples = []
                fn_yaml = fn.replace(".yaml", ".tsv")
                tsv = os.path.join(matches_dir, fn_yaml)
                url = "{}/{}".format(pattern_matches_location, fn_yaml)
                ghurl = "{}/{}".format(pattern_matches_location_gh, fn_yaml)
                print(url)
                print(tsv)
                sample_table = ""
                example = ""
                if os.path.isfile(tsv):
                    try:
                        df = pd.read_csv(tsv, sep="\t")
                        if not df.empty:
                            examples.append("[mondo]({})".format(ghurl))
                            example = "{}".format(ghurl)
                            dfh = df.head()
                            sample_table = dfh.to_markdown(index=False)
                            i = i + 1
                        else:
                            print("No matches!")
                    except Exception:
                        print("No matches!")
                else:
                    print(tsv + " does not exist!")

                lines.append("### " + splitted.replace("_", " "))
                lines.append("*" + y["description"].strip() + "*")
                lines.append("")
                lines.append("| Attribute | Info |")
                lines.append("|----------|----------|")
                lines.append("| IRI | " + y["pattern_iri"] + " |")
                lines.append("| Name | " + y["pattern_name"] + " |")
                lines.append("| Classes | " + classes + " |")
                lines.append("| Variables | " + variables + " |")
                lines.append("| Contributors | " + contributors + " |")
                lines.append("| Examples | " + " ".join(examples) + " |")
                lines.append("")
                if sample_table:
                    lines.append("#### Data preview: ")
                    oboiri = "http://purl.obolibrary.org/obo/"
                    lines.append(sample_table.replace(oboiri, "").replace("_", ":"))
                    lines.append("")
                    lines.append("See full table [here]({})".format(example))

            except yaml.YAMLError as exc:
                print(exc)

with open(md_file, "w") as f:
    for item in lines:
        f.write("%s\n" % item)

#!/usr/bin/env python3
import glob
import re
import os
import ruamel.yaml
from pathlib import Path

patterndirin = "/Users/matentzn/ws/mondo/src/patterns/dosdp-dev/"
patterndirout = "/Users/matentzn/ws/mondo/src/patterns/dosdp-patterns/"

pattern_docs = glob.glob(patterndirin + "*.yaml")
pattern_docs.extend(glob.glob(patterndirout + "*.yml"))

for pattern_doc in pattern_docs:
    print("Transforming %s" % pattern_doc)
    fn = os.path.basename(pattern_doc)
    file = open(pattern_doc, "r")
    pattern = ruamel.yaml.round_trip_load(file.read())
    name = pattern["pattern_name"]
    pattern["pattern_iri"] = "http://purl.obolibrary.org/obo/mondo/patterns/%s" % fn
    if "annotationProperties" in pattern:
        if "exact_synonym" not in pattern["annotationProperties"]:
            pattern["annotationProperties"]["exact_synonym"] = "oio:hasExactSynonym"
        if "related_synonym" not in pattern["annotationProperties"]:
            pattern["annotationProperties"]["related_synonym"] = "oio:hasRelatedSynonym"
    else:
        pattern["annotationProperties"] = {
            "exact_synonym": "oio:hasExactSynonym",
            "related_synonym": "oio:hasRelatedSynonym",
        }

    for key in pattern:
        if isinstance(pattern[key], dict):
            if "text" in pattern[key]:
                if re.search("[%]($|\s)", pattern[key]["text"]):
                    print(
                        "Replacing % with % s potentially broken text: %s",
                        str(pattern[key]["text"]),
                    )
                    pattern[key]["text"] = re.sub(
                        "[%](?=\s|$)", "%s", pattern[key]["text"]
                    )
                    print(pattern[key]["text"])
        if isinstance(pattern[key], list):
            l = []
            for e in pattern[key]:
                if "text" in e:
                    if re.search("[%]($|\s)", e["text"]):
                        print("Replacing adding missing s to: %s", str(e["text"]))
                        e["text"] = re.sub("[%](?=\s|$)", "%s", e["text"])
                        print(e["text"])
                l.append(e)
            pattern[key] = l

    if "vars" in pattern:
        for key in pattern["vars"]:
            if pattern["vars"][key] == "owl:Thing":
                print("Fixing erroneous occurrence of owl:Thing")
                pattern["vars"][key] = pattern["vars"][key].replace(
                    "owl:Thing", "owl_thing"
                )
                pattern["classes"]["owl_thing"] = "owl:Thing"

    if "description" not in pattern:
        pattern["description"] = "TBD."

    if "annotations" in pattern:
        annotations = []
        for annotation in pattern["annotations"]:
            annotation["annotationProperty"] = annotation["annotationProperty"].replace(
                "oio:hasExactSynonym", "exact_synonym"
            )
            annotation["annotationProperty"] = annotation["annotationProperty"].replace(
                "oio:hasRelatedSynonym", "related_synonym"
            )
            annotations.append(annotation)
        pattern["annotations"] = annotations

    contributors = []
    contributors.append("https://orcid.org/0000-0002-6601-2165")
    pattern["contributors"] = contributors

    outfile = Path(os.path.join(patterndirout, fn))
    print(outfile)
    # yaml.dump(pattern, outfile, default_flow_style=False, sort_keys=False)
    ruamel.yaml.round_trip_dump(
        pattern,
        stream=open(outfile, "w"),
        indent=4,
        block_seq_indent=2,
        explicit_start=False,
    )

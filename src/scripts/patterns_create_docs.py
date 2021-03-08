#!/usr/bin/env python3

from pathlib import Path
import yaml

ROOT = Path(__file__).parent.parent.parent
mkdocs_file = ROOT / "mkdocs.yml"
pattern_files = (ROOT / "src/patterns/dosdp-patterns").glob("*.yaml")
pattern_doc_dir = ROOT / "docs/editors-guide/patterns"

# We might need to make changes to the mkdocs.yaml file
# mkdocs_yaml = yaml.load(mkdocs_file.read_text(), Loader=yaml.FullLoader)

pattern_lst = []

for pattern_file in pattern_files:
    pattern = yaml.load(pattern_file.read_text(), Loader=yaml.FullLoader)
    md_file_path = pattern_doc_dir / (pattern_file.stem + ".md")
    with md_file_path.open("w") as fout:
        fout.write(f"# {pattern['pattern_name']} \n")
        fout.write("## URL \n")
        fout.write(f"[{pattern['pattern_iri']}]({pattern['pattern_iri']})\n")
        fout.write("## Description \n")
        fout.write(pattern["description"] + "\n")
        if "contributors" in pattern:
            fout.write("## Contributors \n")
            for contributor in pattern["contributors"]:
                fout.write(f"* [{contributor}]({contributor}) \n")
        if "classes" in pattern:
            fout.write("## Classes \n")
            for key, val in pattern["classes"].items():
                prefix, identifier = val.split(":")
                if prefix.lower() == 'owl':
                    fout.write(f"* {key}: {val} \n")
                else:
                    fout.write(f"* {key}: [{val}](http://purl.obolibrary.org/obo/{prefix}_{identifier}) \n")
        fout.write("## _To be completed_")
    pattern_lst.append((pattern_file.stem, pattern))

# create the index.md file 
pattern_lst.sort(key=lambda x: x[1]['pattern_name'].lower())
index_md_path = pattern_doc_dir / "index.md"
with index_md_path.open("w") as fout:
    fout.write(f"# Design Patterns \n\n")
    fout.write(f"\n")
    for pattern_file_name, pattern in pattern_lst:        
        fout.write(f"* [{pattern['pattern_name']}]({pattern_file_name}/) \n")




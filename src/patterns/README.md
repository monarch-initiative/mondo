# MONDO Design Patterns

This directory contains design pattern specifications for the construction and maintenance of MONDO. 

There are two kinds of files in this repo

 * `*.yaml` design pattern specification [DOSDP spec](https://github.com/dosumis/dead_simple_owl_design_patterns)
 * `*.csv` tsv reverse engineered from ontology following DP (uses [dosdp-tools](https://github.com/INCATools/dosdp-tools) )

The overall philosophy is to split rather than lump; so for example, we have distinct DPs for [carcinoma](carcinoma.yaml) and [cancer](cancer.yaml)

Consult each yaml for documentation.

## Reverse engineering from external ontologies based on lexical patterns

The [Makefile](Makefile) also includes target for reverse engineering OWL definitions from lexical patterns

---
layout: ontology_detail
id: tbn
title: TBD Disease Ontology
jobs:
  - id: https://travis-ci.org/cmungall/tbd-disease-ontology
    type: travis-ci
build:
  checkout: git clone https://github.com/cmungall/tbd-disease-ontology.git
  system: git
  path: "."
contact:
  email: cjmungall@lbl.gov
  label: Chris Mungall
description: TBD Disease Ontology is an ontology...
domain: stuff
homepage: https://github.com/cmungall/tbd-disease-ontology
products:
  - id: tbn.owl
  - id: tbn.obo
dependencies:
 - id: uberon
 - id: cl
 - id: go
 - id: pato
 - id: ro
 - id: bfo
tracker: https://github.com/cmungall/tbd-disease-ontology/issues
license:
  url: http://creativecommons.org/licenses/by/3.0/
  label: CC-BY
---

Enter a detailed description of your ontology here

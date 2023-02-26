# Slurp Workflow

1. In mondo-ingest GitHub, navigate to src/ontology/slurp
1. Open slurp tsv file in google docs, such as [https://github.com/monarch-initiative/mondo-ingest/blob/main/src/ontology/slurp/ordo.tsv](https://github.com/monarch-initiative/mondo-ingest/blob/main/src/ontology/slurp/ordo.tsv).
1. Open file in google docs as a google spreadsheet
1. View each term to check if it is already in Mondo or if there is something similar - if so, add the Orphanet dbxref and add that term to the exclusion list and delete the row.
1. Add a column in column H for SC_source (G1) and add >A oboInOwl:source SPLIT=| in G2. Add your ORCID as the source (eg https://orcid.org/0000-0001-5208-3432)
1. If it is a term term that should be added, add the ID for the parent in column G (in most cases, we should reclassify the term.)
1. When the spreadsheet is ready, merge the terms into Mondo using the [ROBOT merge template workflow](..editors-guide/robot-template.md).

See example spreadsheet [here](https://docs.google.com/spreadsheets/d/1k2ycAyi1m1NjnYlfgXgDcN7T3U5-V3muObjaS8zyQyI/edit#gid=339514456). 


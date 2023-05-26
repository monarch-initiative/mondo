# Migration Workflow

1. In mondo-ingest GitHub, navigate to src/ontology/slurp
1. Open slurp tsv file in google docs, such as [https://github.com/monarch-initiative/mondo-ingest/blob/main/src/ontology/slurp/ordo.tsv](https://github.com/monarch-initiative/mondo-ingest/blob/main/src/ontology/slurp/ordo.tsv).
1. Open file in google docs as a google spreadsheet
1. View each term to check if it is already in Mondo or if there is something similar - if so, add the source dbxref and add that term to the exclusion list and delete the row.
1. Add a column in column H for SC_source (G1) and add >A oboInOwl:source SPLIT=| in G2. Add your ORCID as the source (eg https://orcid.org/0000-0001-5208-3432)
1. If it is a term term that should be added, add the ID for the parent in column G (in most cases, we should reclassify the term.)
1. When the spreadsheet is ready, merge the terms into Mondo using the [ROBOT merge template workflow](..editors-guide/robot-template.md).

See example spreadsheet [here](https://docs.google.com/spreadsheets/d/1k2ycAyi1m1NjnYlfgXgDcN7T3U5-V3muObjaS8zyQyI/edit#gid=339514456). 

# Weekly Workflow

1. Review mappings
   1. Go to [https://github.com/monarch-initiative/mondo-ingest/blob/main/src/ontology/lexmatch/README.md](https://github.com/monarch-initiative/mondo-ingest/blob/main/src/ontology/lexmatch/README.md) 
   1. Review all tables named `unmapped_%_lex` (for example, `unmapped_omim_lex`) and `unmapped_%_lex_exact` (for example, `unmapped_omim_lex_exact`)
   1. Process tables as usually
1. Migrate terms   
   1. go to link: [https://github.com/monarch-initiative/mondo-ingest/tree/main/src/ontology/slurp](https://github.com/monarch-initiative/mondo-ingest/tree/main/src/ontology/slurp)
   1. For a ontology X (eg OMIM), if (and only if) there are no unmapped terms according to the previous step, process as usual.
   IMPORTANT: it is not enough if you have processed all the unmapped terms, the tables need to be empty on GitHub.
1. Mapping reconcilliation
   1. In process, _Nico and Harshad are working on this_
   

## Extract All Mondo terms
Get all Mondo terms and the following information: 

- term ID (formatted as an IRI)
- label
- definition
- comment
- parents (direct parents only) - the labels and IRIs
- synonyms (exact synonyms only)
- xrefs to OMIM and Orphanet where there is a MONDO:equivalentTo annotation

The query is run against the `reasoned.owl` file, which corresponds to the Mondo content from the latest Mondo release.

## Extract all Mondo terms
To extract all Mondo terms, run the command below from the `mondo/src/ontology` directory as:  
`sh run.sh make dump-mondo-terms`

The result file is created in `mondo/src/ontology/reports/mondo_term_dump.csv`. This file is ignored by git so you will not see it highlighted as a changed file.

## SPARQL Queries
The query used to extract the terms is called `dump-mondo-terms.ru` and is in the `src/sparql/reports` directory.

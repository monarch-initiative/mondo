## Mondo Statistics
The Mondo statistics include: 

- disease classes
- terms with definitions
- xrefs
- exact, related, narrow, and broad synonyms
- rare diseases
- cancer diseases
- infectious diseases
- hereditary diseases

When creating the stats, a set of SPARQL queries are run on the reasoned version of Mondo. This reasoned version of Mondo is created from the most recent version of `mondo-edit.obo` in your current GitHub branch. 

## Create Mondo Stats
Create Mondo stats from the `mondo/src/ontology` directory as:  
`sh run.sh make create-mondo-stats`

The result file is created in `mondo/src/ontology/reports/mondo_stats`. This file is ignored by git so you will not see it highlighted as a changed file.

## SPARQL Queries
All queries used to create the Mondo statistics are in the `src/sparql/mondo_stats/` directory.

### Disease terms
- Definition = all unique non-obsolete classes (asserted and inferred) that are children of MONDO:0000001 disease and have a MONDO CURIE, i.e. the IRI starts with `http://purl.obolibrary.org/obo/MONDO_` 
- SPARQL query - see `COUNT-classes.sparql`

### Term definitions
- Definition = all unique non-obsolete classes (asserted and inferred) that are children of MONDO:0000001 disease that have a MONDO CURIE and have a definition
- SPARQL query - see `COUNT-classes-with-definitions.sparql`

### Database cross references
- Definition = count of all xrefs that are found on all unique non-obsolete classes (asserted and inferred) that are children of MONDO:0000001 disease and have a MONDO CURIE
- SPARQL query - `COUNT-xrefs.sparql`

### Exact Synonyms
- Definition = count of all exact synonyms that are found on all unique non-obsolete classes (asserted and inferred) that are children of MONDO:0000001 disease and have a MONDO CURIE
- SPARQL query - see `COUNT-exact-synonyms.sparql`

### Related synonyms
- Definition = count of all related synonyms that are found on all unique non-obsolete classes (asserted and inferred) that are children of MONDO:0000001 disease and have a MONDO CURIE
- SPARQL query - see `COUNT-related-synonyms.sparql`

### Narrow Synonyms
- Definition = count of all narrow synonyms that are found on all unique non-obsolete classes (asserted and inferred) that are children of MONDO:0000001 disease and have a MONDO CURIE
- SPARQL query - see `COUNT-narrow-synonyms.sparql`

### Broad Synonyms
- Definition = count of all broad synonyms that are found on all unique non-obsolete classes (asserted and inferred) that are children of MONDO:0000001 disease and have a MONDO CURIE
- SPARQL query - see `COUNT-broad-synonyms.sparql`

### Rare Diseases
- Definition = all unique non-obsolete classes (asserted or inferred) that are children of MONDO:0000001 disease and are in the "rare" subset
- SPARQL query - see `COUNT-rare-diseases-classes.sparql`

### Infectious Diseases
- Definition = all unique non-obsolete classes (asserted or inferred) that are children of of MONDO:0005550 'infectious disease' and have a Mondo CURIE
- SPARQL query - see `COUNT-infectious-diseases.sparql`

### Cancer Diseases
- Definition = all unique non-obsolete classes (asserted or inferred) that are children of of MONDO:0045024 'cancer or benign tumor' and have a Mondo CURIE
- SPARQL query - see `COUNT-cancer-diseases.sparql`

### Mendelian Diseases
- Definition = all unique non-obsolete classes (asserted or inferred) that are children of MONDO:0003847 'hereditary disease' and have a Mondo CURIE
- SPARQL query - see `COUNT-hereditary-disease.sparql`


## Query Execution
This section includes examples of how to run an individual statistics query and how all queries can be run together as specified
in the `create-mondo-stats` make goal.

### Run Individual Query
- Any query can be run individually with the general pattern of:
	`robot query -i reasoned.owl -q ../sparql/mondo_stats/<MY-QUERY-OF-INTEREST.sparql> <RESULTS.csv>`

- Working example: 
```
$ robot query -i reasoned.owl -q ../sparql/mondo_stats/COUNT-disease-classes.sparql ../sparql/reports/mondo_stats/diseaseClass_count.tsv
```

### Run multiple ROBOT queries in one command
```
robot query --input reasoned.owl \
--query ../sparql/mondo_stats/COUNT-classes.sparql ../sparql/reports/mondo_stats/tmp_01_class_count.tsv \
--query ../sparql/mondo_stats/COUNT-classes-with-definitions.sparql ../sparql/reports/mondo_stats/tmp_03_classDefinition_count.tsv \
--query ../sparql/mondo_stats/COUNT-xrefs.sparql ../sparql/reports/mondo_stats/tmp_02_xref_count.tsv \
--query ../sparql/mondo_stats/COUNT-exact-synonyms.sparql ../sparql/reports/mondo_stats/tmp_04_exactSynonym_count.tsv \
--query ../sparql/mondo_stats/COUNT-related-synonyms.sparql ../sparql/reports/mondo_stats/tmp_05_relatedSynonym_count.tsv \
--query ../sparql/mondo_stats/COUNT-narrow-synonyms.sparql ../sparql/reports/mondo_stats/tmp_06_narrowSynonym_count.tsv \
--query ../sparql/mondo_stats/COUNT-broad-synonyms.sparql ../sparql/reports/mondo_stats/tmp_07_broadSynonym_count.tsv \
--query ../sparql/mondo_stats/COUNT-rare-diseases-classes.sparql  ../sparql/reports/mondo_stats/tmp_08_rareDiseaseClass_count.tsv \
--query ../sparql/mondo_stats/COUNT-infectious-diseases.sparql ../sparql/reports/mondo_stats/tmp_09_infectiousDiseaseClass_count.tsv \
--query ../sparql/mondo_stats/COUNT-cancer-diseases.sparql ../sparql/reports/mondo_stats/tmp_10_cancerDiseaseClass_count.tsv \
--query ../sparql/mondo_stats/COUNT-hereditary-diseases.sparql ../sparql/reports/mondo_stats/tmp_11_hereditaryDiseaseClass_count.tsv

```
NOTE: A number was included in the result file name so the combined file will have the contents in the desired order of information.

- Combine all "tmp_" result files into 1 file
```
echo "All Combined Results created on: $(date)" > ../sparql/reports/mondo_stats/all_mondo_stats.txt
cat ../sparql/reports/mondo_stats/tmp_* >> ../sparql/reports/mondo_stats/all_mondo_stats.txt
```

- Remove all "tmp_" result files
```
rm ../sparql/reports/mondo_stats/tmp_*
```

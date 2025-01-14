## Overall Mondo Stats

### Description
This notebook and SPARQL queries are to generate data as requested [here](https://docs.google.com/document/d/1vPl2x8gfTypjzcb9ND8qXXfKIjPDE4RwuExmzAUpM6Q/edit?tab=t.0).


### Request 1: Alignment with the source - Total number of diseases in sources
For Mondo terms are in the human disease branch, i.e. children of MONDO:0700096 'human disease', get the total number of diseases represented by each source of interest (see below). This should be the count of distinct Mondo classes that contain at least one database_cross_reference to each of the "Sources of Interest". The query can be run against `mondo-edit.obo`, but must use the parameter `reason` with the robot command since many Mondo classes only classify with a parent of MONDO:0700096 'human disease' in the inferred hierarchy.

NOTE: A list of all NCIT terms in the neoplasm branch is needed in order to filter all Mondo xrefs to NCIT where these NCIT terms are in the neoplasm branch since Mondo contains NCIT xrefs to terms both in the neoplasm branch and other NCIT branches.


- Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as: 
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_all_human_disease_mondo_classes_with_xref.ru data/output/all_human_disease_mondo_class_xref_count.tsv
```


#### Sources of Interest:
- DOID
- NCIT (neoplasm branch) --> special processing needed
- OMIM
- Orphanet
- ICD10CM
- UMLS (as provided by MedGen)


#### Alignment to NCIT
##### Get all classes from NCIT that are in the neoplasm branch
- Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as:
```
robot reason -i ./data/component-download-ncit.owl.owl query --use-graphs true -q sparql/ncit_neoplasm_children.ru ./data/input/ncit_neoplasm_children.tsv
```
The file `component-download-ncit.owl.owl` was copied from the mondo-ingest repo from `mondo-ingest/src/ontology/tmp`.

- Query Mondo for a _list_ of all Mondo classes that are in the human disease branch, i.e. children of MONDO:0700096 'human disease' and have an xref to NCIT. Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as: 
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_mondo_class_list_with_ncit_xref.ru data/input/all_mondo_classes_with_ncit_xref.tsv
```

- Check for overlapping NCIT CURIEs in each file by running these commands from the Terminal:
```
$ awk -F'\t' 'NR==FNR {xref[$1]; next} $3 in xref' data/ncit_neoplasm_children.tsv data/input/all_mondo_classes_with_ncit_xref.tsv > data/all_mondo_classes_with_ncit_xref_neoplasm-branch.tsv

$ wc data/all_mondo_classes_with_ncit_xref_neoplasm-branch.tsv
    3804   20177  229560 data/all_mondo_classes_with_ncit_xref_neoplasm-branch.tsv
```

#### Results for Alignment with the source - Total number of diseases in sources
- DOID	11390
- ICD10CM	9142
- NCIT	3804
- OMIM	9333
- Orphanet	11035
- UMLS	20738


### Alignment with the source - Number of terms from the sources that are in Mondo (as Mondo:equivalent)
To generate these counts, follow the steps above for "Alignment with the source - Total number of diseases in sources", but create new queries where the xref must also have a source annotation of `MONDO:equivalentTo`.

- Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as: 
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_all_human_disease_mondo_classes_with_xref-equivalentTo.ru data/output/all_human_disease_mondo_class_xref_count-equivalentTo.tsv
```


#### Alignment to the source NCIT - Number of terms from the sources that are in Mondo (as Mondo:equivalent)
- Query Mondo for a _list_ of all Mondo classes that are in the human disease branch, i.e. children of MONDO:0700096 'human disease' and have an xref to NCIT and also have an xref source annotation of `MONDO:equivalentTo`. Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as: 
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_mondo_class_list_with_ncit_xref-equivalentTo.ru data/input/all_mondo_classes_with_ncit_xref-equivalentTo.tsv
```

- Check of overlapping NCIT CURIEs in each file by running these commands from the Terminal:
```
$ awk -F'\t' 'NR==FNR {xref[$1]; next} $3 in xref' data/input/ncit_neoplasm_children.tsv data/input/all_mondo_classes_with_ncit_xref-equivalentTo.tsv > data/output/all_mondo_classes_with_ncit_xref_neoplasm-branch-equivalentTo.tsv

$ wc data/output/all_mondo_classes_with_ncit_xref_neoplasm-branch-equivalentTo.tsv
    3452   18507  210236 data/output/all_mondo_classes_with_ncit_xref_neoplasm-branch-equivalentTo.tsv
```

#### Results for Alignment with the source - Number of terms from the sources that are in Mondo (as Mondo:equivalent)
- DOID	11185
- ICD10CM	1116
- NCIT	3452
- OMIM	9141
- Orphanet	8176
- UMLS	20738


### Request 3: Externally Managed Content
For Mondo terms are in the human disease branch, i.e. children of MONDO:0700096 'human disease', get the total number of diseases represented by each Externally Managed Content source (see below). This should be the count of distinct Mondo classes that contain at least one database_cross_reference to each of the "Externally Managed Content" sources. The query can be run against `mondo-edit.obo`, but must use the parameter `reason` with the robot command since many Mondo classes only classify with a parent of MONDO:0700096 'human disease' in the inferred hierarchy.

- Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as: 
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_all_human_disease_mondo_classes_with_EMC_xref.ru data/output/all_human_disease_mondo_class_xref_EMC_count.tsv
```

#### Externally Managed Content
- GARD
- MedGen
- NANDO
- NORD

#### Results for Externally Managed Content
- GARD	10719
- MedGen	20738
- NANDO	1499
- NORD	911


### Request 4 - General Statistics
These can be generated as: `sh run.sh make create-mondo-stats`.

#### Results - General Statistics
All Mondo Stats created on: Tue Jan 14 05:02:59 UTC 2025
?classCount
25470
?xrefCount
127289
?clsDefinitionCount
17550
?exactSynonymCount
73357
?relatedSynonymCount
30474
?narrowSynonymCount
2539
?broadSynonymCount
1385
?rareClassCount
15641
?infectiousClassCount
1071
?cancerClassCount
4710
?hereditaryClassCount
11436


### Request 5: Rare Diseases with Gene association
Get the total number of Mondo classes that are a subclass of and that have the subset annotation `rare`.

- Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as: 
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_human_disease_mondo_classes_rare.ru data/output/human_disease_mondo_classes_rare.tsv
```

#### Results - Rare Diseases
15641 human diseases in the rare subset

- Of those classes in the `rare` subset, how many also have a gene association.

Run as:
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_human_disease_mondo_classes_rare_and_gene_associations.ru data/output/human_disease_mondo_classes_rare_and_gene_associations.tsv
```

#### Results - Rare Disease with Gene Association
5620


### Request 7 - Synonyms
Get the number of exact synonyms we have from each source.

- Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as: 
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_exact_synonyms.ru data/output/exact_synonyms.tsv
```

- To extract a list of unique sources, run as:
```
awk -F'\t' '
NR > 1 {
    n = split($4, xrefs, ", ");
    for (i = 1; i <= n; i++) {
        split(xrefs[i], parts, ":");
        source = parts[1];
        gsub(/^"/, "", source);  # Remove leading double-quote
        sources[source]++;  # Increment count for each source
    }
}
END {
    print "Source\tCount";
    for (source in sources) {
        print source "\t" sources[source];
    }
}' data/output/exact_synonyms.tsv 
```

NOTE: To search for synonyms from a particular source, use this regex: `synonym: ".*?" EXACT \[.*?\bNCIT:[^\]]*\]` and make sure to toggle the Seach box in VS Code to the regex option. Alternatively, the search can also be done using grep, e.g. `grep -E 'synonym: ".*?" EXACT \[.*?\bhttps:[^]]*\]' mondo-edit.obo`.

#### Results - Synonyms
Source	Count
MONDO	18297
MedDRA	5
Orphanet	13181
https	1422
ONCOTREE	39
ISBN-13	12
EFO	34
PMID	446
ICD10CM	540
MESH	649
MEDGEN	5
HP	11
icd11.foundation	2606
OMOP	24
GTR	13
MedGen	1
UMLS	53
MTH	102
Wikipedia	72
OMIM	10030
SCDO	1
NORD	438
DECIPHER	40
NCIT	20215
GARD	912
ICD10WHO	2
DOID	17968
OGMS	1
ICD9	1
SCTID	57
MONDORULE	2825
doi	88
http	8
ICD9CM	513
OMIMPS	265

These results are too messy (multiple sources that start with 'https', e.g. ORICID, CDC, ClinGen, etc.) and will be tabulated in the Jupyter notebook.

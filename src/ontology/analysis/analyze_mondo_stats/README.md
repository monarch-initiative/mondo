## Overall Mondo Stats

### Description
This notebook and SPARQL queries are to generate data as requested [here](https://docs.google.com/document/d/1vPl2x8gfTypjzcb9ND8qXXfKIjPDE4RwuExmzAUpM6Q/edit?tab=t.0). The section headings in this README follow those in that Google Document.


---

### Mondo Cross Reference and Synomym Counts
| Source     | Xref   | Xref and MONDO:equivalentTo | Exact Synonyms |
| :---       | :---:  |        :---:                | :---:          |
| DOID       | 11390  | 11184                       | 17968          |
| ICD10CM    | 9142   | 1116                        | 540            | 
| ICD11      | 4053   | 4040                        | 2606           |
| NCIT       | 3804<sup>*</sup>  | 3452<sup>*</sup> | 20215<sup>**</sup> |
| OMIM       | 9333   | 9141                        | 10030          |
| Orphanet   | 11035  | 8176                        | 13181          |
| Orphanet (disorder and subtypes) | 7218   | 7218  | NC             |
| UMLS       | 20738  | 20737                       | 53             |
| GARD       | 10719  | NC                          | 912            |
| MedGen     | 20737  | NC                          | 6              |
| NANDO      | 1499   | NC                          | 0              |  
| NORD       | 911    | NC                          | 438            |


*Count is restricted to NCIT CURIEs that are within the NCIT 'neoplasm' branch. See section "Alignment to NCIT" for details on how this was calculated.

**Count is for any NCIT CURIE.

NC - not calculated


The data was generated using `mondo-edit.obo` from the `master` branch. The alignment data was generated using the `mondo-edit.obo` version from 14-Jan-2025, commit hash [88a1204](https://github.com/monarch-initiative/mondo/blob/88a1204182d90ad43c725669044806235598e8ba/src/ontology/mondo-edit.obo) (the most recent version available at the time the analysis was run).

---
### Request 1: Alignment with the source - Total number of diseases in sources
For Mondo terms are in the human disease branch, i.e. children of MONDO:0700096 'human disease', get the total number of diseases represented by each source of interest (see below). This should be the count of distinct Mondo classes that contain at least one database_cross_reference to each of the "Sources of Interest". The query can be run against `mondo-edit.obo`, but must use the parameter `reason` with the robot command since many Mondo classes only classify with a parent of MONDO:0700096 'human disease' in the inferred hierarchy.

NOTE: A list of all NCIT terms in the neoplasm branch is needed in order to filter all Mondo xrefs to NCIT where these NCIT terms are in the neoplasm branch since Mondo contains NCIT xrefs to terms both in the neoplasm branch and other NCIT branches.


- Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as: 
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_all_human_disease_mondo_classes_with_xref.ru data/output/all_human_disease_mondo_classes_with_xref.tsv
```


#### Sources of Interest:
- DOID
- NCIT - only terms in the NCIT 'neoplasm' branch
- OMIM
- Orphanet - all terms and also only orphanet disorder and disease subtypes
- ICD10CM
- UMLS


#### Orphanet Disorder and Disease Subtypes
- Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as:
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_all_human_disease_mondo_classes_with_xref_ORDO-disorder-subtypes.ru data/output/all_human_disease_mondo_classes_with_xref_ORDO-disorder-subtypes.tsv
```

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
DOID	11390
ICD10CM	9142
NCIT*	3804
OMIM	9333
Orphanet	11035 (all terms)
Orphanet**    7218 (ordo_disorder and ordo_subtype_of_a_disorder subsets)
UMLS	20738
*See "Alignment to NCIT" for details on how this was calculated.
**See "Orphanet Disorder and Disease Subtypes" for details on how this was calculated.

### Alignment with the source - Number of terms from the sources that are in Mondo (as MONDO:equivalentTo)
To generate these counts, follow the steps above for "Alignment with the source - Total number of diseases in sources", but create new queries where the xref must also have a source annotation of `MONDO:equivalentTo`.

- Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as: 
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_all_human_disease_mondo_classes_with_xref-equivalentTo.ru data/output/all_human_disease_mondo_classes_with_xref-equivalentTo.tsv
```

#### Alignment with Orphanet Disorder and Disease Subtypes
- Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as: 
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_all_human_disease_mondo_classes_with_xref-equivalentTo_ORDO-disorders-subtypes.ru data/output/all_human_disease_mondo_classes_with_xref-equivalentTo_ORDO-disorders-subtypes.tsv
```

#### Alignment to the source NCIT - Number of terms from the sources that are in Mondo (as MONDO:equivalentTo)
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

#### Results for Alignment with the source - Number of terms from the sources that are in Mondo (as MONDO:equivalentTo)
- DOID	11184
- ICD10CM	1116
- NCIT	3452
- OMIM	9141
- Orphanet	8176
- Orphanet 7218 (ordo_disorder and ordo_subtype_of_a_disorder subsets)
- UMLS	20737

### Get the total number of Mondo classes in the Mondo human neoplasm branch, e.g. children of MONDO:0005070
From `mondo/src/ontology/analysis/analyze_mondo_stats` run as:
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_all_human_disease_mondo_classes_neoplasm_children.ru data/output/mondo_neoplasm_count.tsv
```


### Request 3: Externally Managed Content
For Mondo terms are in the human disease branch, i.e. children of MONDO:0700096 'human disease', get the total number of diseases represented by each Externally Managed Content source (see below). This should be the count of distinct Mondo classes that contain at least one database_cross_reference to each of the "Externally Managed Content" sources. The query can be run against `mondo-edit.obo`, but must use the parameter `reason` with the robot command since many Mondo classes only classify with a parent of MONDO:0700096 'human disease' in the inferred hierarchy.

- Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as: 
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_all_human_disease_mondo_classes_with_EMC_xref.ru data/output/all_human_disease_mondo_classes_with_EMC_xref.tsv
```

#### Externally Managed Content
- GARD
- MedGen
- NANDO
- NORD

- Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as:
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_all_human_disease_mondo_classes_with_EMC_xref.ru data/output/get_all_human_disease_mondo_classes_with_EMC_xref.tsv
```


#### Results for Externally Managed Content
GARD	10719
MedGen	20737
NANDO	1499
NORD	911


### Request 4 - General Statistics
These can be generated as: `sh run.sh make create-mondo-stats`. To get more details on this, search for the goal `create-mondo-stats` in the `mondo.Makefile` to see the commands and queries that are run.

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
### Get the number of exact synonyms we have from each source

- Run from `mondo/src/ontology/analysis/analyze_mondo_stats` as: 
```
robot reason -i ../../mondo-edit.obo query --use-graphs true -q sparql/get_exact_synonyms.ru data/output/exact_synonyms.tsv
```

- To extract a list of unique sources from `exact_synonyms.tsv`, run as:
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

NOTE: To search for synonyms from a particular source, use this regex pattern:  `synonym: ".*?" EXACT \[.*?\bNCIT:[^\]]*\]` where `NCIT` is the CURIE prefix or `synonym: ".*?" .*? \[\]` for synonyms of any type without any source. Make sure to toggle the Seach box in VS Code to the regex option.
Alternatively, the search can also be done using grep, e.g. `grep -E 'synonym: ".*?" EXACT \[.*?\bhttps:[^]]*\]' mondo-edit.obo`.

For synonym source values that are a URL, the regex pattern is: `synonym: ".*?" EXACT \[.*?\bhttps:\/\/orcid\.org\/[^\],]*.*`, where the bsae URL to search for is `https://orcid.org`.

The list needed further analysis of synonym source values that start with `http` or `https` so further analysis was done in the Jupyter notebook.


#### Results - Synonyms
sources  count
NCIT	20215
MONDO	18297
DOID	17968
Orphanet	13181
OMIM	10030
MONDORULE	2825
icd11.foundation	2606
~https	1422~ # these sources were further processed based on unique URL domain
GARD	912
MESH	649
ICD10CM	540
ICD9CM	513
PMID	446
NORD	438
OMIMPS	265
MTH	102
doi	88
Wikipedia	72
SCTID	57
UMLS	53
DECIPHER	40
ONCOTREE	39
EFO	34
OMOP	24
GTR	13
ISBN-13	12
HP	11
~http	8~ # these sources were further processed based on unique URL domain
MedDRA	5
MEDGEN	5
ICD10WHO	2
OGMS	1
ICD9	1
MedGen	1
SCDO	1
https://orcid.org	873
https://clinicalgenome.org	178
https://www.clinicalgenome.org	119
https://www.ncbi.nlm.nih.gov	68
https://github.com	36
https://rarediseases.org	31
https://www.epilepsydiagnosis.org	22
https://www.circadiansleepdisorders.org	11
https://ghr.nlm.nih.gov	11
https://www.cdc.gov	9
https://www.niddk.nih.gov	9
https://www.ninds.nih.gov	4
https://www.dysautonomiainternational.org	4
https://rarediseases.info.nih.gov	4
https://en.wikipedia.org	4
https://www.who.int	3
https://www.mda.org	3
https://wwwnc.cdc.gov	3
https://www.nccn.org	2
https://www.medicalalgorithms.com	2
https://www.dermnetnz.org	2
https://science.jrank.org	2
https://includedcc.org	2
https://www.cincinnatichildrens.org	2
https://medical-dictionary.thefreedictionary.com	2
https://www.verywellhealth.com	2
https://www.medicinenet.com	2
https://doi.org	2
http://www.clevelandclinicmeded.com	2
http://www.kat6a.org	1
https://www.nih.gov	1
http://purl.bioontology.org	1
https://search.clinicalgenome.org	1
https://fertilitynj.com	1
http://www.emro.who.int	1
http://purl.obolibrary.org	1
https://www.ecgmedicaltraining.com	1
https://eyewiki.aao.org	1
https://www.mayoclinic.org	1
https://www.merriam-webster.com	1
https://www.britannica.com	1
http://cmr.asm.org	1
http://www.dictionary.com	1
https://globalgenes.org	1
https://emedicine.medscape.com	1


### Number of Sources for Synonyms
How many sources overlap in terms of synonyms: Number of synonyms that have more than one source where that synonym exists. See the Jupyter
notebook "Overall Mondo Stats-checkpoint" for details on how these counts were generated.

#### Results - Number of Sources for Synonyms
Number of Sources	Count of Synonyms
0	12389
1	40059
2	14079
3	4538
4	1470
5	441
6	132
7	24

This means there are 40059 exact synonyms that have only 1 database cross reference source for the synonym.


### Request 7 - "Preferred" Labels
Get the count of how many mondo term have a:
- ClinGen Label
  - Run this command from the Terminal from `mondo/src/ontology/analysis/analyze_mondo_stats` as: 
  `grep -c 'EXACT CLINGEN_LABEL' ../../mondo-edit.obo ` --> 1881 Mondo classes with an exact synonym designated as the CLINGEN_LABEL
- NORD label (ignore if we don’t have it yet) --> I don't see anything with a tag of `NORD_LABEL`
- OTAR label (ignore if we don’t have it yet) --> I don't see anything with a tag of `OTAR_LABEL`



## Automatic Mondo Quality Control Checks for Externally Managed Content
A subset of the extensive Mondo QC checks are automatically run on externally managed content. Any content from external providers that does not pass these QC checks is not included in Mondo until the content is updated and passes the QC checks. Reports of these QC checks will be available for review of any errors so that any needed changes can be made.

### QC Checks for Externally Managed Content
| Error | Description | SPARQL Query | 
|:------|:------------|:-------------|
| duplicate_scoped_synonym | An entity has duplicate synonyms with different properties (e.g. the same broad and related synonym). This causes ambiguity. | <a href='https://robot.obolibrary.org/report_queries/duplicate_scoped_synonym' target='_blank'>duplicate scoped synonym</a> |
| invalid_xref | A database_cross_reference is not in CURIE format. | <a href='https://robot.obolibrary.org/report_queries/invalid_xref' target='_blank'>invalid xref</a> |
| qc-duplicate-exact-synonym-no-abbrev| An exact synonym, excluding abbreviations, or label is used for two different entities.| <a href='https://github.com/monarch-initiative/mondo/blob/master/src/sparql/qc/general/qc-duplicate-exact-synonym-no-abbrev.sparql' target='_blank'>duplicate synonyms</a>|
| qc-related-exact-synonym| A value for a synonym is used with both the exact and related synonym scopes.|<a href='https://github.com/monarch-initiative/mondo/blob/master/src/sparql/qc/general/qc-related-exact-synonym.sparql' target='_blank'>related exact synonym</a>|
| qc-syn-source-not-xref| A synonym does not have a database cross reference as the source of the synonym.| <a href='https://github.com/monarch-initiative/mondo/blob/master/src/sparql/qc/general/qc-syn-source-not-xref.sparql' target='_blank'>missing synonym source</a>|
| qc-trailing-whitespace.sparql| An entity contains a leading or trailing whitespace. | <a href='https://github.com/monarch-initiative/mondo/blob/master/src/sparql/qc/general/qc-trailing-whitespace.sparql' target='_blank'>trailing whitespace</a>|
| qc-animal-disease-rare| An animal disease is contained within a rare disease subset. |<a href='https://github.com/monarch-initiative/mondo/blob/master/src/sparql/qc/mondo/qc-animal-disease-rare.sparql' target='_blank'>animal disease rare</a>|
| qc-proxy-merges| Two Mondo classes have a mapping to the same term. See <a href='https://mondo.readthedocs.io/en/latest/editors-guide/proxy-merge/' target='_blank'>proxy merges</a> for more information.| <a href='https://github.com/monarch-initiative/mondo/blob/master/src/sparql/qc/mondo/qc-proxy-merges.sparql' target='_blank'>proxy merge</a>|


### Example Report for QC Check

```
# QC Failure Report for nord.robot.tsv

## Removed from the resource

| mondo_id      | report_ref   | report_ref_source   | preferred_name             | preferred_name_source   | synonym_type   | subset   | subset_source   | subset_source2   | Source         | Check                                               |
|:--------------|:-------------|:--------------------|:---------------------------|:------------------------|:---------------|:---------|:----------------|:-----------------|:---------------|:----------------------------------------------------|
| MONDO:0001280 |              |                     | Posterior Uveitis          |                         |                |          |                 |                  | nord.robot.tsv | duplicate_scoped_synonym (oboInOwl:hasExactSynonym) |
| MONDO:0002119 |              |                     | Juvenile Ossifying Fibroma |                         |                |          |                 |                  | nord.robot.tsv | duplicate_scoped_synonym (oboInOwl:hasExactSynonym) |
| MONDO:0005731 |              |                     | Acanthocheilonemiasis      |                         |                |          |                 |                  | nord.robot.tsv | duplicate_scoped_synonym (oboInOwl:hasExactSynonym) |
| MONDO:0005761 |              |                     | Elephantiasis              |                         |                |          |                 |                  | nord.robot.tsv | duplicate_scoped_synonym (oboInOwl:hasBroadSynonym) |
| MONDO:0007030 |              |                     | Aarskog Syndrome           |                         |                |          |                 |                  | nord.robot.tsv | duplicate_scoped_synonym (oboInOwl:hasExactSynonym) |
| MONDO:0007306 |              |                     | Klippel-Feil Syndrome      |                         |                |          |                 |                  | nord.robot.tsv | duplicate_scoped_synonym (oboInOwl:hasBroadSynonym) |
| MONDO:0007389 |              |                     | Spondylothoracic Dysplasia |                         |                |          |                 |                  | nord.robot.tsv | duplicate_scoped_synonym (oboInOwl:hasExactSynonym) |
```
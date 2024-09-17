## Automatic Mondo Quality Control Checks for Externally Managed Content
A subset of the extensive Mondo QC checks are automatically run on externally managed content. Any content from external providers that does not pass these QC checks is not included in Mondo. These reports will be available for the external providers to review the errors and make the needed changes in their source files.

### QC Checks
- mondo/src/sparql/qc/general/qc-syn-source-not-xref.sparql
- invalid_xref
- duplicate_scoped_synonym
- mondo/src/sparql/qc/general/qc-duplicate-exact-synonym-no-abbrev.sparql
- mondo/src/sparql/qc/mondo/qc-proxy-merges.sparql
- mondo/src/sparql/qc/general/qc-related-exact-synonym.sparql
- mondo/src/sparql/qc/mondo/qc-animal-disease-rare.sparql
- mondo/src/sparql/qc/general/qc-trailing-whitespace.sparql



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
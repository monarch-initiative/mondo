# OMIM_phenotypic_series 

[http://purl.obolibrary.org/obo/mondo/patterns/OMIM_phenotypic_series.yaml](http://purl.obolibrary.org/obo/mondo/patterns/OMIM_phenotypic_series.yaml)
## Description 

This pattern is meant to be used for OMIM phenotypic series (OMIMPS), which are represented as grouping classes in Mondo. Note:  - every instance of this metaclass should be equivalent to (via annotated xref) to something in OMIMPS namespace - it will never have an asserted causative gene as logical axiom (and no single causative gene in text def) - it must never be equivalent to an OMIM:nnnnnn (often redundant with the above rule) - it must have an acronym synonym, e.g. HPE - it must have two or more subclasses (direct or indirect) that are equivalent to OMIMs - the subclasses should (not must) have a logical def that uses the PS as a genus (see http://purl.obolibrary.org/obo/mondo/patterns/disease_series_by_gene.yaml) - the OMIM subclasses must have acronym synonyms that are the parent syn + number, e.g. HPE1, HPE2 - the primary label for the children should also be parent + {"type"} + number - the first member will usually have the same number local ID as the PS - the first member in OMIM usually has documentation that is pertinent to the parent PS - the members may(?) generally share high semantic similarity - All OMIMPS disease should have a has characteristic some inherited restricted, see http://purl.obolibrary.org/obo/mondo/sparql/omimps-should-be-inherited-violation.sparql

Examples: [holoprosencephaly](http://purl.obolibrary.org/obo/MONDO_0016296) [OMIMPS:236100](https://omim.org/phenotypicSeries/PS236100), '3-M syndrome'(http://purl.obolibrary.org/obo/MONDO_0007477) [OMIMPS:236100](https://omim.org/phenotypicSeries/PS273750). 
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

{[disease](http://purl.obolibrary.org/obo/MONDO_0700096)}


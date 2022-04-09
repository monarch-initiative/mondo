# inherited_susceptibility 

[http://purl.obolibrary.org/obo/mondo/patterns/inherited_susceptibility.yaml](http://purl.obolibrary.org/obo/mondo/patterns/inherited_susceptibility.yaml)
## Description 

This pattern should be used for children of MONDO_0020573'inherited disease susceptibility', including OMIM phenotypic series (OMIMPS) for which the subclasses are susceptibilities. Note, this pattern should not have an asserted causative gene as logical axiom (and no single causative gene in text definition), in those cases, the susceptibility_by_gene pattern should be used instead. The children should have asserted causative genes in the text definitions and in the logical axioms. This pattern is a superclass of the susceptibility_by_gene pattern.

Examples: ['microvascular complications of diabetes, susceptibility'](http://purl.obolibrary.org/obo/MONDO_0000065), ['epilepsy, idiopathic generalized'](http://purl.obolibrary.org/obo/MONDO_0005579), ['aspergillosis, susceptibility to'](http://purl.obolibrary.org/obo/MONDO_0013562).
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

{[disease](http://purl.obolibrary.org/obo/MONDO_0000001)} susceptibility

## Annotations 

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)}, susceptibility

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)}, susceptibility to

## Definition 

An inherited susceptibility or predisposition to developing {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)}.

## Equivalent to 

([inherited disease susceptibility](http://purl.obolibrary.org/obo/MONDO_0020573) and ([predisposes towards](http://purl.obolibrary.org/obo/http_//purl.obolibrary.org/obo/mondo#predisposes_towards) some {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)}))

## Data preview 
| defined_class                                | defined_class_label                           | disease                                      | disease_label                            |
|:---------------------------------------------|:----------------------------------------------|:---------------------------------------------|:-----------------------------------------|
| [MONDO:0000093](http://purl.obolibrary.org/obo/MONDO_0000093) | Schistosoma mansoni infection, susceptibility | [MONDO:0044345](http://purl.obolibrary.org/obo/MONDO_0044345) | Schistosoma mansoni infectious disease   |
| [MONDO:0013562](http://purl.obolibrary.org/obo/MONDO_0013562) | aspergillosis, susceptibility to              | [MONDO:0005657](http://purl.obolibrary.org/obo/MONDO_0005657) | aspergillosis                            |
| [MONDO:0000162](http://purl.obolibrary.org/obo/MONDO_0000162) | autoimmune thyroid disease, susceptibility to | [MONDO:0005623](http://purl.obolibrary.org/obo/MONDO_0005623) | autoimmune thyroid disease               |
| [MONDO:0000108](http://purl.obolibrary.org/obo/MONDO_0000108) | bacteremia, susceptibility                    | [MONDO:0005229](http://purl.obolibrary.org/obo/MONDO_0005229) | bacterial infectious disease with sepsis |
| [MONDO:0015279](http://purl.obolibrary.org/obo/MONDO_0015279) | chronic mucocutaneous candidiasis             | [MONDO:0002026](http://purl.obolibrary.org/obo/MONDO_0002026) | candidiasis                              |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/inherited_susceptibility.tsv) 

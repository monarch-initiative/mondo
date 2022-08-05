# consequence_of_infectious_disease 

[http://purl.obolibrary.org/obo/mondo/patterns/consequence_of_infectious_disease.yaml](http://purl.obolibrary.org/obo/mondo/patterns/consequence_of_infectious_disease.yaml)
## Description 

This pattern is applied to a disease that is caused by an infectious agent.

Examples: [hepatitis C induced liver cirrhosis](http://purl.obolibrary.org/obo/MONDO_0005448), [rubella encephalitis](http://purl.obolibrary.org/obo/MONDO_0020648)
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

{[cause](http://purl.obolibrary.org/obo/MONDO_0005550)} {[parent](http://purl.obolibrary.org/obo/MONDO_0000001)}

## Definition 

A {[parent](http://purl.obolibrary.org/obo/MONDO_0000001)} that arises as a consequence of {[cause](http://purl.obolibrary.org/obo/MONDO_0005550)}.

## Equivalent to 

{[parent](http://purl.obolibrary.org/obo/MONDO_0000001)} and [disease arises from feature](http://purl.obolibrary.org/obo/RO_0004022) some {[cause](http://purl.obolibrary.org/obo/MONDO_0005550)}

## Data preview 
| defined_class                                | defined_class_label       | cause                                        | cause_label                  | parent                                       | parent_label        |
|:---------------------------------------------|:--------------------------|:---------------------------------------------|:-----------------------------|:---------------------------------------------|:--------------------|
| [MONDO:0020689](http://purl.obolibrary.org/obo/MONDO_0020689) | AIDS dementia complex     | [MONDO:0005109](http://purl.obolibrary.org/obo/MONDO_0005109) | HIV infectious disease       | [MONDO:0001627](http://purl.obolibrary.org/obo/MONDO_0001627) | dementia            |
| [MONDO:0002812](http://purl.obolibrary.org/obo/MONDO_0002812) | infectious otitis interna | [MONDO:0005550](http://purl.obolibrary.org/obo/MONDO_0005550) | infectious disease           | [MONDO:0002008](http://purl.obolibrary.org/obo/MONDO_0002008) | labyrinthitis       |
| [MONDO:0021673](http://purl.obolibrary.org/obo/MONDO_0021673) | post-bacterial disorder   | [MONDO:0005113](http://purl.obolibrary.org/obo/MONDO_0005113) | bacterial infectious disease | [MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001) | disease or disorder |
| [MONDO:0021669](http://purl.obolibrary.org/obo/MONDO_0021669) | post-infectious disorder  | [MONDO:0005550](http://purl.obolibrary.org/obo/MONDO_0005550) | infectious disease           | [MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001) | disease or disorder |
| [MONDO:0021670](http://purl.obolibrary.org/obo/MONDO_0021670) | post-infectious syndrome  | [MONDO:0005550](http://purl.obolibrary.org/obo/MONDO_0005550) | infectious disease           | [MONDO:0002254](http://purl.obolibrary.org/obo/MONDO_0002254) | syndromic disease   |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/consequence_of_infectious_disease.tsv) 

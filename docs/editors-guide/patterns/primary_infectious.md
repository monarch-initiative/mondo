# primary infectious 

[http://purl.obolibrary.org/obo/mondo/patterns/primary_infectious.yaml](http://purl.obolibrary.org/obo/mondo/patterns/primary_infectious.yaml)
## Description 


Pattern for extending a disease class to a primary infectious form, a characteristic of an infectious disease in which the disease affects an immunologically normal host. Example: MONDO_0000308 'primary systemic mycosis'.
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
## Name 

primary {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)}

## Definition 

A {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} that arises from infection in an immunologically normal host.

## Equivalent to 

{disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} and {has modifier\([RO:0002573](http://purl.obolibrary.org/obo/RO_0002573)\)} some {primary infectious\([MONDO:0045036](http://purl.obolibrary.org/obo/MONDO_0045036)\)}

## Data preview 
| defined:class                                | defined:class:label                  | disease                                      | disease:label                |
|:---------------------------------------------|:-------------------------------------|:---------------------------------------------|:-----------------------------|
| MONDO:0000314 | primary bacterial infectious disease | MONDO:0005113 | bacterial infectious disease |
| MONDO:0000308 | primary systemic mycosis             | MONDO:0000256 | systemic mycosis             |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/primary_infectious.tsv) 

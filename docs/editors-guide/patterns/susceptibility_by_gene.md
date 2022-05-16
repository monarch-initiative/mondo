# susceptibility_by_gene 

[http://purl.obolibrary.org/obo/mondo/patterns/susceptibility_by_gene.yaml
Examples - [autism, susceptibility to, X-linked 5](http://purl.obolibrary.org/obo/MONDO_0010449), [bulimia nervosa, susceptibility to, 2](http://purl.obolibrary.org/obo/MONDO_0012461), [nephrolithiasis susceptibility caused by SLC26A1](http://purl.obolibrary.org/obo/MONDO_0020722)'](http://purl.obolibrary.org/obo/mondo/patterns/susceptibility_by_gene.yaml
Examples - [autism, susceptibility to, X-linked 5](http://purl.obolibrary.org/obo/MONDO_0010449), [bulimia nervosa, susceptibility to, 2](http://purl.obolibrary.org/obo/MONDO_0012461), [nephrolithiasis susceptibility caused by SLC26A1](http://purl.obolibrary.org/obo/MONDO_0020722)')
## Description 

This pattern should be used for terms in which a gene dysfunction causes a predisposition or susceptibility towards developing a specific disease. This pattern is a sub-pattern of [inherited_susceptibility.yaml](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/inherited_susceptibility.yaml)
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

{[disease](http://purl.obolibrary.org/obo/MONDO_0000001)} susceptibility, {[gene](http://purl.obolibrary.org/obo/SO_0000704)} form

## Annotations 

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)} susceptibility caused by {[gene](http://purl.obolibrary.org/obo/SO_0000704)}

## Definition 

A susceptibility or predisposition to {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)} in which the cause of the disease is a mutation in the {[gene](http://purl.obolibrary.org/obo/SO_0000704)} gene.

## Equivalent to 

([inherited disease susceptibility](http://purl.obolibrary.org/obo/MONDO_0020573) and ([has material basis in germline mutation in](http://purl.obolibrary.org/obo/RO_0004003) some {[gene](http://purl.obolibrary.org/obo/SO_0000704)}) and ([predisposes towards](http://purl.obolibrary.org/obo/http_//purl.obolibrary.org/obo/mondo#predisposes_towards) some {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)}))

## Data preview 
| defined_class                                | defined_class_label                                         | disease                                      | disease_label                                    | gene                              | gene_label   |
|:---------------------------------------------|:------------------------------------------------------------|:---------------------------------------------|:-------------------------------------------------|:----------------------------------|:-------------|
| [MONDO:0012153](http://purl.obolibrary.org/obo/MONDO_0012153) | Alzheimer disease 9                                         | [MONDO:0015140](http://purl.obolibrary.org/obo/MONDO_0015140) | early-onset autosomal dominant Alzheimer disease | http://identifiers.org/hgnc/37    | ABCA7        |
| [MONDO:0012466](http://purl.obolibrary.org/obo/MONDO_0012466) | Parkinson disease 13, autosomal dominant, susceptibility to | [MONDO:0005180](http://purl.obolibrary.org/obo/MONDO_0005180) | Parkinson disease                                | http://identifiers.org/hgnc/14348 | HTRA2        |
| [MONDO:0013653](http://purl.obolibrary.org/obo/MONDO_0013653) | Parkinson disease 18, autosomal dominant, susceptibility to | [MONDO:0005180](http://purl.obolibrary.org/obo/MONDO_0005180) | Parkinson disease                                | http://identifiers.org/hgnc/3296  | EIF4G1       |
| [MONDO:0013340](http://purl.obolibrary.org/obo/MONDO_0013340) | Parkinson disease 5, autosomal dominant, susceptibility to  | [MONDO:0005180](http://purl.obolibrary.org/obo/MONDO_0005180) | Parkinson disease                                | http://identifiers.org/hgnc/12513 | UCHL1        |
| [MONDO:0011727](http://purl.obolibrary.org/obo/MONDO_0011727) | anorexia nervosa, susceptibility to, 1                      | [MONDO:0005351](http://purl.obolibrary.org/obo/MONDO_0005351) | anorexia nervosa                                 | http://identifiers.org/hgnc/5293  | HTR2A        |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/susceptibility_by_gene.tsv) 

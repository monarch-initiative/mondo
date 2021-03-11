# cancer 

[http://purl.obolibrary.org/obo/mondo/patterns/cancer.yaml](http://purl.obolibrary.org/obo/mondo/patterns/cancer.yaml)
## Description 



Cancers are malignant neoplasms arising from a variety of different cell types.

This is a design pattern for classes representing cancers based on their location. This may be the site of origin, but it can also represent a secondary site for metastatized cancer.

We use the generic 'disease has location' relation, which generalized over primary and secondary sites.
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
## Name 

{[location](http://www.w3.org/2002/07/owl#Thing)} cancer

## Annotations 

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): malignant {[location](http://www.w3.org/2002/07/owl#Thing)} neoplasm

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): malignant neoplasm of {[location](http://www.w3.org/2002/07/owl#Thing)}

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): cancer of {[location](http://www.w3.org/2002/07/owl#Thing)}

## Definition 

A cancer involving a {[location](http://www.w3.org/2002/07/owl#Thing)}.

## Equivalent to 

[cancer](http://purl.obolibrary.org/obo/MONDO_0004992) and [disease has location](http://purl.obolibrary.org/obo/RO_0004026) some {[location](http://www.w3.org/2002/07/owl#Thing)}

## Data preview 
| defined_class                                | defined_class_label        | location                                      | location_label           |
|:---------------------------------------------|:---------------------------|:----------------------------------------------|:-------------------------|
| [MONDO:0000954](http://purl.obolibrary.org/obo/MONDO_0000954) | Meckel diverticulum cancer | [UBERON:0003705](http://purl.obolibrary.org/obo/UBERON_0003705) | Meckel's diverticulum    |
| [MONDO:0004685](http://purl.obolibrary.org/obo/MONDO_0004685) | Waldeyer's ring cancer     | [UBERON:0001735](http://purl.obolibrary.org/obo/UBERON_0001735) | tonsillar ring           |
| [MONDO:0002817](http://purl.obolibrary.org/obo/MONDO_0002817) | adrenal gland cancer       | [UBERON:0002369](http://purl.obolibrary.org/obo/UBERON_0002369) | adrenal gland            |
| [MONDO:0003606](http://purl.obolibrary.org/obo/MONDO_0003606) | adrenal medulla cancer     | [UBERON:0001236](http://purl.obolibrary.org/obo/UBERON_0001236) | adrenal medulla          |
| [MONDO:0000919](http://purl.obolibrary.org/obo/MONDO_0000919) | ampulla of vater cancer    | [UBERON:0004913](http://purl.obolibrary.org/obo/UBERON_0004913) | hepatopancreatic ampulla |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/cancer.tsv) 

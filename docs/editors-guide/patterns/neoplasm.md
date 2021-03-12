# neoplasm 

[http://purl.obolibrary.org/obo/mondo/patterns/neoplasm.yaml](http://purl.obolibrary.org/obo/mondo/patterns/neoplasm.yaml)
## Description 



Neoplasms are benign or malignant tissue growths resulting from uncontrolled cell proliferation cell types.

This is a design pattern for classes representing neoplasms based on their location. This may be the site of origin, but it can also represent a secondary site for malignant neoplasms that have metastasized.

We use the generic 'disease has location' relation, which generalized over primary and secondary sites.

Note that tumor is typically a synonym for neoplasm, although this can be context dependent. For NETs, NCIT uses the nomenclature 'tumor' to indicate 'well differentiated, low or intermediate grade tumor'. This can also be called carcinoid, see https://www.cancer.org/cancer/gastrointestinal-carcinoid-tumor/about/what-is-gastrointestinal-carcinoid.html We attempt to spell this out in our labels.
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
## Name 

{[location](http://www.w3.org/2002/07/owl#Thing)} neoplasm

## Annotations 

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): neoplasm of {[location](http://www.w3.org/2002/07/owl#Thing)}

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): {[location](http://www.w3.org/2002/07/owl#Thing)} tumor

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): tumor of {[location](http://www.w3.org/2002/07/owl#Thing)}

## Definition 

A neoplasm involving a {[location](http://www.w3.org/2002/07/owl#Thing)}.

## Equivalent to 

[neoplasm](http://purl.obolibrary.org/obo/MONDO_0005070) and [disease has location](http://purl.obolibrary.org/obo/RO_0004026) some {[location](http://www.w3.org/2002/07/owl#Thing)}

## Data preview 
| defined_class                                | defined_class_label          | location                                      | location_label         |
|:---------------------------------------------|:-----------------------------|:----------------------------------------------|:-----------------------|
| [MONDO:0021114](http://purl.obolibrary.org/obo/MONDO_0021114) | Bartholin gland neoplasm     | [UBERON:0000460](http://purl.obolibrary.org/obo/UBERON_0000460) | major vestibular gland |
| [MONDO:0021082](http://purl.obolibrary.org/obo/MONDO_0021082) | Meckel diverticulum neoplasm | [UBERON:0003705](http://purl.obolibrary.org/obo/UBERON_0003705) | Meckel's diverticulum  |
| [MONDO:0001884](http://purl.obolibrary.org/obo/MONDO_0001884) | abducens nerve neoplasm      | [UBERON:0001646](http://purl.obolibrary.org/obo/UBERON_0001646) | abducens nerve         |
| [MONDO:0036591](http://purl.obolibrary.org/obo/MONDO_0036591) | adrenal cortex neoplasm      | [UBERON:0001235](http://purl.obolibrary.org/obo/UBERON_0001235) | adrenal cortex         |
| [MONDO:0021227](http://purl.obolibrary.org/obo/MONDO_0021227) | adrenal gland neoplasm       | [UBERON:0002369](http://purl.obolibrary.org/obo/UBERON_0002369) | adrenal gland          |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/neoplasm.tsv) 

# adenoma disease has location X 

[http://purl.obolibrary.org/obo/mondo/patterns/adenoma.yaml](http://purl.obolibrary.org/obo/mondo/patterns/adenoma.yaml)
## Description 



Adenomas are neoplasms arising from epithelium. This is a design pattern for classes representing adenomas based on their location. This may be the site of origin, but it can also represent a secondary site for metastatized cancer. We use the generic `disease has location` relation, which is generalized over primary and secondary sites. Examples: [pituitary gland adenoma](http://purl.obolibrary.org/obo/MONDO_0006373), [breast adenoma](http://purl.obolibrary.org/obo/MONDO_0002058)
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

{[location](http://www.w3.org/2002/07/owl#Thing)} adenoma

## Annotations 

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): {[location](http://www.w3.org/2002/07/owl#Thing)} adenoma

* [related_synonym](http://www.geneontology.org/formats/oboInOwl#hasRelatedSynonym): adenoma of {[location](http://www.w3.org/2002/07/owl#Thing)}

## Definition 

A adenoma that involves the {[location](http://www.w3.org/2002/07/owl#Thing)}.

## Equivalent to 

[adenoma](http://purl.obolibrary.org/obo/MONDO_0004972) and ([disease has location](http://purl.obolibrary.org/obo/RO_0004026) some {[location](http://www.w3.org/2002/07/owl#Thing)})

## Data preview 
| defined_class                                | defined_class_label        | location                                      | location_label         |
|:---------------------------------------------|:---------------------------|:----------------------------------------------|:-----------------------|
| [MONDO:0003419](http://purl.obolibrary.org/obo/MONDO_0003419) | Bartholin gland adenoma    | [UBERON:0000460](http://purl.obolibrary.org/obo/UBERON_0000460) | major vestibular gland |
| [MONDO:0021301](http://purl.obolibrary.org/obo/MONDO_0021301) | adenoma of nipple          | [UBERON:0002030](http://purl.obolibrary.org/obo/UBERON_0002030) | nipple                 |
| [MONDO:0021303](http://purl.obolibrary.org/obo/MONDO_0021303) | adenoma of small intestine | [UBERON:0002108](http://purl.obolibrary.org/obo/UBERON_0002108) | small intestine        |
| [MONDO:0003924](http://purl.obolibrary.org/obo/MONDO_0003924) | adrenal cortex adenoma     | [UBERON:0001235](http://purl.obolibrary.org/obo/UBERON_0001235) | adrenal cortex         |
| [MONDO:0006088](http://purl.obolibrary.org/obo/MONDO_0006088) | appendix adenoma           | [UBERON:0001154](http://purl.obolibrary.org/obo/UBERON_0001154) | vermiform appendix     |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/adenoma.tsv) 

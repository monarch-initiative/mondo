# location 

[http://purl.obolibrary.org/obo/mondo/patterns/location.yaml](http://purl.obolibrary.org/obo/mondo/patterns/location.yaml)
## Description 

A disease that is located in a specific anatomical site.
Examples: ['abdominal cystic lymphangioma'](http://purl.obolibrary.org/obo/MONDO_0021726), ['articular cartilage disease'](http://purl.obolibrary.org/obo/MONDO_0003816), ['urethral disease'](http://purl.obolibrary.org/obo/MONDO_0004184)
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

{disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} of {location\([UBERON:0001062](http://purl.obolibrary.org/obo/UBERON_0001062) or [CL:0000000](http://purl.obolibrary.org/obo/CL_0000000)\)}

## Annotations 

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: {location\([UBERON:0001062](http://purl.obolibrary.org/obo/UBERON_0001062) or [CL:0000000](http://purl.obolibrary.org/obo/CL_0000000)\)} {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)}

## Definition 

A {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} that involves the {location\([UBERON:0001062](http://purl.obolibrary.org/obo/UBERON_0001062) or [CL:0000000](http://purl.obolibrary.org/obo/CL_0000000)\)}.

## Equivalent to 

{disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} and {disease has location\([RO:0004026](http://purl.obolibrary.org/obo/RO_0004026)\)} some {location\([UBERON:0001062](http://purl.obolibrary.org/obo/UBERON_0001062) or [CL:0000000](http://purl.obolibrary.org/obo/CL_0000000)\)}

## Data preview 
| defined:class                                | defined:class:label                  | disease                                      | disease:label        | location                                      | location:label         |
|:---------------------------------------------|:-------------------------------------|:---------------------------------------------|:---------------------|:----------------------------------------------|:-----------------------|
| MONDO:0003909 | Bartholin gland adenomyoma           | MONDO:0005635 | adenomyoma           | UBERON:0000460 | major vestibular gland |
| MONDO:0004120 | Bartholin gland small cell carcinoma | MONDO:0000402 | small cell carcinoma | UBERON:0000460 | major vestibular gland |
| MONDO:0005665 | Bell's palsy                         | MONDO:0006496 | palsy                | UBERON:0001647 | facial nerve           |
| MONDO:0024283 | Demodex folliculitis                 | MONDO:0017280 | demodicidosis        | UBERON:0002073 | hair follicle          |
| MONDO:0018675 | IgG4-related ophthalmic disease      | MONDO:0017287 | IgG4-related disease | UBERON:0000970 | eye                    |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/location.tsv) 

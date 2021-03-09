# sarcoma 

[http://purl.obolibrary.org/obo/mondo/patterns/sarcoma.yaml](http://purl.obolibrary.org/obo/mondo/patterns/sarcoma.yaml)
## Description 



Sarcomas are malignant neoplasms arising from soft tissue or bone.

This is a design pattern for classes representing sarcomas based on their location. This may be the site of origin, but it can also represent a secondary site for metastatized sarcma.

We use the generic 'disease has location' relation, which generalized over primary and secondary sites.
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
## Name 

{[location](http://www.w3.org/2002/07/owl#Thing)} sarcoma

## Annotations 

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: sarcoma of {[location](http://www.w3.org/2002/07/owl#Thing)}

## Definition 

A sarcoma involving a {[location](http://www.w3.org/2002/07/owl#Thing)}.

## Equivalent to 

{[sarcoma](http://purl.obolibrary.org/obo/MONDO_0005089)} and {[disease has location](http://purl.obolibrary.org/obo/RO_0004026)} some {[location](http://www.w3.org/2002/07/owl#Thing)}

## Data preview 
| defined:class                                | defined:class:label     | location                                      | location:label   |
|:---------------------------------------------|:------------------------|:----------------------------------------------|:-----------------|
| MONDO:0019480 | Langerhans cell sarcoma | CL:0000453     | Langerhans cell  |
| MONDO:0016982 | angiosarcoma (disease)  | UBERON:0001981 | blood vessel     |
| MONDO:0002865 | anus sarcoma            | UBERON:0001245 | anus             |
| MONDO:0002862 | bile duct sarcoma       | UBERON:0002394 | bile duct        |
| MONDO:0001374 | bladder sarcoma         | UBERON:0001255 | urinary bladder  |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/sarcoma.tsv) 

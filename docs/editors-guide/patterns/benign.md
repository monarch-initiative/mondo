# benign 

[http://purl.obolibrary.org/obo/mondo/patterns/benign.yaml](http://purl.obolibrary.org/obo/mondo/patterns/benign.yaml)
## Description 


This is a design pattern for classes representing benign neoplasms, extending a generic neoplasm class. For example, a benign adrenal gland pheochromocytoma, defined as being the benign form of the more general adrenal gland pheochromocytoma.
TODO: encode alternate way of representing
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
## Name 

benign {neoplasm\([MONDO:0005070](http://purl.obolibrary.org/obo/MONDO_0005070)\)}

## Annotations 

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: {neoplasm\([MONDO:0005070](http://purl.obolibrary.org/obo/MONDO_0005070)\)}, benign

## Definition 

A form of {neoplasm\([MONDO:0005070](http://purl.obolibrary.org/obo/MONDO_0005070)\)} without malignant characteristics.

## Equivalent to 

{neoplasm\([MONDO:0005070](http://purl.obolibrary.org/obo/MONDO_0005070)\)} and {has modifier\([RO:0002573](http://purl.obolibrary.org/obo/RO_0002573)\)} some {neoplastic, non-malignant\([PATO:0002096](http://purl.obolibrary.org/obo/PATO_0002096)\)}

## Data preview 
| defined:class                                | defined:class:label                   | neoplasm                                     | neoplasm:label                                              |
|:---------------------------------------------|:--------------------------------------|:---------------------------------------------|:------------------------------------------------------------|
| MONDO:0036990 | benign Leydig cell tumor              | MONDO:0006266 | Leydig cell tumor                                           |
| MONDO:0020581 | benign PEComa                         | MONDO:0006359 | neoplasm with perivascular epithelioid cell differentiation |
| MONDO:0006103 | benign adrenal gland pheochromocytoma | MONDO:0004974 | adrenal gland pheochromocytoma                              |
| MONDO:0036781 | benign axillary neoplasm              | MONDO:0036779 | axillary neoplasm                                           |
| MONDO:0002065 | benign breast adenomyoepithelioma     | MONDO:0002066 | breast adenomyoepithelioma                                  |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/benign.tsv) 

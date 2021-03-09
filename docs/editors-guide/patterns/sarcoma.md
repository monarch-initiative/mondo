# sarcoma 

[http://purl.obolibrary.org/obo/mondo/patterns/sarcoma.yaml](http://purl.obolibrary.org/obo/mondo/patterns/sarcoma.yaml)
## Description 


Sarcomas are malignant neoplasms arising from soft tissue or bone.
This is a design pattern for classes representing sarcomas based on their location. This may be the site of origin, but it can also represent a secondary site for metastatized sarcma.
We use the generic 'disease has location' relation, which generalized over primary and secondary sites.
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
## Name 

{location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)} sarcoma

## Annotations 

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: sarcoma of {location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)}

## Definition 

A sarcoma involving a {location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)}.

## Equivalent to 

{sarcoma\([MONDO:0005089](http://purl.obolibrary.org/obo/MONDO_0005089)\)} and {disease has location\([RO:0004026](http://purl.obolibrary.org/obo/RO_0004026)\)} some {location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)}


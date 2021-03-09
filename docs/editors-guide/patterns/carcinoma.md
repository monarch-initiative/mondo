# carcinoma 

[http://purl.obolibrary.org/obo/mondo/patterns/carcinoma.yaml](http://purl.obolibrary.org/obo/mondo/patterns/carcinoma.yaml)
## Description 


Carcinomas are malignant neoplasms arising from epithelial cells.
This is a Design pattern for classes representing carcinomas based on their location. This may be the site of origin, but it can also represent a secondary site for metastatized cancer.
We use the generic 'disease has location' relation, which generalized over primary and secondary sites.
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
## Name 

{location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)} carcinoma

## Annotations 

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: carcinoma of {location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)}

## Definition 

A carcinoma involving a {location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)}.

## Equivalent to 

{carcinoma\([MONDO:0004993](http://purl.obolibrary.org/obo/MONDO_0004993)\)} and {disease has location\([RO:0004026](http://purl.obolibrary.org/obo/RO_0004026)\)} some {location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)}


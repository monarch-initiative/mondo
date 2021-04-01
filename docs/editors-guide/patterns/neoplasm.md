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


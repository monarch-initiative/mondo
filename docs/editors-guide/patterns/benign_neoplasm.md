# benign_neoplasm 

[http://purl.obolibrary.org/obo/mondo/patterns/benign_neoplasm.yaml](http://purl.obolibrary.org/obo/mondo/patterns/benign_neoplasm.yaml)
## Description 


Neoplasms are benign or malignant tissue growths resulting from uncontrolled cell proliferation cell types.
This is a design pattern for classes representing *benign* neoplasms based on their location.
See also: benign.yaml TODO: choose one over another
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
## Name 

benign {location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)} neoplasm

## Annotations 

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: {location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)} benign neoplasm

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: {location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)} benign tumor

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: benign neoplasm of {location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)}

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: benign {location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)} tumor

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: {location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)} neoplasm, benign

## Definition 

A benign neoplasm involving a {location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)}.

## Equivalent to 

{benign neoplasm\([MONDO:0005165](http://purl.obolibrary.org/obo/MONDO_0005165)\)} and {disease has location\([RO:0004026](http://purl.obolibrary.org/obo/RO_0004026)\)} some {location\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)}

## Data preview 
| defined:class                                | defined:class:label              | location                                      | location:label                             |
|:---------------------------------------------|:---------------------------------|:----------------------------------------------|:-------------------------------------------|
| MONDO:0002193 | Bartholin gland benign neoplasm  | UBERON:0000460 | major vestibular gland                     |
| MONDO:0044764 | benign choroid plexus neoplasm   | UBERON:0001886 | choroid plexus                             |
| MONDO:0002278 | benign colon neoplasm            | UBERON:0001155 | colon                                      |
| MONDO:0006105 | benign conjunctival neoplasm     | UBERON:0001811 | conjunctiva                                |
| MONDO:0000385 | benign digestive system neoplasm | UBERON:0005409 | alimentary part of gastrointestinal system |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/benign_neoplasm.tsv) 

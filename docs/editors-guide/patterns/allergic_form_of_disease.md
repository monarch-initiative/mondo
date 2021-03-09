# allergic_form_of_disease 

[http://purl.obolibrary.org/obo/mondo/patterns/allergic_form_of_disease.yaml](http://purl.obolibrary.org/obo/mondo/patterns/allergic_form_of_disease.yaml)
## Description 


An etiological pattern that extends an etiology-generic disease to an allergic form (i.e. caused by pathological type I hypersensitivity reaction). The [allergy.yaml](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/allergy.yaml) pattern is to refine an existing disease by trigger.
Examples: [allergic respiratory disease](http://purl.obolibrary.org/obo/MONDO_0000771), [atopic eczema](http://purl.obolibrary.org/obo/MONDO_0004980), [allergic otitis media](http://purl.obolibrary.org/obo/MONDO_0021202)
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

allergic {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)}

## Annotations 

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: allergic form of {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)}

## Definition 

A {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} with a basis in a pathological type I hypersensitivity reaction.

## Equivalent to 

{disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} and {disease has basis in disruption of\([RO:0004021](http://purl.obolibrary.org/obo/RO_0004021)\)} some {type I hypersensitivity\([GO:0016068](http://purl.obolibrary.org/obo/GO_0016068)\)}

## Data preview: 
| defined:class                                | defined:class:label          | disease                                      | disease:label              |
|:---------------------------------------------|:-----------------------------|:---------------------------------------------|:---------------------------|
| MONDO:0004784 | allergic asthma              | MONDO:0004979 | asthma                     |
| MONDO:0006525 | allergic contact dermatitis  | MONDO:0005480 | contact dermatitis         |
| MONDO:0005271 | allergic disease             | MONDO:0000001 | disease or disorder        |
| MONDO:0021202 | allergic otitis media        | MONDO:0005441 | otitis media (disease)     |
| MONDO:0000771 | allergic respiratory disease | MONDO:0005087 | respiratory system disease |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/allergic_form_of_disease.tsv) 

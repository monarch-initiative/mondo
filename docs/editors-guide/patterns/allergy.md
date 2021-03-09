# allergy 

[http://purl.obolibrary.org/obo/mondo/patterns/allergy.yaml](http://purl.obolibrary.org/obo/mondo/patterns/allergy.yaml)
## Description 


Allergy classified according to allergic trigger. This pattern is to refine an existing disease by trigger, the [allergic_form_of_disease.yaml](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/allergic_form_of_disease.yaml) pattern is for a generic disease.
Examples: [egg allergy](http://purl.obolibrary.org/obo/MONDO_0005741), [peach allergy](http://purl.obolibrary.org/obo/MONDO_0000785), [gluten allergy](http://purl.obolibrary.org/obo/MONDO_0000606)
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

{substance\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)} allergic disease

## Annotations 

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: allergy of {substance\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)}

## Definition 

A allergic disease involving a {substance\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)}.

## Equivalent to 

{allergic disease\([MONDO:0005271](http://purl.obolibrary.org/obo/MONDO_0005271)\)} and {realized in response to stimulus\([RO:0004028](http://purl.obolibrary.org/obo/RO_0004028)\)} some {substance\([owl:Thing](http://www.w3.org/2002/07/owl#Thing)\)}

## Data preview: 
| defined:class                                | defined:class:label     | substance                                      | substance:label   |
|:---------------------------------------------|:------------------------|:-----------------------------------------------|:------------------|
| MONDO:0000789 | Atlantic cod allergy    | NCBITaxon:8049  | Gadus morhua      |
| MONDO:0000790 | Atlantic salmon allergy | NCBITaxon:8030  | Salmo salar       |
| MONDO:0000802 | Indian prawn allergy    | NCBITaxon:29960 | Penaeus indicus   |
| MONDO:0000773 | Timothy grass allergy   | NCBITaxon:15957 | Phleum pratense   |
| MONDO:0000779 | apple allergy           | NCBITaxon:3750  | Malus domestica   |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/allergy.tsv) 

# specific_inflammatory_disease_by_site 

[http://purl.obolibrary.org/obo/mondo/patterns/specific_infectious_disease_by_agent.yaml](http://purl.obolibrary.org/obo/mondo/patterns/specific_infectious_disease_by_agent.yaml)
## Description 



as for inflammatory_disease_by_site, but refining a specific disease
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
## Name 

{[agent](http://purl.obolibrary.org/obo/NCBITaxon_1)} {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)}

## Annotations 

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: {[agent](http://purl.obolibrary.org/obo/NCBITaxon_1)} caused {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)}

## Definition 

An {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)} caused by infection with {[agent](http://purl.obolibrary.org/obo/NCBITaxon_1)}.

## Equivalent to 

{[disease](http://purl.obolibrary.org/obo/MONDO_0000001)} and {[realized in response to stimulus](http://purl.obolibrary.org/obo/RO_0004028)} some {[agent](http://purl.obolibrary.org/obo/NCBITaxon_1)}

## Data preview 
| defined:class                                | defined:class:label                     | agent                                         | agent:label          | disease                                      | disease:label      |
|:---------------------------------------------|:----------------------------------------|:----------------------------------------------|:---------------------|:---------------------------------------------|:-------------------|
| MONDO:0021747 | Acanthamoeba infectious disease         | NCBITaxon:5754 | Acanthamoeba         | MONDO:0005550 | infectious disease |
| MONDO:0006635 | Acinetobacter infectious disease        | NCBITaxon:469  | Acinetobacter        | MONDO:0005550 | infectious disease |
| MONDO:0006636 | Actinobacillus infectious disease       | NCBITaxon:713  | Actinobacillus       | MONDO:0005550 | infectious disease |
| MONDO:0006921 | Actinomycetales infectious disease      | NCBITaxon:2037 | Actinomycetales      | MONDO:0005550 | infectious disease |
| MONDO:0005117 | Aeromonas hydrophila infectious disease | NCBITaxon:644  | Aeromonas hydrophila | MONDO:0005550 | infectious disease |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/specific_infectious_disease_by_agent.tsv) 

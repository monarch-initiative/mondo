# infectious_inflammation 

[http://purl.obolibrary.org/obo/mondo/patterns/infectious_inflammation.yaml](http://purl.obolibrary.org/obo/mondo/patterns/infectious_inflammation.yaml)
## Description 



This combines the [infectious disease by agent pattern](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/infectious_disease_by_agent.yaml) and the [inflammatory disease by site](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/inflammatory_disease_by_site.yaml) pattern.

Examples: [bacterial endocarditis (disease)](http://purl.obolibrary.org/obo/MONDO_0006669), [fungal gastritis](http://purl.obolibrary.org/obo/MONDO_0002843)
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

inflammation of {[location](http://purl.obolibrary.org/obo/UBERON_0000061)} due to {[agent](http://purl.obolibrary.org/obo/NCBITaxon_1)}

## Annotations 

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): {[location](http://purl.obolibrary.org/obo/UBERON_0000061)} {[agent](http://purl.obolibrary.org/obo/NCBITaxon_1)} inflammation

## Definition 

An inflammatory disease involving a pathogenic inflammatory response in the {[location](http://purl.obolibrary.org/obo/UBERON_0000061)} caused by infection with {[agent](http://purl.obolibrary.org/obo/NCBITaxon_1)}.

## Equivalent to 

[infectious disease](http://purl.obolibrary.org/obo/MONDO_0005550) and [disease has inflammation site](http://purl.obolibrary.org/obo/RO_0004027) some {[location](http://purl.obolibrary.org/obo/UBERON_0000061)} and [realized in response to stimulus](http://purl.obolibrary.org/obo/RO_0004028) some {[agent](http://purl.obolibrary.org/obo/NCBITaxon_1)}

## Data preview 
| defined_class                                | defined_class_label              | agent                                         | agent_label   | location                                      | location_label   |
|:---------------------------------------------|:---------------------------------|:----------------------------------------------|:--------------|:----------------------------------------------|:-----------------|
| [MONDO:0006668](http://purl.obolibrary.org/obo/MONDO_0006668) | bacterial conjunctivitis         | [NCBITaxon:2](http://purl.obolibrary.org/obo/NCBITaxon_2)    | Bacteria      | [UBERON:0001811](http://purl.obolibrary.org/obo/UBERON_0001811) | conjunctiva      |
| [MONDO:0006669](http://purl.obolibrary.org/obo/MONDO_0006669) | bacterial endocarditis (disease) | [NCBITaxon:2](http://purl.obolibrary.org/obo/NCBITaxon_2)    | Bacteria      | [UBERON:0002165](http://purl.obolibrary.org/obo/UBERON_0002165) | endocardium      |
| [MONDO:0002842](http://purl.obolibrary.org/obo/MONDO_0002842) | bacterial gastritis              | [NCBITaxon:2](http://purl.obolibrary.org/obo/NCBITaxon_2)    | Bacteria      | [UBERON:0000945](http://purl.obolibrary.org/obo/UBERON_0000945) | stomach          |
| [MONDO:0016127](http://purl.obolibrary.org/obo/MONDO_0016127) | bacterial myositis               | [NCBITaxon:2](http://purl.obolibrary.org/obo/NCBITaxon_2)    | Bacteria      | [UBERON:0002385](http://purl.obolibrary.org/obo/UBERON_0002385) | muscle tissue    |
| [MONDO:0002843](http://purl.obolibrary.org/obo/MONDO_0002843) | fungal gastritis                 | [NCBITaxon:4751](http://purl.obolibrary.org/obo/NCBITaxon_4751) | Fungi         | [UBERON:0000945](http://purl.obolibrary.org/obo/UBERON_0000945) | stomach          |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/infectious_inflammation.tsv) 

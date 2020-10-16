# MONDO Design Patterns

This directory contains design pattern specifications for the construction and maintenance of MONDO. 

There are two kinds of files in this repo

 * `*.yaml` design pattern specification [DOSDP spec](https://github.com/dosumis/dead_simple_owl_design_patterns)
 * `*.csv` tsv reverse engineered from ontology following DP (uses [dosdp-tools](https://github.com/INCATools/dosdp-tools) )

The overall philosophy is to split rather than lump; so for example, we have distinct DPs for [carcinoma](https://github.com/monarch-initiative/mondo/tree/master/src/patterns/dosdp-patterns/carcinoma.yaml) and [cancer](https://github.com/monarch-initiative/mondo/tree/master/src/patterns/dosdp-patterns/cancer.yaml)

Consult each yaml for documentation.

## Reverse engineering from external ontologies based on lexical patterns

The [Makefile](Makefile) also includes target for reverse engineering OWL definitions from lexical patterns

## Patterns by type

### Genetic v acquired etiology

 * [acquired.yaml](http://purl.obolibrary.org/obo/mondo/patterns/acquired.yaml)
 * [genetic.yaml](http://purl.obolibrary.org/obo/mondo/patterns/genetic.yaml)
 * [hereditary.yaml](http://purl.obolibrary.org/obo/mondo/patterns/hereditary.yaml)
 * [x_linked.yaml](http://purl.obolibrary.org/obo/mondo/patterns/x_linked.yaml)
 * [y_linked.yaml](http://purl.obolibrary.org/obo/mondo/patterns/y_linked.yaml)
 * [autosomal_dominant.yaml](http://purl.obolibrary.org/obo/mondo/patterns/autosomal_dominant.yaml)
 * [autosomal_recessive.yaml](http://purl.obolibrary.org/obo/mondo/patterns/autosomal_recessive.yaml)
 * [congenital.yaml](http://purl.obolibrary.org/obo/mondo/patterns/congenital.yaml)

## Chronic v acute

 * [acute.yaml](http://purl.obolibrary.org/obo/mondo/patterns/acute.yaml)
 * [chronic.yaml](http://purl.obolibrary.org/obo/mondo/patterns/chronic.yaml)

## Cancer

 * [benign.yaml](http://purl.obolibrary.org/obo/mondo/patterns/benign.yaml)
 * [benign_neoplasm.yaml](http://purl.obolibrary.org/obo/mondo/patterns/benign_neoplasm.yaml)
 * [cancer.yaml](http://purl.obolibrary.org/obo/mondo/patterns/cancer.yaml)
 * [carcinoma.yaml](http://purl.obolibrary.org/obo/mondo/patterns/carcinoma.yaml)
 * [carcinoma_in_situ.yaml](http://purl.obolibrary.org/obo/mondo/patterns/carcinoma_in_situ.yaml)
 * [malignant.yaml](http://purl.obolibrary.org/obo/mondo/patterns/malignant.yaml)
 * [neoplasm.yaml](http://purl.obolibrary.org/obo/mondo/patterns/neoplasm.yaml)
 * [neoplasm_by_origin.yaml](http://purl.obolibrary.org/obo/mondo/patterns/neoplasm_by_origin.yaml)
 * [sarcoma.yaml](http://purl.obolibrary.org/obo/mondo/patterns/sarcoma.yaml)

## Allergy, inflammation and infection

 * [allergic_form_of_disease.yaml](http://purl.obolibrary.org/obo/mondo/patterns/allergic_form_of_disease.yaml)
 * [allergy.yaml](http://purl.obolibrary.org/obo/mondo/patterns/allergy.yaml)
 * [autoimmune_inflammation.yaml](http://purl.obolibrary.org/obo/mondo/patterns/autoimmune_inflammation.yaml)
 * [infectious_disease_by_agent.yaml](http://purl.obolibrary.org/obo/mondo/patterns/infectious_disease_by_agent.yaml)
 * [inflammatory_disease_by_site.yaml](http://purl.obolibrary.org/obo/mondo/patterns/inflammatory_disease_by_site.yaml)

## Anatomy

 * [disease_by_dysfunctional_structure.yaml](http://purl.obolibrary.org/obo/mondo/patterns/disease_by_dysfunctional_structure.yaml)
 * [location.yaml](http://purl.obolibrary.org/obo/mondo/patterns/location.yaml)
 * [location_top.yaml](http://purl.obolibrary.org/obo/mondo/patterns/location_top.yaml)

## Mechanistic etiology

 * [inborn_metabolic.yaml](http://purl.obolibrary.org/obo/mondo/patterns/inborn_metabolic.yaml)
 * [basis_in_disruption_of_process.yaml](http://purl.obolibrary.org/obo/mondo/patterns/basis_in_disruption_of_process.yaml)

## Orphanet-specific

 * [rare.yaml](http://purl.obolibrary.org/obo/mondo/patterns/rare.yaml)
 * [rare_genetic.yaml](http://purl.obolibrary.org/obo/mondo/patterns/rare_genetic.yaml)

## Isolated vs syndromic

 * [isolated.yaml](http://purl.obolibrary.org/obo/mondo/patterns/isolated.yaml)
 * [syndromic.yaml](http://purl.obolibrary.org/obo/mondo/patterns/syndromic.yaml)

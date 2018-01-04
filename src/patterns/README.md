# MONDO Design Patterns

This directory contains design pattern specifications for the construction and maintenance of MONDO. 

There are two kinds of files in this repo

 * `*.yaml` design pattern specification [DOSDP spec](https://github.com/dosumis/dead_simple_owl_design_patterns)
 * `*.csv` tsv reverse engineered from ontology following DP (uses [dosdp-tools](https://github.com/INCATools/dosdp-tools) )

The overall philosophy is to split rather than lump; so for example, we have distinct DPs for [carcinoma](carcinoma.yaml) and [cancer](cancer.yaml)

Consult each yaml for documentation.

## Reverse engineering from external ontologies based on lexical patterns

The [Makefile](Makefile) also includes target for reverse engineering OWL definitions from lexical patterns

## Patterns by type

### Genetic v acquired etiology

 * [acquired.yaml](acquired.yaml)
 * [genetic.yaml](genetic.yaml)
 * [hereditary.yaml](hereditary.yaml)
 * [x_linked.yaml](x_linked.yaml)
 * [y_linked.yaml](y_linked.yaml)
 * [autosomal_dominant.yaml](autosomal_dominant.yaml)
 * [autosomal_recessive.yaml](autosomal_recessive.yaml)
 * [congenital.yaml](congenital.yaml)

## Chronic v acute

 * [acute.yaml](acute.yaml)
 * [chronic.yaml](chronic.yaml)

## Cancer

 * [benign.yaml](benign.yaml)
 * [benign_neoplasm.yaml](benign_neoplasm.yaml)
 * [cancer.yaml](cancer.yaml)
 * [carcinoma.yaml](carcinoma.yaml)
 * [carcinoma_in_situ.yaml](carcinoma_in_situ.yaml)
 * [malignant.yaml](malignant.yaml)
 * [neoplasm.yaml](neoplasm.yaml)
 * [neoplasm_by_origin.yaml](neoplasm_by_origin.yaml)
 * [sarcoma.yaml](sarcoma.yaml)

## Allergy, inflammation and infection

 * [allergic_form_of_disease.yaml](allergic_form_of_disease.yaml)
 * [allergy.yaml](allergy.yaml)
 * [autoimmune_inflammation.yaml](autoimmune_inflammation.yaml)
 * [infectious_disease_by_agent.yaml](infectious_disease_by_agent.yaml)
 * [inflammatory_disease_by_site.yaml](inflammatory_disease_by_site.yaml)

## Anatomy

 * [disease_by_dysfunctional_structure.yaml](disease_by_dysfunctional_structure.yaml)
 * [location.yaml](location.yaml)
 * [location_top.yaml](location_top.yaml)

## Mechanistic etiology

 * [inborn_metabolic.yaml](inborn_metabolic.yaml)
 * [basis_in_disruption_of_process.yaml](basis_in_disruption_of_process.yaml)

## Orphanet-specific

 * [rare.yaml](rare.yaml)
 * [rare_genetic.yaml](rare_genetic.yaml)

## Isolated vs syndromic

 * [isolated.yaml](isolated.yaml)
 * [syndromic.yaml](syndromic.yaml)

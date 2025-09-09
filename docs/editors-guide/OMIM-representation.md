# Representation of OMIM terms in Mondo

_Last update September 9th, 2025_

This document summarizes how OMIM terms are integrated into Mondo. This document includes: 

- OMIM terms included in Mondo
- Representation of OMIM Phenotypic Series
- Representation of OMIM “included” entries
- Representation of OMIM “susceptibility” entries
- Classification of OMIM terms in Mondo
- OMIM-related (semi-)automated alignment
   - addition of new OMIM terms in Mondo
   - gene-disease association
   - OMIM synonyms

It should be noted that while this document summarizes the most recent workflows and decisions regarding the representation of OMIM terms in Mondo, these practices have evolved over time. As a result, revisions to the representation of OMIM terms are still in progress, and some instances may not yet fully align with the approach described here. We encourage community members and users to report any errors or inconsistencies they encounter, as such feedback helps to accelerate the refinement process.

## OMIM terms included in Mondo
All OMIM entries representing disease concepts are represented in Mondo, that is all OMIM entries except the one reported below. The following terms might be removed (ie, obsoleted) or excluded from Mondo after curator review, often based on community feedback and report:
-  OMIM entries representing genes/loci (MONDO:excludeGene). These OMIM entry types are excluded from the alignment workflow based on metadata in the OMIM files.
- OMIM entries representing a phenotype (MONDO:excludePhenotype; MONDO:excludeNonDisease). _For example: 'anosmia for butyl mercaptan' - MONDO:0010034 (obsolete) - OMIM:270350_
- OMIM entries representing a trait (MONDO:excludeTrait ; MONDO:excludeNonDisease). _For example: ‘blood group, mn’ - OMIM:111300_
- OMIM entries representing “historical” diseases (MONDO:excludeHistoricalDisease), i.e., terms that were entered in OMIM more than 20 years ago, were limited to one or two families, and have not been reported in any other patients/families since the creation of this entry. _For examples: 'apnea, central sleep' - MONDO:0008807 (obsolete) - OMIM:107640 ; 'pachyonychia congenita, autosomal recessive' - MONDO:0009827 (obsolete) - OMIM:260130_

## Representation of OMIM Phenotypic Series

[OMIM Phenotypic Series](https://www.omim.org/phenotypicSeriesTitles/) (OMIMPS) group diseases that are clinically similar. In Mondo, these OMIMPS entries are represented as “grouping term” (or parent term). Diseases included in OMIMPS are represented in Mondo as subclasses of the Mondo term representing the OMIMPS, with the OMIM ID of disease term as a source evidence for these subclasses. 

![alt text](<Screenshot 2025-09-08 at 6.30.05 PM.png>)

It is important to note that, since these phenotypic series are created by grouping clinically similar diseases, we have occasionally found that, some of these subclasses are not ontologically correct. For example, some OMIMPS include both diseases and susceptibility to diseases (examples: [OMIMPS:162091](https://www.omim.org/phenotypicSeries/PS162091), [OMIMPS194070](https://www.omim.org/phenotypicSeries/PS194070)). Such “ontologically incorrect” subclasses are manually reviewed and removed (see [“Excluded subclassOf” documentation](https://mondo.readthedocs.io/en/latest/editors-guide/g-logical-axioms/#excluded-subclassof)). 

## Representation of OMIM “included” entries

OMIM entries sometimes include a section for “Other entities represented in this entry:”, with disease names ending with “, included”. We call these “OMIM included entries”. 
These “OMIM included entries” represent disease concepts that are different from the main OMIM entry, but for which a lack of information prevented the creation of their own OMIM entries. 

![alt text](<Screenshot 2025-09-08 at 6.01.33 PM.png>)

In Mondo, we consider these “OMIM included” entries as separate diseases and therefore represent them by creating specific Mondo entries. Their database cross-reference refers to the main OMIM entries, with the source annotation  “MONDO:includedEntryInOMIM”. (see also OMIM included entries documentation [here](https://mondo.readthedocs.io/en/latest/editors-guide/omim-included-entries/))

Notes: 
- There is currently no automated process to create Mondo terms to represent “OMIM included entries”. All the “MONDO:includedEntryInOMIM” currently available in Mondo have been created manually based mostly on user requests and feedback. 
- Currently, “OMIM included entries” are not automatically included as synonyms in Mondo. We, however, acknowledge that some can still be found in Mondo as “related synonyms”, due to erroneous previous work still to be reviewed and updated.


## Representation of OMIM “susceptibility” entries
Susceptibility terms represented in Mondo conform to the [“inherited_susceptibility design pattern”](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/inherited_susceptibility.yaml), and are, unless reported otherwise by experts (e.g. cancer predispositions and some immunological diseases), classified in the “disease susceptibility” (MONDO:0042489) branch of Mondo. 


## Classification of OMIM terms in Mondo
The classification of OMIM terms in Mondo is made mostly manually, based on curator review and input from the community. 
When they are part of a phenotypic series, OMIM terms are classified as subclasses on their corresponding OMIMPS via an automated process.

## OMIM-related (semi-)automated alignment

### Addition of new OMIM terms in Mondo

Alignment with OMIM, i.e. ensuring that all OMIM terms representing diseases are represented in Mondo, occurs via a semi-automated process described [here](https://docs.google.com/document/d/1bpn_aDhd3OQG40T0ks9itS3bG9x6qFAVva5O6lVah2U/edit?tab=t.0#heading=h.jmd7l1nkdnbi)

### Gene-disease association

OMIM is our main source for gene-disease associations. 
The automated process describing the gene-disease association update is [here](https://github.com/monarch-initiative/omim/blob/main/README.md). In short, gene-disease associations are added automatically when a single gene is associated with a disease as reported in the OMIM file (see [here](https://github.com/monarch-initiative/omim/blob/main/README.md) for more details). The reference to the OMIM entry is given as provenance for this annotation.
Any OMIM gene-disease association that do not follow this rule (e.g. 2 genes being associated to a “digenic” disease) are either not added, or are removed through this automated workflow. In this case, manual review and curation is required to either add or maintain gene-disease associations deemed correct, with the OMIM source. 

### OMIM synonyms

Terms reported as “Alternative titles; symbols” in OMIM are automatically added as ‘exact synonyms’ in Mondo, with the OMIM ID as a cross reference, through an automatic workflow (synonym sync process explained [here](https://docs.google.com/document/d/1YK4_yOL_agrPfMJKLaj11omK7reVk3yE_sozvzL7Vt8/edit?tab=t.0#heading=h.jmd7l1nkdnbi)). 
In some cases, manual review can lead to a change in the synonym scope. In this case, the curated synonym scope is maintained. 

It should be noted that some “OMIM included entries” (see “Representation of OMIM “included” entries” section) might be included as “related synonyms” on Mondo terms. As explained in the section above, these synonyms were erroneously created, and their removal is part of an ongoing revision.



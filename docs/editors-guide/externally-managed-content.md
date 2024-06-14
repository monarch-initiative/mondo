## Externally managed content

- [Overview](#overview)
- [Synchronisation system](#sync)
- [List of external content providers](#providers)

### Overview

In 2024, we have begun outsourcing a few select dataypes to trusted external providers.
We collaborate with these providers as follows:

1. We agree on the content provided.
1. The external provider provides the content in a table format that we can easily integrate (for example a ROBOT template TSV)
1. We synchronize that content together with all other external content as part of the [Mondo Ingest pipeline](https://github.com/monarch-initiative/mondo-ingest)
1. We periodically integrate the content into the Mondo ontology
   **Note**: The content is integrated into Mondo without a detailed curation review.

<a id="sync"></a>

### Synchronisation system

<a id="providers"></a>

### List of external content providers

**Providers**:

- [ClinGen](#clingen)
- [MedGen](#medgen)
- [NORD](#nord)
- [GARD](#gard)
- [Orphanet](#orphanet)
- [Open Targets](#otar)
- [Nando](#nando)

<a id="clingen"></a>

#### Clinical Genome Resource (ClinGen)

- ClinGen linkouts
- ClinGen preferred names
- ClinGen subset (terms used by ClinGen)

<a id="medgen"></a>

#### NCBI's Medical Genetics Portal (MedGen)

MedGen is NCBI's portal to information about conditions and phenotypes related to Medical Genetics.

- [Website](https://www.ncbi.nlm.nih.gov/medgen/)
- Externally managed content:
    - Mondo -  Medgen mappings
    - Mondo - UMLS mappings
    - Mondo - MESH mappings (currently on hold)

<a id="nord"></a>

#### National Organization for Rare Disorders (NORD)

- NORD rare subset (Mondo IDs deemed "rare" by NORD)
- NORD preferred names (report names)
- NORD cross-references

<a id="gard"></a>

#### Genetic and Rare Diseases (GARD) Information Center

- GARD rare subset
- GARD cross-references

<a id="orphanet"></a>

#### Orphanet

- Subsets for `disorder`, `group of disorders`, `subtype of a disorder`.
- Rare subset (based on `disorder` subset above)

<a id="otar"></a>

#### Open Targets (OTAR)

- Mondo - EFO mappings (managed by EBI)
- Open Targets subset (terms used by Open Targets)

<a id="nando"></a>

#### NANDO

- Mondo - Nando mappings (managed by DBCLS)
- Nando rare subset

#### OMIM

- Mondo - OMIM phenotype associations
- 


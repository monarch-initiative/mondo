---
---
## Download Mondo:

**Download**: https://github.com/monarch-initiative/mondo  
**Format**: OWL, OBO and json formats  
**License**: CC BY 4.0  

## Products:

Stable release versions 

File | Link | Description
--- | --- | ---
Main OWL edition | [mondo.owl](https://purl.obolibrary.org/obo/mondo.owl)| Complete ontology, plus inter-ontology equivalence axioms. Uses Mondo IDs.
International edition | [mondo-international.owl](https://purl.obolibrary.org/obo/mondo/mondo-international.owl)| Like the Main OWL version, but with language translations, see [below](#international) .
Rare Disease subset | [mondo-rare.owl](https://purl.obolibrary.org/obo/mondo/subsets/mondo-rare.owl)| A subset of mondo.owl including only rare diseases, see [below](#rare).
obo-format edition | [mondo.obo](https://purl.obolibrary.org/obo/mondo.obo) | As OWL, but omits equivalence axioms. xrefs can be used as proxy for equivalence. Uses Mondo IDs.
json edition | [mondo.json](https://purl.obolibrary.org/obo/mondo.json) | Equivalent to the OWL edition.
 
<a id="international"></a>

## International Edition

The Mondo international edition was created in 2025 to accomodate for the first community-curated language translation, Japanese.

The [Japanese language translation](https://github.com/dbcls/mondo-japanese) is led by
Toyofumi Fujiwara and Terue Takatsuki for the [Database Center for Life Science](https://dbcls.rois.ac.jp/index-en.html) (DBCLS).

<a id="rare"></a>

## Rare Disease Subset

The [Mondo Rare Disease](rare-disease.md) subset comprises all human Rare Diseases as designated by a Rare Disease authoritiative resource.

Rare disease authorities include:

| Rare disease authority | Link | Annotation in Mondo |
| --- | --- | --- |
| GARD | [https://rarediseases.info.nih.gov/](https://rarediseases.info.nih.gov/) | gard_rare |
| NORD | [https://rarediseases.org/](https://rarediseases.org/) | nord_rare |
| Orphanet | [https://www.orpha.net/](https://www.orpha.net/) | orphanet_rare |

Find out more [here](rare-disease.md).

## View Mondo

- **Ontology Lookup Service**: [https://www.ebi.ac.uk/ols4/ontologies/mondo](https://www.ebi.ac.uk/ols4/ontologies/mondo). _Note: OLS is uploaded approximately one week after the Mondo release._
- **Monarch Initiative**: [https://monarchinitiative.org/disease/MONDO:0000001](https://monarchinitiative.org/disease/MONDO:0000001) _Note: Monarch does not always have the latest Mondo release. We recommend searching in OLS for the latest changes._
- **AberOWL**: [http://aber-owl.net/ontology/MONDO/#/](http://aber-owl.net/ontology/MONDO/#/)
- **BioPortal**: [https://bioportal.bioontology.org/ontologies/MONDO](https://bioportal.bioontology.org/ontologies/MONDO)
- **OBO Foundry**: [http://obofoundry.org/ontology/mondo.html](http://obofoundry.org/ontology/mondo.html)
- **Ontobee**: [http://www.ontobee.org/ontology/MONDO](http://www.ontobee.org/ontology/MONDO)


## Documentation
- The Mondo Editor's Guide: [https://mondo.readthedocs.io/en/latest/](https://mondo.readthedocs.io/en/latest/)
- The Mondo Ingest Guide: [https://monarch-initiative.github.io/mondo-ingest/](https://monarch-initiative.github.io/mondo-ingest/)


## Report issues/bugs/new term requests, changes, etc.

[https://github.com/monarch-initiative/mondo](https://github.com/monarch-initiative/mondo)


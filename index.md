---
layout: splash
author_profile: true
#title: Mondo Home page
---
{% comment %} This is a comment {% endcomment %}

# Mondo Disease Ontology

The Mondo Disease Ontology (Mondo) aims to harmonize disease definitions across the world. The name Mondo comes from the latin word 'mundus' and means 'for the world.'

- [About](#about)
- [How was it created?](#created)
- [Contribute](#contribute)
- [License](#license)
- [Contact](#contact)

<a name="about"></a> 
## About  

Numerous sources for disease definitions and data models currently exist, which include [HPO](https://hpo.jax.org/app/), [OMIM](https://omim.org/), [SNOMED CT](http://www.snomed.org/), [ICD](https://www.cdc.gov/nchs/icd/icd10cm.htm), [PhenoDB](https://phenodb.org/), [MedDRA](https://www.meddra.org/), [MedGen](https://www.ncbi.nlm.nih.gov/medgen/), [ORDO](https://www.orpha.net/consor/cgi-bin/index.php?lng=EN), [DO](http://disease-ontology.org/), [GARD](https://rarediseases.info.nih.gov/), etc; however, these sources partially overlap and sometimes conflict, making it difficult to know definitively how they relate to each other. This has resulted in a proliferation of mappings between disease entries in different resources; however mappings are problematic: collectively, they are expensive to create and maintain. Most importantly, the mappings lack completeness, accuracy, and precision; as a result, mapping calls are often inconsistent between resources. The UMLS provides intermediate concepts through which other resources can be mapped, but these mappings suffer from the same challenges: they are not guaranteed to be one-to-one, especially in areas with evolving disease concepts such as rare disease.

In order to address the lack of a unified disease terminology that provides precise equivalences between disease concepts, we created Mondo, which provides a logic-based structure for unifying multiple disease resources.

Mondo’s development is coordinated with the [Human Phenotype Ontology (HPO)](https://hpo.jax.org/app/), which describes the individual phenotypic features that constitute a disease. Like the HPO, Mondo provides a hierarchical structure which can be used for classification or “rolling up” diseases to higher level groupings. It provides mappings to other disease resources, but in contrast to other mappings between ontologies, we precisely annotate each mapping using strict semantics, so that we know when two disease names or identifiers are equivalent or one-to-one, in contrast to simply being closely related.

For more details, please see these [slides](https://docs.google.com/presentation/d/1piBa680WN4EmI2q5oGpXGeuurZNkP66E4iOSJtEM1Ro/edit#slide=id.p1).

<a name="created"></a> 
## How was it created?    

Mondo is a semi-automatically constructed ontology that merges in multiple disease resources to yield a coherent merged ontology. See sources [here](https://mondo.monarchinitiative.org/pages/sources/). Original versions of Mondo were constructed entirely automatically and used the IDs of source databases and ontologies. Later, additional manually curated cross-ontology axioms were added, and a native Mondo ID system was used to avoid confusion with source databases.

One feature of Mondo is that it goes beyond loose xrefs. It curated precise 1:1 equivalence axioms connecting to other resources, validated by OWL reasoning. This means it is safe to propagate across these from OMIM, Orphanet, EFO, DOID (soon NCIT).

**These precise mappings are available as stable release versions in three formats:**  

- the **[mondo-with-equivalent](http://purl.obolibrary.org/obo/mondo/mondo-with-equivalents.owl)** edition uses OWL equivalence axioms directly in the ontology. Note this makes it harder to browse in some portals, but this edition may be preferable for computational use. The owl edition also includes axiomatization using CL, Uberon, GO, HP, RO, NCBITaxon.
- the **[.obo version](http://purl.obolibrary.org/obo/mondo.obo)** is simpler, lacks inter-ontology axiomatization, and lacks equivalence axioms to other databases; instead xrefs are used as the linking mechanism. If the ID is one of Orphanet, OMIM, DOID or EFO then the xref precisely shadows the equivalence axiom.
- the **[json edition](http://purl.obolibrary.org/obo/mondo/mondo-with-equivalents.json)** is equivalent to the OWL edition.

The **Mondo GitHub repository** is available here: [https://github.com/monarch-initiative/mondo](https://github.com/monarch-initiative/mondo).

<a name="contribute"></a> 
# Contribute

The best way to contribute is by addressing tickets or reporting issues on the [GitHub tracker](https://github.com/monarch-initiative/mondo/issues). See more info on our [contributors page](https://monarch-initiative.github.io/mondo/pages/contributors/) and the [editors page](https://mondo.monarchinitiative.org/pages/editors/).

<a name="license"></a> 
# License

[CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/)

<a name="contact"></a> 
# Contact

If you're interested in receiving email updates about releases, please contact [monarchinitiative@gmail.com.](mailto:monarchinitiative@gmail.com)

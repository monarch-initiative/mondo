---
---
# FAQs

### How often is Mondo released?

Mondo is released around the first of each month. See the latest release [here](https://github.com/monarch-initiative/mondo/releases).

### Am I allowed to change the content in Mondo?

Mondo is a community-driven project and we welcome your feedback and suggested changes. We request that all proposed changed be suggested on [GitHub issue tracker](https://github.com/monarch-initiative/mondo), so they can be seen and discussed by the Mondo community. Note, you will need sign up for a free GitHub account, if you do not already have one.

### How can I collaborate with Mondo?

We welcome the participation of interested colleagues. We anticipate that the structure of Mondo will continue to be refined and completed for some time to come. Groups or persons with expert knowledge in a particular domain of disease(s) are invited to contribute their knowledge on a collaborative basis. See issues that need input from medical experts [here](https://github.com/monarch-initiative/mondo/labels/medical%20input%20needed). Please contact us to discuss details.

Join the Mondo users group [here](https://groups.google.com/forum/#!forum/mondo-users). {% comment %} add more content here, see HPO:  {% endcomment %}

### How is Mondo related to the Monarch Initiative?

Mondo is the disease ontology for the [Monarch Initiative](https://monarchinitiative.org/), which is an NIH supported project that integrates, aligns, and re-distributes cross-species gene, genotype, variant, disease, and phenotype data. The [Monarch Browser](https://monarchinitiative.org/) allows users to browse not only human diseases but to see their links to other organisms, genes, phenotypes, and pathways, which may be of special interest to translational researchers.

### How is the Human Phenotype Ontology (HPO) related to Mondo?

Mondo is co-developed with [HPO](https://hpo.jax.org/app/), to ensure interoperability and alignment between the two ontologies and create a more holistic semantic disease resource. A subset of HPO classes are imported into Mondo. HPO terms are used in the logical definitions for the disease terms, where applicable. For example, [MONDO:0003337 'acute hemorrhagic encephalitis'](http://purl.obolibrary.org/obo/MONDO_0003337) is computationally defined as `encephalitis and ('disease has feature' some 'Abnormal bleeding')` ([Abnormal bleeding is an HPO term, HP:0001892](https://hpo.jax.org/app/browse/term/HP:0001892)).

### How do I cite Mondo?

Please cite: Mungall, Christopher J., et al. 2017 [The Monarch Initiative: An Integrative Data and Analytic Platform Connecting Phenotypes to Genotypes across Species.](https://academic.oup.com/nar/article/45/D1/D712/2605791) Nucleic Acids Research 45 (D1): D712–22.

### Why do we need Mondo?

Please see our [blog post](https://medium.com/@MonarchInit/new-release-of-mondo-disease-ontology-9a48521353e3) that describes why we created Mondo.

### Does the definition of 'equivalent-class' mapping require that the MONDO/Other relationship is strictly 1:1?

The semantics of owl equivalentClass are such that all concepts are strictly identical in meaning. This always translates to a 1:1 mapping, except when we do a 'proxy merge' - we decide that two concepts in an external resource mean the same thing. This is rare, and the numbers usually come down as we work with the upstream to resolve this. See [ticket](https://github.com/monarch-initiative/mondo/issues/936).

{% comment %} ### What is an ontology? {% endcomment %}

{% comment %} Review this page and add some more FAQs {% endcomment %}

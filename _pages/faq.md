---
---
# FAQs

### What is an ontology?
An ontology is a formal, computational representation of knowledge in a particular domain or area of knowledge, such as diseases or anatomy. Terms are arranged in a hierarchy, and the terms and relationships between them are defined using both human readable and machine readable definitions, allowing logical inference and sophisticated queries. They are expressed in a knowledge representation language like RDF or OWL.

### I want to request a new term or request a change to Mondo, how do I do so?
All requests should go on our [GitHub issue tracker](https://github.com/monarch-initiative/mondo/issues). You will need to create a free [GitHub](https://github.com/) account if you do not already have one.

### What kind of information should I include when I create a ticket on the GitHub tracker?
We have [guidelines](https://mondo.readthedocs.io/en/latest/editors-guide/c-make-good-term-request/) on how to make a good term request. Also note, when you click [New Issue](https://github.com/monarch-initiative/mondo/issues/new/choose) on our issue tracker, it will give you options to chose a pre-formatted template that will suggest the type of information to include on a ticket. If none of the templates fit your issue, you can [open a blank issue](https://github.com/monarch-initiative/mondo/issues/new).

### How often is Mondo released?

Mondo is released around the first of each month. See the latest release [here](https://github.com/monarch-initiative/mondo/releases).

### When will I see the latest release of Mondo in [OLS](https://www.ebi.ac.uk/ols4)?

A new release can be expected in [OLS](https://www.ebi.ac.uk/ols4/ontologies/mondo) within 7 business days usually.  

### Am I allowed to change the content in Mondo?

Mondo is a community-driven project and we welcome your feedback and suggested changes. We request that all proposed changed be suggested on [GitHub issue tracker](https://github.com/monarch-initiative/mondo), so they can be seen and discussed by the Mondo community. Note, you will need sign up for a free GitHub account, if you do not already have one.

### Why and how are terms obsoleted from Mondo?

#### Why are terms obsoleted
Terms in Mondo may be obsoleted when they are no longer needed, considered out of scope, if they are duplicates, or if they have been obsoleted in a source ontology and merged with another term. Mondo terms are never deleted, instead are obsoleted, so that any MONDO ID ever created remains in the ontology. 

To ensure minimal disruption to curation and annotations using Mondo terms, if a term is to be considered for obsoletion in Mondo, we inform users before obsoletion. Our workflow entails 1) adding an ‘obsoletion candidate’ subset tag in Mondo ontology file, 2) including a link to the GitHub ticket that describes the reason for obsoletion (and is a place for community comments), 3) add the date for proposed obsoletion (for example, 2022–01–01), and 4) a comment that indicates the reason and terms to be considered for replacement or an actual replacement term (in the case of a merge). We provide an obsoletion report (for example, see the November report [here](https://github.com/monarch-initiative/mondo/releases/download/v2021-11-01/mondo_obsoletioncandidates.tsv)) with each release and will wait at least two months before obsoleting any class, to allow our users time to update their annotations or make comments (or request the term be kept instead).

Further description and a discussion board on obsoletions is available [here](https://github.com/monarch-initiative/mondo/discussions/2765). Anyone with a GitHub account can contribute to the discussion.

#### How are terms obsoleted?
Our workflow for obsoleting terms is evolving to meet the needs of our users. When a term is to be obsoleted (or merged), the term will be annotated with a subset tag `obsoletion candidate`, and will include an annotation with a link to a relevant GitHub ticket and a comment describing the obsoletion reason. The Mondo curation team will send a report around the first of each month, along with the latest release to inform users of potential obsoletions. Users will have at least 2 months* to review the obsoletion candidates. If there are no objections from the community, the curation team will obsolete the term.

*There is an exception, if a term is not a disease, like a gene, it may be obsoleted sooner. See this [ticket](https://github.com/monarch-initiative/mondo/issues/6337) for an example.

### How can I collaborate with Mondo?

We welcome the participation of interested colleagues. We anticipate that the structure of Mondo will continue to be refined and completed for some time to come. Groups or persons with expert knowledge in a particular domain of disease(s) are invited to contribute their knowledge on a collaborative basis. See issues that need input from medical experts [here](https://github.com/monarch-initiative/mondo/labels/medical%20input%20needed). Please contact us to discuss details.

Join the Mondo users group [here](https://groups.google.com/forum/#!forum/mondo-users). {% comment %} add more content here, see HPO:  {% endcomment %}

### How is Mondo related to the Monarch Initiative?

Mondo is the disease ontology for the [Monarch Initiative](https://monarchinitiative.org/), which is an NIH supported project that integrates, aligns, and re-distributes cross-species gene, genotype, variant, disease, and phenotype data. The [Monarch Browser](https://monarchinitiative.org/) allows users to browse not only human diseases but to see their links to other organisms, genes, phenotypes, and pathways, which may be of special interest to translational researchers.

### Is the latest version of Mondo displayed in the Monarch Initiative website?

The latest release of Mondo is not always displayed in the Monarch website, as the release cycles are not in sync. To see the latest version of Mondo online, we recommend using the [Ontology Lookup Service (OLS)](https://www.ebi.ac.uk/ols4/ontologies/mondo).

### How is the Human Phenotype Ontology (HPO) related to Mondo?

Mondo is co-developed with [HPO](https://hpo.jax.org/app/), to ensure interoperability and alignment between the two ontologies and create a more holistic semantic disease resource. A subset of HPO classes are imported into Mondo. HPO terms are used in the logical definitions for the disease terms, where applicable. For example, [MONDO:0003337 'acute hemorrhagic encephalitis'](http://purl.obolibrary.org/obo/MONDO_0003337) is computationally defined as `encephalitis and ('disease has feature' some 'Abnormal bleeding')` ([Abnormal bleeding is an HPO term, HP:0001892](https://hpo.jax.org/app/browse/term/HP:0001892)).

### What is the difference between a disease and a phenotype?

There is a lot of overlap between diseases and phenotypes. Mondo and Human Phenotype Ontology (HPO) define a disease as an entity that has all four of the following features:

- an etiology (whether identified or as yet unknown)
- a time course
- a set of phenotypic features
- if treatments exist, there is a characteristic response to them

A phenotype (or a phenotypic feature) is a component of a disease, and HPO terms can be used to describe the set of phenotypic features that characterize a disease. There is a grey zone between diseases and phenotypic features. For instance, diabetes mellitus can be conceptualized as a disease, but it is also a feature of other diseases such as Bardet Biedl syndrome. In some cases like this, Mondo may label the disease entity with (disease) after the disease name, to distinguish it from the HPO phenotype term (for example, [MONDO:0005466 'hypersomnia (disease)'](http://www.ontobee.org/ontology/MONDO?iri=http://purl.obolibrary.org/obo/MONDO_0005466) and [HP:0100786 Hypersomnia](https://hpo.jax.org/app/browse/term/HP:0100786)).

### What are disease naming conventions in Mondo?
Please refer to our page on [disease naming](https://mondo.monarchinitiative.org/pages/disease-naming/).

### How can we know what’s in OMIM/NCIt/Orphanet/Disease Ontology that’s not in Mondo or what’s in Mondo that is not in OMIM/NCIt/Orphanet/Disease Ontology? Is there an easy way to know this?

Mondo IDs are mapped to OMIM, NCIt, Orphanet and DOIDs, so this can be used to compare coverage.

### Since there are several source ontologies, how does Mondo manage the mappings? Is there a resource that contains all of the mappings?

We use semi-automated process to map the sources, but these are always manually evaluated by a curator. The mappings are distributed with the ontology (see [releases](https://github.com/monarch-initiative/mondo/releases) and we will soon be releasing these using a new format called [A Simple Standard for Sharing Ontology Mappings, SSSOM](https://github.com/OBOFoundry/SSSOM).

### How do Mondo and Disease Ontology (DO) differ in terms of their classifications of cancer?

Mondo and DO have slightly different approaches to classifying cancer; Mondo’s approach is based on NCIT’s, and Mondo is more closely aligned with NCIT when it comes to cancer.

### How do I cite Mondo?

Please cite: Nicole A Vasilevsky, et al. (2022) [Mondo: Unifying diseases for the world, by the world](https://www.medrxiv.org/content/10.1101/2022.04.13.22273750v3) medRxiv 2022.04.13.22273750; doi: https://doi.org/10.1101/2022.04.13.22273750

### Why do we need Mondo?

Please see our [blog post](https://medium.com/@MonarchInit/new-release-of-mondo-disease-ontology-9a48521353e3) that describes why we created Mondo.

### Does the definition of 'equivalent-class' mapping require that the Mondo/Other relationship is strictly 1:1?

The semantics of owl equivalentClass are such that all concepts are strictly identical in meaning. This always translates to a 1:1 mapping, except when we do a 'proxy merge' - we decide that two concepts in an external resource mean the same thing. This is not very common, and the numbers usually come down as we work with the source ontologies to resolve this. See [ticket](https://github.com/monarch-initiative/mondo/issues/936).

### What is the difference between MONDO:equivalentTo and skos:exactMatch?

MONDO:equivalentTo and skos:exactMatch conceptually overlap but they have entirely different semantics. Mondo:equivalentTo is much stronger than skos:exactMatch. Mondo uses skos:exactMatch to bridge semantic spaces which conceptually overlap, but are not (necessarily) logically coherent according to OWL semantics. For example, Mondo defines X (an example here of a disease) which is an exact match to Y (add mapped MeSH term) in MeSH, which is not an OWL ontology - trying to apply an equivalent relation with OWL semantics would not make much sense.

Moreover, merging Mondo with another disease ontology, even if both are maintained in OWL, is not guaranteed to produce a coherent result, i.e one that contains no logical errors. This is a very fundamental feature of Mondo: integrating various disease classification to create a harmonised classification. This harmonised classification may, by design, partially disagree with any particular source. Therefore, applying strong OWL semantics with owl:equivalentClass is, usually, inappropriate.

### What are the different types of synonyms in Mondo?

- **Exact synonym**: an alternative term that has the same meaning.  
  Example:   
  name: hereditary Wilms' tumor  
  exact synonym: familial Wilms’ tumor  
- **Narrow synonym**: a more specific term.  
Example:  
name: asthma  
narrow synonym: exercise-induced asthma  
- **Broad synonym**: a more general term.  
Example:  
name: autoimmune hepatitis  
broad synonym: autoimmune liver disease
- **Related synonym**: A word of phrase has been used synonymously with the primary term name in the literature, but the usage is not strictly correct. (_Note - we have a lot of synonyms in Mondo currently that are marked related but should really be exact and we're actively working on cleaning this up_).  
Example:  
name: AGAT deficiency  
related synonym: disorder of glycine amidinotransferase activity 

### What if I cannot find a specific code / term mapped to a Mondo ID?

There are two main reasons why a code or a term from another ontology, vocabulary or terminology is not mapped to Mondo yet. 

1. The term is relatively new and the Mondo synchronisation pipeline has not captured it. If the term is newer than 3 months, the term will usually only appear in the next Mondo release.
2. The term was explicitly excluded. If you want to know if and what a specific term was excluded, see [list of excluded terms](https://github.com/monarch-initiative/mondo-ingest/blob/main/src/ontology/reports/exclusion_reasons.robot.template.tsv)

In rare cases, a term is excluded because of a mistake in the curation. This can happen, for example, when a relevant disease term exist in a branch of a source ontology, like NCIT, that is not tracked by Mondo. In this case, we encourage you to make an issue on the [Mondo issue tracker](https://github.com/monarch-initiative/mondo/issues) to let us know.
 
### What are the capitalization rules for Mondo labels?
 
 Mondo classes are lowercase, unless they are a proper name. This is standard naming convention for ontologies and is an [OBO Foundry principle](https://obofoundry.org/principles/fp-012-naming-conventions.html). See more details [here](https://mondo.readthedocs.io/en/latest/editors-guide/f-entities/#labels). A related ticket is [here](https://github.com/monarch-initiative/mondo/issues/6332).

{% comment %} Add more FAQs as needed {% endcomment %}

# Rare Disease Subset in Mondo

A rare disease is a disease that affects fewer than 200,000 people in the United States. However, this definition is not universal and varies between rare disease sources, geographical locations, etc. Consequently, rare disease criteria also vary between sources, and one might have difficulties reconciling sources and creating a list for rare diseases. Mondo recognizes these impediments and differences of view. This document explains how Mondo handles rare diseases, how one could get a rare disease list, and the efforts made to bring the community together.

#### What are rare diseases in Mondo?
There are 3 sources for rare diseases in Mondo:
1. rare disease authorities
2. manual curation based on literature
3. ontology inference

**1. rare disease authorities**
We rely on rare disease authorities (see table below) to determine diseases recognized as “rare”. These rare diseases are determined by the rare disease authorities according to their own criteria. When a disease is considered “rare” according to a source, the corresponding Mondo term is annotated with an `in_subset` annotation expressing that this disease is considered rare according to this source: `X_rare`  (where X is the rare disease authority). These rare disease subset annotations are maintained automatically via rare disease lists from the authorities.  

Example: 'calciphylaxis' (MONDO:0017215) is considered "rare" according to NORD, GARD, and Orphanet, as shown by the 'in_subset' annotations 'nord_rare', 'gard_rare', 'orphanet_rare'.
![rare230804](https://github.com/monarch-initiative/mondo/assets/12737987/e8d6f16c-0d58-4867-bafb-2755def10b8b)


**2. manual curation**
In some occasional cases, some diseases are reported in the literature as 'rare', though they are not reported in the rare disease authorities' list. In these cases, we record the disease as rare by manually adding the "mondo_rare" subset annotation to the term. These manually curated annotations must be supported by the literature. This new rare disease is reported to the rare disease authorities. 

**3. ontology inference**
Ontological parents pass their characteristics (here: axioms) to their children. We leverage this ontological property for rare diseases: ontological children of a term that is considered "rare" according to the rules above are getting the "inferred_rare" subset annotation.


#### The Mondo rare disease subset includes ALL rare diseases according to ALL rare disease sources.
The Mondo rare disease subset represents the UNION of rare diseases according to all authority sources, manual curation, and ontology inference. It should be noted that most of the diseases in this subset will be viewed as “rare” by _most_ authorities, but some will be viewed as “rare” by _only some_ authorities. 

Rare disease terms in Mondo are annotated with `in_subset: rare` (see arrowhead in image above), and include
- terms with the annotation in_subset ‘X_rare’ (which includes ALL the rare disease authorities represented in Mondo)
- terms with the annotation in_subset ‘mondo_rare’ (representing the manually curated rare diseases)
- terms with the annotation in_subset 'inferred_rare' (representing the diseases  ontologically inferred as rare based on their parents)

Users should decide which subset they want to use for their applications. They can do so by filtering the rare disease subset by any of the 'in_subset' annotations. 

#### Where to find the Mondo rare disease subset, and what is included in the file?
The Mondo rare disease can be found as a product of the Mondo release, available in .obo and .json formats
- [http://purl.obolibrary.org/obo/mondo/subsets/mondo-rare.obo](http://purl.obolibrary.org/obo/mondo/subsets/mondo-rare.obo)
- [http://purl.obolibrary.org/obo/mondo/subsets/mondo-rare.json](http://purl.obolibrary.org/obo/mondo/subsets/mondo-rare.json)

#### What happens when a rare disease term is obsoleted or loses its "rare" characteristic?
Terms in Mondo can be obsoleted for multiple reasons (see obsoletion documents [here](https://mondo.readthedocs.io/en/latest/editors-guide/merging-and-obsoleting/)). It is possible that some of these terms to be obsoleted are in the rare disease subset. 

1. If a MONDO term (MONDO id) is obsoleted, the Mondo term will not appear in the rare disease subset, regardless of whether the disease is considered rare by one of the authoritative rare disease sources. The rare disease authoritative source reporting this disease will be contacted to report this obsoletion and its reasons.
2. If an authoritative rare source obsoletes a disease term or removes a disease from their rare disease list, the corresponding Mondo term will lose its corresponding "rare subset" annotation for this particular source. It should be noted that the rare subset annotation for the other authorities will not be modified unless they also obsolete or remove the corresponding disease from their rare disease list.
3. If a MONDO term (Mondo-1) is merged with another term (Mondo-2), its rare subset annotations will be transferred to this term (Mondo-2)

#### Current rare disease authority sources represented in Mondo

| Rare disease authority | link | in_subset annotation in Mondo | Rare disease source criteria |
| --- | --- | --- | --- |
| GARD | [https://rarediseases.info.nih.gov/](https://rarediseases.info.nih.gov/) | gard_rare | *(coming soon)*|
| NORD | [https://rarediseases.org/](https://rarediseases.org/) | nord_rare | *(coming soon)*|
| Orphanet | [https://www.orpha.net/](https://www.orpha.net/) | orphanet_rare | *(coming soon)*|





# Rare Disease Curation

Rare diseases in Mondo are created based on 3 main subsets. Rules for editing these subsets depends on the subset type. Before editing rare disease information in Mondo, please familiarize yourself with how rare diseases are represented in Mondo [here](https://mondo.readthedocs.io/en/latest/editors-guide/rare-disease-subset/).

It is important to remember that the rare disease subsets are updated automatically at the time of the monthly Mondo release. It is, therefore, crucial that editing rare disease information is done by following the instructions below for these edits to be retained after the release.

**1. Rare disease from authority sources.**
These terms have an `in_subset` annotation `X_rare`  (where X is the rare disease authority).
These subsets are maintained automatically:
- a list of rare diseases is maintained for each source here:
    - src/ontology/subsets/nord-subset.template.tsv
    - src/ontology/subsets/gard-subset.template.tsv
- during the Mondo release, the `X_rare` subset is updated based on the Mondo terms on the authoritative source list

Until we have set a process with the sources to maintain this list automatically, Mondo editors should update this list of rare diseases manually **upon request by the authoritative source**.
1. Create or open a GitHub issue reported by the authoritative source (ie NORD, GARD) to add or remove a term from the authoritative rare disease list.   
1. Open the rare disease list (from src/ontology/subsets) in a text editor:
     1. To add a new term, add a new line with the Mondo ID to add to the rare subset. Please make sure that the line is similar to the previous one: this document is a robot template, and therefore the information in each column is important.
     1. To remove a term from the list, delete the line
1. The term will be added to the rare disease list once the PR is merged, but the subset annotation will not be added until the monthly Mondo release has run.

Note: rare diseases from Orphanet are maintained by a completely automated process. If an update is needed, please create a GitHub issue for the technical team.

**2. Manually curated rare diseases.**
These terms have an `in_subset` annotation `mondo_rare`, and should be added manually when they are reported in the literature as 'rare', but they are not reported in the rare disease authorities' list.

1. In Protege, go to the Mondo term, and add the following annotation:
   - Annotation property: in_subset
   - Entity IRI: mondo_rare (note that this term is “subset_property” annotation property branch)
![Screenshot 2023-08-07 at 2 24 46 PM](https://github.com/monarch-initiative/mondo/assets/12737987/18731ad9-3154-49fc-882c-0db4352a0c54)
2. Add sources for this annotation (it is important to document how a term was determined as rare). Sources MUST include
   - Curator ORCID
   - Supporting evidence : PMID and/or other trusted source (e.g. doi, experts in the field)
3. Share the GH issue reporting this term as a rare disease with the rare disease authoritative sources (by bringing their attention to this term, they might want to add it to their rare disease list).

**3. Inferred rare disease.**
These terms have an `in_subset` annotation `inferred_rare`. This subset is created automatically and refers to the ontological children of rare disease terms.
This subset should **NOT** be manually curated.


#### Note about rare disease subset during term obsoletion/merging.

1. If a MONDO term (MONDO id) is obsoleted, the Mondo term will not appear in the rare disease subset, regardless of whether the disease is considered rare by one of the authoritative rare disease sources.
This removal of an obsolete term from the rare disease subset is automated. Curators should confirm that the removal from the rare disease subset by reviewing the Mondo release following the term obsoletion. Any error should be reported to the technical team via a GitHub issue.

2. If an authoritative rare source obsoletes a disease term or removes a disease from their rare disease list, the corresponding Mondo term will lose its corresponding "X_rare" subset annotation for this particular source.
This removal from an authoritative source subset will be automated. However, until the pipeline is fully set and functional, curators will update the authority rare disease subset list manual (see "Rare disease from authority sources" section above)

3. If a MONDO term (Mondo-1) is merged with another term (Mondo-2), its rare subset annotations will be transferred to this term (Mondo-2).
Curators merging a rare disease term should ensure that the Mondo ID is merged or added to the authoritative source list. (see "Rare disease from authority sources: section above).


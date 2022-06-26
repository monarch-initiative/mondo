---
---
# Disease Naming in Mondo
  
Mondo aims to provide complete coverage of disease entities in humans and across species. New disease classes are continuously added to Mondo as needed, and Mondo team members participate in a community-wide committee of biocurators and clinicians to define disease language. Different communities have different preferences for disease naming conventions and Mondo intends to address all of our users’ needs through use of primary labels and synonyms. 

## Mendelian Disease Naming

Below we describe two different perspectives on Mendelian disease naming from the [OMIM](https://www.omim.org) clinical genetics team, and Leslie Biesecker (NIH) and his team. 

OMIM differentiates molecular subtypes of Mendelian diseases using a numbering schema, for example, Noonan syndrome 1-13. Diseases that have similar phenotypes that have different underlying causal gene variants are grouped into a phenotypic series (for example, Noonan syndrome, [https://omim.org/phenotypicSeries/PS163950)](https://omim.org/phenotypicSeries/PS163950) [1]. 

In a paper by [Biesecker et al (2021)](https://pubmed.ncbi.nlm.nih.gov/33417889/) [2], they describe a formal, dyadic, unitary approach to naming Mendelian genetic disorders that captures the genetic variants, and the specific phenotypic characteristic in the naming schema: “GENE-related phenotype descriptor.” For example, 'TPM2-related myopathy'. 

For disease naming in Mondo, we aim to utilize the former approach in that we prefer not to include gene names within primary labels, since gene names can change and can be associated with multiple diseases [3]. Mondo can support multiple synonyms, which are codified by design patterns that can handle any number of alternative synonyms. For example, for a term created by OMIM, we use the OMIM label as the primary label, and add gene-based names as synonyms. To address specific user needs, we can create specific solutions. For example, ClinGen curators prefer gene-based labels for their curation efforts, so we created a new synonym type called ‘ClinGen preferred’, that is used to annotate the preferred labels for the ClinGen community. This will allow ClinGen curators to display ClinGen preferred labels in their Gene Curation Interface, and aid in their curation workflows. (Note - these ClinGen preferred labels are currently not displayed in the release version, per the request of ClinGen). Mondo is continually iterated and will evolve to meet the community’s needs for disease naming. We welcome feedback via our GitHub tracker: https://github.com/monarch-initiative/mondo/issues. 

## Design Patterns

We use design patterns to apply consistent logical definitions across terms in Mondo. For gene-centric diseases that are caused by germline mutations, we should use the pattern [OMIM_disease_series_by_gene](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/OMIM_disease_series_by_gene.yaml). See pattern for more details. Note, this pattern can be applied to non-OMIM diseases as well.

For diseases that are caused by somatic mutations, we use the relation 'has material basis in somatic mutation in' in the logical definition, for example, see [MONDO:0010438 'paroxysmal nocturnal hemoglobinuria 1'](https://www.ebi.ac.uk/ols/ontologies/mondo/terms?iri=http%3A%2F%2Fpurl.obolibrary.org%2Fobo%2FMONDO_0010438). See this [ticket](https://github.com/monarch-initiative/mondo/issues/4675) for further discussion.

## References

1. Rasmussen SA, Hamosh A; OMIM curators. (2020) What's in a name? Issues to consider when naming Mendelian disorders. Genet Med. 2020 Oct;22(10):1573-1575. doi: 10.1038/s41436-020-0851-0. Epub 2020 Jun 18. PMID: 32555417. [Link here](https://europepmc.org/article/pmc/pmc7521992)
2. Biesecker, L.G., Adam, M.P., Alkuraya, F.S., Amemiya, A.R., Bamshad, M.J., Beck, A.E., Bennett, J.T., Bird, L.M., Carey, J.C., Chung, B., et al. (2021). A dyadic approach to the delineation of diagnostic entities in clinical genomics. Am J Hum Genet 108, 8-15. [Link here](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7820621/)
3. Ada Hamosh, Joanna S. Amberger, Carol A. Bocchini, Joann Bodurtha, Carol J. Bult, Christopher G. Chute, Garry R. Cutting, Harry C. Dietz, Helen V. Firth, Richard A.Gibbs, Wayne W. Grody, Melissa A. Haendel, James R.Lupski, Jennifer E. Posey, Peter N. Robinson, Lynn M. Schriml, Alan F. Scott, Nara L. Sobreira, David Valle, Nan Wu, Sonja A. Rasmussen. (2021) Response to Biesecker et al. The American Journal of Human Genetics 108, 1807–1808, September 2, 20211807. [Link here](https://www.sciencedirect.com/science/article/pii/S000292972100272X?dgcid=author)




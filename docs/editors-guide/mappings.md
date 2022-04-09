## Mappings in MONDO

### How mappings are created in MONDO

All mappings in Mondo are created the same way:

1. Cross-references are imported from existing sources (other ontologies, external sources, see metadata on the cross references).
2. We add candidate cross-references with a basic lexical matching tool.
3. We run a Bayesian tool for alignment (https://github.com/INCATools/boomer) to determine the most likely correct mapping precision: is the cross-reference most likely to be exact, broad, narrow, or related. This tool ensures that we do not have mapping "hairballs", i.e. groups of mutually exact mappings.
4. This set becomes our set of "candidate mappings", and are merged into Mondo.
5. We rely on the community to inform us of bad mappings (i.e. we do _not_ review every single mapping manually).

Mappings are scoped as:
- exact
- close (somewhat similar, but not the same)
- broad (external term is broader in scope)
- narrow (external term is narrower in scope) 
- related (external term is in a different branch, i.e. a disease in Mondo to a phenotype in HPO)

## Disclaimer

Since all terminologies are used in different contexts, mappings can never be 100% precise in all contexts. These mappings are intended for use in computational analysis and data integration and aggregation, but they are not intended to be used directly by clinicians, for example, as part of clinical rules. 

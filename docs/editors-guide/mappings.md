## Mappings in MONDO

### How mappings are created in MONDO

All mappings in Mondo are created the same way:

1. Cross-references are imported from existing sources (other ontologies, external sources, see Metadata on the cross references).
2. We add candidate cross references with a basic lexical matching tool.
3. We run a bayesian tool for alignment (https://github.com/INCATools/boomer) to determine the most likely correct mapping precision: is the cross reference most likely. to be exact, broad, narrow, close. This tool ensures that we do not have mapping "hairballs", i.e. groups of mutually exact mappings.
4. This set becomes our set of "candidate mappings" and are merged into Mondo.
5. We rely on the community to inform us of bad mappings (i.e. we do _not_ review every single mapping manually).

Mappings are scoped as:
- exact
- close (somewhat similar, but not the same)
- broad (external term is broader in scope)
- narrow (external term is narrower in scope) 
- related (external term is in a different branch, i.e. a disease to a "disease susceptibility" term) matches

### "Harmonized Mappings"

A "mapping" can only ever be an approximation. It cannot be taken to mean anything other than "corresponds roughly to mean the same thing" - there cannot be exact mappings between clinical terminologies because the meanings of the terms are not logically specified in a compatible manner. A mapping between OBO and an external source (e.g. UMLS, Orphanet, etc) will always express this sentiment:

You can roughly substitute the subject of the mapping for the object, but the object term can be a bit narrower or broader then the subject term".
OBO-Clinical Mappings will be ok for use in Machine Learning tasks and perhaps data grouping (where precision is not that important), but not for substitution problems like "Replace UMLS:123 with MONDO:123 and be certain that you did not change the intention of the original EHR statement"
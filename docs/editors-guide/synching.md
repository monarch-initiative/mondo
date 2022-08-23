# Ingest source terms into Mondo
_Updated 2022-08-19_

## There are three phases of ingesting source terms into Mondo:

1. **Mapping** creates links between existing Mondo classes and external ids
2. **"Migrating"** or **"syncing"** updates the content of Mondo in the light of changes to sources. For example a subclassOf axiom previously supported by ORDO may have been removed in the latest release. If ORDO was the only source supporting that axiom, we may want to also drop it.
3. **Slurping** moves an entire term over from a source, if no suitable mapping was found. It is almost like migrating, but it involves some additional tasks, like “minting” a new Mondo ID, adding a candidate rdfs:label (during migration, we will never change the rdfs:label of a term).

### OMIM sync/slurp

#### Ingest gene associations

1. We slurp the gene association from OMIM whenever a disease has only 1 gene. We implicitly assume that these cases are monogenic diseases (which may not be fully optimal but will be mostly ok (according to our knowledge of OMIM)). We won't import disease to gene associations if there is more than one gene.
1. Genes can be associated with more than one disease, for example, APC is implicated in MONDO:0016613 'APC-related attenuated familial adenomatous polyposis' and MONDO:0021056 'familial adenomatous polyposis 1'
1. We may get disease to gene associations from external groups as well, such as ClinGen, who often request new gene-related disease terms.

Further instructions for the **OMIM sync/slurp** are documented [here](https://mondo.readthedocs.io/en/latest/editors-guide/omim-slurp/).

## Definitions (Under development)

The approach to handling definitions is under development. Potential approaches are:

1. We could check if a definition is present, and if it is present choose not to migrate a definition from the source under consideration. This requires keeping some kind of if-else logic in the migration code. 

2. Alternatively, we could create a new annotation property like "definitionAtSource" or something and add all definitions from each source. 


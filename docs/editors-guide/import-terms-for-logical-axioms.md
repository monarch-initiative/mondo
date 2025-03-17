_Last updated 2025-02-15_

## Import terms into Mondo for use in logical axioms

This workflow is for adding classes from external ontologies (e.g. GO, CHEBI, HGNC, or NCBI) and is much more streamlined compared to [MIREOTing](https://github.com/obophenotype/human-phenotype-ontology/wiki/Editor-Guide#mireoting).

As a Mondo curator, when you have a ticket that requires a term from an external ontology, create a new git feature branch to include _only_ the changes for the refresh of the imports following the steps below. Also, ask on Slack if other curators need other terms imported. 

### Add new term via ROBOT template
_Updated 2025-02-15_: This the preferred workflow currently to add a new gene for use in a subclassOf axiom.

1. Create a ROBOT template, such as [this](https://docs.google.com/spreadsheets/d/1rJsEEi47oysRnO5LJ8rlTy5_NxnDLZawRPn-Rgtmyek/edit?gid=835348843#gid=835348843)
1. Add the term ID in Column A for the term you want to add a subclass axiom to
1. In the subclassOf Axiom column (column L on this spreadsheet), add the IRI for the term you want to add, for example: http://identifiers.org/hgnc/23017. Note, this will add a new sublcassOf axiom: 
1. Run the ROBOT merge template command (See [Merging a ROBOT template into Mondo](https://mondo.readthedocs.io/en/latest/editors-guide/robot-template/#merging-a-robot-template-into-mondo_1))
1. You will see the new subclassOf axiom with the gene ID. Before the Mondo release, the imports will be refreshed (using the `refresh-merged` make goal as described below) and this will bring in the label
1. Alternatively, if only a few new genes are being added, these can be added at the root of the ontology and then reference the entity in the subclassOf axiom as compared to merging in a ROBOT template
1. Commit your changes and create a PR.

## Alternative workflows

### Prepare your environment
- Set the memory in Docker to 28 GB. See [instructions](/editors-guide/imports/#increase-memory-in-docker-mac-specific-instructions) below on how to change the memory setting.

- Increase the local environment memory to 28 GB by running `export "MEMORY_GB=28"` in your Terminal window.

### Refresh Imports 
1. Fetch the latest changes from `master` in the "mondo" repo
1. Create a new git feature branch
1. In the Terminal, run: `export "MEMORY_GB=28"` (this is the least amount of memory needed)
1. Then refresh the imports: 
    - From `src/ontology/` run the command: `sh run.sh make refresh-merged` (Note: takes ~20 minutes)
    - All the imports will be updated, which means that you might see changes in your GitHub diff in the following files:
        - `src/ontology/imports/*_terms.txt`
        - `src/ontology/imports/merged_import.owl`
1. Close Protege and open `mondo-edit.obo` in Protege again and use the "Save as..." option under the "File" menu to save the ontology as OBO Format (.obo).
    - One needs to save the `mondo-edit.obo` file in order for the updates from the refresh import update process (e.g. updated names) to be visible in the ontology file 
    - Therefore, changes such as updated names of imported entities might be shown in the git diff. 
    - The new terms should be available for logical definitions in Protege. Therefore one can also edit the `mondo-edit.obo` file too, but changes not manually made could be expected (see previous comment).
        - Example file changes from previous refresh of imports: <a href="https://github.com/monarch-initiative/mondo/pull/7716/files" target="_blank">https://github.com/monarch-initiative/mondo/pull/7716/files</a>
1. Commit the changes to the git feature branch and create a PR.
1. Once the PR is approved and merged, the terms imported from external ontologies can be referenced in logical definitions.

### Importing a new NCBITaxon class
- If adding a new NCBITaxon class that is from a species not already found in `src/ncbi_gene/transform.yaml` in the Monarch Initiative [ncbi-gene repo](https://github.com/monarch-initiative/ncbi-gene/blob/main/src/ncbi_gene/transform.yaml), this file also needs to be updated.
- Check if the new NCBI Taxon identifier(s) also exist in the [taxon-subset-ids.txt](https://github.com/obophenotype/ncbitaxon/blob/master/subsets/taxon-subset-ids.txt) file in the "obophenotype/ncbitaxon/subsets" repo
    - If the identifiers are not in the file, update the `taxon-subset-ids.txt` file to add the identifiers and create a PR in the "obophenotype/ncbitaxon/subsets" repo to include the new identifiers  
    _Note_: this file contains CURIEs (not IRIs) so the identifier should be added in this format `NCBITaxon:1`
    - This additional step is needed since we are not using NCBI Taxon directly, but the OBO slim, and the [taxon-subset-ids.txt](https://github.com/obophenotype/ncbitaxon/blob/master/subsets/taxon-subset-ids.txt) file is the seed of the NCBITaxon slim.
 

## Increase memory in Docker (Mac specific instructions)

1. Open Docker Settings
2. Click Resources
3. Increase memory to 28 GB

## Errors due to not enough Memory
Currently (11-Dec-2024) the process requires a minimum of 28 GB of memory. It is possible that the amount of memory needed may increase over time. If the process needs more memory than what is allocated, the import refresh process will stop before completing successfully and you will see at these error lines in your Terminal window:
```
Exception in thread "main" java.lang.OutOfMemoryError: Java heap space
...
make[1]: Leaving directory '/work/src/ontology'
make: *** [Makefile:481: refresh-merged] Error 2
```

To resolve an error due to lack of memory, allocate more memory to Docker and your local environment as described above.

## Alternate approaches
While there are alternate approaches to add classes from external ontologies, the instructions above are the only process that should be followed for importing external ontology classes into Mondo.

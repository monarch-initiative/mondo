_Last updated 2-Jan-2025_

## Import terms into Mondo for use in logical axioms

This workflow is for adding classes from external ontologies (e.g. GO, CHEBI, HGNC, or NCBI) and is much more streamlined compared to [MIREOTing](https://github.com/obophenotype/human-phenotype-ontology/wiki/Editor-Guide#mireoting).

As a Mondo curator, when you have a ticket that requires a term from an external ontology, create a new git feature branch to include _only_ the changes for the refresh of the imports following the steps below. Also, ask on Slack if other curators need other terms imported. 

### Prepare your environment
- Set the memory in Docker to 28 GB. See [instructions](/editors-guide/imports/#increase-memory-in-docker-mac-specific-instructions) below on how to change the memory setting.

- Increase the local environment memory to 28 GB by running `export "MEMORY_GB=28"` in your Terminal window.

### Refresh Imports 
1. Fetch the latest changes from `master` in the "mondo" repo
1. Create a new git feature branch
1. Open the `src/ontology/imports/manual_seed.txt` file
1. Add the IRI of the term(s) you want to add to the ontology to this document (`manual_seed.txt`) and save the file
    - IRIs for any entity can be added into the `manual_seed.txt` file, e.g. HGNC gene, NCBI gene (for non-human genes), NCBITaxon, etc.
    - The IRIs to add to the `manual_seed.txt` file can be found in the <a href="https://docs.google.com/spreadsheets/d/1UME3pTeR42hwNt1I6RPl0nvJKVfTIeJqhx80laAlD50/edit?pli=1&gid=0#gid=0" target="_blank">terms required for import</a> Google Sheet.
1. In the Terminal, run: `export "MEMORY_GB=28"`
1. Then refresh the imports: 
    - From `src/ontology/` run the command: `sh run.sh make refresh-merged` (Note: takes ~20 minutes)
    - All the imports will be updated, which means that you might see changes in your GitHub diff in the following files:
        - `src/ontology/imports/*_terms.txt`
        - `src/ontology/imports/merged_import.owl`
    - The terms added in the `manual_seed.txt` file will be added to the appropriate import file (e.g human genes will be added to hgnc_terms.txt; NCBITaxon will be added to ncbitaxon_terms.txt). 
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

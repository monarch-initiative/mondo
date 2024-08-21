_Last updated 27-Mar-2024_

## Import terms into Mondo for use in logical axioms

This workflow is for adding classes from external ontologies (i.e., GO or CHEBI), which is much more streamlined compared to [MIREOTing](https://github.com/obophenotype/human-phenotype-ontology/wiki/Editor-Guide#mireoting).

As a Mondo curator, when you have a ticket that requires a term from an external ontology, create a new git feature branch to include _only_ the changes for the refresh of the imports following the steps below. Also, ask on Slack if other curators need other terms imported.

1. Fetch the latest changes from `master` in the "mondo" repo
1. Create a new git feature branch
1. Open the `src/ontology/imports/manual_seed.txt` file
1. Add the IRI of the term(s) you want to add to this document and save the file
    - IRIs for any entity can be added into the `manual_seed.txt` file, e.g. gene, NCBITaxon, etc.
1. In the Terminal, run: `export "MEMORY_GB=15"`
1. Then refresh the imports: 
    - From `src/ontology/` run the command: `sh run.sh make refresh-merged` (Note: this may take ~2 hours)
    - All the imports will be updated, which means that you might see changes in your GitHub diff in the following files:
        - `src/ontology/imports/*_terms.txt`
        - `src/ontology/imports/merged_import.owl`
    - The terms added in the `manual_seed.txt` file will be added to the appropriate import file (e.g human genes will be added to hgnc_terms.txt; NCBITaxon will be added to ncbitaxon_terms.txt). 
1. Close Protege and open `mondo-edit.obo` in Protege again and use the "Save as..." option under the "File" menu to save the ontology as OBO Format (.obo).
    - One needs to save the `mondo-edit.obo` file in order for the updates from the refresh import update process (e.g. updated names) to be visible in the ontology file 
    - Therefore, changes such as updated names of imported entities might be shown in the git diff. 
    - The new terms should be available for logical definitions in Protege. Therefore one can also edit the file too, but changes not manually made could be expected (see previous comment).
        - Example file changes from previous refresh of imports: <a href="https://github.com/monarch-initiative/mondo/pull/7716/files" target="_blank">https://github.com/monarch-initiative/mondo/pull/7716/files</a>
1. Commit the changes to the git feature branch and create a PR.
1. Once the PR is approved and merged, the terms imported from external ontologies can be referenced in logical definitions.

### Note when importing a new NCBITaxon class
- Check if the new NCBI Taxon identifier(s) also exist in the [taxon-subset-ids.txt](https://github.com/obophenotype/ncbitaxon/blob/master/subsets/taxon-subset-ids.txt) file in the "obophenotype/ncbitaxon/subsets" repo
    - If the identifiers are not in the file, update the `taxon-subset-ids.txt` file to add the identifiers and create a PR in the "obophenotype/ncbitaxon/subsets" repo to include the new identifiers  
    _Note_: this file contains CURIEs (not IRIs) so the identifier should be added in this format `NCBITaxon:1`
- This additional step is needed since we are not using NCBI Taxon directly, but the OBO slim, and the [taxon-subset-ids.txt](https://github.com/obophenotype/ncbitaxon/blob/master/subsets/taxon-subset-ids.txt) file is the seed of the NCBITaxon slim.
 

## Alternate approaches
While there are alternate approaches to add classes from external ontologies, the instructions above are the only process that should be followed for importing external ontology classes into Mondo.

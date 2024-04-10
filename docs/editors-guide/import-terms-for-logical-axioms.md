## Import terms into Mondo for use in logical axioms

These workflows for adding classes from external ontologies (i.e., GO or CHEBI), which is much more streamlined compared to [MIREOTing](https://github.com/obophenotype/human-phenotype-ontology/wiki/Editor-Guide#mireoting).

_Last updated 27-Mar-2024_

1. Open the `src/ontology/imports/manual_seed.txt`
2. Add the IRI of the term(s) you want to add to this document, and save
    - you can add any IRI, e.g. gene, NCBITaxon,...
3. In the Terminal, run: `export "MEMORY_GB=15"`
4. Then run import: `sh run.sh make refresh-merged` 
    - All the imports will be updated, which means that you might see changes in your GitHub diff in the following files
        - `src/ontology/imports/*_terms.txt`
        - `src/ontology/imports/merged_import.owl`
    - The terms added in the "manual_seed.txt" will be added to the appropriate import (e.g human genes will be added to hgnc_terms.txt; NCBITaxon will be added to ncbitaxon_terms.txt), and removed from the "manual_seed.txt" after the import refresh has run. 
5. Open mondo-edit.obo in protege, and save the ontology (as .obo).
    - one needs to save the mondo-edit.obo in order for the updates from the import updates (e.g. updated names) to be visible in this file. 
    - Therefore, changes such as updated names of imported entities might be shown in the GH diff. 
    - The new terms should be available for logical definitions in Protege. Therefore one can also edit the file too, but changes not manually made could be expected (see previous comment)

**Note when adding a new NCBITaxon**
Check if the new NCBI Taxon identifier(s) exist in [https://github.com/obophenotype/ncbitaxon/blob/master/subsets/taxon-subset-ids.txt](https://github.com/obophenotype/ncbitaxon/blob/master/subsets/taxon-subset-ids.txt). 
    - if the identifiers are not in the file, create a PR in this repo to include the new identifiers
    Note: this file contains CURIEs (not IRIs) so the identifier should be added in this format `NCBITaxon:1`

This additional step is needed since we are not using NCBI Taxon directly, but the OBO slim, and this file is the seed of the NCBITaxon slim.
 


### Alternate approaches
These alternate approaches are mentioned here for documentation purposes. These should **only be used by experienced curators**, and followed by a clean-up of class declarations in mondo-edit.obo 

- **Add the required axiom, using classes from external ontologies, the in mondo-edit.obo *text file* using a Text Editor**
 For example:  relationship: disease_has_basis_in_dysfunction_of http://identifiers.org/hgnc/129


- **Add classes from external ontologies using Protege.**
These classes should be added as new classses under 'owl:Thing', using the full IRI in the 'Name:' field, for example, http://purl.obolibrary.org/obo/CHEBI_50906.

While classes from external ontologies can be added directly using Protege, this process results in having class declarations in mondo-edit.obo and require further work to be cleaned out.

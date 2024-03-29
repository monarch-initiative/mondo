## Import terms into Mondo for use in logical axioms

These workflows for adding classes from external ontologies (i.e., GO or CHEBI), which is much more streamlined compared to [MIREOTing](https://github.com/obophenotype/human-phenotype-ontology/wiki/Editor-Guide#mireoting).

### Preferred Instructions

_Added 2020-05-06_

1. Open the `src/ontology/imports/*_terms.txt`
2. Add term to this file
3. In the Terminal, run: `export "MEMORY_GB=15"`
4. Then run import: `sh run.sh make refresh-merged`
4. Close Protege and open again
5. Edit in Protege

---
#### Detailed instructions for adding a new NCBI Taxon identifier 

_Last updated 6-Mar-2024_

1. Fetch the latest changes from `master`
1. Create a new feature branch for the updated NCBI Taxon additions
1. Open the `src/ontology/imports/ncbitaxon_terms.txt` file
1. Add the IRI(s) of interest into the file, e.g. `http://purl.obolibrary.org/obo/NCBITaxon_3052303`
1. In the Terminal, run: `export "MEMORY_GB=15"`
1. Run import: `sh run.sh make refresh-merged` (Note: this may take ~2 hours)
1. Review and commit the updated files, the changed files will be:
    - `src/ontology/imports/ncbitaxon_terms.txt`
    - `src/ontology/imports/merged_import.owl`
1. Publish the branch and create a PR
1. Once the PR is approved and merged, the new NCBI Taxon can be referenced in logical definitions
1. Check if the new NCBI Taxon identifier(s) exist in [https://github.com/obophenotype/ncbitaxon/blob/master/subsets/taxon-subset-ids.txt](https://github.com/obophenotype/ncbitaxon/blob/master/subsets/taxon-subset-ids.txt)
    - if the identifiers are not in the file, create a PR in this repo to include the new identifiers

    Note: this file contains CURIEs (not IRIs) so the identifier should be added in this format `NCBITaxon:1`

    This additional step is needed since we are not using NCBI Taxon directly, but the OBO slim, and this file is the seed of the NCBITaxon slim.
 
---
#### Detailed instructions for adding a new gene

1. Find the gene in HGNC that you need to add:
https://www.genenames.org/. Copy the ID (for example, 8965)
2. Open the `src/ontology/imports/hgnc_terms.txt` file
3. Add a new line to the file: http://identifiers.org/hgnc/[your ID], for example http://identifiers.org/hgnc/8965
5. Run import:
`sh run.sh make refresh-merged`
4. Close Protege and open again
5. Edit in Protege
6. In your diff, you will see changes to src/ontology/imports/hgnc_terms.txt and src/ontology/imports/merged_import.owl
7. Commmit changes on a branch and create a pull request.

Note: if an import does not have a `src/ontology/imports/*_terms.txt` file (e.g. for adding NCIT terms). The term(s) to import should be added to src/ontology/imports/manual_seed.txt.  When updating the import, the term(s) will seed the import files, which are pulled in when refreshing modules.

### Alternate instructions

#### Add classes from external ontologies using a Text Editor

1. Close Protege
1. Checkout master
1. Create a new branch
1. Open mondo-edit.obo with a text editor like Sublime or TextEdit
1. Add axiom in mondo-edit.obo *text file*
1. **For example:**  relationship: disease_has_basis_in_dysfunction_of http://identifiers.org/hgnc/129
1. Save text file
1. open mondo-edit.obo in Protege
1. File -> save as (obo format, save as mondo-edit.obo)
1. Replace existing file  
1. Check diff
1. Commit/Push

#### Add classes from external ontologies using Protege

1. Select 'owl:Thing'
1. Add a new class
paste the full iri in the 'Name:' field, for example, http://purl.obolibrary.org/obo/CHEBI_50906.
1. hit 'OK'
1. Now you can use this term, for example to construct logical axioms. The next time the imports are refreshed, the metadata (labels, definitions, etc) for this term is imported from the respective external source ontology and becomes visible in mondo-edit.obo.
1. See instructions on how to remake the imports file [here](../developer-guide/imports.md).


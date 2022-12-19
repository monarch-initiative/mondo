# OMIM Slurp

1. Navigate to src/ontology
1. Create a new branch
1. In terminal:
`sh run.sh make omim_slurp -B`
1. two new files will be created in src/ontology/tmp:
- ps_slurp_omim.obo
- rest_slurp_omim.obo

1. Open these files and examine them closely for any issues. For example, 
are labels and synonyms appropriately capitalized, etc.
2. **For OMIMPS:**
  1. Check the OMIMPS to see if a grouping class already exists in Mondo (there may already be a grouping class from Orphanet, in which case, just add the OMIMPS as an additional dbxref.) To check, check the ID after the PS (for example, if the OMIMPS is OMIMPS:131760, check OMIM:131760 to see if that term already exists in Mondo.)
  1. If a prototype term exists (i.e., the original term in OMIM, where another gene was identified later and that term term became type 1 and other type 2, etc. were created, and then an OMIM Phenotypic Series (OMIMPS) was created), this term needs to be split.
    1. For the OMIMPS, if a split is needed, we need to mark the existing terms as obsoletion candidates and wait for 2 months before we do the split (see instructions [here](https://mondo.readthedocs.io/en/latest/editors-guide/sop_splitting-terms/)). Create a ticket following this [example](https://github.com/monarch-initiative/mondo/issues/4500).
  1. Note - if you add a new OMIMPS, the children will **_not_** automatically be added, they need to be added manually. (Some children terms may not be in Mondo and will be added in a future slurp.)
  1. New OMIMPS terms can be added directly into mondo-edit.obo text file. Note, they may not have the superclass and they also need a subclassOf axiom (or you will get a QC error):
  `is_a: MONDO:0003847 {source="OMIMPS:XXXXXX"} ! l'Mendelian disease'`
  `relationship: has_characteristic MONDO:0021152 {source="OMIMPS:XXXXXX"} ! inherited` 
3. **For rest of OMIM:**
  1. Check the terms to make sure they do not already exist in Mondo. (Search for OMIM:XXXXXX in mondo-edit.obo text file.) 
  2. If the term does already exist in Mondo, verify the term is equivalent by checking the OMIM record online, then add the OMIM dbxref and MONDO:equivalent to to the Mondo class.
  3. Check the capitalization of each new Mondo label and fix if needed.
  4. Synonyms should be exact, fix if needed. (Search for RELATED and replace with EXACT in the text file.)
  5. Add abbreviations to the abbreviation synonyms:
    - turn on regex buttons in Atom (.* and Aa)
    - Find:  `^(synonym: "[A-Z0-9]+["][ ][A-Z]+[ ])\[`
    - Replace: ``$1ABBREVIATION [``
    - Note, test a few of these before doing a global find and replaced_by
1. Manually add these to the mondo-edit.obo file by copying and pasting 
the lines into the mondo-edit.obo file in a text editor such as Atom.
1. Re-run step 3 until all the files are empty.

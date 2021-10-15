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
1. Manually add these to the mondo-edit.obo file by copying and pasting 
the lines into the mondo-edit.obo file in a text editor.
1. Note - if you add a new OMIMPS, the children will not automatically be added.
1. For the OMIMPS, if a split is needed, we need to mark the existing terms 
as obsoletion candidates and wait for 2 months before we do the split (see 
  instructions [here](https://mondo.readthedocs.io/en/latest/editors-guide/sop_splitting-terms/)).
1. Re-run step 3 until all the files are empty.
# Regenerate import file

These instructions are specific to regenerating the NCBITaxom import but can be applied to other import files.

If you have Docker installed: 

1. Navigate to your local ontology directory, for example:
` cd src/ontology`
2. Work on a branch.
3. Make a mirror directory: `mkdir mirror`
4. Run command: `./run.sh make imports/ncbitaxon_import.owl`  
    1. Note - if you don't have Docker installed but have Robot installed, run this command:  
  `make imports/ncbitaxon_import.owl`  
    2. Note - this can take a while to run.  
    3. Note - if it failed with a message saying the source ontology is not available, try again later.  
5. Do the diff on ncbitaxon_import. We expect new classes and some subClassOf changes. A new ncbitaxon_import.owl file will be created in the imports folder. Run command: `git diff`  
6. If you are expecting new classes to be added, check to see if those were added. For example: check the coronovirus shows up in the new import
    1. `grep 2697049 imports/ncbitaxon_import.owl`
    2. 2697049 = ID for class I am trying to import.  
7. Commit ncbitaxon_import.owl file (if you see changes on any other files, discard the changes on the other files):  
     `git add imports/ncbitaxon_import.owl`  
     `git status` should only this file is to be committed.  
     `git commit`  
     `git push`  
8. Once you regenerated the new import, it could contain newly deprecatecd classes from the source ontology and this could affect the Mondo ontology by creating danglers/obsolete references. To fix this, follow the instructions in [Repair axioms pointing to deprecated classes](https://mondo.readthedocs.io/en/latest/developer-guide/repair-obsoleted-classes/).

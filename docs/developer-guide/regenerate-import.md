# Regenerate import file

See the [imports/ folder](https://github.com/monarch-initiative/mondo/tree/master/imports).

These work in the usual way, see OBO docs for details. See [Design Pattern](https://mondo.readthedocs.io/en/latest/editors-guide/e-design-patterns/) section for more details on how these are used.

## Instructions

If you need to remake the import "foo" (replace "foo" with the name of your file, for example ncbitaxon_import):

If you have Docker installed (note - you may need to increase your memory in Docker to 24GB): 

1. Navigate to your local ontology directory, for example:
` cd src/ontology`
2. Work on a branch.
3. Make a mirror directory: `mkdir mirror`
4. Run command: `./run.sh make imports/foo_import.obo` 
    1. For example: `./run.sh make imports/ncbitaxon_import.obo`  
    1. Note - if you don't have Docker installed but have Robot installed, run this command:  
  `make imports/foo_import.obo` 
    1. For example:`make imports/ncbitaxon_import.obo`  
    1. Note - this can take a while to run.  
    1. Note - if it failed with a message saying the source ontology is not available, try again later.  
5. Do the diff on ncbitaxon_import. We expect new classes and some subClassOf changes. A new foo_import.obo file will be created in the imports folder (for example: ncbitaxon_import.obo). Run command: `git diff`  
6. If you are expecting new classes to be added, check to see if those were added. For example: check the coronovirus shows up in the new import
    1. `grep 2697049 imports/ncbitaxon_import.obo`
    2. 2697049 = ID for class I am trying to import.  
7. Commit the foo_import.* file (for example: ncbitaxon_import.obo and ncbitaxon_import.owl) (if you see changes on any other files, discard the changes on the other files):  
     `git add imports/foo_import.obo`  
     `git add imports/foo_import.owl`
     `git status` - only those two files should be added and ready to be committed. There will be some untracked files as well, which should not be added or committed.  
     `git commit`  
     `git push`  
8. Once you regenerated the new import, it could contain newly deprecatecd classes from the source ontology and this could affect the Mondo ontology by creating danglers/obsolete references. To fix this, follow the instructions in [Repair axioms pointing to deprecated classes](https://mondo.readthedocs.io/en/latest/developer-guide/repair-obsoleted-classes/).

## Increase memory in Docker

1. Open Docker preferences
2. Click Resources
3. Increase memory to 24 GB

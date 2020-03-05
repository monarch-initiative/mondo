Regenerate ncbitaxon_import

If I have ROBOT installed (which I do):
1. navigate to:
cd git/mondo/src/ontology
2. work on a branch
3. run command
make imports/ncbitaxon_import.owl
4. Note - it seems to run very slowly
5. do the diff on ncbitaxon_import. we expect new classes and some subClassOf changes.
6. If I am expecting new classes to be added, check to see if those were added. For example: check the coronovirus shows up in the new import
    1.  grep 2697049 imports/ncbitaxon_import.owl
    2. 2697049 = ID for class I am trying to import
7. Commit ncbitaxon_import file (discard the changes on the other files)
8. Check for danglers/obsolete references:
    1. run command: robot reason -r elk -i mondo-edit.obo
9. [at this point, Chris said "it looks like repair caught everything. ie all had replaced-by. no need for manual repair”]
10. roundtrip mondo-edit, then merge into master, then make a release
    1. load in protege, make an edit, save, check diff, then commit
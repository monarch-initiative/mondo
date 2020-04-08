# Imports

See the [imports/ folder](https://github.com/monarch-initiative/mondo/tree/master/imports).

Updating imoprts is needed whenever logical axioms that reference exgtenal ontologies are added but the classes being referenced have no labels or other logical definitions. Updating an import for those classes will bring in the labels, annotations, and logical axioms into the import file, and therefore into the Mondo ontology. See [Design Pattern](https://mondo.readthedocs.io/en/latest/editors-guide/e-design-patterns/) section for more details patterns that reference external ontologies.

If you need to remake the import "foo":

1. Navigate to mondo/src/ontology on your loccal machine
2. `./run.sh make imports/foo_import.obo`  

- Note- you will need to replace 'foo' with the file name you are trying to import, such as:  
`./run.sh make imports/ncbitaxon_import.obo`

- You can omit `run.sh` and run `make` natively if you have ROBOT installed, if you are fine without Docker; this is a standard ODK thing. For example:  

`make imports/ncbitaxon_import.owl`

Updating the *.obo import file will also update the *.owl file. Always update the *.obo file so both versions (obo and owl) remain in sync. 

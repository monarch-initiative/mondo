# Imports

See the [imports/ folder](https://github.com/monarch-initiative/mondo/tree/master/imports).

These work in the usual way, see OBO docs for details. See [Design Pattern](https://mondo.readthedocs.io/en/latest/editors-guide/e-design-patterns/) section for more details on how these are used.

If you need to remake the import "foo":

1. Navigate to mondo/src/ontology on your loccal machine
2. `./run.sh make imports/foo_import.obo`  

- Note- you will need to replace 'foo' with the file name you are trying to import, such as:  
`./run.sh make imports/ncbitaxon_import.obo`

- You can omit `run.sh` and run `make` natively if you have ROBOT installed, if you are fine without Docker; this is a standard ODK thing. For example:  

`make imports/ncbitaxon_import.owl`

Updating the *.obo import file will also update the *.owl file. Always update the *.obo file so both versions (obo and owl) remain in sync. 

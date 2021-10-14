## Check for and Merge Duplicate annotations in Mondo

### Description
This command will check for and fix duplicate annotations, such as duplicate 
is_a assertions (parents), duplicate synonyms, and duplicate xrefs.

### Instructions

1. Navigate to src/ontology
1. Create a branch
1. In Terminal run :
1. `sh run.sh make NORM`
1. `mv NORM mondo-edit.obo`
1. Check the diff in GitHub Desktop. If everything looks okay, commit and 
create a Pull Request.
1. For example, see [https://github.com/monarch-initiative/mondo/pull/3802](https://github.com/monarch-initiative/mondo/pull/3802)
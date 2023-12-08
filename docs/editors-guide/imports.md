# Imports

Updating imports is needed whenever logical axioms that reference external ontologies are added but the classes being referenced have no labels or other logical definitions. Updating an import for those classes will bring in the labels, annotations, and logical axioms into the import file, and therefore into the Mondo ontology.

# Regenerate import file

See the [imports/ folder](https://github.com/monarch-initiative/mondo/tree/master/imports).

See [Design Pattern](https://mondo.readthedocs.io/en/latest/editors-guide/e-design-patterns/) section for more details on patterns that reference external ontologies and how these are used.

## Instructions

If you have Docker installed (note - you may need to increase your memory in Docker to 24GB): 

1. Navigate to your local ontology directory, for example: `cd src/ontology`
2. Create a git branch, e.g. `git checkout -b iss-GH_ISSUE_NUMBER`
3. Run command: `sh run.sh make refresh-merged`
4. Run `git status` to see what files have been updated
5. Commit the updated files:
     `git add <PATH-TO-FILE>`
     `git status` - only the updated files should be added and ready to be committed. There will be some untracked files as well, which should not be added or committed.
     `git commit`  
     `git push`  
6. Once the new imports are generated, it could contain newly deprecatecd classes from the source ontology and this could affect the Mondo ontology by creating danglers/obsolete references. To fix this, follow the instructions in [Repair axioms pointing to deprecated classes](https://mondo.readthedocs.io/en/latest/developer-guide/repair-obsoleted-classes/).

## Increase memory in Docker (Mac specific instructions)

1. Open Docker preferences
2. Click Resources
3. Increase memory to 24 GB
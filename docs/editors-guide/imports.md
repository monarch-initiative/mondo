_Last updated 11-Dec-2024_

Updating imports is needed whenever logical axioms that reference external ontologies are added, but the classes being referenced have no labels or other logical definitions. Updating an import for those classes will bring in the labels, annotations, and logical axioms into the import file, and therefore into the Mondo ontology.

## Regenerate import file

See the [imports/ folder](https://github.com/monarch-initiative/mondo/tree/master/imports).

See [Design Pattern](https://mondo.readthedocs.io/en/latest/editors-guide/e-design-patterns/) section for more details on patterns that reference external ontologies and how these are used.

## Instructions

### Prepare your environment
- Set the memory in Docker to 28 GB. See [instructions](/editors-guide/imports/#increase-memory-in-docker-mac-specific-instructions) below on how to change the memory setting.

- Increase the local environment memory to 28 GB by running `export "MEMORY_GB=28"` in your Terminal window.

### Refresh Imports
1. Navigate to your local ontology directory, for example: `cd src/ontology`
2. Create a git branch, e.g. `git checkout -b iss-GH_ISSUE_NUMBER`
3. Run command: `sh run.sh make refresh-merged`
4. Run `git status` to see what files have been updated. Only the updated files should be added and ready to be committed. There may be some untracked files as well, which should not be added or committed.
5. Commit the updated files: 
     - `git add <PATH-TO-FILE>` 
     - `git commit`   
     - `git push`   
6. Once the new imports are generated, it could contain newly deprecated classes from the source ontology and this could affect the Mondo ontology by creating danglers/obsolete references. To fix this, follow the instructions in [Repair axioms pointing to deprecated classes](https://mondo.readthedocs.io/en/latest/developer-guide/repair-obsoleted-classes/).

The process to refresh the imports takes ~20 minutes with a memory setting of 28 GB (11-Dec-2024).

## Increase memory in Docker (Mac specific instructions)

1. Open Docker Settings
2. Click Resources
3. Increase memory to 28 GB

## Errors due to not enough Memory
Currently (11-Dec-2024) the process requires a minimum of 28 GB of memory. It is possible that this limit may increase over time. If the process needs more memory than what is allocated, the import refresh process will stop before completing successfully and you will see at these error lines in your Terminal window:
```
Exception in thread "main" java.lang.OutOfMemoryError: Java heap space
...
make[1]: Leaving directory '/work/src/ontology'
make: *** [Makefile:481: refresh-merged] Error 2
```

To resolve an error due to lack of memory, allocate more memory to Docker and your local environment as described above.
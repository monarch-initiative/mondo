# Mondo release workflow

_Check back soon for documentation on creating the Mondo release._

## Write a description of the release

1. All of the releases can be found under the [releases](https://github.com/monarch-initiative/mondo/releases) tab.
2. To add a description of the release, click edit, and write a summary from [changes.md](https://github.com/monarch-initiative/mondo/blob/master/Changes.md) in the 'describe this release' section. 

## Generate Change Log

### Initial Setup:
1. copy the obo script from github: https://github.com/cmungall/obo-scripts
    1. the script is: https://raw.githubusercontent.com/cmungall/obo-scripts/master/obo-simple-diff.pl
        1. right click and save as
2. move that file: mv [wherever I downloaded it, for example: /Users/vasilevs/bin/obo-simple-diff.pl] /usr/local/bin
    1. mv  /Users/vasilevs/bin/obo-simple-diff.pl /usr/local/bin
3. chmod 755 obo-simple-diff.pl 

### Workflow:
1. Download the latest mondo.obo from GitHub (https://github.com/monarch-initiative/mondo/releases) and save under /ontology folder (do not commit later)
2. Download the previous mondo.obo and save as mondo-lastbuild.obo
3. In terminal: `make mondo-diff.txt`
4. `./get-new-classes.sh > somefilename.txt`
    1. For exaample: ./get-new-classes.sh > MondoRelease_2020-07-01.txt
5. Open this file on your computer: MondoRelease_somefilename.txt
  1. For example: MondoRelease_2020-06-01.txt

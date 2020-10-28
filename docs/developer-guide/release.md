# Release process

Mondo is released on a monthly basis around the first of the month. Additional releases are run ad hoc. All Mondo releases are available [here](https://github.com/monarch-initiative/mondo/releases).

# Releases

All release products are described on the [OBO page](http://obofoundry.org/ontology/mondo.html) and [Mondo website](https://mondo.monarchinitiative.org/).

 - the [mondo-with-equivalent](http://purl.obolibrary.org/obo/mondo/mondo-with-equivalents.owl) edition uses OWL equivalence axioms directly in the ontology. Note this makes it harder to browse in some portals, but this edition may be preferable for computational use. The owl edition also includes axiomatization using CL, Uberon, GO, HP, RO, NCBITaxon.
 - the primary release versions (mondo.owl, mondo.obo) are simpler, lacking owl equivalence axioms from Mondo classes to terms from other databases; instead, xrefs are used for linking these terms. If the ID is one of Orphanet, OMIM, DOID or EFO then the xref precisely shadows the equivalence axiom.
- The [mondo-with-equivalents json edition](http://purl.obolibrary.org/obo/mondo/mondo-with-equivalents.json) has all owl equivalencies as well as all xrefs to other disease sources.

The release mondo.owl will look like this in Protege:
![How release looks in Protege](images/release-protege-look.png)

# Mondo release workflow

1. Pull master
2. `cd git/mondo/src/ontology/`
3. `sh run.sh make all -B` - note, this takes about 2-3 hours
4. Open mondo.owl and mondo.obo and check the latest changes are there and it looks reasonable
5. `cp ~/.token .token`  
6. `sh run.sh make GHVERSION=vYYYY-MM-DD deploy_release` - note, this takes about 30 minutes  
Note- the date should be the date of the release in the format sh run.sh make GHVERSION=vYYYY-MM-DD deploy_release (for example, v2020-08-10)  (very important: It should not necessarily be today, it is the day the release artifacts were created according to the IRIs. In order to find the right date, open mondo-base.obo and check version IRI, and use this date)
7. Check these two release pages (make sure you replace the date correctly in the first link): 
    1. https://github.com/monarch-initiative/mondo/releases/tag/v2020-XX-XX
    2. https://github.com/monarch-initiative/mondo/releases/tag/current 
    3. Both should: Ensure on both that it says nicolevasilevsky released this 1 days ago or now
    4.  Ensure that both have all release artefacts attached to it
7. When this is done, follow instructions for the change log

## Generate Change Log

### Initial Setup:
1. copy the obo script from github: https://github.com/cmungall/obo-scripts
    1. the script is: https://raw.githubusercontent.com/cmungall/obo-scripts/master/obo-simple-diff.pl
        1. right click and save as
2. move that file: mv [wherever I downloaded it, for example: /Users/vasilevs/bin/obo-simple-diff.pl] /usr/local/bin
    1. mv  /Users/vasilevs/bin/obo-simple-diff.pl /usr/local/bin
3. chmod 755 obo-simple-diff.pl 

### Generate Change Log Workflow:
1. Download the latest mondo.obo from GitHub (https://github.com/monarch-initiative/mondo/releases) and save under /ontology folder (do not commit later)
2. Download the previous mondo.obo and save as mondo-lastbuild.obo
3. In terminal: `make mondo-diff.txt`
4. `./get-new-classes.sh > somefilename.txt`
    1. For exaample: ./get-new-classes.sh > MondoRelease_2020-07-01.txt
5. Open this file on your computer: MondoRelease_somefilename.txt
  1. For example: MondoRelease_2020-06-01.txt

## Write a description of the release

1. All of the releases can be found under the [releases](https://github.com/monarch-initiative/mondo/releases) tab.
2. To add a description of the release, click edit, and write a summary from [changes.md](https://github.com/monarch-initiative/mondo/blob/master/Changes.md) in the 'describe this release' section. 


## Commit release files 

8. Commit all of the changed import and report files (ignore or discard diff files, change log)


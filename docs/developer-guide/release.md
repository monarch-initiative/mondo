# Release process

Mondo is released on a monthly basis around the first of the month. Additional releases are run ad hoc. All Mondo releases are available [here](https://github.com/monarch-initiative/mondo/releases).

Videos outlining this process are available [here](https://drive.google.com/drive/u/0/folders/1kDD572vCE2NRGC57cX7vTUHQSFvomyb7).

## Initial setup: 
These steps will be done only once, when setting up your computer for Mondo release. 
### Generate token
1. Follow the instructions [here](https://mondo.readthedocs.io/en/latest/developer-guide/generate-token/) to generate the GitHub token.
### Get the obo-simple-diff script and set-up your path:
1. In terminal, create a "tools" directory in your home directory: 
`mkdir ~/tools`. 
Note that we are creating a directory in your user directory, not in your Mondo directory (FYI, `~/` refers to your home directory in Mac or Linux systems). This directory can in the future contain various tools, such as ROBOT and scripts necessary for release processes. 
1. Copy the obo script from github: https://github.com/cmungall/obo-scripts
    1. the script is: https://raw.githubusercontent.com/cmungall/obo-scripts/master/obo-simple-diff.pl
        1. right click and save as (and save in Downloads)
        2. Move the file to the "tools" directory: `mv Downloads/obo-simple-diff.pl ~/tools`
    1. alternatively, you can download the script directly using a command line tool like wget: `wget https://raw.githubusercontent.com/cmungall/obo-scripts/master/obo-simple-diff.pl -O ~/tools/obo-simple-diff.pl`
1. We now make the downloaded script executable using the `chmod` command: type `chmod +x ~/tools/obo-simple-diff.pl` in your terminal and hit enter.
1. Lastly, ensure that your ~/tools directory is added to your path. If you are using zsh (as shown in the terminal window title), create your path: 
   - `nano ~/.zshrc`
   - paste the following line into the file, usually at the very end: `export PATH=/Users/torosa/tools:$PATH`(instead of "/Users/torosa", use your path to the tools directory)
   - save (by hitting control+o and then enter) and close (control+x)
   - in the terminal, type: `source ~/.zshrc`; this reloades the `.zshrc` file. 
   - *Open a new Terminal window before you continue*. 


# Releases

All release products are described on the [OBO page](http://obofoundry.org/ontology/mondo.html) and [Mondo website](https://mondo.monarchinitiative.org/).

 - the [mondo-with-equivalent](http://purl.obolibrary.org/obo/mondo/mondo-with-equivalents.owl) edition uses OWL equivalence axioms directly in the ontology. Note this makes it harder to browse in some portals, but this edition may be preferable for computational use. The owl edition also includes axiomatization using CL, Uberon, GO, HP, RO, NCBITaxon.
 - the primary release versions (mondo.owl, mondo.obo) are simpler, lacking owl equivalence axioms from Mondo classes to terms from other databases; instead, xrefs are used for linking these terms. If the ID is one of Orphanet, OMIM, DOID or EFO then the xref precisely shadows the equivalence axiom.
- The [mondo-with-equivalents json edition](http://purl.obolibrary.org/obo/mondo/mondo-with-equivalents.json) has all owl equivalencies as well as all xrefs to other disease sources.

The release mondo.owl will look like this in Protege:
![How release looks in Protege](images/release-protege-look.png)

# Mondo release workflow

_Note: While the release is running, don't shut your laptop or switch between repos or branches in GitHub, as this will stop the release._

1. Pull master
2. `cd git/mondo/src/ontology/`
3. `MEMORY_GB=12 sh run.sh make IMP=false all -B` - note, this takes about 2-3 hours.
4. Open mondo.owl and mondo.obo and check the latest changes are there and it looks reasonable
5. Make sure you see ‘release finished’ after the command has run

## Commit changes to a branch
1. Create a branch and commit the changes on the branch
2. Do a pull request (PR)
3. Wait for GitHub Actions/QC to pass
4. Merge PR
5. When this is done, follow instructions to Generate Change Log

## Generate Change Log

### Initial Setup:
Make sure the initial setup (see above) has been done :
1. Download the `obo-simple-diff.pl` script to the "tools" directory and set-up your path to the tools directory.
2. Generate token

### Generate Change Log Workflow:
<!-- 1. Download the latest mondo.obo from GitHub (https://github.com/monarch-initiative/mondo/releases) and save under /ontology folder (do not commit later)
2. Download the previous mondo.obo and save as mondo-lastbuild.obo-->

1. In terminal: `make mondo-diff.txt -B`  
1. `./get-new-classes.sh > somefilename.txt`  
  - "somefilename" should be MondoRelease_YYYY-MM-DD, for example: `./get-new-classes.sh > MondoRelease_2020-07-01.txt`  
3. Open this file on your computer: MondoRelease_somefilename.txt  
  - For example: MondoRelease_2020-06-01.txt     

## Deploy Release
1. `cp ~/.token .token`  
1. `sh run.sh make GHVERSION=vYYYY-MM-DD deploy_release` - note, this takes about 30 minutes  
Note- the date should be the date of the release in the format sh run.sh make GHVERSION=vYYYY-MM-DD deploy_release (for example, v2020-08-10)  (very important: It should not necessarily be today, it is the day the release artifacts were created according to the IRIs. In order to find the right date, open mondo-base.obo and check version IRI, and use this date)
1. Check these the release pages (make sure you replace the date correctly in the first link):
    1. https://github.com/monarch-initiative/mondo/releases/tag/v2020-XX-XX
    2. Ensure that it says [name] (eg nicolevasilevsky) released this 1 days ago or now
    3. Ensure it has all release artefacts attached to it (there should be 18 assets)
    4. Check this file to ensure you see the expected changes (spot check a few changes): https://github.com/monarch-initiative/mondo/releases/latest/download/mondo.owl

## Write a description of the release

1. Add the release description to the release tab: 
 - All of the releases can be found under the [releases](https://github.com/monarch-initiative/mondo/releases) tab.
 - To add a description of the release: 
   - click edit
   - in the 'describe this release' section add the content from the change log text file above
   - click "update release"
2. Add the summary of changes to [changes.md](https://github.com/monarch-initiative/mondo/blob/master/Changes.md).
 - go to changes.md
 - click edit
 - add the name of the new release and the content from the change log text file above. 
 - commit to master

## Commit release files

1. Commit all of the changed import and report files (ignore or discard diff files, change log) to a branch
1. Once all checks have passed, merge to master
Note: The changes shown in this new commit are the copied files from the source ontology directory (they don’t affect anything).

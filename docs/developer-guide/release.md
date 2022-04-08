# Release process

Mondo is released on a monthly basis around the first of the month. Additional releases are run ad hoc. All Mondo releases are available [here](https://github.com/monarch-initiative/mondo/releases).

Videos outlining this process are available [here](https://drive.google.com/drive/u/0/folders/1kDD572vCE2NRGC57cX7vTUHQSFvomyb7).

## Initial setup: 
These steps will be done only once, when setting up your computer for Mondo release. 
### Generate token
1. Follow the instructions [here](https://mondo.readthedocs.io/en/latest/developer-guide/generate-token/) to generate the GitHub token.
### Set-up your path:
1. In terminal, create a "tools" directory in your home directory: 
`mkdir ~/tools`. 
Note that we are creating a directory in your user directory, not in your Mondo directory (FYI, `~/` refers to your home directory in Mac or Linux systems). This directory can in the future contain various tools, such as ROBOT and scripts necessary for release processes. 
1. Lastly, ensure that your ~/tools directory is added to your path. If you are using zsh (as shown in the terminal window title), create your path: 
   - `nano ~/.zshrc`
   - paste the following line into the file, usually at the very end: `export PATH=/Users/torosa/tools:$PATH`(instead of "/Users/torosa", use your path to the tools directory)
   - save (by hitting control+o and then enter) and close (control+x)
   - in the terminal, type: `source ~/.zshrc`; this reloades the `.zshrc` file. 
   - *Open a new Terminal window before you continue*. 
###  install gh : 
- make sure you have installed 'brew' [here](https://brew.sh/)
- `brew install gh`


# Releases

All release products are described on the [OBO page](http://obofoundry.org/ontology/mondo.html) and [Mondo website](https://mondo.monarchinitiative.org/).

 - the [mondo-with-equivalent](http://purl.obolibrary.org/obo/mondo/mondo-with-equivalents.owl) edition uses OWL equivalence axioms directly in the ontology. Note this makes it harder to browse in some portals, but this edition may be preferable for computational use. The owl edition also includes axiomatization using CL, Uberon, GO, HP, RO, NCBITaxon.
 - the primary release versions (mondo.owl, mondo.obo) are simpler, lacking owl equivalence axioms from Mondo classes to terms from other databases; instead, xrefs are used for linking these terms. If the ID is one of Orphanet, OMIM, DOID or EFO then the xref precisely shadows the equivalence axiom.
- The [mondo-with-equivalents json edition](http://purl.obolibrary.org/obo/mondo/mondo-with-equivalents.json) has all owl equivalencies as well as all xrefs to other disease sources.

The release mondo.owl will look like this in Protege:
![How release looks in Protege](images/release-protege-look.png)

# Mondo release workflow

_Note: While the release is running, don't shut your laptop or switch between repos or branches in GitHub, as this will stop the release._

## Prepare the release
1. Do a docker pull: `docker pull obolibrary/odkfull`
1. Pull master
1. Run command: `cd mondo/src/ontology/` (navigate to folder on your computer)
1. `MEMORY_GB=12 sh run.sh make IMP=false all -B` - note, this takes 1+ hour(s)
1. Make sure you see ‘release finished’ after the command has run
1. Open mondo.owl and mondo.obo and check the latest changes are there and it looks reasonable
1. Run `sh run.sh make prepare_release_direct`
1. Review the file `src/ontology/reports/mondo_release_diff.md`. There is now a new QC section up top, `---START LOG:` to `---END LOG:`. Review the text and _delete it from the file_ if there is no suspicious output.
1. Commit changes to a branch
   1. Create a branch and commit the changes on the branch
   1. Do a pull request (PR)
   1. Wait for GitHub Actions/QC to pass
   1. Merge PR

## Initial Setup:
Make sure the initial setup (see above) has been done:
1. Download the `obo-simple-diff.pl` script to the "tools" directory and set-up your path to the tools directory.
2. Generate token
3. Make sure you have gh installed: `brew install gh`. For other ways to install, see [here](https://github.com/cli/cli). 


## Deploy Release
1. login to GitHub via the command line: `gh auth login`. The command line will give you a series of prompts:

```
? What account do you want to log into? **Answer**: GitHub.com
? What is your preferred protocol for Git operations? **Answer**: HTTPS
? Authenticate Git with your GitHub credentials? **Answer**: Yes
? How would you like to authenticate GitHub CLI? **Answer**: Login with a web browser

! First copy your one-time code: **Note: There will be a code here and you'll need to enter this online**
Press Enter to open github.com in your browser... 
✓ Authentication complete.
- gh config set -h github.com git_protocol https
✓ Configured git protocol
✓ Logged in as nicolevasilevsky
```

1. `cp ~/.token .token`  
1. `make GHVERSION=vYYYY-MM-DD deploy_release` - note, this takes about 30 minutes  
Note- the date should be the date of the release in the format `make GHVERSION=vYYYY-MM-DD deploy_release` (for example, v2022-04-01) (very important: It should not necessarily be today, it is the day the release artifacts were created according to the IRIs. In order to find the right date, open mondo-base.obo and check version IRI, and use this date)
1. Check these the release pages (make sure you replace the date correctly **in the link in the output in the terminal**):
    1. For example: https://github.com/monarch-initiative/mondo/releases/tag/untagged-2a6c39951f3210b62380
    2. Ensure that it says [name] (eg nicolevasilevsky) released this 1 days ago or now
    3. Ensure it has all release artifacts attached to it (there should be 19 assets in the draft. Note, there will be 21 after the release is published.)
    4. Check this file to ensure you see the expected changes (spot check a few changes): download the mondo.obo or mondo.owl from the asset list in the release.
1. Write a description of the release
   1. Add the release description to the release tab: 
       - All of the releases can be found under the [releases](https://github.com/monarch-initiative/mondo/releases) tab.
       - To add a description of the release: 
         - click edit
         - in the 'describe this release' section add the content from the file `src/ontology/reports/mondo_release_diff.md`.
         - click "save draft"
   2. Add the summary of changes to [changes.md](https://github.com/monarch-initiative/mondo/blob/master/Changes.md).
      - go to changes.md
      - click edit
      - add the name of the new release and the content from the change log text file above. 
      - commit to master
   3. Click on "Publish release" (THIS IS NEW, the release, so far should have been in Draft state) 

## Check obsoletion obsoletion candidates

With each release, a TSV should be generated with obsoletion candidates. Check that this tsv file is up-to-date here:
https://github.com/monarch-initiative/mondo/blob/master/src/ontology/reports/mondo_obsoletioncandidates.tsv

## Email Mondo Users
Send an email to Mondo users: mondo-users@googlegroups.com  
(Note - the recipients usually a picture of someone's pet to be included.)

### Subject
Mondo release + obsoletion candidates

### Body

Hello,  

The latest Mondo release is now available here:https://github.com/monarch-initiative/mondo/releases  

Please find a list of terms that are candidates to be obsoleted or merged here: https://github.com/monarch-initiative/mondo/blob/master/src/ontology/reports/mondo_obsoletioncandidates.tsv
  
Note - the proposed obsoletion date is listed in the table.  

If you have an open issue that needs to be prioritized, please email us or comment on the ticket.  

Thanks all,  

Nicole and Sabrina  

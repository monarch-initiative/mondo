# Release process

Mondo is released on a monthly basis around the first of the month. Additional releases are run ad hoc. All Mondo releases are available [here](https://github.com/monarch-initiative/mondo/releases).

Videos outlining this process are available [here](https://www.youtube.com/watch?v=LfOnrnCCnmI).

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
For other ways to install, see [here](https://github.com/cli/cli).  
### dowload diff-generator tools:
1. Download the `obo-simple-diff.pl` script to the "tools" directory
      1. go into the tools directory
      2. type `wget https://github.com/cmungall/obo-scripts/blob/master/obo-simple-diff.pl`
      3. Note that if you have a new computer, you might need to install 'wget' using `brew install wget`
          1. you can see whether you have wget installed by taping `wget -V`. If it is installed, the version will be reported 




# Mondo release workflow

_Note: While the release is running, don't shut your laptop or switch between repos or branches in GitHub, as this will stop the release._

## Prepare the release  
1. Pull master, create a branch, and navigate to the `mondo/src/ontology` folder on your computer
1. **Run command: `sh run.sh make IMP=false all -B`** 
    - note, this takes 1+ hour(s)
    - note that we are using the dev image as it is always up to date with the Python dependencies.
1. Review before the next step:
    1. Make sure you see ‘release finished’ after the command has run
    1. Open mondo.owl and mondo.obo and check the latest changes are there and it looks reasonable
1. **Run `sh run.sh make prepare_release_direct`**
    1. reports files will be created after running this command.
1. Commit changes to a branch
    1. Commit the changes on the branch (you should already be on a branch)
    1. Do a pull request (PR)
    1. Wait for GitHub Actions/QC to pass
    1. Review PR (see "Review release PR" below)
    1. Merge PR


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
       - make sure you are in the `src/ontology` folder when running the above command   
       - the date should be the date of the release in the format `make GHVERSION=vYYYY-MM-DD deploy_release` (for example, v2022-04-01) (very important: It should not necessarily be today, it is the day the release artifacts were created according to the IRIs. In order to find the right date, open mondo-base.obo and check version IRI, and use this date)
1. Check these the release pages (make sure you replace the date correctly **in the link in the output in the terminal**):
    1. For example: https://github.com/monarch-initiative/mondo/releases/tag/untagged-2a6c39951f3210b62380
    2. Ensure that it says [name] (eg nicolevasilevsky) released this 1 days ago or now
    3. Ensure it has all release artifacts attached to it (there should be 22 assets in the draft. Note, there will be 24 after the release is published.)
    4. Check this file to ensure you see the expected changes (spot check a few changes): download the mondo.obo or mondo.owl from the asset list in the release.
1. Write a description of the release
    1. Add the release description to the release tab:
          - All of the releases can be found under the [releases](https://github.com/monarch-initiative/mondo/releases) tab.
          - To add a description of the release (see "Release description" section)
         - click "save draft"
1. Click on "Publish release"

## Record release statistics
Statistics related to each release are recorded on the main Mondo website and on an internal spreadsheet
### update the statistic spreadsheet
1.  run the ["Generate GitHub Issue Statistics" Action](https://github.com/monarch-initiative/mondo/actions/workflows/github-issue-stats.yml) to get statistics between the last and the new release. See also [here](https://mondo.readthedocs.io/en/latest/developer-guide/release-stats/#:~:text=Commuity%20Statistics%20reports.-,Usage,-%3A)
    1. the number of newly created and closed user requests are reported in this report
1. Update [this spreadsheet](https://docs.google.com/spreadsheets/d/1TGD1ta2RyoLMvAne1dp-b3LTj6b5Y_jTvsz04HPHmEk/edit?gid=1836451386#gid=1836451386) with the information from the "release_announcement_*.md" file (see "Generate the release description" section) and from the statistic report above.

### update the Mondo website with the latest statistics 

This must be done AFTER the release is completed!

1. Go [here](https://github.com/monarch-initiative/mondo/actions/workflows/update-stats-mondo-web.yaml)
2. Hit "Run workflow" (from `master`)
3. Wait until PR is created, sanity check, merge


# Announcement 

### Email Mondo Users
- Mondo announcement email is created using a google template and sent to Mondo users: mondo-users@googlegroups.com  
(Note - the recipients usually a picture of someone's pet to be included.)
1. Subject: The <INSERT-MONTH> Mondo release is available
1. Update the Mondo release template with highlights of the releases, upcoming changes coming, announcements, etc.



## How to

### Review release PR

Check the following:

1. There should be about 106 files changed (at least over 100 files changed)

2. Compare the file list for the new release compared to a previous successful release and make sure each generally have the same files included in the PR

3. Review the contents of these files:

    1. reports/basic-report.tsv 
        - Make sure the number of MONDO classes has increased since the last release and that any other number changes make sense (generally any change should reflect an increase since the previous release)
    2. reports/obsoletion_candidates.tsv
        - Make sure the newly added obsoletion candidates total new additions is the same number of all terms from the google sheet (obsolete, split, merge) candidates
    3. src/ontology/mappings/*
        - Quick look to make sure all dates are updated to the Mondo release date in the file
    4. src/ontology/reports/mondo_obsoletioncandidates.tsv
        - Make sure the newly added obsoletion candidates total new additions is the same number of all terms from the Candidates for Obsoletion google sheet [here](https://docs.google.com/spreadsheets/d/1h8_3g4GWzFyC0jhvCVFBx6CTd6PUBsHCoZ-HX1iCQvQ/edit?gid=848705321#gid=848705321) (obsolete, split, merge) candidates

#### Check obsoletion candidates

With each release, a TSV should be generated with obsoletion candidates. Check that this tsv file is up-to-date here:
https://github.com/monarch-initiative/mondo/blob/master/src/ontology/reports/mondo_obsoletioncandidates.tsv

### Generate the release description

Every release include a description of main changes made in the ontology, included, though not limited to: the list of new terms added, new or updated labels and definitions, obsoleted/merged terms.

We have 2 files reporting the difference between the new release and the previous one. These files were created at different time in Mondo history, and have similar information, though in different format (and different level of details): 
    - `src/ontology/reports/mondo_release_diff.md` 
       - This file include a summary of the new terms, updated definition, new obsoletion, etc...
       - There is a QC section up top, `---START LOG:` to `---END LOG:`. 
       - this file is 'gitignore', ie one only sees it if they are the one running the release.
    - `src/ontology/reports/difference_release_base.md`
       - similar to the file above, this file include new terms, updated definition, etc, but also update in mappings, subclass of, subsets, etc.
       - the format of this files allows for open/close sections in the GH/Markdown format
       - titles are jargony (eg "nodes" to refer to "terms")
       - some sections are not be added as they are confusing (e.g. mappings update, change in SubClasses,etc.)

1. create the release description by using the Claude-Code skill "release-announcement"
1. review the created report by comparing with the information in the diff-files mentioned above (note that, since the diff files are slightly different, the information reported in them is also slightly different. For example, one file include ALL the changes in definition (including definition to newly created terms) while the other does not. 
1. !!! do not include the summary table at the top of the Claude-code created report to the release description.



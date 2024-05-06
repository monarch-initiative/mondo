# SOP Splitting Terms

## Overview of workflow

1. Identify a term that should be split. 
1. If the term should be split into two new terms, assign
the new ID for that term in advance.
1. Check to see if the term is being used by EFO, ClinGen or other users, where 
possible.
1. Notify users of the the users that the term will be split.
1. If there are no objections, make the changes after two release cycles have
passed.
1. The workflow involves two steps:
  1. Create new terms and IDs for the term that will be split.
  1. Obsolete and merge the existing term into the new term.
  
## Example:
OMIM may rename a disease from FOO to FOO 1, and create a new phenotypic series (PS) with the name FOO. (For an example, see [OMIM:606176 Diabetes mellitus, permanent neonatal 1](https://www.omim.org/entry/606176), which is part of the phenoypic series [PS606176 Diabetes mellitus, permanent neonatal](https://www.omim.org/phenotypicSeries/PS606176) and the respective Mondo ticket [#1803](https://github.com/monarch-initiative/mondo/issues/1803). In this case, we should follow the [Splitting a more specific term into a more generic term workflow](https://mondo.readthedocs.io/en/latest/editors-guide/splitting-classes/#splitting-a-more-specific-term-into-a-more-generic-term).

## Workflow:

1. Add the label FOO and FOO1 to the [ROBOT_CreateNewTerm Template](https://docs.google.com/spreadsheets/d/1tt1Wk70j9XiHLV1vKQyNiHhaazh286pobpJk1ecSCCg/edit#gid=2063035843.)
1. Add obsoletion tag to FOO via the [ROBOT_NewTermSplit-ObsTag](https://docs.google.com/spreadsheets/d/1tt1Wk70j9XiHLV1vKQyNiHhaazh286pobpJk1ecSCCg/edit#gid=1242007499) and via instructions in [Merge a ROBOT template into Mondo](https://mondo.readthedocs.io/en/latest/editors-guide/robot-template/).
1. At the time of the release, generate the sparql report for obsoletion candidates and share with the Mondo users list.
1. After two release cycles have passed, obsolete and merge the terms.
  

## Detailed Workflow

### Add obsoletion tags to terms to be split
1. Identify a term that should be split. 
1. If the term should be split into two new terms, assign
the new ID for the new terms in advance by adding the label to this [ROBOT template](https://docs.google.com/spreadsheets/d/1tt1Wk70j9XiHLV1vKQyNiHhaazh286pobpJk1ecSCCg/edit#gid=2063035843).
1. Add the obsoletion tags to the terms to be obsoleted:
1. In [ROBOT_NewTermSplit-ObsTag](https://docs.google.com/spreadsheets/d/1tt1Wk70j9XiHLV1vKQyNiHhaazh286pobpJk1ecSCCg/edit#gid=1242007499):
- add the IDs for the terms to be obsoleted in column A
- add the labels in column B (for human readability)
- the labels in column E should be automatically populated from the [ROBOT_CreateNewTerm](https://docs.google.com/spreadsheets/d/1tt1Wk70j9XiHLV1vKQyNiHhaazh286pobpJk1ecSCCg/edit#gid=2063035843)
template
- add a link to the GitHub ticket in column G
1. Follow the instructions to [Merge a ROBOT template into Mondo](https://mondo.readthedocs.io/en/latest/editors-guide/robot-template/).
1. At the time of the release, generate the sparql report for obsoletion candidates and 
share with the Mondo users list: 
1. In terminal, run `sh run.sh make report-obsoletioncandidates-withcomment`
1. The report will be in the src/sparql/reports folder

### Tips
- Tip 1: If you want to look a the report quickly, type in Terminal `atom reports/report-disease-labeled-terms.tsv`. This will open it in Atom.
- Tip 2: In Terminal, `open reports` - this will open the file in Finder.

## Split Terms

1. When we're ready to split the terms, we need to add the new terms to Mondo, that the old terms will be merged into.
1. Follow the instructions to [Merge a ROBOT template into Mondo](https://mondo.readthedocs.io/en/latest/editors-guide/robot-template/) with the [ROBOT_CreateNewTerm](https://docs.google.com/spreadsheets/d/1tt1Wk70j9XiHLV1vKQyNiHhaazh286pobpJk1ecSCCg/edit#gid=2063035843)
template.
1. Follow the instructions for [splitting classes](https://mondo.readthedocs.io/en/latest/editors-guide/splitting-classes/).
1. If terms are to be obsoleted and merged into new classes, follow the instructions [here](https://mondo.readthedocs.io/en/latest/editors-guide/merging-and-obsoleting/#merge-using-owltools).

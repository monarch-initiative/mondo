# Mass obsoletion pipeline

## Curator Branch Review

1. In this [spreadsheet](https://docs.google.com/spreadsheets/d/1xTfYCOCGKx_svNT8PirgGDiCINV7IDqzhBk76DNe150/edit#gid=0), there are branches with children that are prioritized for obsoletion.
2. Each branch has a corresponding GitHub ticket and an assigned curator (assigned in GitHub) and a corresponding spreadsheet that lists terms that will either be:
  - orphaned
  - leave the branch
  - stay in the branch
3. For each term that will be orphaned, create the following columns:

Label for the parent	| parent class |	source |	PMID |	Curator confidence
--- | --- | --- | --- | --- |
|	SC % |	>A oboInOwl:source | |	| 


### Review and reassign superclasses to orphaned terms

1. review terms that will become orphaned when the terms are mass obsoleted
2. assign a new parent to each term
3. See [video here]() for more detail_dystonias
4. Share the spreadsheet with another curator for review, if needed
5. Nicole, Trish or Sabrina should proceed with Mass obsoletion pipeline

### Mass obsoletion pipeline

#### 1. Add new parents to orphaned superclasses

1. Add new parents via ROBOT template
2. See example template [here](https://docs.google.com/spreadsheets/d/1KUYvnB1VVBV7KwbKipxvgNLX9FQC0aeaPn3kaxzz92g/edit#gid=834522600)

#### 2. Mass obsolete TermsMerged
1. Go to relevant GitHub ticket (for example, [https://github.com/monarch-initiative/mondo/issues/6739](https://github.com/monarch-initiative/mondo/issues/6739))
2. copy and paste the table into a new tab in the spreadsheet (for example, see [here](https://docs.google.com/spreadsheets/d/1KUYvnB1VVBV7KwbKipxvgNLX9FQC0aeaPn3kaxzz92g/edit#gid=36625823))
3. Create a new column with the CURIES (see column C)
4. Create a new file in mondo/src/ontology/config/ named `obsolete_me.txt`
5. Copy and paste the CURIES into `obsolete_me.txt` and save
6. Run `sh run.sh make mass_obsolete2 -B`
7. (Optional) Open in Protege and make sure everything looks okay


##### 2a. Add the term tracker item to the obsoleted terms

1. Create a ROBOT template to add the term tracker item to the obsoleted terms (see example [here](https://docs.google.com/spreadsheets/d/1KUYvnB1VVBV7KwbKipxvgNLX9FQC0aeaPn3kaxzz92g/edit#gid=36625823))
2. Run ROBOT command to add term tracker intermediate

##### 2b. Review changes in Protege

1. Check the branch and review changes for obsoleted terms and orphaned terms. Spot check a few terms.
2. Run the reasoner and make sure there are no unsatisfiable classes.
3. Commit changes and creat a PR and assign another curator to review

## Review PR

1. See review spreadsheet [here](https://docs.google.com/spreadsheets/d/1zklQAnU_zHUphFAI4AYzwzwg1dj59o_RNfC4jg9VIzo/edit#gid=0)


# Mass obsoletion pipeline

## Summary

The goal of this project is to clean up the hierarchy in Mondo and remove Orphanet grouping classes that are causing unwanted classifications in Mondo.

**Justification**: Orphanet takes a different approach to classification compared to Mondo, where many disease entities are grouped together based on phenotypic features. This is causing some incorrect inferences in Mondo. 

**Approach**: The approach is to obsolete many of the Orphanet grouping classes and review the resulting hierarchy to ensure proper classification of the children. This will be an incremental and iterative approach. An overview of the approach is:

1. [review potential obsoletion candidates](../editors-guide/mass-obsoletion/#review-proposed-obsoletion-candidates)
2. tag terms for obsoletion and share obsoletion candidates with community and wait at least two months for feedback
3. Review proposed obsoletion candidates
4. Mass obsoletion pipeline

### Relevant tickets
- [review ORDO grouping classes #5114](https://github.com/monarch-initiative/mondo/issues/5114)
- [Remove all terms for which the single source of evidence is ORDO #5853](https://github.com/monarch-initiative/mondo/issues/5853)
- [Remove unsupported associations #5857](https://github.com/monarch-initiative/mondo/issues/5857)

## Review potential obsoletion candidates

1. the tab [candidates.tsv](https://docs.google.com/spreadsheets/d/1e8S9sjE2kmnCOvmqI98CQ7HJoSPh8HyV9CEP4ysI07I/edit#gid=2039272934) has grouping classes, that have xrefs to ORDO and do not have any xrefs from any other external source 
2. Mondo curators (Nicole and Sabrina) did a first pass at reviewing this list and made a call if it would be okay to obsolete the term or if it should be ‘rescued’ meaning that we should not obsolete it right now, but we should revisit it later and consider obsoleting it
3. reasons for ‘rescuing’ a term varied and are noted in the column J
4. Nicole and Sabrina both looked at all the terms and noted if we agreed or disagreed if a term should be obsoleted (and if we disagreed, we rescued it and we’ll revisit it later)
5. any term that was marked for obsoletion, we added obsoletion tags (see documentation [here](https://mondo.readthedocs.io/en/latest/editors-guide/merging-and-obsoleting/#workflow)) to obsolete those classes in 2 months from the date we added the tag (for this initial round, the obsoletion dates were either 2023-09-01 or 2023-10-01)
6. When the work below is done (review proposed obsoletion candidates and mass obsoletion pipeline), we need to go back and re-review all of the rescued terms and determine if they should be obsoleted and do this process again.

## Review proposed obsoletion candidates

## Curator Branch Review

1. In this [spreadsheet](https://docs.google.com/spreadsheets/d/1xTfYCOCGKx_svNT8PirgGDiCINV7IDqzhBk76DNe150/edit#gid=0), there are branches with children that are prioritized for obsoletion.
2. Each branch has a corresponding GitHub ticket and an assigned curator (assigned in GitHub) and a corresponding spreadsheet that lists terms that will either be:

    - orphaned  
    - leave the branch  
    - stay in the branch  
  
3. For each term that will be orphaned, create the following columns in the spreadsheet (if it has not been done already):

Label for the parent	| parent class |	source |	PMID |	Curator confidence
--- | --- | --- | --- | ---
|	SC % |	>A oboInOwl:source | | 

### Review and reassign superclasses to Orphaned terms

1. review terms that will become orphaned when the terms are mass obsoleted
2. assign a new parent to each term
3. See [video here](https://drive.google.com/file/d/1Be2Uh3bi-ni8bUOTlhxn6YvD31bEsDgX/view) for more details
4. Share the spreadsheet with another curator for review, if needed
5. Nicole, Trish or Sabrina should proceed with Mass obsoletion pipeline

### Mass obsoletion pipeline

#### 1. Add new parents to orphaned superclasses

1. Add new parents via ROBOT template
2. See example template [here](https://docs.google.com/spreadsheets/d/1KUYvnB1VVBV7KwbKipxvgNLX9FQC0aeaPn3kaxzz92g/edit#gid=834522600)

#### 2. Mass obsolete Terms
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

1. Check the branch and review changes for obsoleted terms and orphaned terms:
    - Spot check a few terms to ensure they were properly obsoleted and have the correct Annotations
    - spot check a few terms to make sure they are assigned the correct parent (per the ROBOT template) and they have the correct source annotation(s)
    - check the top level disease branch to ensure there are only two subclasses: 'human disease' and 'non-human disease' (if there are any other classes under there, assert new superclasses to that term. Note in the PR if you are uncertain abou the superclass assertion and would like additional review)
2. Run the reasoner and make sure there are no unsatisfiable classes.
3. Commit changes and create a PR and assign another curator to review

## Review PR

1. See review spreadsheet [here](https://docs.google.com/spreadsheets/d/1zklQAnU_zHUphFAI4AYzwzwg1dj59o_RNfC4jg9VIzo/edit#gid=0)


## Merging and Obsoleting Classes

### Overview

1. Mondo users need to be notified before we obsolete, merge or [split](https://mondo.readthedocs.io/en/latest/editors-guide/splitting-classes/) a Mondo class.
1. If there is a request to obsolete a Mondo class, [Monarch Initiative](https://monarchinitiative.org/) to determine if the disease term is used for Monarch annotations. For example, [discitis](https://monarchinitiative.org/disease/MONDO:0006728) (see ticket [here](https://github.com/monarch-initiative/mondo/issues/501)) does not have any annotations in Monarch. (_This is something that we hope to automate in the future_).
3. If a term is to be obsoleted, in a new row in the [ROBOT_ObsoleteTag spreadsheet template](https://docs.google.com/spreadsheets/d/1tt1Wk70j9XiHLV1vKQyNiHhaazh286pobpJk1ecSCCg/edit#gid=505727337), add the following information for the term-to-be-obsoleted:
    1. ID for term to be obsoleted 
    1. Label for term to be obsoleted 
    1. seeAlso: GitHub ticket that describes the obsoletion request
    1. Consider: the replacement term that should be considered for use after the term is obsoleted. If there is no replacement, leave it blank.
    1. Obsoletion reason: chose from dropdown list.
    1. Comment: do not add free text here. Copy and paste the formula from the row above so the comment is consistently structured.
    1. Obsoletion candidate subset: This should always be http://purl.obolibrary.org/obo/mondo#obsoletion_candidate
    1. obsoletion date: should be a release date at the first of the month, at least two months from today. Please write in the format YYYY-MM-DD.
4. If a term is to be merged, in a new row in the [ROBOT_MergeTag spreadsheet template](https://docs.google.com/spreadsheets/d/1tt1Wk70j9XiHLV1vKQyNiHhaazh286pobpJk1ecSCCg/edit#gid=1109324509), add the information above, and in addition, add:
    1. Mondo ID for the term that will replace the obsoleted terms
    1. Label for the term that will replace the obsoleted terms

#### Monthly (before release)
1. Run the pipeline to [merge the ROBOT template](https://mondo.readthedocs.io/en/latest/editors-guide/robot-template/) and commit and merge the PR into mondo-edit.obo.
3. Run the [risky_obsoletion_check](https://mondo.readthedocs.io/en/latest/editors-guide/risky_obsoletion_check) pipeline to check if external ontologies and databases (such as EFO and ClinGen) are using this Mondo term.
  - if so, create a ticket on the [EFO tracker](https://github.com/EBISPOT/efo/issues) and notify ClinGen users (_for now, email Larry Babb_).
1. Perform a SPARQL query to identify all the obsoletion candidates (see instructions [here](https://mondo.readthedocs.io/en/latest/editors-guide/generate-report/#how-to-generate-reports)). The command to run the query is: `sh run.sh make report-query-obsoletioncandidates-withcomment`. This will be the report that will be shared with Mondo users to inform them of upcoming obsoletions.
1. Share the report on the Mondo users email list (include the file as an attachment) and/or share the report (tsv file) on GitHub [here](https://github.com/monarch-initiative/mondo/tree/master/reports/obsoletion-candidates).
1. Allow for at least one month after sending the report or contacting users before obsoleting the terms to allow users time to comment.

### How to
There are 3 ways to merge classes:

* Manually (not recommended)
* Using the Protege merge tool (not yet released)
* Using owltools

Until the Protege merge tool is ready it is preferred to make merge requests using owl tools via Nicole and Sabrina. You will need to have Docker installed and running (see instructions [here](https://mondo.readthedocs.io/en/latest/editors-guide/set-up-new-computer/#set-up-docker)). This should be done in plain text, either csv or tsv. Two columns (or optionally 4 columns with labels):

1. CURIE of class to be obsoleted
1. CURIE of replacement class

These are then merged like this:

```
owltools mondo-edit.obo  --obsolete-replace MONDO:0000267 MONDO:0015264 --assert-inferred-subclass-axioms --markIsInferred --removeRedundant -o -f obo new.obo
diff mondo-edit.obo new.obo
mv new.obo mondo-edit.obo
```

Note this can frequently lead to cycles and equivalence between named class pairs, as many seemingly identical classes have different implicit semantics.

Note: if you add an obsoletion reason, make sure that the replaced class does not have an alt_id assertion. If so, remove that before committing.

## Merge terms

### Merge using owltools

1. Create a branch and name it issue-### (for example issue-2864)
1. Open Protege
1. Prepre the owltools command:
`owltools --use-catalog mondo-edit.obo  --obsolete-replace [CURIE 1] [CURIE 2] -o -f obo mondo-edit.obo`  

CURIE 1 = term to be obsoleted  
CURIE 2 = replacement term (ie term to be merged with)

For example:
If to merge MONDO:0023052 ectrodactyly polydactyly with MONDO:0009156 ectrodactyly-polydactyly syndrome, the command is: 

`owltools --use-catalog mondo-edit.obo  --obsolete-replace MONDO:0023052 MONDO:0009156 -o -f obo mondo-edit.obo`

_Recommended_: Use this [template](https://docs.google.com/spreadsheets/d/1tt1Wk70j9XiHLV1vKQyNiHhaazh286pobpJk1ecSCCg/edit#gid=1265889881) to track the terms to be mergd. There is a formula in column G, copy from the row above.
_Note_: the Mondo ID in columns A and C must be in CURIE format (use a colon, not an underscore)  

1. In Terminal, navigate to ..mondo/src/ontology
1. Run your owltools command
1. Check the output in GitHub desktop
1. Open a new version of mondo-edit.obo in Protege
1. Search for the term that was obsoleted
1. Add SeeAlso with a link to the GitHub issue that requested the obsoletion.
1. Add an obsoletion reason: use the annotation property 'has obsolescence reason' and write 'terms merged' in the literal field.
1. Search for the 'term replaced by' term
1. Delete the old ID
1. Review the annotations to ensure there are no duplicate annotations. If there are, they should be merged.
1. If there are duplicate dbxrefs that are annotated as MONDO:equivalentTo (ie two OMIM xrefs), the dbxref from the obsolete class should be annotated as MONDO:obsoleteEquivalent 
1. Review the subClassOf assertions, and make sure there are no duplicates. If there are, they should be merged.
1. When reviewing the diff, make sure there is not an Alt ID. The diff should only show additions to the merged term and the obsoletion

### Manual merge/obsolete
1. If one class should be merged with another class, first obsolete the class that will be merged.
1. Search for the class to be obsoleted
1. Rename label to: obsolete [class name]
1. Add annotation **owl:deprecated** and indicate true (in literal)
1. Add annotation **term replaced by** and add ID of term which replaced it (in CURIE format, such as MONDO:0010684). If the disease term is being obsoleted and an HPO term should be used instead, do not use **term replaced by**, rather use the annotation **consider.** For example, see MONDO:0001445.
1. Add an obsoletion reason: use the annotation property 'has obsolescence reason' and chose an individual reason (click on Entity IRI and select a reason from the list. If there is not a valid reason in the list, add it as an individual, or manually write in a reason as a string.)
1. Add SeeAlso with a link to the GitHub issue that requested the obsoletion.
1. Remove superclass axioms
1. If the class has children, remove the superclass assertion for the children 
1. Example: ![Manual merge example 1](images/github-workflow-manual-merge-1.png)
1. Move all the synonyms to the new term. 
1. Move all the **database_cross_references** to the new term.
1. If applicable, to mark the synonym as deprecated, add an annotation to the synonym: has_synonym_type ‘A synonym that is historic and discouraged’. See granulomatosis with polyangiitis for examples of deprecated syn axiom annotations
1. It is a good idea to add a reason for obsoletion to the class. This can be added as a **comment** or add **seeAlso** and add a link to the GitHub ticket.

Note: A Mondo obsolete class should not have an xref axiom tagged with "MONDO:equivalentTo". Instead use "MONDO:obsoleteEquivalent" to map between an obsolete MONDO class and a live entry in another resource (these serve as a kind of flag of a state of inconsistency).

## Obsolete a class (without merging)

### Obsolete a class (using Protege 'Make entity obsolete' function)
1. Search for the class to be obsoleted.
1. In the Protege edit menu-> Make entity obsolete
1. Add annotation 'has obsolescence reason' and either add an individual or add free text in the literal box, if there is not a suitable individual. (To add an individual, click the 'Entity IRI' tab, then click Individuals)
1. Add SeeAlso with a link to the GitHub issue that requested the obsoletion.
1. If the term has **database_cross_reference annotations** and the **source** is annotated as MONDO:equivalentTo, change the source to **source** MONDO:obsoleteEquivalent (in the literal tab). Obsolete terms should never be equivalent.
1. Add annotation consider, add the CURIE for the term that should be considered as a replacement.

### Obsolete a class (manually)
1. Search for the class to be obsoleted.
1. Rename label to: obsolete [class name].
1. Add annotation **owl:deprecated** and indicate true (in literal).
1. Add annotation 'has obsolescence reason' and either add an individual or add free text in the literal box, if there is not a suitable individual. (To add an individual, click the 'Entity IRI' tab, then click Individuals)
1. Add SeeAlso with a link to the GitHub issue that requested the obsoletion.
1. Remove superclass axioms.
1. If the class has children, remove the superclass assertions for the children.
1. If the term has **database_cross_reference annotations** and the **source** is annotated as MONDO:equivalentTo, change the source to **source** MONDO:obsoleteEquivalent (in the literal tab). Obsolete terms should never be equivalent.

## When to obsolete / merge

If a term is a candidate for obsoletion and/or merging, this should be reported on the [GitHub issue tracker](https://github.com/monarch-initiative/mondo/issues) and labeled 'obsolete'. Click [here](https://github.com/monarch-initiative/mondo/issues?q=is%3Aissue+is%3Aopen+label%3Aobsolete) for potential terms to be obsoleted.

Some examples of when to obsolete and/or merge a term are:  

- **Duplicate terms** (for example MONDO:0019055 mitochondrial disease was obsoleted and replaced by MONDO:0004069 'inborn mitochondrial metabolism disorder')  
- **Out of scope**- Terms that are not truly diseases, (ie phenotype terms, such as MONDO:0007348 Colchicine resistance). For another example, see [see #503](https://github.com/monarch-initiative/mondo/issues/503)  
- **obsoleted in source**: for example, OMIM, Orphanet or GARD may retire or obsolete a term. For example, MONDO:0015173 obsolete autoimmune enteropathy type 2
is a phenotype and not a disease: for example, MONDO:0043606 'obsolete pathologic fracture'

Issues should remain open for at least two weeks to allow for the community to comment and bring up any objections. All obsoletions will be done via a pull request and reviewed by Mondo developers.

See [GitHub Discussion](https://github.com/monarch-initiative/mondo/discussions/2765) on Obsoletions

by Nicole Vasilevsky and Sabrina Toro _updated 2021-09_28_

## Merging and Obsoleting Classes

There are 3 ways to merge classes:

* Manually (not recommended)
* Using the Protege merge tool (not yet released)
* Using owltools

Until the Protege merge tool is ready it is preferred to make merge requests via Chris. This should be done in plain text, either csv or tsv. Two columns (or optionally 4 columns with labels):

1. CURIE of class to be obsoleted
1. CURIE of replacement class

These are then merged like this:

```
owltools mondo-edit.obo  --obsolete-replace MONDO:0000267 MONDO:0015264 --assert-inferred-subclass-axioms --markIsInferred --removeRedundant -o -f obo new.obo
diff mondo-edit.obo new.obo
mv new.obo mondo-edit.obo
```

Note this can frequently lead to cycles and equivalence between named class pairs, as many seemingly identical classes have different implicit semantics.

## Manual merge/obsolete

by Nicole Vasilevsky 08/31/18

1. If one class should be merged with another class, first obsolete the class that will be merged.
1. Search for the class to be obsoleted
1. Rename label to: obsolete [class name]
1. Add annotation **owl:deprecated** and indicate true (in literal)
1. Add annotation **term replaced by** and add ID of term which replaced it (in CURIE format, such as MONDO:0010684). If the disease term is being obsoleted and an HPO term should be used instead, do not use **term replaced by**, rather use the annotation **consider.** For example, see MONDO:0001445.
1. Remove superclass axioms
1. If the class has children, remove the superclass assertion for the children 
1. Example: ![Manual merge example 1](images/github-workflow-manual-merge-1.png)
1. Move all the synonyms to the new term. 
1. Move all the **database_cross_references** to the new term.
1. If applicable, to mark the synonym as deprecated, add an annotation to the synonym: has_synonym_type ‘A synonym that is historic and discouraged’. See granulomatosis with polyangiitis for examples of deprecated syn axiom annotations
1. It is a good idea to add a reason for obsoletion to the class. This can be added as a **comment** or add **seeAlso** and add a link to the GitHub ticket.

Note: A Mondo obsolete class should not have an xref axiom tagged with "MONDO:equivalentTo". Instead use "MONDO:obsoleteEquivalent" to map between an obsolete MONDO class and a live entry in another resource (these serve as a kind of flag of a state of inconsistency).

## Obsolete a class (without merging)
1. Search for the class to be obsoleted.
1. Rename label to: obsolete [class name].
1. Add annotation **owl:deprecated** and indicate true (in literal).
1. Remove superclass axioms.
1. If the class has children, remove the superclass assertions for the children.
1. If the term has **database_cross_reference annotations** and the **source** is annotated as MONDO:equivalentTo, change the source to **source** MONDO:obsoleteEquivalent (in the literal tab). Obsolete terms should never be equivalent.

## When to obsolete / merge

If a term is a candidate for obsoletion and/or merging, this should be reported on the [GitHub issue tracker](https://github.com/monarch-initiative/mondo/issues) and labeled 'obsolete'. Click [here](https://github.com/monarch-initiative/mondo/issues?q=is%3Aissue+is%3Aopen+label%3Aobsolete) for potential terms to be obsoleted.

Some examples of when to obsolete and/or merge a term are:  

- **Duplicate terms** (for example MONDO:0019055 mitochondrial disease was obsoleted and replaced by MONDO:0004069 'inborn mitochondrial metabolism disorder')  
- **Terms that are not truly diseases** (ie phenotype terms, such as MONDO:0007348 Colchicine resistance)  

Issues should remain open for at least two weeks to allow for the community to comment and bring up any objections. All obsoletions will be done via a pull request and reviewed by Mondo developers.

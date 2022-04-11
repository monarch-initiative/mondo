# Mondo Changelog Metadata Schema 

## Glossary:

Term | Definition
-- | --
Deprecated term | A term that should not be used anymore. Technically, "deprecated" means: "still in use but will be removed soon" ([cite](https://stackoverflow.com/questions/9208091/the-difference-between-deprecated-depreciated-and-obsolete/9208164#:~:text=Deprecated%20means%20that%20it%20is,already%20out%2Dof%2Duse.)), like our "obsoletion candidate". But due to the property owl:deprecated, "deprecated" in the ontology world is used synonymous with "obsolete". To avoid confusion, use "obsolete" instead.
Obsoleted term | A term that should not be used anymore and has been removed from the logical structure of the ontology. For provenance purpose, such terms live on in the ontology file outside the class hierarchy, denoted with owl:deprecated "true".
Active term | A term that active in the ontology, i.e. part of the logical classification.
Obsoletion candidate term | A term that is proposed for obsoletion in the future, but still active.
Born obsolete | These are terms that didn't previously exist, but they are added because they are "in scope" (refer to diseases), but are against Mondo's curation rules. For example, see [issue #4525](https://github.com/monarch-initiative/mondo/issues/).

 As part of a release of the Mondo Disease Ontology, we produce three files that document key changes between the new release and the previous release:

1.  Record of obsoletion candidates: a table that documents the terms that are still active, but proposed for obsoletion in the future.
2.  Record of changes to ontology terms: a table that documents changes of key metadata elements to active and obsolete terms in the ontology.
3.  Record of new terms: a table that documents terms that were not present in the previous release and have been added to the current release.

In the following, we formally define the contents of these files in the form of a contract, the "Mondo Changelog Metadata Contract". That means that our users can rely on this structure for automatic processing.

Record of [obsoletion candidates](http://purl.obolibrary.org/obo/mondo/mondo_obsoletioncandidates.tsv)
-------------------------------

-   No MONDO term should appear more than once in this list.
-   The records in the planned obsoletion or obsoletion candidate file represent the unique set of all MONDO terms (ids/labels) who are still active at the time of the release, but are scheduled for obsoletion in the future
-   The git issue(s) and planned date are required.
-   The planned date may change from release to release.
-   Multiple related git issues should be separated by the "|" (pipe) character.
-   When a MONDO term is removed from the list it may be caused either by the fact that it has been "Obsoleted" or simply "Not an Obsoletion Candidate Anymore". 

[Changed Term records](http://purl.obolibrary.org/obo/mondo/mondo_release_diff_changed_terms.tsv)
--------------------

-   The records in the changed terms file represent the property values that have changed for a given MONDO term in a release (compared with the previous release).
-   Only specific core properties are tracked for changes, see below. The changed term table does not reflect the complete set of changes to Mondo terms (i.e. changes with regard to to other properties).
-   Each record in this file MUST have a unique MONDO id + property combination of values.
-   The previous (old) and new value of the given property on a given MONDO term are included in each record. 
-   The 4 properties being tracked are "**label**", "**definition**", "**obsolete**" flag, and "**obsoletion_candidate**" flag. 
    - "**label**" - the previous (old) value of the mondo label and the new value. 
      - This will include ANY change to the label including when the "obsolete" term is prepended at the time a MONDO term is actually obsoleted in a given release. 
      - Both old and new values are required (labels cannot be blank or empty). 
      - While the obsolete = TRUE state is the computably definitive way to determine if a term is obsoleted, we should reasonably expect all obsoleted terms to have a label change.
    - "**definition**" the previous (old) value of the mondo definition and the new value. 
      - This will include ANY change from typographic or minor editing to complete rewrites or removals.
    - "**obsoletion_candidate**" flag.
      - term is a boolean flag that changes from 
        - blank (or FALSE) to TRUE when a MONDO term is added to the obsoletion candidate list. 
        - TRUE to blank (or FALSE) when a MONDO term is removed from the obsoletion candidate list
      - Records that remain on the obsoletion candidate for several releases would not have a changed "obsoletion_candidate" flag value until they are obsoleted or removed for the candidate list without being obsoleted at which time the obsoletion_candidate flag would change from TRUE to blank (or FALSE).
    - "**obsolete**" flag term is a boolean value that changes from blank (or FALSE) to TRUE when a MONDO term is obsoleted in a given release. Blank and FALSE mean the same thing (the term is NOT obsoleted), but they are represented differently in the ontology: blank means, no owl:deprecated annotation, false means, owl:deprecated false. The latter case does not happen in practice intentionally, but it can happen by accident. 
      - If a MONDO term is ever "un-obsoleted" the values would change from TRUE to blank (or FALSE) - but this use case is yet to be observed in practice.   
      - Any MONDO term that is obsoleted (new value = TRUE) should have a corresponding change in the obsoletion_candidate flag value from TRUE to blank (or FALSE) if the MONDO term was on the candidate obsoletion list in a prior release (i.e. a term MUST NOT be obsolete and an obsoletion candidate at the same time). 
      - When a MONDO term is obsoleted the "label" property will be changed to have a prepended "obsolete" term prepended to the previous value of the label.

[New Term records](http://purl.obolibrary.org/obo/mondo/mondo_release_diff_new_terms.tsv)
----------------

-   No MONDO Id in the New Term records table have been present in the previous or any of the previous releases (i.e. are new)
-   No MONDO id appears in more than two records.
-   The MONDO id MUST NOT be in either of the other two files (changed terms and obsoletion candidate terms). 
-   MONDO id, label, definition, obsolete flag and obsoletion_candidate flag values are provided. 
-   The MONDO id and label are required.

## Splitting Classes

by Nicole Vasilevsky 07/22/20

**Objective:** 

Sometimes one class should be split into two classes. For example, OMIM may rename a disease from FOO to FOO 1, and create a new phenotypic series (PS) with the name FOO. (For an example, see [OMIM:606176 Diabetes mellitus, permanent neonatal 1](https://www.omim.org/entry/606176), which is part of the PS [PS606176 Diabetes mellitus, permanent neonatal](https://www.omim.org/phenotypicSeries/PS606176) and the respective [Mondo ticket #1803](https://github.com/monarch-initiative/mondo/issues/1803). In this case, we should split the generic term and more specific terms (the numbered term) into 2(+) classes, to avoid confusion. 

**Notes**
- When requesting a term to be split, please use the ['split term' template](https://github.com/monarch-initiative/mondo/issues/new?assignees=nicolevasilevsky&labels=split&template=split-term.md&title=split+term%3A+%3Center+name%3E).
- OMIM sometimes redefines something like FOO1 to FOO1A. FOO1 needs to be retained and the OMIM number and the FOO1A be used for the new record.

**Workflow**

**_Splitting a more specific term into a more generic term_**
1. If you have a term in Mondo, such as FOO1, and there is now a more general grouping class, create a new class for the new parent term.
1. Make the more specific class, FOO1 a child term.
1. Make sure the appropriate annotations are associated with the correct class. Use your judgment in moving these annotations, such as the synonyms and dbxrefs. E.g. Orphanet tends to represent the generic form of diseases but their text definition may mention a specific gene that should actually be associated with the child (more specific class).
1. In the case of OMIM, the Phenotypic Series (PS) ID should be associated with the parent/grouping class (use the format OMIMPS:XXXXX {source="MONDO:equivalentTo"}.

**_Splitting a more generic term into a more specific term_**
1. If you have a term in Mondo, such as FOO, and there are now more specific subtypes, such as FOO1, FOO2 (which could be new diseases with specific gene mutations), create the new class for the child(ren) term(s).
1. Make sure the appropriate annotations are associated with the correct class. Use your judgment in moving these annotations, such as the synonyms and dbxrefs. E.g. Orphanet tends to represent the generic form of diseaases but their text definition may mention a specific gene that should actually be associated with the child (more specific class).
1. In the case of OMIM, the OMIM ID should be associated with the child class (use the format OMIM:XXXXX {source="MONDO:equivalentTo"}.


## Splitting Classes

by Nicole Vasilevsky 07/22/20

**Objective:** 

Sometimes one class should be split into two classes. 

There are two use cases:

1) A grouping class or phenotypic series (PS) is created to group more specific classes and the original class becomes ambiguous. (This usually applies to OMIM). For example, OMIM may rename a disease from FOO to FOO 1, and create a new phenotypic series (PS) with the name FOO. (For an example, see [OMIM:606176 Diabetes mellitus, permanent neonatal 1](https://www.omim.org/entry/606176), which is part of the PS [PS606176 Diabetes mellitus, permanent neonatal](https://www.omim.org/phenotypicSeries/PS606176) and the respective [Mondo ticket #1803](https://github.com/monarch-initiative/mondo/issues/1803). In this case, we should follow the  **_Splitting a more specific term into a more generic term_** workflow.

2) Budding of new terms - new subtypes of the term are created, such as Imerslund-Grasbeck syndrome has new subtypes, Imerslund-Grasbeck syndrome 1 and Imerslund-Grasbeck syndrome 2. In this case, we should follow the **_Splitting a more generic term into a more specific term_** workflow.

**Notes**
- When requesting a term to be split, please use the ['split term' template](https://github.com/monarch-initiative/mondo/issues/new?assignees=nicolevasilevsky&labels=split&template=split-term.md&title=split+term%3A+%3Center+name%3E).
- OMIM sometimes redefines something like FOO1 to FOO1A. FOO1 needs to be retained and the OMIM number and the FOO1A be used for the new record.

### General Workflow

**_Splitting a more specific term into a more generic term_**
1. If you have a term in Mondo, such as FOO1, and there is now a more general grouping class, [obsolete](https://mondo.readthedocs.io/en/latest/editors-guide/merging-and-obsoleting/#obsolete-a-class-without-merging) the old term and create two new terms; one for the parent class and the other for the child class (the more specific class).
1. Make sure the appropriate annotations are associated with the correct class. Use your judgment in moving these annotations, such as the synonyms and dbxrefs. E.g. Orphanet tends to represent the generic form of diseases but their text definition may mention a specific gene that should actually be associated with the child (more specific class).

**_Splitting a more generic term into a more specific term_**
1. If you have a term in Mondo, such as FOO, and there are now more specific subtypes, such as FOO1, FOO2 (which could be new diseases with specific gene mutations), create the new class for the child(ren) term(s).
1. Make sure the appropriate annotations are associated with the correct class. Use your judgment in moving these annotations, such as the synonyms and database cross references (dbxrefs). E.g. Orphanet tends to represent the generic form of diseaases but their text definition may mention a specific gene that should actually be associated with the child (more specific class).

### Splitting OMIM Phenotypic Series (PS) terms

There is a specific use case where OMIM creates a phenotypic series (PS); "a Phenotypic Series is a tabular view of genetic heterogeneity of similar phenotypes across the genome. The link is available under the Phenotype-Gene mini-table in many phenotype entries. A list of disorders with a phenotypic series is available [here](https://www.omim.org/phenotypicSeriesTitles/all)." ([OMIM FAQs](https://www.omim.org/help/faq#1_13)).

In Mondo, we assign new Mondo IDs to the OMIM PS terms, and add equivalence axioms (MONDO:equivalentTo) to the dbxrefs for the OMIM PS terms (which should be added as dbxefs in the format: OMIMPS:XXXXX). The OMIM PS terms are a grouping class for the OMIM terms in the PS.

**_Splitting a more specific term into a more generic term_**
1. If you have a term in Mondo, such as FOO1, and there is now a more general grouping class, [obsolete](https://mondo.readthedocs.io/en/latest/editors-guide/merging-and-obsoleting/#obsolete-a-class-without-merging) the old term and create two new terms; one for the parent class and the other for the child class (the more specific class). _For example: [OMIM:606176 Diabetes mellitus, permanent neonatal 1](https://www.omim.org/entry/606176) is now part of the PS [PS606176 Diabetes mellitus, permanent neonatal](https://www.omim.org/phenotypicSeries/PS606176)._
1. Add a new class for the more general grouping class and add the OMIMPS ID as a dbxref and add the equivalent axiom, MONDO:equivalentTo, to the dbxref. _For example, create a new class Diabetes mellitus, permanent neonatal and add: `xref: OMIMPS:606176 {source="MONDO:equivalentTo"} ! diabetes mellitus, permanent neonatal`.
1. Make the more specific class, FOO1 a child term. _For example, OMIM:606176 Diabetes mellitus, permanent neonatal 1 would be the child class and it would have the xref: `xref: OMIM:606176 {source="MONDO:equivalentTo"} ! diabetes mellitus, permanent neonatal`
1. Make sure the appropriate annotations are associated with the correct class. Use your judgment in moving these annotations, such as the synonyms and dbxrefs. E.g. Orphanet tends to represent the generic form of diseases but their text definition may mention a specific gene that should actually be associated with the child (more specific class). _In the example above, Orphanet:99885 should be xref'd on the parent class, 'permanent neonatal diabetes mellitus'.

**_Splitting a more generic term into a more specific term_**
1. If you have a term in Mondo, such as FOO, and there are now more specific subtypes, such as FOO1, FOO2 (which could be new diseases with specific gene mutations), create the new class for the child(ren) term(s). _For example, MONDO:0009853 Imerslund-Grasbeck syndrome, which is equivalent to [OMIMPS:PS261100](https://www.omim.org/phenotypicSeries/PS261100). The children terms are MONDO:0009853 Imerslund-Grasbeck syndrome 1 (which is equivalent to [OMIM:261100](https://www.omim.org/entry/261100) and MONDO:0100127 Imerslund-Grasbeck syndrome 2 (which is equivalent to [OMIM:618882](https://www.omim.org/entry/618882).
1. Add the OMIM ID as a dbxref and add the equivalent axiom, MONDO:equivalentTo, to the dbxref. _For example, create a new class Imerslund-Grasbeck syndrome 1 and add: `xref: OMIM:261100 {source="MONDO:equivalentTo"} ! Imerslund-Grasbeck syndrome 1`.
1. Make sure the appropriate annotations are associated with the correct class. Use your judgment in moving these annotations, such as the synonyms and dbxrefs. E.g. Orphanet tends to represent the generic form of diseaases but their text definition may mention a specific gene that should actually be associated with the child (more specific class).





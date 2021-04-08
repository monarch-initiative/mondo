
## Regular Expressions

by [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432) and [Nico Matentzoglu](https://orcid.org/0000-0002-7356-1779)   
_updated 2021-04-08_

**Objective:** 

Regular expressions can be used for mass editing in the mondo-edit.obo text file. 

### Workflow

1. Create a new branch.
2. Make the changes in the mondo-edit.obo text file (src/ontology/mondo-edit.obo). [Sublime](https://www.sublimetext.com/) (for Mac) or [Atom](https://atom.io/) (for Mac) are recommended text editors.
3. Make a pull request (PR)
4. Once all other bulk change PRs are merged after the build has passed, do this:
5. `sh run.sh make NORM`
6. `mv NORM mondo-edit.obo`

---

### Notes

- ( ) these means you declare a group in Regex  
- $1 first group  
- $2 second group  
- [  ] means single character  

---

### Abbreviations
**Description:** Add an 'abbrevation' tag to synonyms.

**Find**
^(synonym: "[A-Z]+["] EXACT)( [0-9: a-zA-Z\[\],/\.-_\-]*)$
^(synonym: "[A-Z0-9]+["][ ][A-Z]+[ ])\[

**Replace**
$1ABBREVIATION [

---

### Mental Retardation
**Description:** Replace all the mentions of 'mental retardation' with 'intellectual disability'.

**Step 1:** Update all the exact synonyms.  

**Find**
^(synonym: ".*)mental retardation(.*EXACT)( \[.*)$

**Replace**
$1mental retardation$2 DEPRECATED$3
$1intellectual disability$2$3

**Step 2:** Update all the related synonyms.

**Find**
^(synonym: ".*)mental retardation(.*RELATED)( \[.*)$

**Replace**
$1mental retardation$2 DEPRECATED$3
$1intellectual disability$2$3

---

### Remove kboom scores
**Description:** This removes the source annotation that contained kboom scores.

**Find**
, source="MONDO:kboom-pr-[0-9].[0-9]+/[0-9].[0-9]+/[0-9]+.[0-9]+
source="MONDO:kboom-pr[0-9]+-[0-9]+”,
source="MONDO:kboom-pr-[0-9].[0-9]+/[0-9].[0-9]+/[0-9].[0-9]+", 

---

### Replace OMIM RELATED with OMIM EXACT
**Description:** This changes related synonyms to exact synonyms, for synonyms that come from OMIM.

**Find**
^(synonym:.*)(RELATED)(.*OMIM)

**Replace**
$1EXACT$3

---



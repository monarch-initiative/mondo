
## Regular Expressions

by Nicole Vasilevsky and Nico Matentzoglu    
_updated 2021-04-08_

**Objective:** 

Regular expressions can be used for mass editing in the mondo-edit.obo text file. 

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
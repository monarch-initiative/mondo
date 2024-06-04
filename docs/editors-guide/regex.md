
## Bulk Editing Using Regular Expressions

by [Nicole Vasilevsky](https://orcid.org/0000-0001-5208-3432) and [Nico Matentzoglu](https://orcid.org/0000-0002-7356-1779)   
_updated 2021-05-12_

**Objective:** 

Regular expressions can be used for mass editing in the mondo-edit.obo text file. A very helpful reference for writing regex patterns is available here: [regex101](https://regex101.com/).

### Workflow

1. Create a new branch.
2. Make the changes in the mondo-edit.obo text file (src/ontology/mondo-edit.obo). [Sublime](https://www.sublimetext.com/) (for Mac) or [Atom](https://atom.io/) (for Mac) are recommended text editors.
3. **Note:** The 'Regular Expresission' button must be checked (.*) and the 'Case sensitive' button (Aa) in your text editor. 
4. Make a pull request (PR)
5. Once all other bulk change PRs are merged after the build has passed, run these commands on the command line:
6. `sh run.sh make NORM`
7. `mv NORM mondo-edit.obo`

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
`^(synonym: "[A-Z]+["] EXACT)( [0-9: a-zA-Z\[\],/\.-_\-]*)$` _or_ 
`^(synonym: "[A-Z0-9]+["][ ][A-Z]+[ ])\[`

**Replace**
$1ABBREVIATION [

---

### Replace all the mentions of a label
**Description:** This specifically replaces all the mentions of 'mental retardation' with 'intellectual disability', but this could be applied to other strings by replacing the terms 'mental retardation' with the a new label (replace 'intellectual disability'.

#### Step 1: Update all the exact synonyms.  

**Find**
^(synonym: ".*)mental retardation(.*EXACT)( \[.*)$

**Replace**
$1mental retardation$2 DEPRECATED$3
$1intellectual disability$2$3

#### Step 2: Update all the related synonyms.

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
### Add subClassOf axiom to a group of terms
**Description:** This specifically adds the subClassOf axiom `'has modifier' some inherited` to every term that is equivalent to an OMIM phenotypic series (OMIMPS). This is a 'relationship' in the text file. In addition, this adds the source to the axiom, that is the OMIMPS ID.

**Find:**  
^(xref:.*)(OMIMPS[:][0-9]+)(.*equivalentTo.*)

**Replace:**  
$1$2$3
relationship: has_modifier MONDO:0021152 {source="$2"} ! inherited

---
### Split OMIM synonyms and abbreviations
**Description:** By default, OMIM terms and synonyms are written as the long name and abbreviation combined, for example [Barber-Say syndrome, BBRSAY](https://omim.org/entry/209885). This will split the synonym and abbreviation, for example Barber-Say syndrome and BBRSAY (see [MONDO:0008853](http://purl.obolibrary.org/obo/MONDO_0008853)). This should be followed by adding the abbreviation tag to the abbreviation synonyms (see above).

**Find:**  
^(synonym:.*); (.*["])(.*)(.*OMIM.*)

**Replace:**  
$1"$3$4
synonym: "$2$3$4


---

### Find a single letter
**Description:** Find a label that contains a single letter.

**Find:**  
^(name: .* )[a-z]$

**Example:**  
id: MONDO:0014986  
name: Fanconi anemia complementation group R  

---

### Remove MONDO:superClassOf and MONDO:subClassOf source axiom annotations

Related to: https://github.com/monarch-initiative/mondo/issues/4688 

**Find:**  
(xref: .*)source="MONDO:subClassOf", (.*) _or_
(xref: .*)source="MONDO:superClassOf", (.*) _or_
(xref: .*), source="MONDO:subClassOf"(.*) _or_
(xref: .*), source="MONDO:superClassOf"(.*) _or_
(xref: .*)source="MONDO:subClassOf"(.*) _or_
(xref: .*)source="MONDO:superClassOf"(.*) _or_

**Replace:**
$1$2

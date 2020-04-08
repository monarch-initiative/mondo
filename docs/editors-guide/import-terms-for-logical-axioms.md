## Import terms into Mondo for use in logical axioms

These workflows for adding classes from external ontologies (i.e., GO or CHEBI), which is much more streamlined compared to [MIREOTing](https://github.com/obophenotype/human-phenotype-ontology/wiki/Editor-Guide#mireoting).

### Add classes from external ontologies using a Text Editor 

1. Close Protege
1. Checkout master
1. Create a new branch
1. Open mondo-edit.obo with a text editor like Sublime or TextEdit
1. Add axiom in mondo-edit.obo *text file*
1. **For example:**  relationship: disease_has_basis_in_dysfunction_of http://identifiers.org/hgnc/129
1. Save text file
1. open mondo-edit.obo in Protege
1. File -> save as (obo format, save as mondo-edit.obo)
1. Replace existing file 
1. Check diff
1. Commit/Push

### Add classes from external ontologies using Protege 

1. Select 'owl:Thing'
1. Add a new class
paste the full iri in the 'Name:' field, for example, http://purl.obolibrary.org/obo/CHEBI_50906.
1. hit 'OK'
1. Now you can use this term, for example to construct logical axioms. The next time the imports are refreshed, the metadata (labels, definitions, etc) for this term is imported from the respective external source ontology and becomes visible in mondo-edit.obo.
1. See instructions on how to remake the imports file [here](../developer-guide/imports.md).

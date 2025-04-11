## Add New Terms to Mondo

#### Before you start:
- make sure your Protege is setup (see instructions [here](https://mondo.readthedocs.io/en/latest/editors-guide/a-protege-setup/))
-   make sure you are working on a branch in GitHub

### Creating a new class

New classes are created in the Class hierarchy panel on the left.

There are three buttons at the top of the class hierarchy view. These allow you to add a subclass (L-shaped icon), add a sibling class (c-shaped icon), or delete a selected class (x'd circle).

#### Add a new term:

-   Search for the parent term 
-   When you are clicked on the term in the Class hierarchy pane, click the add subclass button to add a child class

![](https://lh6.googleusercontent.com/8Yx82gFh0zvlnoXVnkGerib50qgHcy2V4yYczwL5MRxiJ_XatFkLBAKjJiX9ZyDbyjhDhKx6i1g65o8YvlhABB_Z86mdj1yORgUqImocZm9Y6-sipAisTWhWbHEatGHYGXKEBKI8)

A dialog will popup. Add the name of the new term, see example below. Click "OK" to add the class.

![](https://lh3.googleusercontent.com/gMbBBAo_zVdGvXDUBJmMTTZ-bXWCNImi2fcG9CD0d4TBVg5Sx8r4hHr1AAObc6wIM6asK3EIpvlvrVaBkA-y2RGvzuZV80wa-cVJl22WXtweovy-5KI-7v4hwiW5WolyDYr0i_VE)

#### Adding annotations 

Using Protégé you can add annotations such as labels, definitions, synonyms, database cross references (dbxrefs) to any OWL entity. The panel on the right, named Annotations, is where these annotations are added. CL includes a pre-declared set of annotation properties. The most commonly used annotations are below. 

-   rdfs:label
-   definition
-   has_exact_synonym
-   has_broad_synonym
-   has_narrow_synonym
-   has_related synonym
-   database_cross_reference
-   rdfs:comment

Note, most of these are bold in the annotation property list:

![](https://lh5.googleusercontent.com/NL1uWNo9KSETrkPBCCG92Tw6CSsE0oW7qIPZWK6NJ7PJx6YdGE4YxaFEZgN5OfMf8VzTVNmL2whgIv2FvSkYc0ASHM4YfN0l8psVcgjT-5SG2uEDncBUMoCozhP1vjqRyYPnIprS)

Use this panel to add a definition to the class you created. Select the + button to add an annotation to the selected entity. Click on the annotation 'definition' on the left and add the definition to the white editing box on the right. Click OK.

For example:
![](https://lh3.googleusercontent.com/4p6jqLqln6U1NHs71h30sdbqfPjSop7KxLJrF_JFfapYPPnBL1A3uA4MHRhqXHUA5YLN7rezy7SD1vNH-KslUWM5qb_Z8PP9IWQJSfg2GzX5XL3aa1CkcAtiR46tETCnwzIXHukm)

![](https://lh4.googleusercontent.com/TP0O04TD6kN1rEn1EM1GcXoWJGz-EsFNihzHSOQi-Q4tq65f1Qpd66ItPFVqn6SuQhDge5PSbiXGz2XwoykEYKxe6f3wwCN0j70bNv3WArJE_wOZSjeMNokuLVEx0r9Odbh0rG9L)

Definitions in Mondo should have a 'database cross reference' (dbxref), which is a reference to the definition source, such as a paper from the primary literature or another database. For references to papers, we cross reference the PubMed Identifier in the format, PMID:XXXXXXXX. (Note, no space)

To add a dbxref to the definition:

-   Click the @ symbol next to the definition
-   Click the + button next in the pop-up window
-   Scroll up on the left hand side until you find 'database_cross_reference', and click it
-   Add a dbxref. If adding a PubMed ID, it should be in the format PMID:XXXXXX, for example PMID:25527564. _Note: the PMID should not have any spaces)
-   Click OK
- If you need to add more than one dbxref, repeat the steps from the beginning.
-   The dbxref(s) should appear as below.

See example below:
![](https://lh6.googleusercontent.com/l589uvv3OKKxrabrqKQdL-NF6PfKi_mSfaz-xk--59WtSD15VOy9CQVZXdE0SHl6ZA761zv9G0UULHF5EKRfMToX2F0kqrwuGbjdnzVV3JRRJbb2l40UjOLeXi-7aM_TBkCSkN3L)

![](https://lh6.googleusercontent.com/aW3quN013aSDfyFXpn-_prKrn0TN7eMzodwK4HdryZ_Zbjade5xZWnFCVt8flkRqIbMy5eT5lKzFEimuGNgJ3YYYybI5rgdcmVWUzzfdwFeXjJSFBpNjqgv27kZVPiazcMiZABn1)

#### Add Synonyms

- Synonyms should be exact, narrow, broad or related. Select appropriate annotation: 'has_exact_synonym', etc. Click [here](https://mondo.readthedocs.io/en/latest/editors-guide/f-entities/#synonym-scope) for more details on synonym scopes.
- All synonyms in Mondo should have a dbxref on the synonym

1.  Click the add annotations button
1.  Select 'has_exact_synonym' (or other 'has_synonym...'' type as needed)
1. Add the synonym label in the white box
1. Click OK
1.  Click the @ symbol next to the synonym
1.  Click the + button
1.  Add the dbxref to each synonym: Select database_cross_reference, and add dbxref in white box
1. Click OK
1. Click OK

### Synonym types:

Synonyms can be further annotated with synonym types. Click [here](https://mondo.readthedocs.io/en/latest/editors-guide/f-entities/#synonym-types) for a  summary and description of synonym types in Mondo.

#### Add a synonym annotation in Protege

1. Click on the synonym
2. Click the @ symbol on the synonym
3. Click `Annotations` +
4. Click `has_synonym_type` on the left
5. Click `Entity IRI` on the top of the box
6. Click `Annotation properties` on the top of the box
7. Scroll to bottom, and show annotation below `synonym_type_property` (click triangle)
8. Select appropriate synonym type (e.g. `A synonym that is historic and discouraged`).
9. Click OK

#### Add Database cross reference

- Database cross references to other source ontologies and terminologies can be added to terms

1. Click the add annotations buttons
1. Select 'database_cross_reference'
1. Add the dbxref in the white carboxylase
1. Click OK
1.  Add Axiom Annotation: Click the @ symbol next to the dbxref
1.  Click the + button
1. Click source
1.  Add source in the white box, such as MONDO:equivalentTo. See [Axiom Annotation Summary Table](https://mondo.readthedocs.io/en/latest/editors-guide/f-entities/#axiom-annotations-summary-table) for all types of axiom annotations.
1. Click OK
1. Click OK

#### Add source to parent (subClassOf assertion)

In Mondo, all of the parents (subClassOf assertions) should have a source, so we capture the provenance of where the superclass (subClassOf/parent) assertion came from.

1. Click on the @ symbol next to the parent class
2. Click the + next to Annotations in the pop up box
3. Select source from the annotations list
4. Add a source, such as an OMIM or Orphanet ID, your ORCID, or a PMID ID.
5. Note - you can add more than one source, as displayed in the example below.

![image](https://user-images.githubusercontent.com/6722114/130161740-1ead68d9-7444-4336-a8a6-45df388ce448.png)

![image](https://user-images.githubusercontent.com/6722114/130161756-dad35b4a-ce8f-485b-9841-9cc7465ca088.png)

### Add subset tags

1. See a description of subsets [here](https://mondo.readthedocs.io/en/latest/editors-guide/f-entities/#subsets).
1. To add a subset tag, click the + above Annotations in the Annotations box
1. Chose in_subset in the annotations list 
1. Click Entity IRI tab 
1. Click Annotation Properties tab 
1. Scroll down to subset_property and expand the list
1. Chose subset tag, such as obsoletion_candidate

### Commit to GitHub

Save your work and view the diff in GitHub Desktop and [create a pull request](https://mondo.readthedocs.io/en/latest/editors-guide/d-github-pr-workflow/).

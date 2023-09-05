Browsing and Searching Mondo
============================

Open the Mondo in Protégé
-------------------------

_Note: Windows users should open Protege using run.bat_

1.  Navigate to where you downloaded the repository and open the mondo-edit.obo file (src/ontology/mondo-edit.obo)
2.  When you open Protege, you will be on the Active Ontology tab
3.  Note the Ontology IRI field. The IRI is used to identify the ontology on the Web.

![image](https://user-images.githubusercontent.com/6722114/115821407-9b03eb00-a3b7-11eb-8dd2-7eb0eb9593eb.png)

The Protégé UI
--------------

The Protégé interface follows a basic paradigm of Tabs and Panels. By default, Protégé launches with the main tabs seen below. The layout of tabs and panels is configurable by the user. The Tab list will have slight differences from version to version, and depending on your configuration. It will also reflect your customizations.

To customize your view, go to the Window tab on the toolbar and select Views. Here you can customize which panels you see in each tab. In the tabs view, you can select which tabs you will see. You will commonly want to see the Entities tab, which has the Classes tab and the Object Properties tab.

![image](https://user-images.githubusercontent.com/6722114/115821442-a9520700-a3b7-11eb-9710-cc85471f133b.png)

Note: if you open a new ontology while viewing your current ontology, Protégé will ask you if you'd like to open it in a new window.  **_For most normal usage you should answer no._** This will open in a new window.

The panel in the center is the ontology annotations panel. This panel contains basic metadata about the ontology, such as the authors, a short description and license information.

![image](https://user-images.githubusercontent.com/6722114/115821747-34cb9800-a3b8-11eb-9ec4-302ed3fcd222.png)

Running the reasoner
--------------

Before browsing  or searching an ontology, it is useful to run an OWL reasoner first.  This ensures that you can view the full, intended classification and allows you to run queries.  Navigate to the query menu, and run the ELK reasoner:

![image](https://user-images.githubusercontent.com/6722114/115822558-9b04ea80-a3b9-11eb-922b-c4c908fd99cc.png)


Entities tab
--------------

You will see various tabs along the top of the screen. Each tab provides a different perspective on the ontology. 
For the purposes of this tutorial, we care mostly about the Entities tab, the DL query tab and the search tool.  OWL Entities include Classes (which we are focussed on editing in this tutorial), relations (OWL Object Properties) and Annotation Properties (terms like, 'definition' and 'label' which we use to annotate OWL entities.
Select the Entities tab and then the Classes sub-tab.  Now choose the inferred view (as shown below).

![image](https://user-images.githubusercontent.com/6722114/115822595-a9530680-a3b9-11eb-8797-b60964733067.png)

The Entities tab is split into two halves. The left-hand side provides a suite of panels for selecting various entities in your ontology. When a particular entity is selected the panels on the right-hand side display information about that entity. The entities panel is context specific, so if you have a class selected (like Thing) then the panels on the right are aimed at editing classes. The panels on the right are customizable. Based on prior use you may see new panes or alternate arrangements.
You should see the class OWL:Thing.  You could start browsing from here, but the upper level view of the ontology is too abstract for our purposes. To find something more interesting to look at we need to search or query.

Searching in Protege
--------------

You can search for any entity using the search bar on the right:

![image](https://user-images.githubusercontent.com/6722114/115822673-c8ea2f00-a3b9-11eb-9dca-dfe3d3bfe72a.png)

The search window will open on top of your Protege pane, we recommend resizing it and moving it to the side of the main window so you can view together.  

![image](https://user-images.githubusercontent.com/6722114/115822725-dacbd200-a3b9-11eb-96de-5b727f931a71.png)

Here's an example search for 'COVID-19':
![image](https://user-images.githubusercontent.com/6722114/115822742-e28b7680-a3b9-11eb-8d28-1046833b2f4d.png)

It shows results found in display names, definitions, synonyms and more.  The default results list is truncated.  To see full results check the 'Show all results option'. You may need to resize the box to show all results.
Double clicking on a result, displays details about it in the entities tab, e.g. 

![image](https://user-images.githubusercontent.com/6722114/115822767-f040fc00-a3b9-11eb-8f90-5b1cc9a8775f.png)

In the Entities, tab, you can browse related types, opening/closing branches and clicking on terms to see details on the right. In the default layout, annotations on a term are displayed in the top panel and logical assertions in the 'Description' panel at the bottom.

Try to find these specific classes:
- 'congenital heart disease'
- 'Kindler syndrome'
- 'kidney failure'

Note - a cool feature in the search tool in Protege is you can search on partial string matching. For example, if you want to search for ‘down syndrome’, you could search on a partial string: ‘do synd’. 

- Try searching for ‘br car and see what kind of results are returned.
- **Question:** The search will also search on synonyms. Try searching for ‘shingles’ and see what results are returned. Were you able to find the term?

**Note** - if the search is slow, you can uncheck the box ‘Search in annotation values. Try this and search for a term and note if the search is faster. Then search for ‘shingles’ again and note what results you get.

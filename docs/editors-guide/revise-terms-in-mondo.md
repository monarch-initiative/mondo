## Revise Terms in Mondo

You may wish to revise existing terms in Mondo. To add a new term or class,
see the instructions [here](https://mondo.readthedocs.io/en/latest/editors-guide/add-new-terms/).

### Revise a superclass/parent

#### The Class description view
Superclasses or parents are added in the Description view in Protege, 
under the 'SubClass Of' panel. In the [add new terms documentation](https://mondo.readthedocs.io/en/latest/editors-guide/add-new-terms/), it describes how to add sub/superclasses and annotate the class hierarchy. Another way revise the superclass is via the Class description view. When an OWL class is selected in the entities view, the right-hand side of the tab shows the class description panel. If we select the 'vertebral column disease' class, we see in the class description view that this class is a "SubClass Of" (= has a SuperClass) the 'musculoskeletal system disease' class. Using the (+) button beside "SubClass Of" we could add another superclass to the 'skeletal system disease' class.

Note the Anonymous Ancestors. These are superclasses that are inherited from the parents. If you hover over the Subclass Of (Anonymous Ancestor) you can see the parent that the class inherited the superclass from.

![](https://lh4.googleusercontent.com/hC3R3tw3S5eVNLc70iCN0lrtj9rD_gIPUBxberpw4gSRRR6xct1Xv5dHYSfXPchpYvpGMhIgGnQQ18dl6pWicyClpL-GGyi_JjkeSKOetm4hleSfA-kxu6ww6v-3q-NOLj3xhd7m)

#### Add a superclass

1.  If you want to revise the superclass, click the 'o' symbol next to the superclass and replace the text. Try to revise 'musculoskeletal system disease' to  'disease by anatomical system'.

#### Exclude a superclass 

In Mondo, we don't want to delete superclasses, but rather exclude the superclasses using the excludedsubcClassOf annotation, in order to retain the provenance of that superclass assertion.

1. Click on the parent class that you want to exclude.
1. On a Mac, click command + U or go to Refactor -> Rename entity...
1. Click box to Show full IRI
1. Copy the IRIs
1. Click on the child class, for which you want to exclude the parent
1. In the Annotations box, click the + button to add a new annotation
1. Select excludedsubcClassOf
1. In the right hand side of the box, click the IRI Editor tab
1. Paste the IRI into the box and click OK
1. On the parent class in the Description box, click the @ symbol next to the parent class
1. Move the axiom annotations (source) from the parent class to the excludedsubcClassOf annotation: click the o button, then copy the source annotation (eg DOID:0110668)
1. Click OK
1. Click OK
1.In the Annotations box above, scroll to the bottom to your excludedsubcClassOf and click the @ symbol next to that terms
1. Click + above Annotations
1. Click Source
1. Paste in the source from the parent classes
1. Click OK
1. Click OK
1. Repeat as needed to move all the source annotations from the parent to the excludedsubcClassOf annotation

<iframe width="560" height="315" src="https://www.youtube.com/embed/PVrl_ONPgZY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

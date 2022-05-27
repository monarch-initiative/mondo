# Creating a New Annotation Property in Protege

1. Go to the Annotation properties tab. 
1. Add a new property using the “+” (similar to adding a class)
![Picture1](https://user-images.githubusercontent.com/12737987/161809288-a074fc51-2767-4ec0-a54e-77abb86e4288.png)


1. Name the annotation property   
The IRI for annotation properties should do not have numerical ID.    
The convention for Annotation Property IRI in Mondo is `http://purl.obolibrary.org/obo/mondo#new_property` where.   
- mondo = ontology where the property is created   
- #new_property = name of the annotation property, preceded by #    
    
In order to create this IRI, manually add the IRI when creating the annotation property, as shown here: 

![Screen Shot 2022-04-05 at 10 01 25 AM](https://user-images.githubusercontent.com/12737987/161809825-6bfb17bb-320d-4439-9d82-00ed1d606799.png)


1. Add annotations to this new property. This can be done by adding “Annotations” as would be done for any other class.
Annotation required: 
  - rdfs:label
  - is_metadata_tag    with  ‘true’ (added as literal)
Note: "is_metadata_tag" MUST be added when adding a new annotation property in obo, in order to obo to recognize the new annotation property.
No other annotations are required for annotation properties, however, it is a good idea to add a comment, or other useful information.

# Creating a New Annotation Property in Protege

1. Go to the Annotation properties tab. 
1. Add a new property using the “+” (similar to adding a class)


1. Name the annotation property
The IRI for annotation properties should do not have numerical ID. The convention for Annotation Property IRI in Mondo is: 
http://purl.obolibrary.org/obo/mondo#new_property where
    mondo = ontology where the property is created
    #new_property = name of the annotation property, preceded by #
In order to create this IRI, manually add the IRI when creating the annotation property, as shown here: 



1. Add annotations to this new property. This can be done by adding “Annotations” as would be done for any other class.
Annotation required: 
- rdfs:label
- is_metadata_tag   -  with  ‘true’ (added as literal)
Note: "is_metadata_tag" MUST be added when adding a new annotation property in obo, in order to obo to recognize the new annotation property
No other annotations are required for annotation properties, however, it is a good idea to add a comment, or other useful information.

PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix MONDO: <http://purl.obolibrary.org/obo/MONDO_>

DELETE {
  ?entity <http://purl.obolibrary.org/obo/IAO_0006012> ?date .
  ?entity oboInOwl:inSubset ?subset . #this does not delete nested subsets (ie subsets with dbxrefs)
  ?entity rdfs:comment ?comment .
  ?entity oboInOwl:inSubset <http://purl.obolibrary.org/obo/mondo#obsoletion_candidate> .
  ?xsubset a owl:Axiom ;
         owl:annotatedSource ?entity ;
         owl:annotatedProperty oboInOwl:inSubset ;
         owl:annotatedTarget ?subset ;
         oboInOwl:source ?subsetsource .
  ?xref_anno oboInOwl:source ?source . #this deletes MONDO:equivalentTo 
  ?entity rdfs:label ?label . #this deletes the old label and adds the new label
  ?entity <http://purl.obolibrary.org/obo/IAO_0000115> ?definition . #This deletes the definition
  ?def_anno owl:annotatedTarget ?definition.
}

INSERT {
  ?xref_anno oboInOwl:source ?new_source . #adds MONDO:obsoleteEquivalent (where previously MONDO:equivalentTo) and adds MONDO:obsoleteEquivalentObsolete (where previously MONDO:equivalentObsolete)
  ?entity rdfs:label ?new_label . #this adds the new label obsolete label 
  ?entity owl:deprecated true .
  ?entity <http://purl.obolibrary.org/obo/IAO_0000231> <http://purl.obolibrary.org/obo/OMO_0001000> .
  ?entity <http://purl.obolibrary.org/obo/IAO_0000115> ?obsolete_definition .
  ?def_anno owl:annotatedTarget ?obsolete_definition.
  [] rdf:type owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty <http://purl.obolibrary.org/obo/IAO_0000231> ;
           owl:annotatedTarget <http://purl.obolibrary.org/obo/OMO_0001000> ;
           oboInOwl:source "MONDO:excludeGrouping" .
}

WHERE {
  VALUES ?entity { MONDO:0000000 }  .
    ?entity rdfs:label ?label .
    ?entity oboInOwl:inSubset <http://purl.obolibrary.org/obo/mondo#obsoletion_candidate> .
    
    ?xref_anno a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty ?property ;
           owl:annotatedTarget ?value ;
           oboInOwl:source ?source .
  
  	OPTIONAL {
  		?entity oboInOwl:inSubset ?subset .
    	FILTER(?subset != <http://purl.obolibrary.org/obo/mondo#obsoletion_candidate> )
  	}
    
    OPTIONAL {
      ?entity oboInOwl:inSubset ?subset .
      
      ?xsubset a owl:Axiom ;
             owl:annotatedSource ?entity ;
             owl:annotatedProperty oboInOwl:inSubset ;
             owl:annotatedTarget ?subset ;
             oboInOwl:source ?subsetsource .
             
      FILTER(?subset != <http://purl.obolibrary.org/obo/mondo#obsoletion_candidate> )
    }
    
  	OPTIONAL {
  		?entity <http://purl.obolibrary.org/obo/IAO_0006012> ?date .
  	}

    OPTIONAL {
  		?entity rdfs:comment ?comment .
  	}
    
    OPTIONAL {
  		?entity <http://purl.obolibrary.org/obo/IAO_0000115> ?definition .
      ?def_anno a owl:Axiom ;
         owl:annotatedSource ?entity ;
         owl:annotatedProperty <http://purl.obolibrary.org/obo/IAO_0000115> ;
         owl:annotatedTarget ?definition ;
         ?p ?x .
      BIND(CONCAT("OBSOLETE. ",str(?definition)) as ?obsolete_definition)
  	}
    
    OPTIONAL {
  		?entity <http://purl.obolibrary.org/obo/IAO_0000115> ?definition .
      BIND(CONCAT("OBSOLETE. ",str(?definition)) as ?obsolete_definition)
  	}

   	FILTER NOT EXISTS { ?entity owl:deprecated true }
  	
  	BIND (REPLACE(REPLACE(?source, "MONDO:equivalentTo", "MONDO:obsoleteEquivalent"), "MONDO:equivalentObsolete", "MONDO:obsoleteEquivalentObsolete") AS ?new_source)
    BIND(CONCAT("obsolete ",str(?label)) as ?new_label)
}
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

DELETE {
  ?xref_anno oboInOwl:source ?source . 
}
INSERT {
  ?xref_anno oboInOwl:source "MONDO:obsoleteEquivalentObsolete" .
}
WHERE {
  ?entity oboInOwl:hasDbXref ?xref .
      
  ?xref_anno a owl:Axiom ;
         owl:annotatedSource ?entity ;
         owl:annotatedProperty oboInOwl:hasDbXref ;
         owl:annotatedTarget ?xref ;
         oboInOwl:source ?source .
  
  ?entity owl:deprecated true 

  FILTER ((str(?source)="MONDO:equivalentObsolete"))
  FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
  BIND(?xref as ?property)
  BIND(?source as ?value)
}
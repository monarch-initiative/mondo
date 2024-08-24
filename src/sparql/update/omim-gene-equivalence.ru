PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX identifiers: <http://identifiers.org/hgnc/>

DELETE {
  ?restriction owl:someValuesFrom ?oldSymbol .
}
INSERT {
  ?restriction owl:someValuesFrom ?newSymbol .
}
WHERE {
  # Match the class and restriction
  ?class rdf:type owl:Class ;
         owl:equivalentClass ?equivClass ;
         rdfs:subClassOf ?subClassRestriction .
         
  # Match the subclass restriction and get the HGNC symbol
  ?subClassRestriction rdf:type owl:Restriction ;
                       owl:onProperty <http://purl.obolibrary.org/obo/RO_0004003> ;
                       owl:someValuesFrom ?newSymbol .
                       
  # Match the equivalent class restriction and old symbol
  ?equivClass owl:intersectionOf ?intersection .
  ?intersection rdf:rest*/rdf:first ?restriction .
  ?restriction owl:onProperty <http://purl.obolibrary.org/obo/RO_0004003> ; owl:someValuesFrom ?oldSymbol .
  
  FILTER(?newSymbol != ?oldSymbol)
}

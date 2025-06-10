PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

# Remove gene associations with RO:0004003 'has material basis in germline mutation in' from obsolete classes

DELETE {
  ?obsoleteClass rdfs:subClassOf ?restriction .
  ?axiom a owl:Axiom ;
         owl:annotatedSource ?obsoleteClass ;
         owl:annotatedProperty rdfs:subClassOf ;
         owl:annotatedTarget ?restriction ;
         oboInOwl:source ?source .
}
WHERE {
  ?obsoleteClass owl:deprecated true ;
                 rdfs:subClassOf ?restriction .

  ?restriction a owl:Restriction ;
               owl:onProperty obo:RO_0004003 ;
               owl:someValuesFrom ?gene .

  OPTIONAL {
    ?axiom a owl:Axiom ;
           owl:annotatedSource ?obsoleteClass ;
           owl:annotatedProperty rdfs:subClassOf ;
           owl:annotatedTarget ?restriction ;
           oboInOwl:source ?source .
  }
}

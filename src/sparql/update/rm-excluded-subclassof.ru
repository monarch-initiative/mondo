PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX pattern: <http://purl.obolibrary.org/obo/mondo/patterns/>
PREFIX MONDO: <http://purl.obolibrary.org/obo/MONDO_>
PREFIX oio: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

DELETE {
    ?x rdfs:subClassOf ?entity .
    ?ax a owl:Axiom ;
           owl:annotatedSource ?x ;
           owl:annotatedProperty rdfs:subClassOf ;
           owl:annotatedTarget ?entity ;
           ?p ?z .
    ?ax ?x ?y .
}

WHERE {
  
  ?x rdfs:subClassOf ?entity .
  ?x <http://purl.obolibrary.org/obo/mondo#excluded_subClassOf> ?entity .

  OPTIONAL {
    ?ax a owl:Axiom ;
           owl:annotatedSource ?x ;
           owl:annotatedProperty rdfs:subClassOf ;
           owl:annotatedTarget ?entity ;
           ?p ?z .
           OPTIONAL {
            ?ax ?x ?y .
           }
  }
  
}
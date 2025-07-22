PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX IAO: <http://purl.obolibrary.org/obo/IAO_>
PREFIX OMO: <http://purl.obolibrary.org/obo/OMO_>
PREFIX MONDO: <http://purl.obolibrary.org/obo/MONDO_>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

# description: Replaces the standard label with the clingen preferred label

DELETE {
  ?entity rdfs:label ?label .
}

INSERT {
?entity rdfs:label ?clingen_label .
[] rdf:type owl:Axiom ;
        owl:annotatedSource ?entity ;
        owl:annotatedProperty oboInOwl:hasExactSynonym ;
        owl:annotatedTarget ?label ;
        oboInOwl:hasSynonymType <http://purl.obolibrary.org/obo/mondo#MONDO_LABEL> .
}

WHERE {
  ?entity rdfs:label ?label .
  VALUES ?synonym_property { oboInOwl:hasExactSynonym }
  ?entity ?synonym_property ?clingen_label .
  [] owl:annotatedSource ?entity ;
         owl:annotatedProperty ?synonym_property ;
         owl:annotatedTarget ?clingen_label ;
         OMO:0002001 <https://w3id.org/information-resource-registry/clingen> .

  FILTER(STR(?label)!=STR(?clingen_label))

  FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))	
}
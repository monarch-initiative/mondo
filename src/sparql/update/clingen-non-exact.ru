PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX IAO: <http://purl.obolibrary.org/obo/IAO_>
PREFIX OMO: <http://purl.obolibrary.org/obo/OMO_>
PREFIX MONDO: <http://purl.obolibrary.org/obo/MONDO_>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

# description: Checks if a proper obsolescence reason was documented for this class


DELETE {
 	?ax oboInOwl:hasSynonymType <http://purl.obolibrary.org/obo/mondo#CLINGEN_PREFERRED> .
}

INSERT {
?entity oboInOwl:hasExactSynonym ?label .
    [] rdf:type owl:Axiom ;
        owl:annotatedSource ?entity ;
        owl:annotatedProperty oboInOwl:hasExactSynonym ;
        owl:annotatedTarget ?label ;
        oboInOwl:hasSynonymType <http://purl.obolibrary.org/obo/mondo#CLINGEN_PREFERRED> .
}

WHERE {
  ?entity rdfs:label ?label .
  VALUES ?synonym_property { oboInOwl:hasRelatedSynonym oboInOwl:hasNarrowSynonym oboInOwl:hasBroadSynonym oboInOwl:hasCloseSynonym }
  ?ax owl:annotatedSource ?entity ;
         owl:annotatedProperty ?synonym_property ;
         owl:annotatedTarget ?value ;
         oboInOwl:hasSynonymType <http://purl.obolibrary.org/obo/mondo#CLINGEN_PREFERRED> .

  FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))	
}
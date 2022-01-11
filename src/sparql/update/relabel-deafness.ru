PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX replaced_by: <http://purl.obolibrary.org/obo/IAO_0100001>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix MONDO: <http://purl.obolibrary.org/obo/MONDO_>

DELETE {
	?term rdfs:label ?label .
}
INSERT {
    ?term rdfs:label ?new_label .
  	?term oboInOwl:hasNarrowSynonym ?label .
		[ rdf:type owl:Axiom ;
	     owl:annotatedSource ?term ;
	     owl:annotatedProperty oboInOwl:hasNarrowSynonym ;
	     owl:annotatedTarget ?label ;
	     oboInOwl:hasDbXref ?xref ] .
  	?term rdfs:seeAlso <https://github.com/monarch-initiative/mondo/issues/551> .
} 
WHERE { 
  ?term rdfs:subClassOf* MONDO:0019497 .
  ?term rdfs:label ?label .
	OPTIONAL {
    ?term oboInOwl:hasDbXref ?xref .
    ?axr rdf:type owl:Axiom ;
         owl:annotatedSource ?term ;
         owl:annotatedProperty oboInOwl:hasDbXref ;
         owl:annotatedTarget ?xref ;
         oboInOwl:source ?source .
    FILTER(regex(str(?xref),"OMIM:") || regex(str(?xref),"OMIMPS:"))
    FILTER(regex(str(?source), "MONDO:equivalentTo"))
	}
  FILTER(regex(str(?label), "deafness"))
  BIND(REPLACE(str(?label), "deafness", "hearing loss") as ?new_label )
}

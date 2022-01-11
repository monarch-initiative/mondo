PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX replaced_by: <http://purl.obolibrary.org/obo/IAO_0100001>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX MONDO: <http://purl.obolibrary.org/obo/MONDO_>
PREFIX IAO: <http://purl.obolibrary.org/obo/IAO_>

DELETE {
	?term oboInOwl:hasExactSynonym ?label .
	?ax rdf:type owl:Axiom ;
     owl:annotatedSource ?term ;
     owl:annotatedProperty oboInOwl:hasExactSynonym ;
     owl:annotatedTarget ?label ;
     oboInOwl:hasDbXref ?xref1 .
	?ax oboInOwl:hasDbXref ?xref2 .
}
INSERT {
  	?term oboInOwl:hasNarrowSynonym ?label .
		?ax rdf:type owl:Axiom ;
	     owl:annotatedSource ?term ;
	     owl:annotatedProperty oboInOwl:hasNarrowSynonym ;
	     owl:annotatedTarget ?label ;
	     oboInOwl:hasDbXref ?xref1 .
		?ax oboInOwl:hasDbXref ?xref2 .
}
WHERE { 
  ?term rdfs:subClassOf+ MONDO:0019497 .
  ?term oboInOwl:hasExactSynonym ?label .
  ?ax rdf:type owl:Axiom ;
     owl:annotatedSource ?term ;
     owl:annotatedProperty oboInOwl:hasExactSynonym ;
     owl:annotatedTarget ?label ;
     oboInOwl:hasDbXref ?xref1 .
	OPTIONAL {
		?ax oboInOwl:hasDbXref ?xref2 .
		FILTER(?xref1!=?xref2)
	}
  FILTER(regex(str(?label), "deafness"))
}

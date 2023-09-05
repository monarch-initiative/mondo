PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

DELETE {
  ?xref_anno2 oboInOwl:source "MONDO:obsoleteEquivalent" . 
}
INSERT {
  ?xref_anno oboInOwl:source "MONDO:preferredExternal" .
  ?xref_anno2 oboInOwl:source "MONDO:equivalentTo" .
}
WHERE {
    ?entity rdfs:subClassOf+ <http://purl.obolibrary.org/obo/MONDO_0000001> .
  	?entity oboInOwl:hasDbXref ?xref .
  	?entity oboInOwl:hasDbXref ?xref2 .
        
    ?xref_anno a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref ;
           oboInOwl:source ?source1 .
  
  	?xref_anno2 a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref2 ;
           oboInOwl:source ?source2 .
           

    FILTER(str(?xref2)!=str(?xref))
  	FILTER(STRBEFORE(str(?xref),":") = STRBEFORE(str(?xref2),":")) 
    FILTER ((str(?source1)="MONDO:equivalentTo"))
  	FILTER ((str(?source2)="MONDO:obsoleteEquivalent"))
    FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
    BIND(?xref as ?property)
    BIND(?xref2 as ?value)
}
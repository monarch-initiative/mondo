prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

DELETE {
    ?entity_without_equivalent_xref oboInOwl:hasDbXref ?xref .
    ?xref_anno3 a owl:Axiom ;
           owl:annotatedSource ?entity_without_equivalent_xref;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref ;
           oboInOwl:source ?source3 ;
           oboInOwl:source ?source4 ;
           oboInOwl:source ?source5 .
}

WHERE {
    ?entity_without_equivalent_xref oboInOwl:hasDbXref ?xref .
    ?entity_with_equivalent_xref oboInOwl:hasDbXref ?xref .
    ?xref_anno2 a owl:Axiom ;
           owl:annotatedSource ?entity_with_equivalent_xref ;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref ;
           oboInOwl:source ?source2 .
   	    FILTER (strstarts(str(?source2), "MONDO:equivalentTo") || strstarts(str(?source2), "MONDO:equivalentObsolete"))

    FILTER NOT EXISTS {
    ?xref_anno a owl:Axiom ;
           owl:annotatedSource ?entity_without_equivalent_xref;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref ;
           oboInOwl:source ?source .
   	    FILTER (strstarts(str(?source), "MONDO:equivalentTo") || strstarts(str(?source), "MONDO:equivalentObsolete") || strstarts(str(?source), "MONDO:includedEntryInOMIM"))
    }

    OPTIONAL {
      ?xref_anno3 a owl:Axiom ;
           owl:annotatedSource ?entity_without_equivalent_xref;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref ;
           oboInOwl:source ?source3 .
           OPTIONAL {
            ?xref_anno3 oboInOwl:source ?source4 .
           }
           OPTIONAL {
            ?xref_anno3 oboInOwl:source ?source5 .
           }
    }

    FILTER (strstarts(str(?xref), "OMIM:") || (strstarts(str(?xref), "OMIMPS:" || strstarts(str(?xref), "DOID:") || strstarts(str(?xref), "Orphanet:") || strstarts(str(?xref), "ORDO:") || strstarts(str(?xref), "NCIT:"))))
    FILTER (isIRI(?entity_without_equivalent_xref) && STRSTARTS(str(?entity_without_equivalent_xref), "http://purl.obolibrary.org/obo/MONDO_"))	
}
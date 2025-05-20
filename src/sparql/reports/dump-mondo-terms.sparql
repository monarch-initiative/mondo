PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX IAO: <http://purl.obolibrary.org/obo/IAO_>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>


# Get all Mondo terms and specific properties for Delphi curation tool from mondo.owl (which is already reasoned)

SELECT DISTINCT ?mondoCURIE ?mondoLabel ?definition ?comment 
                (GROUP_CONCAT(DISTINCT ?formattedExactSynonym; separator=",") AS ?exactSynonyms)
                (GROUP_CONCAT(DISTINCT ?parentIRI; separator=",") AS ?parentIRIs)
                (GROUP_CONCAT(DISTINCT ?formattedParentLabel; separator=",") AS ?parentLabels)
                (GROUP_CONCAT(DISTINCT ?xrefCURIE; separator=",") AS ?xrefCURIEs)
WHERE {
  # Get all classes
  ?mondoIRI a owl:Class ;
            rdfs:label ?mondoLabel .

  # Ensure mondoIRI is only MONDO terms
  FILTER(STRSTARTS(STR(?mondoIRI), "http://purl.obolibrary.org/obo/MONDO_"))

  BIND(REPLACE(STR(?mondoIRI), "http://purl.obolibrary.org/obo/MONDO_", "MONDO:") AS ?mondoCURIE)

  # Ensure the class is not obsolete
  FILTER NOT EXISTS { ?mondoIRI owl:deprecated "true"^^xsd:boolean }

  # Get Definition and Comment
  OPTIONAL { ?mondoIRI IAO:0000115 ?definition }
  OPTIONAL { ?mondoIRI rdfs:comment ?comment }

  # Get Exact Synonyms
  OPTIONAL { 
    ?mondoIRI oboInOwl:hasExactSynonym ?exactSynonym 
    BIND(CONCAT('"', STR(?exactSynonym), '[Exact]"') AS ?formattedExactSynonym)
  }

  # Get direct rdfs:subClassOf parents
  OPTIONAL {
    ?mondoIRI rdfs:subClassOf ?parentIRI .
    
    # Ensure parent is not a restriction
    FILTER NOT EXISTS { ?parentIRI rdf:type owl:Restriction . }

    OPTIONAL { 
      ?parentIRI rdfs:label ?parentLabel 
      BIND(CONCAT('"', STR(?parentLabel), '"') AS ?formattedParentLabel)
    }
  }

  # Get OMIM or Orphanet xrefs that have the annotation MONDO:equivalentTo
  OPTIONAL {
    ?xrefAxiom a owl:Axiom ;
               owl:annotatedSource ?mondoIRI ;
               owl:annotatedProperty oboInOwl:hasDbXref ;
               owl:annotatedTarget ?xref ;
               oboInOwl:source "MONDO:equivalentTo" .

    # Filter only OMIM or Orphanet xrefs
    FILTER(STRSTARTS(STR(?xref), "OMIM:") || STRSTARTS(STR(?xref), "Orphanet:"))

    # Convert to CURIE format
    BIND(STR(?xref) AS ?xrefCURIE)
  }
}

GROUP BY ?mondoCURIE ?mondoLabel ?definition ?comment
ORDER BY ?mondoCURIE

PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT DISTINCT ?xref_source (COUNT(DISTINCT ?mondoClass) AS ?count)
WHERE {
  # Restrict to subclasses of MONDO:0700096 'human disease'
  ?mondoClass rdfs:subClassOf+ <http://purl.obolibrary.org/obo/MONDO_0700096> .

  # Check for xrefs
  ?mondoClass oboInOwl:hasDbXref ?xref .
  
  # Ensure MONDO:equivalentTo is present in the annotation
  ?annotation a owl:Axiom ;
              owl:annotatedSource ?mondoClass ;
              owl:annotatedProperty oboInOwl:hasDbXref ;
              owl:annotatedTarget ?xref ;
              oboInOwl:source "MONDO:equivalentTo" .
  
  # Extract xref source for grouping
  BIND(STRBEFORE(STR(?xref), ":") AS ?xref_source)

  # Filter for specific source (Orphanet)
  FILTER(?xref_source = "Orphanet")

  # Check if the class is in either the ordo_disorder or ordo_subtype_of_a_disorder subsets
  ?mondoClass oboInOwl:inSubset ?subset .
  FILTER(?subset IN (<http://purl.obolibrary.org/obo/mondo#ordo_disorder>, 
                     <http://purl.obolibrary.org/obo/mondo#ordo_subtype_of_a_disorder>))
}
GROUP BY ?xref_source
ORDER BY ?xref_source

PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>


SELECT ?source (COUNT(DISTINCT ?mondoClass) AS ?count)
WHERE {
  # Find subclasses of MONDO:0700096 'human disease'
  ?mondoClass rdfs:subClassOf+ <http://purl.obolibrary.org/obo/MONDO_0700096> .

  # Filter for database cross-references to specific sources
  ?mondoClass oboInOwl:hasDbXref ?xref .
  FILTER(STRSTARTS(STR(?xref), "Orphanet:"))

  # Check if the class is in either the ordo_disorder or ordo_subtype_of_a_disorder subsets
  ?mondoClass oboInOwl:inSubset ?subset .
  FILTER(?subset IN (<http://purl.obolibrary.org/obo/mondo#ordo_disorder>, 
                     <http://purl.obolibrary.org/obo/mondo#ordo_subtype_of_a_disorder>))
}
GROUP BY ?source



PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT ?source (COUNT(DISTINCT ?mondoClass) AS ?count)
WHERE {
  # Find subclasses of MONDO:0700096 'human disease'
  ?mondoClass rdfs:subClassOf+ <http://purl.obolibrary.org/obo/MONDO_0700096> .

  # Filter for database cross-references to specific sources
  ?mondoClass oboInOwl:hasDbXref ?xref .

  # Extract the source from the xref
  BIND(STRBEFORE(STR(?xref), ":") AS ?source)

  # Restrict results to only the sources of interest
  FILTER(?source IN ("GARD", "MEDGEN", "NANDO", "NORD"))
}
GROUP BY ?source
ORDER BY ?source

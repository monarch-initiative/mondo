PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>


SELECT ?source (COUNT(DISTINCT ?mondoClass) AS ?count)
WHERE {
  # Find subclasses of MONDO:0700096
  ?mondoClass rdfs:subClassOf* <http://purl.obolibrary.org/obo/MONDO_0700096> .

  # Filter for database cross-references to specific sources
  ?mondoClass oboInOwl:hasDbXref ?xref .

  # Match the desired sources
  BIND(
    IF(
      STRSTARTS(STR(?xref), "GARD:"),
      "GARD",
      IF(
        STRSTARTS(STR(?xref), "MEDGEN:"),
        "MedGen",
        IF(
          STRSTARTS(STR(?xref), "NANDO:"),
          "NANDO",
          IF(
            STRSTARTS(STR(?xref), "NORD:"), "NORD", "OTHER")
        )
      )
    )
    AS ?source
)
  # Exclude any xrefs not matching the sources of interest
  FILTER(?source != "OTHER")
}
GROUP BY ?source
ORDER BY ?source

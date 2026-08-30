PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>


SELECT ?source (COUNT(DISTINCT ?mondoClass) AS ?count)
WHERE {
  # Find subclasses of MONDO:0700096 'human disease'
  ?mondoClass rdfs:subClassOf+ <http://purl.obolibrary.org/obo/MONDO_0700096> .

  # Filter for database cross-references to specific sources
  ?mondoClass oboInOwl:hasDbXref ?xref .

  # Define valid sources
  VALUES (?prefix ?source) {
    ("DOID:" "DOID")
    #("NCIT:" "NCIT") # Exclude NCIT, count must be limited to NCIT 'neoplasm' branch, see README "Alignment to NCIT"
    ("OMIM:" "OMIM")
    ("Orphanet:" "Orphanet")
    ("ICD10CM:" "ICD10CM")
    ("UMLS:" "UMLS")
    ("icd11.foundation:" "ICD11")
  }

  # Match xref with source
  FILTER(STRSTARTS(STR(?xref), ?prefix))
}
GROUP BY ?source
ORDER BY ?source

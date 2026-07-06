PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX obo: <http://purl.obolibrary.org/obo/>

SELECT DISTINCT ?mondoCURIE ?mondoLabel ?omimID
WHERE {
  # Match Mondo classes
  ?mondoClass rdf:type owl:Class ;
              rdfs:label ?mondoLabel ;
              oboInOwl:hasDbXref ?xref .

  # Convert Mondo IRI to CURIE
  BIND(REPLACE(STR(?mondoClass), "http://purl.obolibrary.org/obo/", "") AS ?mondoCURIE)

  # Filter for OMIM xrefs in the provided list
  FILTER(?xref IN (
    "OMIM:619897", "OMIM:619747", "OMIM:618189", "OMIM:619492", "OMIM:619371",
    "OMIM:613694", "OMIM:613697", "OMIM:613881", "OMIM:614672", "OMIM:615184",
    "OMIM:615235", "OMIM:615248", "OMIM:615373", "OMIM:615396", "OMIM:615916",
    "OMIM:620203", "OMIM:115200", "OMIM:302045", "OMIM:600884", "OMIM:601154",
    "OMIM:601493", "OMIM:601494", "OMIM:604145", "OMIM:604288", "OMIM:604765",
    "OMIM:605582", "OMIM:606685", "OMIM:607482", "OMIM:608569", "OMIM:609909",
    "OMIM:609915", "OMIM:611407", "OMIM:611615", "OMIM:611878", "OMIM:611879",
    "OMIM:611880", "OMIM:612158", "OMIM:612877", "OMIM:613122", "OMIM:613172",
    "OMIM:613252", "OMIM:613286", "OMIM:613424", "OMIM:613426", "OMIM:613642"
  ))

  # Ensure MONDO:equivalentTo is present as a source for the xref
  ?annotation a owl:Axiom ;
              owl:annotatedSource ?mondoClass ;
              owl:annotatedProperty oboInOwl:hasDbXref ;
              owl:annotatedTarget ?xref ;
              oboInOwl:source "MONDO:equivalentTo" .
  
  # Bind the xref to ?omimID for clarity
  BIND(?xref AS ?omimID)
}
ORDER BY ?mondoCURIE

PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT DISTINCT ?mondoCURIE ?mondoLabel ?xref
WHERE {
  # Restrict to subclasses of MONDO:0700096 'human disease'
  ?mondoClass rdfs:subClassOf* <http://purl.obolibrary.org/obo/MONDO_0700096> .

  # Retrieve the Mondo label
  ?mondoClass rdfs:label ?mondoLabel .

  # Check for NCIT xrefs
  ?mondoClass oboInOwl:hasDbXref ?xref .
  FILTER(STRSTARTS(STR(?xref), "NCIT:"))

  # Ensure MONDO:equivalentTo is present in the annotation
  ?annotation a owl:Axiom ;
              owl:annotatedSource ?mondoClass ;
              owl:annotatedProperty oboInOwl:hasDbXref ;
              owl:annotatedTarget ?xref ;
              oboInOwl:source "MONDO:equivalentTo" .

  # Generate Mondo CURIE
  BIND(REPLACE(STR(?mondoClass), "http://purl.obolibrary.org/obo/", "") AS ?mondoCURIE)
}
ORDER BY ?mondoClass

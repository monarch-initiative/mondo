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
  FILTER(REGEX(STR(?xref), "DOID:|OMIM:|Orphanet:|ICD10CM:|UMLS:|icd11.foundation:"))

  # Ensure MONDO:equivalentTo is present in the annotation
  ?annotation a owl:Axiom ;
              owl:annotatedSource ?mondoClass ;
              owl:annotatedProperty oboInOwl:hasDbXref ;
              owl:annotatedTarget ?xref ;
              oboInOwl:source "MONDO:equivalentTo" .
  
  # Extract xref source for grouping
  BIND(STRBEFORE(STR(?xref), ":") AS ?xref_source)
}
GROUP BY ?xref_source
ORDER BY ?xref_source

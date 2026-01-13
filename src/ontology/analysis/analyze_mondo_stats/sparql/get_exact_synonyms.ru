PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT DISTINCT ?mondoCURIE ?mondoLabel ?exactSynonym (GROUP_CONCAT(DISTINCT ?xref; SEPARATOR=", ") AS ?exactSynonymXrefList)
WHERE {
  # Restrict to subclasses of MONDO:0700096 'human disease'
  ?mondoClass rdfs:subClassOf* <http://purl.obolibrary.org/obo/MONDO_0700096> ;
              rdfs:label ?mondoLabel ;
              oboInOwl:id ?mondoCURIE .

  # Match exact synonyms
  ?mondoClass oboInOwl:hasExactSynonym ?exactSynonym .

  # Fetch cross-references for exact synonyms
  OPTIONAL {
    ?annotation a owl:Axiom ;
                owl:annotatedSource ?mondoClass ;
                owl:annotatedProperty oboInOwl:hasExactSynonym ;
                owl:annotatedTarget ?exactSynonym ;
                oboInOwl:hasDbXref ?xref .
  }
}
GROUP BY ?mondoCURIE ?mondoLabel ?exactSynonym
ORDER BY ?mondoCURIE ?exactSynonym

PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>


SELECT DISTINCT ?mondoCURIE ?mondoLabel ?exactSynonym (GROUP_CONCAT(DISTINCT ?xref; SEPARATOR=", ") AS ?exactSynonymXrefList)
WHERE {
  # Restrict to subclasses of MONDO:0700096
  ?mondoClass rdfs:subClassOf* <http://purl.obolibrary.org/obo/MONDO_0700096> ;
              rdfs:label ?mondoLabel ;
              oboInOwl:id ?mondoCURIE .

  # Match exact synonyms
  ?mondoClass oboInOwl:hasExactSynonym ?exactSynonym .

  # Check if the class is in either the ordo_disorder or ordo_subtype_of_a_disorder subsets
  ?mondoClass oboInOwl:inSubset ?subset .
  FILTER(?subset IN (<http://purl.obolibrary.org/obo/mondo#ordo_disorder>, 
                     <http://purl.obolibrary.org/obo/mondo#ordo_subtype_of_a_disorder>))

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
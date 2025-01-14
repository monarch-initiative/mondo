PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

# Get all Mondo classes in the "rare" subset and that are subclasses of MONDO:0700096

SELECT (COUNT(DISTINCT ?mondoCURIE) as ?countRareSubset)
WHERE {
  # Restrict to subclasses of MONDO:0700096
  ?mondoClass rdfs:subClassOf* <http://purl.obolibrary.org/obo/MONDO_0700096> .

  # Match MONDO class, label, and subset
  ?mondoClass rdf:type owl:Class ;
              rdfs:label ?mondoLabel ;
              oboInOwl:id ?mondoCURIE ;
              oboInOwl:inSubset <http://purl.obolibrary.org/obo/mondo#rare> .
}

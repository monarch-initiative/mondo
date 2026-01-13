PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

# Get a count of all children of 'neoplasm' in Mondo

SELECT (COUNT(DISTINCT ?mondoClass) AS ?count)
WHERE {
  ?mondoClass rdfs:subClassOf+ <http://purl.obolibrary.org/obo/MONDO_0005070> .
}

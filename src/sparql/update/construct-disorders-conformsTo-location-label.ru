prefix dcterms: <http://purl.org/dc/terms/>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix mondoPatterns: <http://purl.obolibrary.org/obo/mondo/patterns/>

CONSTRUCT {
  ?term rdfs:label ?label .
}
#CONSTRUCT {
#  ?term rdfs:label ?new_label .
#}
WHERE {
  ?term rdfs:label ?label .
  ?term dcterms:conformsTo mondoPatterns:location.yaml .
  FILTER NOT EXISTS { ?term owl:deprecated "true"^^xsd:boolean . }
  FILTER (isIRI(?term) && regex(str(?term), "^http://purl.obolibrary.org/obo/MONDO_"))
  FILTER(regex(str(?label),"disease"))
  BIND(REPLACE(str(?label), "disease", "disorder") as ?new_label )
}

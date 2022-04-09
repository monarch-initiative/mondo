PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX definition: <http://purl.obolibrary.org/obo/IAO_0000115>


DELETE {
	?term definition: ?value .
}

INSERT {
	?term definition: ?new_value .
}

WHERE {
  ?term definition: ?value .
  ?term owl:deprecated true .
  FILTER (isIRI(?term) && STRSTARTS(str(?term), "http://purl.obolibrary.org/obo/MONDO_"))
  FILTER (!STRSTARTS(STR(?value), "OBSOLETE"))
  BIND(CONCAT("OBSOLETE. ", ?value) as ?new_value) 
}
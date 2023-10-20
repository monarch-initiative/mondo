# Given a list of CURIEs, return only those that are not already obsolete
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX MONDO: <http://purl.obolibrary.org/obo/MONDO_>

SELECT ?curie
WHERE {
  VALUES ?cls { MONDO:0000000 }
  ?cls a owl:Class ;
       owl:deprecated "true"^^xsd:boolean .
  BIND(REPLACE(STR(?cls), "http://purl.obolibrary.org/obo/MONDO_", "MONDO:") AS ?curie) .
}

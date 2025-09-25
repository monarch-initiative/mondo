PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT (REPLACE(STR(?subclass), "http://purl.obolibrary.org/obo/NCIT_", "NCIT:") AS ?subclassCURIE)
WHERE {
  ?subclass rdfs:subClassOf+ <http://purl.obolibrary.org/obo/NCIT_C3262> .
}
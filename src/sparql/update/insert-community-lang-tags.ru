PREFIX owl:  <http://www.w3.org/2002/07/owl#>
PREFIX obo:  <http://purl.obolibrary.org/obo/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

INSERT {
  ?mondo_id rdfs:label ?labelWithLang .
}
WHERE {
  ?axiom a owl:Axiom ;
         owl:annotatedSource ?mondo_id ;
         owl:annotatedTarget ?synonym ;
         obo:OMO_0002001 ?fullURI .

  FILTER(STRSTARTS(STR(?fullURI), "https://w3id.org/information-resource-registry/"))

  BIND(REPLACE(STR(?fullURI),
               "^https://w3id.org/information-resource-registry/",
               "") AS ?shortName)

  BIND(STRLANG(?synonym, CONCAT("en-", ?shortName)) AS ?labelWithLang)
}

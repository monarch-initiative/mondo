prefix dcterms: <http://purl.org/dc/terms/>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix mondoPatterns: <http://purl.obolibrary.org/obo/mondo/patterns/>
prefix rm1: <http://purl.obolibrary.org/obo/mondo#CLINGEN_PREFERRED>
prefix rm2: <http://purl.obolibrary.org/obo/mondo#clingen_preferred>
prefix synonym_type: <http://www.geneontology.org/formats/oboInOwl#hasSynonymType>
prefix source: <http://www.geneontology.org/formats/oboInOwl#source>

DELETE {
  ?anno ?property ?value .
}
WHERE {
  VALUES ?property { synonym_type: source: }
  ?anno a owl:Axiom ;
         owl:annotatedSource ?s ;
         owl:annotatedProperty ?p ;
         owl:annotatedTarget ?o ;
         ?property ?value .
  FILTER(STRSTARTS(STR(?value),"ICD10EXP:"))
}

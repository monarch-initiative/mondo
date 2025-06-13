PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

# Get all Mondo classes with gene associations, in the "rare" subset,
# and that are subclasses of MONDO:0700096 and have a gene association

SELECT (COUNT(DISTINCT ?mondoClass) AS ?countMondoClass)
WHERE {
  # Restrict to subclasses of MONDO:0700096
  ?mondoClass rdfs:subClassOf* <http://purl.obolibrary.org/obo/MONDO_0700096> ;
              rdfs:label ?mondoLabel ;
              oboInOwl:inSubset <http://purl.obolibrary.org/obo/mondo#rare> .

  # Match gene associations via subClassOf
  {
    ?mondoClass rdfs:subClassOf ?restriction .
    ?restriction rdf:type owl:Restriction ;
                 owl:onProperty obo:RO_0004003 ;
                 owl:someValuesFrom ?geneIdentifier .
  }
  UNION
  # Match gene associations via equivalentClass
  {
    ?mondoClass owl:equivalentClass ?equivClass .
    ?equivClass owl:intersectionOf/rdf:rest*/rdf:first ?component .
    ?component rdf:type owl:Restriction ;
               owl:onProperty obo:RO_0004003 ;
               owl:someValuesFrom ?geneIdentifier .
  }
}

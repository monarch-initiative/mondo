PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix MONDO: <http://purl.obolibrary.org/obo/MONDO_>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix def: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

INSERT {
  <https://w3id.org/semapv/vocab/crossSpeciesExactMatch> a owl:AnnotationProperty .
  ?cls <https://w3id.org/semapv/vocab/crossSpeciesExactMatch> ?mondohuman.
}

WHERE
{
  ?cls a owl:Class .
  {
    { 
      ?cls rdfs:subClassOf [
        owl:onProperty MONDO:0700097 ;
        owl:someValuesFrom ?mondohuman 
      ] . 
    }
  } UNION {
    ?cls owl:equivalentClass [ 
      owl:intersectionOf ( 
        MONDO:0005583
        [ rdf:type owl:Restriction ;
          owl:onProperty MONDO:0700097 ;
          owl:someValuesFrom ?mondohuman
        ]
      )
    ] .
  }
 FILTER( !isBlank(?cls) && STRSTARTS(str(?cls), "http://purl.obolibrary.org/obo/MONDO_"))
}

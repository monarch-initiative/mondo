prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix def: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

#add acute modifier to classes with 

INSERT {
  ?cls rdfs:subClassOf <http://purl.obolibrary.org/obo/MONDO_root> 
}

#SELECT distinct ?cls ?label

WHERE 
{
  ?cls a owl:Class .

  FILTER NOT EXISTS {
    ?x rdfs:subClassOf ?cls .
  }

  FILTER NOT EXISTS {
    ?cls rdfs:subClassOf ?x .
  }

 FILTER( !isBlank(?cls) && STRSTARTS(str(?cls), "http://purl.obolibrary.org/obo/MONDO_"))
}
  
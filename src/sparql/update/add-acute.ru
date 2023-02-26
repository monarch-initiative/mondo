prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix def: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

#add acute modifier to classes with 

INSERT {
  ?cls rdfs:subClassOf [
               owl:onProperty <http://purl.obolibrary.org/obo/RO_0002573> ;
  owl:someValuesFrom <http://purl.obolibrary.org/obo/PATO_0000389> ] 
}

#SELECT distinct ?cls ?label

WHERE 
{
  ?cls a owl:Class ;
  rdfs:label ?label .

  FILTER NOT EXISTS {
    ?cls owl:deprecated "true"^^xsd:boolean
  }
 FILTER( !isBlank(?cls) && STRSTARTS(str(?cls), "http://purl.obolibrary.org/obo/MONDO_"))
  FILTER(regex(str(?label),"acute"))
}
  
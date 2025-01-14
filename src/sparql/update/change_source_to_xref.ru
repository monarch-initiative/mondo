prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix xref: <http://www.geneontology.org/formats/oboInOwl#hasDbXref>
prefix efo: <http://www.ebi.ac.uk/efo/>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix skos: <http://www.w3.org/2004/02/skos/core#>
prefix obo: <http://purl.obolibrary.org/obo/>

#[ rdf:type owl:Axiom ;
#   owl:annotatedSource <http://www.orpha.net/ORDO/Orphanet_100039> ;
#   owl:annotatedProperty owl:deprecated ;
#   owl:annotatedTarget "true"^^xsd:boolean ;
#   <http://www.geneontology.org/formats/oboInOwl#source> "ordo.owl"^^xsd:string
#] .

DELETE {
    ?ax oboInOwl:source ?source .
}
INSERT {
    ?ax oboInOwl:hasDbXref ?source .
}
WHERE 
{
  VALUES ?property { oboInOwl:hasExactSynonym oboInOwl:hasNarrowSynonym  oboInOwl:hasBroadSynonym oboInOwl:hasCloseSynonym oboInOwl:hasRelatedSynonym } .
  ?entity ?property ?value .
  ?ax rdf:type owl:Axiom ;
    owl:annotatedSource ?entity ;
    owl:annotatedTarget ?value ;
    owl:annotatedProperty ?property ;
    oboInOwl:source ?source .
  FILTER (isIRI(?entity))
}

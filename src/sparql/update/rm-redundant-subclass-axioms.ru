prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>


DELETE {
    ?ax oio:source "MONDO:Redundant" .
}
WHERE 
{
  VALUES ?property { 
    rdfs:subClassOf 
    <http://purl.obolibrary.org/obo/mondo#excluded_subClassOf> 
  }
  ?entity ?property ?ancestor .
   ?ax a owl:Axiom ;
        owl:annotatedSource ?entity ;
        owl:annotatedProperty rdfs:subClassOf ;
        owl:annotatedTarget ?ancestor ;
        oio:source "MONDO:Redundant" .
}
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>


INSERT {
    ?entity rdfs:subClassOf ?ancestor .
    [] a owl:Axiom ;
        owl:annotatedSource ?entity ;
        owl:annotatedProperty rdfs:subClassOf ;
        owl:annotatedTarget ?ancestor ;
        oio:source "MONDO:Redundant" .
}
WHERE 
{
  ?entity rdfs:subClassOf ?parent .
  ?parent rdfs:subClassOf+ ?ancestor .
  ?entity rdfs:subClassOf ?ancestor .
}
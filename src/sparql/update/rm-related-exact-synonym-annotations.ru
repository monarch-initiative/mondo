prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

DELETE {
  ?term oboInOwl:hasRelatedSynonym ?related .
  ?relax a owl:Axiom ;
       owl:annotatedSource ?term ;
       owl:annotatedProperty oboInOwl:hasRelatedSynonym ;
       owl:annotatedTarget ?related ;
       oboInOwl:hasDbXref ?xref2 .
}

WHERE 
{ 
  { 
    ?term oboInOwl:hasRelatedSynonym ?related ;
      oboInOwl:hasExactSynonym ?exact ;
      a owl:Class .
      ?exax a owl:Axiom ;
           owl:annotatedSource ?term ;
           owl:annotatedProperty oboInOwl:hasExactSynonym ;
           owl:annotatedTarget ?exact ;
           oboInOwl:hasDbXref ?xref1 .
      ?relax a owl:Axiom ;
           owl:annotatedSource ?term ;
           owl:annotatedProperty oboInOwl:hasRelatedSynonym ;
           owl:annotatedTarget ?related ;
           oboInOwl:hasDbXref ?xref2 .
    
    FILTER (str(?related)=str(?exact))
    FILTER (isIRI(?term) && regex(str(?term), "^http://purl.obolibrary.org/obo/MONDO_"))
  }
}

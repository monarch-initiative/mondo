PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix def: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>


# Tests if an animal disease made it into the rare disease subset

INSERT
{
  [] rdf:type owl:Axiom ;
  owl:annotatedSource ?entity ;
         owl:annotatedProperty ?property ;
         owl:annotatedTarget ?value ;
         oboInOwl:source <https://orcid.org/0000-0001-5208-3432> .
}

WHERE
{
  VALUES ?property { <http://purl.obolibrary.org/obo/mondo#excluded_subClassOf> }
  ?entity ?property ?value .
  FILTER NOT EXISTS {
  [] owl:annotatedSource ?entity ;
         owl:annotatedProperty ?property ;
         owl:annotatedTarget ?value ;
         oboInOwl:source ?orcid .
        FILTER(STRSTARTS(STR(?orcid),"https://orcid.org/"))
  }
 FILTER( !isBlank(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
}

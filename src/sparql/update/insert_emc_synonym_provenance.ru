PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX mondo: <http://purl.obolibrary.org/obo/mondo#>
prefix owl: <http://www.w3.org/2002/07/owl#>
PREFIX OMO: <http://purl.obolibrary.org/obo/OMO_>

INSERT {
  ?syn_annot oboInOwl:hasDbXref ?xref_value .
}
WHERE {
    VALUES ?syn_type {  
      <https://w3id.org/information-resource-registry/nord>
      <https://w3id.org/information-resource-registry/clingen>
    }
  ?entity oboInOwl:hasExactSynonym ?syn_value .
  ?syn_annot a owl:Axiom ;
             owl:annotatedSource ?entity ;
             owl:annotatedProperty oboInOwl:hasExactSynonym ;
             owl:annotatedTarget ?syn_value ;
             OMO:0002001 ?syn_type .

  BIND(STR(?syn_type) AS ?syn_type_str)
  BIND(REPLACE(?syn_type_str, "https://w3id.org/information-resource-registry/", "") AS ?syn_local)
  BIND(REPLACE(UCASE(?syn_local), "_LABEL$", "") AS ?xref_suffix)
  BIND(CONCAT("MONDO:", ?xref_suffix) AS ?xref_value)
}

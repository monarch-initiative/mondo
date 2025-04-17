PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX mondo: <http://purl.obolibrary.org/obo/mondo#>
prefix owl: <http://www.w3.org/2002/07/owl#>

INSERT {
  ?syn_annot oboInOwl:hasDbXref ?xref_value .
}
WHERE {
    VALUES ?syn_type {  
        mondo:NORD_LABEL
        mondo:CLINGEN_LABEL
    }
  ?entity oboInOwl:hasExactSynonym ?syn_value .
  ?syn_annot a owl:Axiom ;
             owl:annotatedSource ?entity ;
             owl:annotatedProperty oboInOwl:hasExactSynonym ;
             owl:annotatedTarget ?syn_value ;
             oboInOwl:hasSynonymType ?syn_type .

  BIND(STR(?syn_type) AS ?syn_type_str)
  BIND(STRAFTER(?syn_type_str, "#") AS ?syn_local)
  BIND(REPLACE(?syn_local, "_LABEL$", "") AS ?xref_suffix)
  BIND(CONCAT("MONDO:", ?xref_suffix) AS ?xref_value)
}

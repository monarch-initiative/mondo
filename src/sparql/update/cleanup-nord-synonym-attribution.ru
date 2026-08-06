PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX OMO: <http://purl.obolibrary.org/obo/OMO_>

# Remove all axioms derived from NORD externally managed content.

# The four operations execute in order. Reordering breaks correctness:
# operations (2) and (3) erase the NORD signal needed by (1a)/(1b) to
# identify which synonyms were previously NORD-attributed.


# 1a. Drop synonym axioms whose only evidence is from NORD.
DELETE {
  ?term ?syn_type ?syn_str .
}
WHERE {
  VALUES ?syn_type {
    oboInOwl:hasExactSynonym
    oboInOwl:hasBroadSynonym
    oboInOwl:hasNarrowSynonym
    oboInOwl:hasRelatedSynonym
  }

  ?term ?syn_type ?syn_str .

  ?axiom a owl:Axiom ;
      owl:annotatedSource ?term ;
      owl:annotatedProperty ?syn_type ;
      owl:annotatedTarget ?syn_str ;
      oboInOwl:hasDbXref ?nord_term .
  FILTER(STRSTARTS(STR(?nord_term), "NORD:"))

  # Leave synonyms with evidence from other sources
  FILTER NOT EXISTS {
    ?axiom oboInOwl:hasDbXref ?other_ref .
    FILTER(!STRSTARTS(STR(?other_ref), "NORD:"))
  }
} ;

# (1b) Drop all synonym axiom annotation triples for synonyms whose only evidence
# is from NORD.
DELETE {
  ?axiom ?axiomP ?axiomO .
}
WHERE {
  VALUES ?syn_type {
    oboInOwl:hasExactSynonym
    oboInOwl:hasBroadSynonym
    oboInOwl:hasNarrowSynonym
    oboInOwl:hasRelatedSynonym
  }

  ?axiom a owl:Axiom ;
      owl:annotatedProperty ?syn_type ;
      oboInOwl:hasDbXref ?nord_term .

  FILTER(STRSTARTS(STR(?nord_term), "NORD:"))

  FILTER NOT EXISTS {
    ?axiom oboInOwl:hasDbXref ?other_term .
    FILTER(!STRSTARTS(STR(?other_term), "NORD:"))
  }

  ?axiom ?axiomP ?axiomO .
} ;

# 2. Drop NORD hasDbXref axiom annotations from multi-sourced synonyms.
DELETE {
  ?axiom oboInOwl:hasDbXref ?nord_term .
}
WHERE {
  VALUES ?syn_type {
    oboInOwl:hasExactSynonym
    oboInOwl:hasBroadSynonym
    oboInOwl:hasNarrowSynonym
    oboInOwl:hasRelatedSynonym
  }

  ?axiom a owl:Axiom ;
      owl:annotatedProperty ?syn_type ;
      oboInOwl:hasDbXref ?nord_term .
  FILTER(STRSTARTS(STR(?nord_term), "NORD:"))
} ;

# (3) Strip NORD OMO:0002001 label markers for NORD from multi-sourced synonyms.
DELETE {
  ?axiom OMO:0002001 ?marker .
}
WHERE {
  VALUES ?syn_type {
    oboInOwl:hasExactSynonym
    oboInOwl:hasBroadSynonym
    oboInOwl:hasNarrowSynonym
    oboInOwl:hasRelatedSynonym
  }

  ?axiom a owl:Axiom ;
      owl:annotatedProperty ?syn_type ;
      OMO:0002001 ?marker .

  FILTER(STR(?marker) = "https://w3id.org/information-resource-registry/nord")
}

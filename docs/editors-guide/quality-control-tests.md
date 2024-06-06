# Custom SPARQL checks Mondo

## Mondo specific checks

###  qc-animal-disease-rare.sparql

```
prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix def: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
prefix mondoSparqlQcMondo: <http://purl.obolibrary.org/obo/mondo/sparql/qc/mondo/>
prefix mondo: <http://purl.obolibrary.org/obo/mondo#>

# Tests if an animal disease made it into the rare disease subset

SELECT DISTINCT ?entity ?property ?value WHERE
{
  VALUES ?property { <http://purl.obolibrary.org/obo/mondo#rare> }
  ?entity <http://www.geneontology.org/formats/oboInOwl#inSubset> ?property .
  ?entity rdfs:subClassOf* <http://purl.obolibrary.org/obo/MONDO_0005583>
 FILTER NOT EXISTS {
    ?entity owl:deprecated "true"^^xsd:boolean
  }
   FILTER NOT EXISTS {
      ?entity mondo:excluded_from_qc_check mondoSparqlQcMondo:qc-animal-disease-rare.sparql .
   }
 FILTER( !isBlank(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
  BIND("Animal disease in Rare subset" as ?value)
}

```

###  qc-check-for-two-replaced-by-annotations.sparql

```
PREFIX IAO: <http://purl.obolibrary.org/obo/IAO_>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE {
  VALUES ?property {
    IAO:0100001
  }
  ?entity ?property ?value1 .
  ?entity ?property ?value2 .
  FILTER(?value1!=?value2)
  BIND(CONCAT(str(?value1), CONCAT("|", str(?value2))) as ?value)
}
```

###  qc-conforms-to-omimps-and-more.sparql

```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

# description: This test determines if a class conforms to OMIMPS and at least one more pattern

SELECT ?sub ?pattern WHERE {
  ?sub <http://purl.obolibrary.org/obo/mondo#should_conform_to> <http://purl.obolibrary.org/obo/mondo/patterns/OMIM_phenotypic_series.yaml> .
  ?sub <http://purl.obolibrary.org/obo/mondo#should_conform_to> ?pattern .
  
  FILTER(?pattern!=<http://purl.obolibrary.org/obo/mondo/patterns/OMIM_phenotypic_series.yaml>)
  
}

```

###  qc-equivalent-preferred-multiple.sparql

```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE {
    ?entity rdfs:subClassOf+ <http://purl.obolibrary.org/obo/MONDO_0000001> .
  	?entity oboInOwl:hasDbXref ?xref .
  	?entity oboInOwl:hasDbXref ?xref2 .
        
    ?xref_anno a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref ;
           oboInOwl:source ?source0 ;
           oboInOwl:source ?source1 .
  
  	?xref_anno2 a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref2 ;
           oboInOwl:source ?source2 ;
           oboInOwl:source ?source4 .
           

    FILTER(str(?xref2)!=str(?xref))
  	FILTER(STRBEFORE(str(?xref),":") = STRBEFORE(str(?xref2),":")) 
    FILTER ((str(?source0)="MONDO:preferredExternal"))
    FILTER ((str(?source4)="MONDO:preferredExternal"))
    FILTER ((str(?source1)="MONDO:equivalentTo") || (str(?source1)="MONDO:equivalentObsolete"))
  	FILTER ((str(?source2)="MONDO:equivalentTo") || (str(?source2)="MONDO:equivalentObsolete"))
    FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
    BIND(?xref as ?property)
    BIND(?xref2 as ?value)
}

```

###  qc-equivalent-to-on-deprecated.sparql

```
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

#description: Deprecated class employs equivalentTo

SELECT DISTINCT ?entity ?property ?value WHERE {
    ?entity oboInOwl:hasDbXref ?xref .
        
    ?xref_anno a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref ;
           oboInOwl:source ?source .
    
    ?entity owl:deprecated true 

    FILTER ((str(?source)="MONDO:equivalentTo") || (str(?source)="MONDO:equivalentObsolete"))
    FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
    BIND(?xref as ?property)
    BIND(?source as ?value)
}
ORDER BY ?entity

```

###  qc-exact-synonyms-non-exact-mappings.sparql

```
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX MONDO: <http://purl.obolibrary.org/obo/MONDO_>

SELECT DISTINCT ?entity ?label ?xref ?synonym ?code
WHERE {
  
  VALUES ?code {
    "MONDO:relatedTo"^^xsd:string
    "MONDO:mondoIsNarrowerThanSource"^^xsd:string
    "MONDO:directSiblingOf"^^xsd:string
    "MONDO:mondoIsBroaderThanSource"^^xsd:string
  }
  
  ?entity rdfs:subClassOf* MONDO:0000001 .
  ?entity rdfs:label ?label .
  
  ?entity oboInOwl:hasDbXref ?xref .
    [ 
      owl:annotatedSource ?entity ;
      owl:annotatedProperty oboInOwl:hasDbXref ;
      owl:annotatedTarget ?xref ;
      oboInOwl:source ?code 
    ] .
 
  ?entity oboInOwl:hasExactSynonym ?synonym .
  	[ 
      owl:annotatedSource ?entity ;
      owl:annotatedProperty oboInOwl:hasExactSynonym ;
      owl:annotatedTarget ?synonym ;
      oboInOwl:hasDbXref ?xref 
    ] .
  
}
```

###  qc-excluded-subsumption-is-inferred.sparql

```
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix mondo: <http://purl.obolibrary.org/obo/mondo#>
prefix mondoSparqlQcGeneral: <http://purl.obolibrary.org/obo/mondo/sparql/qc/general/>
prefix mondoSparqlQcMondo: <http://purl.obolibrary.org/obo/mondo/sparql/qc/mondo/>

SELECT DISTINCT ?entity ?property ?value  
WHERE 
{ 
  ?entity mondo:excluded_subClassOf ?parent ;
      rdfs:subClassOf* ?parent .
  
    FILTER NOT EXISTS {
       ?entity mondo:excluded_from_qc_check mondoSparqlQcMondo:qc-excluded-subsumption-is-inferred.sparql .
    }
  
  FILTER (isIRI(?parent) && STRSTARTS(str(?parent), "http://purl.obolibrary.org/obo/MONDO_"))
  FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
  FILTER( ?entity=?parent)
  BIND(mondo:excluded_subClassOf as ?property)
  BIND(str(?parent) as ?value)
}
ORDER BY ?entity
```

###  qc-illegal-prefix-on-xref-annotation.sparql

```
# description: Looks for xrefs with illegal prefixes that are on annotation properties

PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix def: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT DISTINCT ?cls ?property ?prefix ?source

WHERE
{
    VALUES ?property { oboInOwl:source oboInOwl:hasDbXref }
    ?cls a owl:Class;
    		rdfs:subClassOf+ <http://purl.obolibrary.org/obo/MONDO_0000001> ;
       	?mapping ?value .

      ?axiom owl:annotatedSource ?cls ;
             owl:annotatedProperty ?mapping ;
             owl:annotatedTarget ?value ;
             ?property ?source .


    FILTER NOT EXISTS {
    	?cls owl:deprecated ?deprecated .
    }
    FILTER( STRBEFORE(str(?source),":") not in (
      "ClinGen",
      "CSP",
      "DC-OMIM", #Consider removing
      "DECIPHER",
      "DERMO",
      "doi",
      "DOID",
      "ECO",
      "EFO",
      "GARD",
      "GTR",
      "HGNC",
      "HP",
      "http",
      "https",
      "ICD10CM",
      "ICD10WHO",
      "ICD11",
      "icd11.foundation",
      "ICD9",
      "ICD9CM",
      "ICDO",
      "ICDO",
      "IDO",
      "ISBN-13",
      "KEGG",
      "LOINC",
      "MedDRA",
      "MedGen",
      "MEDGEN",
      "MEDIC",
      "MESH",
      "MFOMD",
      "MONDO",
      "NORD",
      "MONDORULE",
      "MP",
      "MPATH",
      "MTH",
      "NCIT",
      "NDFRT",
      "NIFSTD",
      "OBI",
      "OGMS",
      "OMIM",
      "OMIMPS",
      "OMIA",
      "OMIT",
      "OMOP",
      "ONCOTREE",
      "Orphanet",
      "PATO",
      "PMID",
      "Reactome",
      "SCDO",
      "SCTID",
      "UMLS",
      "Wikidata",
      "Wikipedia"
      )
    )
    FILTER( !isBlank(?cls) && STRSTARTS(str(?cls), "http://purl.obolibrary.org/obo/MONDO_"))
    BIND( STRBEFORE(str(?source),":") AS ?prefix)
} ORDER BY ?cls


```

###  qc-illegal-prefix-on-xref.sparql

```
# description: Looks for xrefs with illegal prefixes

PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix def: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT DISTINCT ?cls ?prefix

WHERE
{
  VALUES ?mapping { oboInOwl:hasDbXref }
  ?cls a owl:Class;
     	?mapping ?value .

  FILTER NOT EXISTS {
  	?cls owl:deprecated ?deprecated .
  }
  FILTER( STRBEFORE(str(?value),":") not in (
      "CSP",
      "DECIPHER",
      "DOID",
      "EFO",
      "GARD",
      "GTR",
      "HGNC",
      "HP",
      "ICD10CM",
      "ICD10EXP",
      "ICD10WHO",
      "ICD11",
      "icd11.foundation",
      "ICD9",
      "ICD9CM",
      "ICDO",
      "IDO",
      "KEGG",
      "MedDRA",
      "MEDGEN",
      "MESH",
      "MFOMD",
      "MONDO",
      "MPATH",
      "MTH",
      "NANDO",
      "NCIT",
      "NDFRT",
      "NIFSTD",
      "NORD",
      "OBI",
      "OGMS",
      "OMIM",
      "OMIMPS",
      "OMIA",
      "ONCOTREE",
      "Orphanet",
      "PMID",
      "SCDO",
      "SCTID",
      "UMLS",
      "Wikipedia"
    ))
  FILTER( !isBlank(?cls) && STRSTARTS(str(?cls), "http://purl.obolibrary.org/obo/MONDO_"))
  BIND( STRBEFORE(str(?value),":") AS ?prefix)

} ORDER BY ?cls


```

###  qc-negative-subclass-of.sparql

```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix MONDO: <http://purl.obolibrary.org/obo/MONDO_>
SELECT ?subClass ?property ?superClass  WHERE {
  VALUES ?property { rdfs:subClassOf }. 
  VALUES ?subClass { MONDO:0024643 }. 
  VALUES ?superClass {MONDO:0002081 }. 
  ?subClass	?property ?superClass .
}
```

###  qc-no-subclass-between-genetic-disease.sparql

```
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix mondo: <http://purl.obolibrary.org/obo/mondo#>
prefix mondoSparqlQcGeneral: <http://purl.obolibrary.org/obo/mondo/sparql/qc/general/>
prefix mondoSparqlQcMondo: <http://purl.obolibrary.org/obo/mondo/sparql/qc/mondo/>

SELECT DISTINCT ?entity ?property ?value WHERE 
{

?entity rdfs:subClassOf [ rdf:type owl:Restriction ;
owl:onProperty <http://purl.obolibrary.org/obo/RO_0004020> ;
owl:someValuesFrom ?gene1 ] . 
?entity rdfs:label ?entity_label .

?entity rdfs:subClassOf* ?value .

?value rdfs:subClassOf [ rdf:type owl:Restriction ;
owl:onProperty <http://purl.obolibrary.org/obo/RO_0004020> ;
owl:someValuesFrom ?gene2 ] .

FILTER NOT EXISTS { ?value rdfs:subClassOf [ rdf:type owl:Restriction ;
owl:onProperty <http://purl.obolibrary.org/obo/RO_0004020> ;
owl:someValuesFrom ?gene1 ] . }

FILTER NOT EXISTS {
   ?entity mondo:excluded_from_qc_check mondoSparqlQcMondo:qc-no-subclass-between-genetic-disease.sparql .
}

FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
FILTER (isIRI(?value) && STRSTARTS(str(?value), "http://purl.obolibrary.org/obo/MONDO_"))
FILTER (isIRI(?gene1) && STRSTARTS(str(?gene1), "http://identifiers.org/hgnc/"))
FILTER (isIRI(?gene2) && STRSTARTS(str(?gene2), "http://identifiers.org/hgnc/"))
FILTER ( ?entity!=?value )
FILTER ( ?gene1!=?gene2 )
BIND(rdfs:subClassOf as ?property)
}
ORDER BY ?entity
# FILTER ( ?gene1!=?gene2 ) this is a hack to circumvent the case that a disease pertains to the same gene but is further specified.

# Using the subclass selector turned out way too costly computationally:
# ?gene rdfs:subClassOf* <http://purl.obolibrary.org/obo/SO_0001217> .
# ?gene2 rdfs:subClassOf* <http://purl.obolibrary.org/obo/SO_0001217> .
```

###  qc-no-superclass.sparql

```
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix disease: <http://purl.obolibrary.org/obo/MONDO_0000001>
prefix disease_characteristic: <http://purl.obolibrary.org/obo/MONDO_0021125>
prefix disease_stage: <http://purl.obolibrary.org/obo/MONDO_0021007>
prefix disease_susceptibility: <http://purl.obolibrary.org/obo/MONDO_0042489>
prefix injury: <http://purl.obolibrary.org/obo/MONDO_0021178>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>

SELECT DISTINCT ?entity ?property ?value WHERE
{
  ?entity a owl:Class ;
     rdfs:label ?n
  FILTER (strstarts(str(?entity),"http://purl.obolibrary.org/obo/MONDO_"))
  FILTER (!isBlank(?entity))
  FILTER ( NOT EXISTS {?entity owl:deprecated "true"^^xsd:boolean} )
  FILTER ( NOT EXISTS
    {
      {?entity rdfs:subClassOf* disease: }
        UNION
      {?entity rdfs:subClassOf* disease_characteristic: }
        UNION
      {?entity rdfs:subClassOf* disease_susceptibility: }
        UNION
      {?entity rdfs:subClassOf* disease_stage: }
        UNION
      {?entity rdfs:subClassOf* injury: }
    } )
    BIND(rdfs:subClassOf as ?property)
}
ORDER BY ?entity
```

###  qc-not-replacedby-and-consider.sparql

```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix MONDO: <http://purl.obolibrary.org/obo/MONDO_>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

# description: We do not want a consider and a replaced by at the same time.

SELECT ?entity ?property ?value  WHERE {
  ?entity	<http://purl.obolibrary.org/obo/IAO_0100001> ?value .
  ?entity	oboInOwl:consider ?value2 .
  FILTER( !isBlank(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))

}

```

###  qc-obsolete-equivalent-on-non-deprecated.sparql

```
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE {
    ?entity oboInOwl:hasDbXref ?xref .
        
    ?xref_anno a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref ;
           oboInOwl:source ?source .
    
    FILTER NOT EXISTS { ?entity owl:deprecated true }

    FILTER ((str(?source)="MONDO:obsoleteEquivalent") || (str(?source)="MONDO:obsoleteEquivalentObsolete"))
    FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
    BIND(?xref as ?property)
    BIND(str(?entity2) as ?value)
}
ORDER BY ?entity

```

###  qc-omim-subsumption.sparql

```
prefix omim: <http://identifiers.org/omim/>
prefix skos: <http://www.w3.org/2004/02/skos/core#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix mondo: <http://purl.obolibrary.org/obo/mondo#>
prefix mondoSparqlQcGeneral: <http://purl.obolibrary.org/obo/mondo/sparql/qc/general/>
prefix mondoSparqlQcMondo: <http://purl.obolibrary.org/obo/mondo/sparql/qc/mondo/>
prefix mondoPatterns: <http://purl.obolibrary.org/obo/mondo/patterns/>

SELECT DISTINCT ?entity ?property ?value WHERE {
   ?entity rdfs:subClassOf ?parent .
   ?exp owl:annotatedSource ?entity ;
        owl:annotatedProperty oboInOwl:hasDbXref ;
        owl:annotatedTarget ?xref;
        oboInOwl:source ?source .
   ?exp_p owl:annotatedSource ?parent ;
       owl:annotatedProperty oboInOwl:hasDbXref ;
       owl:annotatedTarget ?xref_p;
       oboInOwl:source ?source_p .
   ?entity rdfs:label ?entity_label .
   
   FILTER NOT EXISTS {
      ?entity mondo:excluded_from_qc_check mondoSparqlQcMondo:qc-omim-subsumption.sparql .
   }
   
   FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
   FILTER (isIRI(?parent) && STRSTARTS(str(?parent), "http://purl.obolibrary.org/obo/MONDO_"))
   FILTER(STRSTARTS(str(?xref), "OMIM:"))
   FILTER(STRSTARTS(str(?xref_p), "OMIM:"))
   FILTER(str(?source)="MONDO:equivalentTo")
   FILTER(str(?source_p)="MONDO:equivalentTo")
   BIND(rdfs:subClassOf as ?property)
   BIND(REPLACE(STR(?parent),"[<>]","") AS ?value)
}
ORDER BY ?entity
```

###  qc-omimps-should-be-inherited.sparql

```
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix xsd: <http://www.w3.org/2001/XMLSchema#>
prefix mondo: <http://purl.obolibrary.org/obo/mondo#>
prefix mondoSparql: <http://purl.obolibrary.org/obo/mondo/sparql/>
prefix mondoPatterns: <http://purl.obolibrary.org/obo/mondo/patterns/>
prefix mondoSparqlQcMondo: <http://purl.obolibrary.org/obo/mondo/sparql/qc/mondo/>


SELECT DISTINCT ?entity ?property ?value WHERE {
  ?exp owl:annotatedSource ?entity ;
       owl:annotatedProperty oboInOwl:hasDbXref ;
       owl:annotatedTarget ?xref;
       oboInOwl:source ?source .

  FILTER NOT EXISTS {
    ?entity rdfs:subClassOf [ rdf:type owl:Restriction ;
    owl:onProperty <http://purl.obolibrary.org/obo/RO_0000053> ;
    owl:someValuesFrom <http://purl.obolibrary.org/obo/MONDO_0021152> ] .
  }

  FILTER NOT EXISTS { ?entity owl:deprecated "true"^^xsd:boolean . }

  FILTER NOT EXISTS {
     ?entity mondo:excluded_from_qc_check mondoSparqlQcMondo:qc-omimps-should-be-inherited.sparql .
  }

  FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
  FILTER(STRSTARTS(str(?xref), "OMIMPS:"))
  FILTER(str(?source)="MONDO:equivalentTo")
  BIND(<http://purl.obolibrary.org/obo/RO_0000053> as ?property)
}
ORDER BY ?entity
```

###  qc-predispose-subClassOf.sparql

```
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix mondo: <http://purl.obolibrary.org/obo/mondo#>

SELECT DISTINCT ?entity ?property ?value WHERE {
  ?entity owl:equivalentClass ?intersection .
  ?intersection owl:intersectionOf ?lst .
  ?lst rdf:rest*/rdf:first ?restriction .
  ?restriction owl:someValuesFrom ?value .
  ?restriction owl:onProperty mondo:predisposes_towards .
  ?entity rdfs:subClassOf ?value . 
  FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
  BIND(mondo:predisposes_towards as ?property)
}
ORDER BY ?entity
```

###  qc-proxy-merge-equiv.sparql

```
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE {
  ?entity owl:equivalentClass ?x .
  ?c2 owl:equivalentClass ?x .

  FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
  FILTER (isIRI(?c2) && STRSTARTS(str(?c2), "http://purl.obolibrary.org/obo/MONDO_"))
  FILTER(?entity != ?c2)
  BIND(owl:equivalentClass as ?property)
}
ORDER BY ?entity
```

###  qc-proxy-merges.sparql

```
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

#description: No two Mondo IDs should ever point to the same external ID

SELECT DISTINCT ?entity ?property ?value WHERE {
    ?entity oboInOwl:hasDbXref ?xref .
    
    ?entity2 oboInOwl:hasDbXref ?xref .
    
    ?xref_anno2 a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref ;
           oboInOwl:source ?source1 .
    	
  		?xref_anno a owl:Axiom ;
           owl:annotatedSource ?entity2 ;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref ;
           oboInOwl:source ?source2 .

  	FILTER (?entity2!=?entity)
    FILTER ((str(?source1)="MONDO:equivalentTo") || (str(?source1)="MONDO:obsoleteEquivalent") || (str(?source1)="MONDO:equivalentObsolete") || (str(?source1)="MONDO:obsoleteEquivalentObsolete"))
  	FILTER ((str(?source2)="MONDO:equivalentTo") || (str(?source2)="MONDO:obsoleteEquivalent") || (str(?source2)="MONDO:equivalentObsolete") || (str(?source2)="MONDO:obsoleteEquivalentObsolete"))
    FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
    FILTER (isIRI(?entity2) && STRSTARTS(str(?entity2), "http://purl.obolibrary.org/obo/MONDO_"))
    BIND(?xref as ?property)
    BIND(str(?entity2) as ?value)
}
ORDER BY ?entity

```

###  qc-related-exact-synonym-omim.sparql

```
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE {
  { 
    ?entity oboInOwl:hasRelatedSynonym ?related ;
      rdfs:label ?entity_label ;
      oboInOwl:hasExactSynonym ?exact ;
      a owl:Class .
      [
         a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty oboInOwl:hasExactSynonym ;
           owl:annotatedTarget ?exact ;
           oboInOwl:hasDbXref ?xref1 
      ] .
      [
         a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty oboInOwl:hasRelatedSynonym ;
           owl:annotatedTarget ?related ;
           oboInOwl:hasDbXref ?xref2 
      ] .
    
    FILTER (str(?related)=str(?exact))
    FILTER (regex(str(?xref1), "OMIM^"))
    FILTER (regex(str(?xref2), "OMIM^"))
    FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
    BIND(oboInOwl:hasExactSynonym as ?property)
  }
}

ORDER BY ?entity

```

## General quality checks

###  orcid-contributor-violation.sparql

```
PREFIX dc_terms: <http://purl.org/dc/terms/>

SELECT ?subject ?orcid
WHERE {
  VALUES ?property { dc_terms:contributor dc_terms:creator }
  ?subject ?property ?orcid .
  FILTER(!regex(str(?orcid), "^(https://orcid.org/)[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{3}(?:[0-9]|X)"))
}
```

###  qc-cross-species-analog.sparql

```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix MONDO: <http://purl.obolibrary.org/obo/MONDO_>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix def: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

SELECT ?entity ?property ?value 

WHERE
{
  VALUES ?property { <https://w3id.org/semapv/vocab/crossSpeciesExactMatch> }
  ?entity ?property ?value.

  FILTER NOT EXISTS {
      ?value rdfs:subClassOf+ MONDO:0700096 .
  }

 FILTER( !isBlank(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
}

```

###  qc-def-lacks-xref.sparql

```
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix def: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>

SELECT ?entity ?property ?value WHERE 
{
  ?entity def: ?value .
  
  ?def_anno a owl:Axiom ;
  owl:annotatedSource ?entity ;
  owl:annotatedProperty def: ;
  owl:annotatedTarget ?value .
  
  FILTER NOT EXISTS {
    ?def_anno oio:hasDbXref ?x .
  }
  
  FILTER (!isBlank(?entity))
  FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
  BIND(def: as ?property)
}
ORDER BY ?entity

```

###  qc-definition-containing-underscore.sparql

```
# description: Checks whether definitions contain underscore characters, which could be an indication of a typo.

prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix IAO: <http://purl.obolibrary.org/obo/IAO_>

SELECT DISTINCT ?entity ?property ?value WHERE 
{
  VALUES ?property {
    IAO:0000115
  }
  ?entity ?property ?value .
  FILTER( regex(STR(?value), "_"))
  FILTER (!isBlank(?entity))
}
ORDER BY ?entity

```

###  qc-deprecated-class-reference.sparql

```
# # Deprecated Class Reference
#
# **Problem:** A deprecated class is used in a logical axiom. A deprecated class can be the child of another class (e.g. ObsoleteClass), but it cannot have children or be used in blank nodes or equivalent class statements. Additionally, a deprecated class should not have any equivalent classes or anonymous parents.
#
# **Solution:** Replace deprecated class.

PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

SELECT DISTINCT ?entity ?property ?value WHERE {
  {
   VALUES ?property {
     rdfs:subClassOf
   }
   ?entity a owl:Class;
           owl:deprecated true ;
           ?property ?value .
   FILTER ( ?value NOT IN (oboInOwl:ObsoleteClass, owl:Thing) )
  }
  UNION
  {
   VALUES ?property {
     owl:equivalentClass
     owl:disjointWith
   }
   ?entity a owl:Class;
           owl:deprecated true ;
           ?property ?value .
  }
  UNION
  {
     VALUES ?property {
       rdfs:subClassOf
       owl:equivalentClass
       owl:disjointWith
     }
     ?entity a owl:Class;
             owl:deprecated true .
     ?value ?property ?entity .
  }
  UNION
  {
   VALUES ?property {
     owl:ObjectProperty
     owl:DataProperty
   }
   ?entity a owl:Class ;
           owl:deprecated true ;
           ?property ?value .
  }
  UNION
  {
   VALUES ?property {
     owl:someValuesFrom
     owl:allValuesFrom
   }
   ?value a owl:Class ;
          owl:deprecated true .
   ?rest a owl:Restriction ;
         ?property ?value .
   BIND("blank node" as ?entity)
  }
}
ORDER BY ?entity
```

###  qc-doublewhite.sparql

```
PREFIX dc: <http://purl.org/dc/elements/1.1/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
SELECT ?entity ?property ?value
WHERE {
  VALUES ?property { 
      rdfs:comment
      rdfs:label
      oio:hasExactSynonym
      oio:hasNarrowSynonym
      oio:hasBroadSynonym
      oio:hasCloseSynonym
      oio:hasRelatedSynonym
    }
    ?entity rdf:type owl:Class ;
            ?property ?value .
  filter( regex(str(?value), "  " ) || regex(str(?value), "\t" ))
  FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))

}
```

###  qc-duplicate-exact-synonym-no-abbrev.sparql

```
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE {
  VALUES ?property1 {
    obo:IAO_0000118
    oboInOwl:hasExactSynonym
    rdfs:label
  }
  VALUES ?property2 {
    obo:IAO_0000118
    oboInOwl:hasExactSynonym
    rdfs:label
  }
  ?entity1 ?property1 ?value.
  ?entity2 ?property2 ?value .
  
  FILTER NOT EXISTS {
    ?axiom owl:annotatedSource ?entity1 ;
         owl:annotatedProperty ?property1 ;
         owl:annotatedTarget ?value ;
         oboInOwl:hasSynonymType <http://purl.obolibrary.org/obo/mondo#ABBREVIATION> .
  }
  
  FILTER NOT EXISTS {
    ?axiom owl:annotatedSource ?entity2 ;
         owl:annotatedProperty ?property2 ;
         owl:annotatedTarget ?value ;
         oboInOwl:hasSynonymType <http://purl.obolibrary.org/obo/mondo#ABBREVIATION> .
  }
  
  FILTER NOT EXISTS { ?entity1 owl:deprecated true }
  FILTER NOT EXISTS { ?entity2 owl:deprecated true }
  FILTER (?entity1 != ?entity2)
  FILTER (!isBlank(?entity1))
  FILTER (!isBlank(?entity2))
  BIND(CONCAT(CONCAT(REPLACE(str(?entity1),"http://purl.obolibrary.org/obo/MONDO_","MONDO:"),"-"), REPLACE(str(?entity2),"http://purl.obolibrary.org/obo/MONDO_","MONDO:")) as ?entity)
  BIND(CONCAT(CONCAT(REPLACE(REPLACE(str(?property1),"http://www.w3.org/2000/01/rdf-schema#","rdfs:"),"http://www.geneontology.org/formats/oboInOwl#","oboInOwl:"),"-"), REPLACE(REPLACE(str(?property1),"http://www.w3.org/2000/01/rdf-schema#","rdfs:"),"http://www.geneontology.org/formats/oboInOwl#","oboInOwl:")) as ?property)
}
ORDER BY DESC(UCASE(str(?value)))
```

###  qc-equivalent-classes.sparql

```
# description: checks for named equivalent classes, which are not allowed in Mondo

prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE 
{
  VALUES ?property {
    owl:equivalentClass
  }
  
  ?entity ?property ?value .
  
  FILTER (!isBlank(?entity)) .
  FILTER (!isBlank(?value))
}
ORDER BY ?entity

```

###  qc-excluded-subclass.sparql

```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix def: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>


# Tests if an animal disease made it into the rare disease subset

SELECT DISTINCT ?entity ?property ?value
WHERE
{
  VALUES ?property { <http://purl.obolibrary.org/obo/mondo#excluded_subClassOf> }
  ?entity ?property ?value .
  FILTER(!isIRI(?value) || !STRSTARTS(STR(?value),"http://purl.obolibrary.org/obo/MONDO_"))
  FILTER( !isBlank(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
}

```

###  qc-illegal-axiom-annotation.sparql

```
PREFIX IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

# Checks whether Axiom annotation are one of oboInOwl:source, oboInOwl:hasDbXref or oboInOwl:hasSynonymType .

SELECT distinct ?entity ?property ?value
WHERE 
{ 
      [
         a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty ?property ;
           owl:annotatedTarget ?x ;
           ?value ?y 
      ] .
    FILTER(?property!=rdfs:subClassOf && ?value!=rdfs:comment)
  	FILTER(?y!=?x && ?y!=?property && ?y!=?entity && ?y!=owl:Axiom)
  	FILTER ((?value != oboInOwl:source) && (?value != oboInOwl:hasDbXref) && (?value != oboInOwl:hasSynonymType)) .
    FILTER (isIRI(?entity) && regex(str(?entity), "^http://purl.obolibrary.org/obo/MONDO_"))

}
```

###  qc-illegal-properties.sparql

```
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE {
  {
  VALUES ?property { <http://purl.obolibrary.org/obo/mondo#source>
                     <http://www.geneontology.org/formats/oboInOwl#http://purl.obolibrary.org/obo/mondo#source> }
  ?entity ?property ?value .
  } UNION {
    VALUES ?entity { <http://purl.obolibrary.org/obo/mondo#source>
                     <http://www.geneontology.org/formats/oboInOwl#http://purl.obolibrary.org/obo/mondo#source> }
  	?entity ?property ?value .
  }
}
ORDER BY DESC(UCASE(str(?value)))

```

###  qc-missing-label.sparql

```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT DISTINCT ?entity ?property ?value WHERE {
 VALUES ?property { rdfs:label }
 ?entity ?any ?o .
 FILTER NOT EXISTS { ?entity ?property ?value }
 FILTER NOT EXISTS { ?entity a owl:Ontology }
 FILTER NOT EXISTS { ?entity owl:deprecated true }
 FILTER NOT EXISTS {
   ?entity rdfs:subPropertyOf oboInOwl:SubsetProperty .
 }
 FILTER EXISTS {
   ?entity ?prop2 ?object .
   FILTER (?prop2 != rdf:type)
   FILTER (?prop2 != owl:equivalentClass)
   FILTER (?prop2 != owl:disjointWith)
   FILTER (?prop2 != owl:equivalentProperty)
   FILTER (?prop2 != owl:sameAs)
   FILTER (?prop2 != owl:differentFrom)
   FILTER (?prop2 != owl:inverseOf)
 }
 FILTER (!isBlank(?entity))
 FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
}
ORDER BY ?entity
```

###  qc-misused-replaced-by.sparql

```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE {
 VALUES ?property { <http://purl.obolibrary.org/obo/IAO_0100001> }
 ?entity ?property ?value .
 FILTER NOT EXISTS { ?entity owl:deprecated true }
 FILTER (?entity != oboInOwl:ObsoleteClass)
}
ORDER BY ?entity
```

###  qc-multiple-logical-definitions.sparql

```
PREFIX owl: <http://www.w3.org/2002/07/owl#>

SELECT DISTINCT ?entity ?property ?value WHERE {
 VALUES ?property { owl:equivalentClass }
 ?entity ?property [ owl:intersectionOf ?value ] .
 ?entity ?property [ owl:intersectionOf ?value2 ] .
 FILTER (?value != ?value2)
 FILTER (!isBlank(?entity))
}
ORDER BY ?entity
```

###  qc-multiple-xref-precision-types.sparql

```
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

# description: This checks that no xref has more than one kinds of precisions
# , for example "related" and "equivalent" at the same time.

SELECT DISTINCT ?entity ?property ?value WHERE {
    ?entity oboInOwl:hasDbXref ?xref .
        
    ?xref_anno a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref ;
           oboInOwl:source ?source1 ;
  			oboInOwl:source ?source2 .

  	FILTER (?source1!=?source2)
  	FILTER ((str(?source1)="MONDO:obsoleteEquivalent") || (str(?source1)="MONDO:equivalentObsolete") || (str(?source1)="MONDO:obsoleteEquivalentObsolete") || (str(?source1)="MONDO:equivalentTo") || (str(?source1)="MONDO:relatedTo") || (str(?source1)="MONDO:mondoIsNarrowerThanSource") || (str(?source1)="MONDO:mondoIsBroaderThanSource") || (str(?source1)="MONDO:includedEntryInOMIM"))
  FILTER ((str(?source2)="MONDO:obsoleteEquivalent") || (str(?source2)="MONDO:equivalentObsolete") || (str(?source2)="MONDO:obsoleteEquivalentObsolete") || (str(?source2)="MONDO:equivalentTo") || (str(?source2)="MONDO:relatedTo") || (str(?source2)="MONDO:mondoIsNarrowerThanSource") || (str(?source2)="MONDO:mondoIsBroaderThanSource") || (str(?source2)="MONDO:includedEntryInOMIM"))
    FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
    BIND(?xref as ?value)
  BIND(CONCAT(CONCAT(STR(?source1),"-"),STR(?source2)) as ?property)
}
```

###  qc-no-genus-logical-definitions.sparql

```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>


SELECT DISTINCT ?entity ?property ?value WHERE {
 VALUES ?property { owl:equivalentClass }
 ?entity ?property ?value .
 ?value rdf:type owl:Restriction .
 FILTER (!isBlank(?entity))
}
ORDER BY ?entity
```

###  qc-nolabels.sparql

```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX replaced_by: <http://purl.obolibrary.org/obo/IAO_0100001>

SELECT DISTINCT ?entity ?property ?value WHERE {
	?entity a owl:Class
	FILTER NOT EXISTS {?entity rdfs:label ?lab}
	FILTER NOT EXISTS {?entity replaced_by: ?replCls}
  FILTER (!isBlank(?entity))
  BIND(rdfs:label as ?property)
  BIND("Must have a label" as ?value)
	FILTER (strstarts(str(?entity),"http://purl.obolibrary.org/obo/MONDO_"))
}
ORDER BY ?entity

```

###  qc-obsoletion-reason.sparql

```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX IAO: <http://purl.obolibrary.org/obo/IAO_>
PREFIX OMO: <http://purl.obolibrary.org/obo/OMO_>
PREFIX MONDO: <http://purl.obolibrary.org/obo/MONDO_>

# description: Checks if a proper obsolescence reason was documented for this class

SELECT ?entity ?property ?value WHERE {
  VALUES ?property { IAO:0000231 }
  ?entity ?property ?value .
  FILTER(!isIRI(?value) || 
   (?value!=OMO:0001000 && 
    ?value!=IAO:0000423 &&
    ?value!=IAO:0000229 &&
    ?value!=IAO:0000227 &&
    ?value!=MONDO:TermsMerged ))
  FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))	
}

```

###  qc-owldef-self-reference.sparql

```
prefix rdf:   <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE 
{
  { ?entity owl:equivalentClass [ owl:intersectionOf [ rdf:rest*/rdf:first ?entity ] ] }
    UNION
  { ?entity owl:equivalentClass [ owl:intersectionOf [ rdf:rest*/rdf:first [ owl:someValuesFrom ?entity ] ] ] }
  BIND(owl:equivalentClass as ?property)
  BIND("Entity referencing itself in equivalentClass expression!" as ?value)
}
ORDER BY ?entity
```

###  qc-permitted-properties.sparql

```
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix RO: <http://purl.obolibrary.org/obo/RO_>
prefix mondo: <http://purl.obolibrary.org/obo/mondo#>
prefix skos: <http://www.w3.org/2004/02/skos/core#>
prefix dce: <http://purl.org/dc/elements/1.1/>
prefix dc: <http://purl.org/dc/terms/>

SELECT DISTINCT ?term ?property WHERE
{
	?term ?property ?value .
	FILTER (isIRI(?term) && regex(str(?term), "^http://purl.obolibrary.org/obo/MONDO_"))
  	FILTER (?property NOT IN (
		IAO:0000115,
		IAO:0000231,
		IAO:0000233,
		IAO:0000589,
		IAO:0006012,
		IAO:0100001,
		RO:0002161,
		RO:0002175,
		dc:conformsTo,
		dc:creator,
		dce:date,
		mondo:excluded_from_qc_check,
		mondo:excluded_subClassOf,
		mondo:excluded_synonym,
		mondo:pathogenesis,
		mondo:related,
		mondo:should_conform_to,
		oboInOwl:consider,
		oboInOwl:creation_date,
		oboInOwl:hasAlternativeId,
		oboInOwl:hasBroadSynonym,
		oboInOwl:hasDbXref,
		oboInOwl:hasExactSynonym,
		oboInOwl:hasNarrowSynonym,
		oboInOwl:hasRelatedSynonym,
		oboInOwl:id,
		oboInOwl:inSubset,
		owl:deprecated,
		owl:disjointWith,
		owl:equivalentClass,
		rdf:type,
		rdfs:comment,
		rdfs:isDefinedBy,
		rdfs:label,
		rdfs:seeAlso,
		rdfs:subClassOf,
		rdfs:subPropertyOf,
		skos:broadMatch,
		skos:closeMatch,
		skos:exactMatch,
		skos:narrowMatch,
		skos:relatedMatch,
		<https://w3id.org/semapv/vocab/crossSpeciesExactMatch>
		)
	)
}

```

###  qc-provenance-missing.sparql

```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix def: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>


# Tests for excluded_subClassOf relationships that do not also have a source annotation with an ORCID.

SELECT DISTINCT ?entity ?property ?value
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

```

###  qc-proxy-merge-missing-preferred.sparql

```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE {
    ?entity rdfs:subClassOf+ <http://purl.obolibrary.org/obo/MONDO_0000001> .
  	?entity oboInOwl:hasDbXref ?xref .
  	?entity oboInOwl:hasDbXref ?xref2 .
        
    ?xref_anno a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref ;
           oboInOwl:source ?source1 .
  
  	?xref_anno2 a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref2 ;
           oboInOwl:source ?source2 .
           
  	FILTER(STRSTARTS(STR(?xref),"DOID") || STRSTARTS(STR(?xref),"Orphanet") || STRSTARTS(STR(?xref),"OMIM"))
    FILTER(str(?xref2)!=str(?xref))
  	FILTER(STRBEFORE(str(?xref),":") = STRBEFORE(str(?xref2),":")) 
  	FILTER NOT EXISTS {
    	?xref_anno oboInOwl:source ?source11 .
      	FILTER ((str(?source11)="MONDO:preferredExternal"))
  	}
    FILTER NOT EXISTS {
    	?xref_anno2 oboInOwl:source ?source21 .
      	FILTER ((str(?source21)="MONDO:preferredExternal"))
  	}
    FILTER ((str(?source1)="MONDO:equivalentTo") || (str(?source1)="MONDO:equivalentObsolete"))
  	FILTER ((str(?source2)="MONDO:equivalentTo") || (str(?source2)="MONDO:equivalentObsolete"))
    FILTER ((str(?source1)="MONDO:equivalentTo") && (str(?source2)="MONDO:equivalentTo"))
  	FILTER ((str(?source1)="MONDO:equivalentObsolete") && (str(?source2)="MONDO:equivalentObsolete"))
    FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
    BIND(?xref as ?property)
    BIND(?xref2 as ?value)
}

```

###  qc-reflexive.sparql

```
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>

SELECT DISTINCT ?entity ?property ?value 
WHERE {
    ?entity ?property ?entity .
    FILTER ( isIRI(?entity))
    FILTER(?entity!=owl:Nothing)
    BIND("Entity referencing itself in triple!" as ?value)
}
ORDER BY ?entity
```

###  qc-related-exact-synonym.sparql

```
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE 
{ 
    ?entity oboInOwl:hasRelatedSynonym ?value ;
      oboInOwl:hasExactSynonym ?exact ;
      a owl:Class .
    
    ?entity rdfs:label ?entity_label .
    
    FILTER (str(?value)=str(?exact))
    FILTER (isIRI(?entity))
    BIND("oboInOwl:hasExactSynonym" as ?property)
}
ORDER BY ?entity
```

###  qc-same-label.sparql

```
SELECT DISTINCT ?entity ?property ?value WHERE {
?entity <http://www.w3.org/2000/01/rdf-schema#label> ?n0 .
?c2 <http://www.w3.org/2000/01/rdf-schema#label> ?n0 .
FILTER NOT EXISTS {?entity <http://www.w3.org/2002/07/owl#deprecated> ?value} .
FILTER NOT EXISTS {?c2 <http://www.w3.org/2002/07/owl#deprecated> ?v2} .
FILTER (?entity != ?c2)
BIND(<http://www.w3.org/2002/07/owl#deprecated> as ?property)
}
ORDER BY ?entity
```

###  qc-seealso-github.sparql

```
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE {
  VALUES ?property {
    rdfs:seeAlso
  }
  ?entity ?property ?value .
  FILTER (isIRI(?entity) && STRSTARTS(STR(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
  FILTER(STRSTARTS(STR(?value),"https://github.com/"))
}
ORDER BY ?entity
```

###  qc-single-child.sparql

```
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix mondoSparqlQcGeneral: <http://purl.obolibrary.org/obo/mondo/sparql/qc/general/>
prefix mondoSparqlQcMondo: <http://purl.obolibrary.org/obo/mondo/sparql/qc/mondo/>
prefix mondo: <http://purl.obolibrary.org/obo/mondo#>

SELECT DISTINCT ?entity ?property ?value WHERE {
    ?entity rdfs:subClassOf ?parent .
    FILTER NOT EXISTS {
       ?child2 rdfs:subClassOf ?parent .
       FILTER (?child2 != ?entity)
       FILTER (isIRI(?child2) && STRSTARTS(str(?child2), "http://purl.obolibrary.org/obo/MONDO_"))
    }
    FILTER NOT EXISTS {
       ?entity mondo:excluded_from_qc_check mondoSparqlQcGeneral:qc-single-child.sparql .
    }
    FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
    FILTER (isIRI(?parent) && STRSTARTS(str(?parent), "http://purl.obolibrary.org/obo/MONDO_"))
    BIND(rdfs:subClassOf AS ?property)
    BIND(str(?parent) AS ?value)
}
ORDER BY ?entity
```

###  qc-subclass-cycle.sparql

```
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>

SELECT DISTINCT ?entity ?property ?value WHERE {
    ?entity rdfs:subClassOf+ ?entity .
   FILTER(?entity!=owl:Nothing)
   BIND(rdfs:subClassOf AS ?property)
   BIND(?entity AS ?value)
}
ORDER BY ?entity
```

###  qc-syn-equal-label.sparql

```
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX replaced_by: <http://purl.obolibrary.org/obo/IAO_0100001>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

SELECT distinct ?term ?label ?related ?synonym
WHERE 
{ 
  VALUES ?synonym { oboInOwl:hasRelatedSynonym oboInOwl:hasNarrowSynonym oboInOwl:hasBroadSynonym oboInOwl:hasCloseSynonym }
    ?term ?synonym ?related ;
          rdfs:label ?label ;
      	a owl:Class .
    
  	FILTER(str(?label)=str(?related))
    FILTER (isIRI(?term) && regex(str(?term), "^http://purl.obolibrary.org/obo/MONDO_"))
}
```

###  qc-syn-source-not-xref.sparql

```
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?entity ?property ?value
WHERE 
{ 
  VALUES ?property {
    oboInOwl:hasRelatedSynonym
    oboInOwl:hasExactSynonym
    oboInOwl:hasNarrowSynonym
    oboInOwl:hasBroadSynonym
  }
    ?entity ?property ?value ;
      a owl:Class .
      ?anno a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty ?property ;
           owl:annotatedTarget ?value ;
           oboInOwl:source ?xref .  
   FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))
}
```

###  qc-trailing-whitespace.sparql

```
# home: hp/sparql/trailing-whitespace-violation.sparql
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE 
{
  ?entity ?property ?value .

  FILTER( regex(STR(?value), "^ ") || regex(STR(?value), " $")  )
  FILTER( ?property != owl:annotatedTarget )
}
ORDER BY ?entity
```

###  qc-two-pattern.sparql

```
SELECT DISTINCT ?entity ?property ?value WHERE {
?entity <http://purl.org/dc/terms/conformsTo> ?value .
?entity <http://purl.org/dc/terms/conformsTo> ?n1 .
FILTER ( ?value!=?n1 ) .
FILTER ( isIRI(?c1))
BIND(<http://purl.org/dc/terms/conformsTo> AS ?property)
}
ORDER BY ?entity
```

###  qc-undeclared-subset.sparql

```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oio: <http://www.geneontology.org/formats/oboInOwl#>

SELECT DISTINCT ?entity ?property ?value WHERE {
   ?c oio:inSubset ?entity .
   FILTER NOT EXISTS { ?entity rdfs:subPropertyOf oio:SubsetProperty } 
   BIND(oio:inSubset AS ?property)
   BIND("Subset not declared." as ?value)
}
ORDER BY ?entity

```

###  qc-undeclared-synonym-type.sparql

```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oio: <http://www.geneontology.org/formats/oboInOwl#>

SELECT DISTINCT ?entity ?property ?value WHERE {
       ?axiom oio:hasSynonymType ?entity .
       FILTER NOT EXISTS { ?entity rdfs:subPropertyOf oio:SynonymTypeProperty } 
       BIND(oio:hasSynonymType AS ?property)
}
ORDER BY ?entity

```

###  qc-xref-syntax.sparql

```
# # Invalid Xref
#
# **Problem:** A database_cross_reference is not in CURIE format.
#
# **Solution:** Replace the reference with a [CURIE](https://www.w3.org/TR/2010/NOTE-curie-20101216/).

PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value
WHERE {
  VALUES ?property {oboInOwl:hasDbXref}
  ?entity ?property ?value .
  FILTER (!regex(?value, "^[A-Za-z_][A-Za-z0-9_.-]*[A-Za-z0-9_]:[^\\s]+$"))
  FILTER (!isBlank(?entity))
}
ORDER BY ?entity

```

###  qc-xref-without-source.sparql

```
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?xref WHERE {
    ?entity oboInOwl:hasDbXref ?xref .
    OPTIONAL {
      ?entity owl:deprecated ?obsolete .
    }
    FILTER NOT EXISTS {
    ?xref_anno a owl:Axiom ;
           owl:annotatedSource ?entity ;
           owl:annotatedProperty oboInOwl:hasDbXref ;
           owl:annotatedTarget ?xref ;
           oboInOwl:source ?source .
   	    FILTER (strstarts(str(?source), "MONDO:"))
  }

    FILTER (strstarts(str(?xref), "OMIM:") || (strstarts(str(?xref), "OMIMPS:" || strstarts(str(?xref), "DOID:") || strstarts(str(?xref), "Orphanet:") || strstarts(str(?xref), "ORDO:") || strstarts(str(?xref), "NCIT:"))))
    FILTER (isIRI(?entity) && STRSTARTS(str(?entity), "http://purl.obolibrary.org/obo/MONDO_"))	
}
ORDER BY ?entity
```


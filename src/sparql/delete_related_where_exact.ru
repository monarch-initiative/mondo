PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT DISTINCT ?entity ?property ?value WHERE {
 VALUES ?property {
   obo:IAO_0000118
   oboInOwl:hasExactSynonym
   oboInOwl:hasRelatedSynonym
   oboInOwl:hasNarrowSynonym
   oboInOwl:hasBroadSynonym
 }
 FILTER NOT EXISTS { ?entity owl:deprecated true }
 FILTER NOT EXISTS { ?entity2 owl:deprecated true }
 ?term rdfs:label ?label .
 ?entity oboInOwl:hasExactSynonym ?value .
 ?entity oboInOwl:hasExactSynonym ?value .
}
ORDER BY ?entity
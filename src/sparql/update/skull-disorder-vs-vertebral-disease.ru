# TODO: Copy/pasted from omim-abbreviation-replace; need to reformat
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

DELETE {
  ?term rdfs:label ?term_label .
}
INSERT {
  ?term rdfs:label ?label_lc .
}
WHERE
{
  {
	?cls a owl:Class;
  		rdfs:label ?label .
    ?cls rdfs:subClassOf ?parent .
    ?parent rdfs:label ?parent_label .
  	FILTER(regex(str(?label),"disease"))
    FILTER NOT EXISTS {
    	?cls owl:deprecated "true"^^xsd:boolean
  	}
    FILTER( !isBlank(?cls) && regex(str(?cls), "^http://purl.obolibrary.org/obo/MONDO_"))
  }
} GROUP BY ?cls ?label

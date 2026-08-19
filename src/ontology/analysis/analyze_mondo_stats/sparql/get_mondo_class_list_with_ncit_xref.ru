PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>

# Get a list of all Mondo classes and xrefs where the Mondo class has at least one xref to NCIT and the Mondo class 
# is a child of MONDO:0700096 'human disease'

SELECT DISTINCT ?mondoCURIE ?label ?ncitXref
WHERE {
  # Retrieve all children of MONDO_0700096
  ?class rdfs:subClassOf* <http://purl.obolibrary.org/obo/MONDO_0700096> ;
         rdfs:label ?label ;
         oboInOwl:hasDbXref ?ncitXref .
  
  # Filter for NCIT xrefs
  FILTER(STRSTARTS(STR(?ncitXref), "NCIT:"))
  
  # Generate Mondo CURIE
  BIND(REPLACE(STR(?class), "http://purl.obolibrary.org/obo/", "") AS ?mondoCURIE)
}
ORDER BY ?mondoCURIE

# disease_series_by_gene 

[http://purl.obolibrary.org/obo/mondo/patterns/disease_series_by_gene.yaml](http://purl.obolibrary.org/obo/mondo/patterns/disease_series_by_gene.yaml)
## Description 

This pattern is for diseases that are caused by a single mutation in a single gene, that have gene-based names, such as new disease terms that are requested by ClinGen, like MED12-related intellectual disability syndrome.  Examples: [MED12-related intellectual disability syndrome](http://purl.obolibrary.org/obo/MONDO_0100000), [TTN-related myopathy](http://purl.obolibrary.org/obo/MONDO_0100175), [MYPN-related myopathy](http://purl.obolibrary.org/obo/MONDO_0015023)
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

{disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} caused by mutation in {gene\([SO:0001217](http://purl.obolibrary.org/obo/SO_0001217)\)}

## Annotations 

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: {gene\([SO:0001217](http://purl.obolibrary.org/obo/SO_0001217)\)} {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)}

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: {gene\([SO:0001217](http://purl.obolibrary.org/obo/SO_0001217)\)} related {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)}

## Definition 

Any {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} in which the cause of the disease is a mutation in the {gene\([SO:0001217](http://purl.obolibrary.org/obo/SO_0001217)\)} gene.

## Equivalent to 

{disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} and {disease has basis in dysfunction of\([RO:0004020](http://purl.obolibrary.org/obo/RO_0004020)\)} some {gene\([SO:0001217](http://purl.obolibrary.org/obo/SO_0001217)\)}


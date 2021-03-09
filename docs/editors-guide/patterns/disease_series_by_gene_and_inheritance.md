# disease_series_by_gene_and_inheritance 
## URL 

[http://purl.obolibrary.org/obo/mondo/patterns/disease_series_by_gene.yaml](http://purl.obolibrary.org/obo/mondo/patterns/disease_series_by_gene.yaml)
## Description 

This pattern is for diseases that are caused by a single mutation in a single gene, that have gene-based names, and are inherited by a specific mechanism, succh as autosomal dominant and autosomal recessive. 
Examples: [Growth hormone insensitivity syndrome with immune dysregulation](https://omim.org/phenotypicSeries/PS245590), Growth hormone insensitivity with immune dysregulation 1, autosomal recessive and Growth hormone insensitivity with immune dysregulation 2, autosomal dominant
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
* [https://orcid.org/0000-0002-7356-1779](https://orcid.org/0000-0002-7356-1779) 
## Name 

{disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} caused by mutation in {gene\([SO:0000704](http://purl.obolibrary.org/obo/SO_0000704)\)}, {mode_of_inheritance\([HP:0000005](http://purl.obolibrary.org/obo/HP_0000005)\)}

## Annotations 

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: {gene\([SO:0000704](http://purl.obolibrary.org/obo/SO_0000704)\)} {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)}, {mode_of_inheritance\([HP:0000005](http://purl.obolibrary.org/obo/HP_0000005)\)}

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: {gene\([SO:0000704](http://purl.obolibrary.org/obo/SO_0000704)\)} related {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)}, {mode_of_inheritance\([HP:0000005](http://purl.obolibrary.org/obo/HP_0000005)\)}

## Definition 

Any {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} in which the cause of the disease is a mutation in the {gene\([SO:0000704](http://purl.obolibrary.org/obo/SO_0000704)\)} gene, and has {mode_of_inheritance\([HP:0000005](http://purl.obolibrary.org/obo/HP_0000005)\)}.

## Equivalent to 

{disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} and {disease has basis in dysfunction of\([RO:0004020](http://purl.obolibrary.org/obo/RO_0004020)\)} some {gene\([SO:0000704](http://purl.obolibrary.org/obo/SO_0000704)\)} and {has modifier\([RO:0002573](http://purl.obolibrary.org/obo/RO_0002573)\)} some {mode_of_inheritance\([HP:0000005](http://purl.obolibrary.org/obo/HP_0000005)\)}


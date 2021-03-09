# susceptibility_by_gene 

[http://purl.obolibrary.org/obo/mondo/patterns/susceptibility_by_gene.yaml
Examples - [autism, susceptibility to, X-linked 5](http://purl.obolibrary.org/obo/MONDO_0010449), [bulimia nervosa, susceptibility to, 2](http://purl.obolibrary.org/obo/MONDO_0012461), [nephrolithiasis susceptibility caused by SLC26A1](http://purl.obolibrary.org/obo/MONDO_0020722)'](http://purl.obolibrary.org/obo/mondo/patterns/susceptibility_by_gene.yaml
Examples - [autism, susceptibility to, X-linked 5](http://purl.obolibrary.org/obo/MONDO_0010449), [bulimia nervosa, susceptibility to, 2](http://purl.obolibrary.org/obo/MONDO_0012461), [nephrolithiasis susceptibility caused by SLC26A1](http://purl.obolibrary.org/obo/MONDO_0020722)')
## Description 

This pattern should be used for terms in which a gene dysfunction causes a predisposition or susceptibility towards developing a specific disease. This pattern is a sub-pattern of [inherited_susceptibility.yaml](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/inherited_susceptibility.yaml)
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

{disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} susceptibility, {gene\([SO:0000704](http://purl.obolibrary.org/obo/SO_0000704)\)} form

## Annotations 

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} susceptibility caused by {gene\([SO:0000704](http://purl.obolibrary.org/obo/SO_0000704)\)}

## Definition 

A susceptibility or predisposition to {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} in which the cause of the disease is a mutation in the {gene\([SO:0000704](http://purl.obolibrary.org/obo/SO_0000704)\)} gene.

## Equivalent to 

({inherited disease susceptibility\([MONDO:0020573](http://purl.obolibrary.org/obo/MONDO_0020573)\)} and ({disease has basis in dysfunction of\([RO:0004020](http://purl.obolibrary.org/obo/RO_0004020)\)} some {gene\([SO:0000704](http://purl.obolibrary.org/obo/SO_0000704)\)}) and ({predisposes towards\([http://purl.obolibrary.org/obo/mondo#predisposes_towards](http://purl.obolibrary.org/obo/http_//purl.obolibrary.org/obo/mondo#predisposes_towards)\)} some {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)}))


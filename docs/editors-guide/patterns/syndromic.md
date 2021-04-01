# syndromic 

[http://purl.obolibrary.org/obo/mondo/patterns/syndromic.yaml](http://purl.obolibrary.org/obo/mondo/patterns/syndromic.yaml)
## Description 

Some diseases exist in both isolated and syndromic forms. For example, aniridia ([MONDO_0019172 aniridia](http://purl.obolibrary.org/obo/MONDO_0019172), [MONDO_0020148'syndromic aniridia'](http://purl.obolibrary.org/obo/MONDO_0020148) and [MONDO_0007119 'isolated aniridia'](http://purl.obolibrary.org/obo/MONDO_0007119). Use this pattern to define the syndromic form of a disease when a term exists for the isolated/syndromic-neutral version. In general, this pattern should be used in parallel with isolated. E.g. if you make a term 'syndromic disease, you should also have 'isolated disease' [see pattern here(https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/isolated.yaml). 

Note that the isolated and syndromic forms will be inferred to be disjoint due to the GCI pattern.
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

syndromic {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)}

## Annotations 

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): syndromic {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)}

* [related_synonym](http://www.geneontology.org/formats/oboInOwl#hasRelatedSynonym): syndrome associated with {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)}

## Definition 

A {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)} that is part of a larger syndrome.

## Equivalent to 

{[disease](http://purl.obolibrary.org/obo/MONDO_0000001)} and [has modifier](http://purl.obolibrary.org/obo/RO_0002573) some [syndromic](http://purl.obolibrary.org/obo/MONDO_0021127)


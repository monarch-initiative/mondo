# disease_series_by_gene_and_inheritance 

[http://purl.obolibrary.org/obo/mondo/patterns/disease_series_by_gene.yaml](http://purl.obolibrary.org/obo/mondo/patterns/disease_series_by_gene.yaml)
## Description 

This pattern is for diseases that are caused by a single mutation in a single gene, that have gene-based names, and are inherited by a specific mechanism, succh as autosomal dominant and autosomal recessive. 

Examples: [Growth hormone insensitivity syndrome with immune dysregulation](https://omim.org/phenotypicSeries/PS245590), Growth hormone insensitivity with immune dysregulation 1, autosomal recessive and Growth hormone insensitivity with immune dysregulation 2, autosomal dominant
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
* [https://orcid.org/0000-0002-7356-1779](https://orcid.org/0000-0002-7356-1779) 
## Name 

{[disease](http://purl.obolibrary.org/obo/MONDO_0700096)} caused by mutation in {[gene](http://purl.obolibrary.org/obo/SO_0000704)}, {[mode_of_inheritance](http://purl.obolibrary.org/obo/HP_0000005)}

## Annotations 

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): {[gene](http://purl.obolibrary.org/obo/SO_0000704)} {[disease](http://purl.obolibrary.org/obo/MONDO_0700096)}, {[mode_of_inheritance](http://purl.obolibrary.org/obo/HP_0000005)}

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): {[gene](http://purl.obolibrary.org/obo/SO_0000704)} related {[disease](http://purl.obolibrary.org/obo/MONDO_0700096)}, {[mode_of_inheritance](http://purl.obolibrary.org/obo/HP_0000005)}

## Definition 

Any {[disease](http://purl.obolibrary.org/obo/MONDO_0700096)} in which the cause of the disease is a mutation in the {[gene](http://purl.obolibrary.org/obo/SO_0000704)} gene, and has {[mode_of_inheritance](http://purl.obolibrary.org/obo/HP_0000005)}.

## Equivalent to 

{[disease](http://purl.obolibrary.org/obo/MONDO_0700096)} and [has material basis in germline mutation in](http://purl.obolibrary.org/obo/RO_0004003) some {[gene](http://purl.obolibrary.org/obo/SO_0000704)} and [has characteristic](http://purl.obolibrary.org/obo/RO_0000053) some {[mode_of_inheritance](http://purl.obolibrary.org/obo/HP_0000005)}

## Data preview 
| defined_class                                | defined_class_label                                                       | disease                                      | disease_label                 | gene                              | gene_label   | mode_of_inheritance                       | mode_of_inheritance_label       |
|:---------------------------------------------|:--------------------------------------------------------------------------|:---------------------------------------------|:------------------------------|:----------------------------------|:-------------|:------------------------------------------|:--------------------------------|
| [MONDO:0007092](http://purl.obolibrary.org/obo/MONDO_0007092) | amelogenesis imperfecta type 1B                                           | [MONDO:0019507](http://purl.obolibrary.org/obo/MONDO_0019507) | amelogenesis imperfecta       | http://identifiers.org/hgnc/3344  | ENAM         | [HP:0000006](http://purl.obolibrary.org/obo/HP_0000006) | Autosomal dominant inheritance  |
| [MONDO:0014865](http://purl.obolibrary.org/obo/MONDO_0014865) | autosomal recessive severe congenital neutropenia due to CSF3R deficiency | [MONDO:0018542](http://purl.obolibrary.org/obo/MONDO_0018542) | severe congenital neutropenia | http://identifiers.org/hgnc/2439  | CSF3R        | [HP:0000007](http://purl.obolibrary.org/obo/HP_0000007) | Autosomal recessive inheritance |
| [MONDO:0018487](http://purl.obolibrary.org/obo/MONDO_0018487) | autosomal recessive severe congenital neutropenia due to CXCR2 deficiency | [MONDO:0018542](http://purl.obolibrary.org/obo/MONDO_0018542) | severe congenital neutropenia | http://identifiers.org/hgnc/6027  | CXCR2        | [HP:0000007](http://purl.obolibrary.org/obo/HP_0000007) | Autosomal recessive inheritance |
| [MONDO:0012930](http://purl.obolibrary.org/obo/MONDO_0012930) | autosomal recessive severe congenital neutropenia due to G6PC3 deficiency | [MONDO:0018542](http://purl.obolibrary.org/obo/MONDO_0018542) | severe congenital neutropenia | http://identifiers.org/hgnc/24861 | G6PC3        | [HP:0000007](http://purl.obolibrary.org/obo/HP_0000007) | Autosomal recessive inheritance |
| [MONDO:0014456](http://purl.obolibrary.org/obo/MONDO_0014456) | autosomal recessive severe congenital neutropenia due to JAGN1 deficiency | [MONDO:0018542](http://purl.obolibrary.org/obo/MONDO_0018542) | severe congenital neutropenia | http://identifiers.org/hgnc/26926 | JAGN1        | [HP:0000007](http://purl.obolibrary.org/obo/HP_0000007) | Autosomal recessive inheritance |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/disease_series_by_gene_and_inheritance.tsv) 

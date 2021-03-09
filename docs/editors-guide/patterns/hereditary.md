# hereditary 

[http://purl.obolibrary.org/obo/mondo/patterns/hereditary.yaml](http://purl.obolibrary.org/obo/mondo/patterns/hereditary.yaml)
## Description 


Pattern for extending a etiology-generic disease class to a hereditary form.  Here hereditary means that etiology is largely genetic, and that the disease is passed down or potentially able to be passed down via inheritance (i.e is germline).
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

hereditary {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)}

## Annotations 

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: hereditary {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)}

## Definition 

An instance of {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} that is caused by an inherited genomic modification in an individual.

## Equivalent to 

{disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} and {has modifier\([RO:0002573](http://purl.obolibrary.org/obo/RO_0002573)\)} some {hereditary\([MONDO:0021152](http://purl.obolibrary.org/obo/MONDO_0021152)\)}

## Data preview 
| defined:class                                | defined:class:label                                         | disease                                      | disease:label                                    |
|:---------------------------------------------|:------------------------------------------------------------|:---------------------------------------------|:-------------------------------------------------|
| MONDO:0003847 | Mendelian disease                                           | MONDO:0000001 | disease or disorder                              |
| MONDO:0007573 | acute erythroleukemia, familial                             | MONDO:0017858 | acute erythroid leukemia                         |
| MONDO:0008734 | adrenocortical carcinoma, hereditary                        | MONDO:0006639 | adrenal cortex carcinoma                         |
| MONDO:0016072 | anomaly of puberty or/and menstrual cycle of genetic origin | MONDO:0015860 | anomaly of puberty or/and menstrual cycle        |
| MONDO:0009925 | autosomal recessive inherited pseudoxanthoma elasticum      | MONDO:0024308 | pseudoxanthoma elasticum (inherited or acquired) |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/hereditary.tsv) 

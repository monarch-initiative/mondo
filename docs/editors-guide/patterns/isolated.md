# isolated 

[http://purl.obolibrary.org/obo/mondo/patterns/isolated.yaml](http://purl.obolibrary.org/obo/mondo/patterns/isolated.yaml)
## Description 

Some diseases exist in both isolated and syndromic forms. For example, aniridia ([MONDO_0019172 aniridia](http://purl.obolibrary.org/obo/MONDO_0019172), [MONDO_0020148'syndromic aniridia'](http://purl.obolibrary.org/obo/MONDO_0020148) and [MONDO_0007119 'isolated aniridia'](http://purl.obolibrary.org/obo/MONDO_0007119). Use this pattern to define the isolated form of a disease when a term exists for the isolated/syndromic-neutral version. In general, this pattern should be used in parallel with syndromic. E.g. if you make a term 'syndromic disease, you should also have 'isolated disease' [see pattern here(https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/syndromic.yaml).  Note that the isolated and syndromic forms will be inferred to be disjoint due to the GCI pattern.

Examples: ['isolated aniridia'](http://purl.obolibrary.org/obo/MONDO_0007119), ['isolated dystonia'](http://purl.obolibrary.org/obo/MONDO_0015494), ['isolated focal palmoplantar keratoderma'](http://purl.obolibrary.org/obo/MONDO_0017673)
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

isolated {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)}

## Annotations 

* [exact_synonym](http://www.geneontology.org/formats/oboInOwl#hasExactSynonym): nonsyndromic {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)}

## Definition 

A {[disease](http://purl.obolibrary.org/obo/MONDO_0000001)} that is not part of a larger syndrome.

## Equivalent to 

{[disease](http://purl.obolibrary.org/obo/MONDO_0000001)} and [has modifier](http://purl.obolibrary.org/obo/RO_0002573) some [isolated](http://purl.obolibrary.org/obo/MONDO_0021128)

## Data preview 
| defined_class                                | defined_class_label                                          | disease                                      | disease_label                                   |
|:---------------------------------------------|:-------------------------------------------------------------|:---------------------------------------------|:------------------------------------------------|
| [MONDO:0016342](http://purl.obolibrary.org/obo/MONDO_0016342) | familial isolated arrhythmogenic right ventricular dysplasia | [MONDO:0016587](http://purl.obolibrary.org/obo/MONDO_0016587) | arrhythmogenic right ventricular cardiomyopathy |
| [MONDO:0020075](http://purl.obolibrary.org/obo/MONDO_0020075) | genetic non-syndromic obesity                                | [MONDO:0019182](http://purl.obolibrary.org/obo/MONDO_0019182) | monogenic obesity                               |
| [MONDO:0017262](http://purl.obolibrary.org/obo/MONDO_0017262) | inherited non-syndromic ichthyosis                           | [MONDO:0015947](http://purl.obolibrary.org/obo/MONDO_0015947) | inherited ichthyosis                            |
| [MONDO:0016520](http://purl.obolibrary.org/obo/MONDO_0016520) | isolated Klippel-Feil syndrome                               | [MONDO:0001029](http://purl.obolibrary.org/obo/MONDO_0001029) | Klippel-Feil syndrome                           |
| [MONDO:0016462](http://purl.obolibrary.org/obo/MONDO_0016462) | isolated agammaglobulinemia                                  | [MONDO:0015977](http://purl.obolibrary.org/obo/MONDO_0015977) | agammaglobulinemia                              |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/isolated.tsv) 

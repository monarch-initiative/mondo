# consequence_of_infectious_disease 

[http://purl.obolibrary.org/obo/mondo/patterns/consequence_of_infectious_disease.yaml](http://purl.obolibrary.org/obo/mondo/patterns/consequence_of_infectious_disease.yaml)
## Description 

This pattern is applied to a disease that is caused by an infectious agent.

Examples: [hepatitis C induced liver cirrhosis](http://purl.obolibrary.org/obo/MONDO_0005448), [rubella encephalitis](http://purl.obolibrary.org/obo/MONDO_0020648)
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

{[cause](http://purl.obolibrary.org/obo/MONDO_0005550)} {[parent](http://purl.obolibrary.org/obo/MONDO_0000001)}

## Definition 

A {[parent](http://purl.obolibrary.org/obo/MONDO_0000001)} that arises as a consequence of {[cause](http://purl.obolibrary.org/obo/MONDO_0005550)}.

## Equivalent to 

{[parent](http://purl.obolibrary.org/obo/MONDO_0000001)} and [disease arises from feature](http://purl.obolibrary.org/obo/RO_0004022) some {[cause](http://purl.obolibrary.org/obo/MONDO_0005550)}

## Data preview 
| defined_class                                | defined_class_label                         | cause                                        | cause_label                   | parent                                       | parent_label              |
|:---------------------------------------------|:--------------------------------------------|:---------------------------------------------|:------------------------------|:---------------------------------------------|:--------------------------|
| [MONDO:0020689](http://purl.obolibrary.org/obo/MONDO_0020689) | AIDS dementia complex                       | [MONDO:0005109](http://purl.obolibrary.org/obo/MONDO_0005109) | HIV infectious disease        | [MONDO:0001627](http://purl.obolibrary.org/obo/MONDO_0001627) | dementia (disease)        |
| [MONDO:0005491](http://purl.obolibrary.org/obo/MONDO_0005491) | Chagas cardiomyopathy                       | [MONDO:0001444](http://purl.obolibrary.org/obo/MONDO_0001444) | Chagas disease                | [MONDO:0004994](http://purl.obolibrary.org/obo/MONDO_0004994) | cardiomyopathy            |
| [MONDO:0000890](http://purl.obolibrary.org/obo/MONDO_0000890) | Zika virus congenital syndrome              | [MONDO:0018661](http://purl.obolibrary.org/obo/MONDO_0018661) | Zika virus infectious disease | [MONDO:0000839](http://purl.obolibrary.org/obo/MONDO_0000839) | congenital abnormality    |
| [MONDO:0005448](http://purl.obolibrary.org/obo/MONDO_0005448) | hepatitis C induced liver cirrhosis         | [MONDO:0005231](http://purl.obolibrary.org/obo/MONDO_0005231) | hepatitis C virus infection   | [MONDO:0005155](http://purl.obolibrary.org/obo/MONDO_0005155) | cirrhosis of liver        |
| [MONDO:0034103](http://purl.obolibrary.org/obo/MONDO_0034103) | infection-related hemolytic uremic syndrome | [MONDO:0005550](http://purl.obolibrary.org/obo/MONDO_0005550) | infectious disease            | [MONDO:0001549](http://purl.obolibrary.org/obo/MONDO_0001549) | hemolytic-uremic syndrome |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/consequence_of_infectious_disease.tsv) 

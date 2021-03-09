# consequence_of_infectious_disease 

[http://purl.obolibrary.org/obo/mondo/patterns/consequence_of_infectious_disease.yaml](http://purl.obolibrary.org/obo/mondo/patterns/consequence_of_infectious_disease.yaml)
## Description 

TBD.
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
## Name 

{cause\([MONDO:0005550](http://purl.obolibrary.org/obo/MONDO_0005550)\)} {parent\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)}

## Definition 

A {parent\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} that arises as a consequence of {cause\([MONDO:0005550](http://purl.obolibrary.org/obo/MONDO_0005550)\)}.

## Equivalent to 

{parent\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} and {disease arises from feature\([RO:0004022](http://purl.obolibrary.org/obo/RO_0004022)\)} some {cause\([MONDO:0005550](http://purl.obolibrary.org/obo/MONDO_0005550)\)}

## Data preview: 
| defined:class                                | defined:class:label                         | cause                                        | cause:label                   | parent                                       | parent:label              |
|:---------------------------------------------|:--------------------------------------------|:---------------------------------------------|:------------------------------|:---------------------------------------------|:--------------------------|
| MONDO:0005491 | Chagas cardiomyopathy                       | MONDO:0001444 | Chagas disease                | MONDO:0004994 | cardiomyopathy            |
| MONDO:0000890 | Zika virus congenital syndrome              | MONDO:0018661 | Zika virus infectious disease | MONDO:0000839 | congenital abnormality    |
| MONDO:0005448 | hepatitis C induced liver cirrhosis         | MONDO:0005231 | hepatitis C virus infection   | MONDO:0005155 | cirrhosis of liver        |
| MONDO:0034103 | infection-related hemolytic uremic syndrome | MONDO:0005550 | infectious disease            | MONDO:0001549 | hemolytic-uremic syndrome |
| MONDO:0002812 | infectious otitis interna                   | MONDO:0005550 | infectious disease            | MONDO:0002008 | labyrinthitis             |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/consequence_of_infectious_disease.tsv) 

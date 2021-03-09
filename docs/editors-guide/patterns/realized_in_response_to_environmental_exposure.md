# disease realized in response to environmental exposure 

[http://purl.obolibrary.org/obo/mondo/patterns/realized_in_response_to_evironmental_exposure.yaml](http://purl.obolibrary.org/obo/mondo/patterns/realized_in_response_to_evironmental_exposure.yaml)
## Description 

This pattern is used for a disease, where the cause of the disease is an exposure to an environmental stimulus (using ECTO exposure terms).
Examples: [chemically-induced disorder](http://purl.obolibrary.org/obo/MONDO_0029001), [alcohol amnestic disorder](http://purl.obolibrary.org/obo/MONDO_0021702), [alcoholic polyneuropathy](http://purl.obolibrary.org/obo/MONDO_0006645) (26 total)
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
* [https://orcid.org/0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432) 
## Name 

{disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} realized in response to {exposure\([ExO:0000002](http://purl.obolibrary.org/obo/ExO_0000002)\)}

## Definition 

Any {disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} that is realized in response to a {exposure\([ExO:0000002](http://purl.obolibrary.org/obo/ExO_0000002)\)}

## Equivalent to 

{disease\([MONDO:0000001](http://purl.obolibrary.org/obo/MONDO_0000001)\)} and ({realized in response to\([RO:0009501](http://purl.obolibrary.org/obo/RO_0009501)\)} some {exposure\([ExO:0000002](http://purl.obolibrary.org/obo/ExO_0000002)\)})

## Data preview: 
| defined:class                                | defined:class:label                        | disease                                      | disease:label                | exposure                                    | exposure:label                    |
|:---------------------------------------------|:-------------------------------------------|:---------------------------------------------|:-----------------------------|:--------------------------------------------|:----------------------------------|
| MONDO:0060781 | Preeyasombat-Varavithya syndrome           | MONDO:0001083 | Fanconi renotubular syndrome | ECTO:9000364 | tetracycline exposure             |
| MONDO:0003245 | aflatoxin-related hepatocellular carcinoma | MONDO:0007256 | hepatocellular carcinoma     | ECTO:0001108 | aflatoxin exposure                |
| MONDO:0044663 | aquagenic palmoplantar keratoderma         | MONDO:0006590 | palmoplantar keratosis       | ECTO:9000156 | water exposure                    |
| MONDO:0043523 | cadmium poisoning                          | MONDO:0029000 | poisoning                    | ECTO:0001566 | cadmium molecular entity exposure |
| MONDO:0000706 | chemical colitis                           | MONDO:0005292 | colitis (disease)            | ECTO:0000231 | chemical entity exposure          |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/realized_in_response_to_environmental_exposure.tsv) 

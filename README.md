[![Jenkins master status](https://ci.monarchinitiative.org/buildStatus/icon?subject=Jenkins%20master%20status&job=test-mondo&build=last:${params.MONDO_BRANCH=master})](https://ci.monarchinitiative.org/job/test-mondo/)

<img src="https://github.com/jmcmurry/closed-illustrations/blob/master/logos/mondo-logos/mondo_logo_black-banner.png"/>

# Mondo

This is the repository for managing the Mondo Disease Ontology (Mondo). Mondo aims to harmonizes disease definitions across the world. For more details on this ontology see:

 * **Mondo website**: https://monarch-initiative.github.io/mondo
 * **OBO Foundry Mondo page**: http://obofoundry.org/ontology/mondo.html

## Versions

Stable release versions

 * http://purl.obolibrary.org/obo/mondo.obo
 * http://purl.obolibrary.org/obo/mondo.json
 * http://purl.obolibrary.org/obo/mondo.owl

See [Changes.md](Changes.md) for more details

## Editors' version

Editors of this ontology should use the edit version, [src/ontology/mondo-edit.obo](src/ontology/mondo-edit.obo)

Read the editors guide first!

https://mondo.readthedocs.io/en/latest/

Layout:

 * src/
    * [ontology](src/ontology) ontology source, plus imports, Makefile
    * [patterns](src/patterns/dosdp-patterns) templated design patterns
    * [sparql](src/sparql) SPARQL queries

## Logo

The Mondo logo is available here: https://github.com/jmcmurry/closed-illustrations/tree/master/logos/mondo-logos

## License
[CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/)

## Contact

Please use this GitHub repository's [Issue tracker](https://github.com/monarch-initiative/mondo-build/issues) to request new terms/classes or report errors or specific concerns related to the ontology.

## Acknowledgements

This ontology repository was created using the [ontology starter kit](https://github.com/INCATools/ontology-starter-kit)



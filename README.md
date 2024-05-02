![Build Status](https://github.com/monarch-initiative/mondo/workflows/CI/badge.svg) <img width="100px" src="http://mirrors.creativecommons.org/presskit/buttons/80x15/png/by.png" alt="CC BY 4.0">

<img src="https://github.com/jmcmurry/closed-illustrations/blob/master/logos/mondo-logos/mondo_logo_black-banner.png"/>

# Mondo

This is the repository for managing the Mondo Disease Ontology (Mondo). Mondo aims to harmonizes disease definitions across the world. For more details on this ontology see:

 * **Mondo website**: https://monarch-initiative.github.io/mondo
 * **OBO Foundry Mondo page**: http://obofoundry.org/ontology/mondo.html

## Identifiers

Concepts in Mondo are represented by URIs like http://purl.obolibrary.org/obo/MONDO_0005015 or by
compact URIs ([CURIEs](https://en.wikipedia.org/wiki/CURIE)) with the prefix `MONDO:`, such as `MONDO:0005015`, as required by the
[OBO Foundry Identifier Policy](http://obofoundry.org/id-policy).

## Versions

Stable release versions

 * [http://purl.obolibrary.org/obo/mondo.obo](https://github.com/monarch-initiative/mondo/releases/latest/download/mondo.obo)
 * [http://purl.obolibrary.org/obo/mondo.json](https://github.com/monarch-initiative/mondo/releases/latest/download/mondo.json)
 * [http://purl.obolibrary.org/obo/mondo.owl](https://github.com/monarch-initiative/mondo/releases/latest/download/mondo.owl)

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

## Cite

[Mondo: Unifying diseases for the world, by the world](https://www.medrxiv.org/content/10.1101/2022.04.13.22273750v1), Nicole A Vasilevsky, Nicolas A Matentzoglu, Sabrina Toro, Joseph E Flack IV, Harshad Hegde, Deepak R Unni, Gioconda F Alyea, Joanna S Amberger, Larry Babb, James P Balhoff, Taylor I Bingaman, Gully A Burns, Orion J Buske, Tiffany J Callahan, Leigh C Carmody, Paula Carrio Cordo, Lauren E Chan, George S Chang, Sean L Christiaens, Louise C Daugherty, Michel Dumontier, Laura E Failla, May J Flowers, H. Alpha Garrett Jr., Jennifer L Goldstein, Dylan Gration, Tudor Groza, Marc Hanauer, Nomi L Harris, Jason A Hilton, Daniel S Himmelstein, Charles Tapley Hoyt, Megan S Kane, Sebastian Köhler, David Lagorce, Abbe Lai, Martin Larralde, Antonia Lock, Irene López Santiago, Donna R Maglott, Adriana J Malheiro, Birgit H M Meldal, Monica C Munoz-Torres, Tristan H Nelson, Frank W Nicholas, David Ochoa, Daniel P Olson, Tudor I Oprea, David Osumi-Sutherland, Helen Parkinson, Zoë May Pendlington, Ana Rath, Heidi L Rehm, Lyubov Remennik, Erin R Riggs, Paola Roncaglia, Justyne E Ross, Marion F Shadbolt, Kent A Shefchek, Morgan N Similuk, Nicholas Sioutos, Damian Smedley, Rachel Sparks, Ray Stefancsik, Ralf Stephan, Andrea L Storm, Doron Stupp, Gregory S Stupp, Jagadish Chandrabose Sundaramurthi, Imke Tammen, Darin Tay, Courtney L Thaxton, Eloise Valasek, Jordi Valls-Margarit, Alex H Wagner, Danielle Welter, Patricia L Whetzel, Lori L Whiteman, Valerie Wood, Colleen H Xu, Andreas Zankl, Xingmin Aaron Zhang, Christopher G Chute, Peter N Robinson, Christopher J Mungall, Ada Hamosh, Melissa A Haendel, medRxiv 2022.04.13.22273750; doi: https://doi.org/10.1101/2022.04.13.22273750

## License
[CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/)

## Contact

Please use this GitHub repository's [Issue tracker](https://github.com/monarch-initiative/mondo-build/issues) to request new terms/classes or report errors or specific concerns related to the ontology.

## Acknowledgements

This ontology repository was created using the [ontology starter kit](https://github.com/INCATools/ontology-starter-kit)



![Build Status](https://github.com/monarch-initiative/mondo/workflows/CI/badge.svg) <img width="100px" src="http://mirrors.creativecommons.org/presskit/buttons/80x15/png/by.png" alt="CC BY 4.0">

<img src="https://github.com/jmcmurry/closed-illustrations/blob/master/logos/mondo-logos/mondo_logo_black-banner.png"/>

# Mondo

This is the repository for managing the Mondo Disease Ontology (Mondo). Mondo aims to harmonizes disease definitions across the world. For more details on this ontology see:

 * **Mondo website**: https://mondo.monarchinitiative.org/
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

The Mondo logo is available here: https://github.com/tis-lab/closed-illustrations/tree/master/logos/mondo-logos

## Cite

[Mondo: integrating disease terminology across communities](https://doi.org/10.1093/genetics/iyaf215), Nicole A Vasilevsky, Sabrina Toro, Nicolas Matentzoglu, Joseph E Flack, Kathleen R Mullen, Harshad Hegde, Sarah Gehrke, Patricia L Whetzel, Yousif Shwetar, Nomi L Harris, Mee S Ngu, Gioconda L Alyea, Megan S Kane, Paola Roncaglia, Eric Sid, Courtney L Thaxton, Valerie Wood, Roshini S Abraham, Maria Isabel Achatz, Pamela Ajuyah, Joanna S Amberger, Lawrence Babb, Jasmine Baker, James P Balhoff, Jonathan S Berg, Amol Bhalla, Xavier Bofill-De Ros, Ian R Braun, Eleanor C Broeren, Blake K Byer, Alicia B Byrne, Tiffany J Callahan, Leigh C Carmody, Lauren E Chan, Amanda R Clause, Julie S Cohen, Marcello DeLuca, Natalie T Deuitch, May Flowers, Jamie Fraser, Toyofumi Fujiwara, Vanessa Gitau, Jennifer L Goldstein, Dylan Gration, Tudor Groza, Benjamin M Gyori, William Hankey, Jason A Hilton, Daniel S Himmelstein, Stephanie S Hong, Charles T Hoyt, Robert Huether, Eric Hurwitz, Julius O B Jacobsen, Atsuo Kikuchi, Sebastian Köhler, Daniel R Korn, David Lagorce, Bryan J Laraway, Jane Y Li, Adriana J Malheiro, James McLaughlin, Birgit H M Meldal, Shruthi Mohan, Sierra A T Moxon, Monica C Munoz-Torres, Tristan H Nelson, Frank W Nicholas, David Ochoa, Daniel Olson, Tudor I Oprea, Tomiko T Oskotsky, David Osumi-Sutherland, Kelley Paris, Helen E Parkinson, Zoë M Pendlington, Xiao P Peng, Amy Pizzino, Sharon E Plon, Bradford C Powell, Julie C Ratliff, Heidi L Rehm, Lyubov Remennik, Erin R Riggs, Sean Roberts, Peter N Robinson, Justyne E Ross, Kevin Schaper, Brian M Schilder, Johanna L Schmidt, Elliott W Sharp, Morgan N Similuk, Damian Smedley, Tam P Sneddon, Rachel Sparks, Ray Stefancsik, Gregory S Stupp, Shilpa Sundar, Terue Takatsuki, Imke Tammen, Kezang C Tshering, Deepak R Unni, Eloise Valasek, Adeline Vanderver, Alex H Wagner, Ryan F Webb, Danielle Welter, Doron Yaya-Stupp, Andreas Zankl, Xingmin Aaron Zhang, Julie A McMurry, Christopher G Chute, Ada Hamosh, Christopher J Mungall, Melissa A Haendel, ClinGen DICER1 and miRNA-Processing Gene Variant Curation Expert Panel; ClinGen Hereditary Gene Curation Expert Panel; ClinGen Motile Ciliopathy Gene Curation Expert Panel; ClinGen Myeloid Malignancy Variant Curation Expert Panel; ClinGen TP53 Variant Curation Expert Panel; ClinGen X-Linked Inherited Retinal Disease Variant Curation Expert Panel, Genetics, Volume 232, Issue 4, April 2026, iyaf215, https://doi.org/10.1093/genetics/iyaf215

## License
[CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/)

## Contact

Please use this GitHub repository's [Issue tracker](https://github.com/monarch-initiative/mondo-build/issues) to request new terms/classes or report errors or specific concerns related to the ontology.

## Acknowledgements

This ontology repository was created using the [ontology starter kit](https://github.com/INCATools/ontology-starter-kit)


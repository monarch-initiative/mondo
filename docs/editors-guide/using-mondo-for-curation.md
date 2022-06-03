# Using Mondo for Data Curation

The following is intended to serve as a guide for anyone who would like to use Mondo for curating disease annotations.

## Important considerations

- Curation using ontologies is intended for use in artificial intelligence (AI) and machine learning.
- When using an ontology for curation, the annotation MUST be done to the CONCEPT (ID), and NOT to the name/synonyms.
- The disease name (label) might change over time depending on the latest knowledge, but the concept ID will never change.
- If there is a change in the concept, the ID/term will be obsoleted, and a new concept will be created. A 'term replaced by' annotation will point to the new term. If the obsoleted term is not replaced by a new term, there may be a 'consider' annotation, that points to a new term to consider using for annotation.
- Note: as long as curations are made to the concept, annotations will always be correct.

### Example
`MONDO:0013731` was renamed from `EMARDD Syndrome (Early-onset myopathy-areflexia-respiratory distress-dysphagia syndrome)` to `MEGF10-related myopathy`

If this disease was annotated with the phenotypes muscle weakness, respiratory difficulties, joint contractures, scoliosis, the phenotypes would still be associated with the same concept, even though the name changed.

See issue [https://github.com/monarch-initiative/mondo/issues/1112](https://github.com/monarch-initiative/mondo/issues/1112)

## Curate to the Definition

- When annotating a disease with a Mondo term, always curate to the definition of the Mondo term, not based on the primary label. 
- Therefore, if the label changes, your annotation will always be correct.
- Review the hierarchy of the term and curate to the most specific term possible.

## Consider the hierarchy/term parentage

Review the ontology classification and annotate to the most specific term when possible.

## Example

If you are curating the statement: “The patient was diagnosed with myofibrillar myopathy, and displayed progressive limb and axial muscle weakness.”  

You would annotate the term `MONDO:0018943 myofibrillar myopathy`. See Figure 1.

If you are curating the statement: “The patient was diagnosed with myofibrillar myopathy caused by a variation in BAG3. The patient displayed progressive limb and axial muscle weakness (...).”  

You would annotate the term `MONDO:0018943 myofibrillar myopathy 6`. See Figure 1.

<img width="895" alt="image" src="https://user-images.githubusercontent.com/6722114/171963572-110aad4d-cbe3-41f2-9eb4-03dd58b243c7.png">

**Figure 1**: Example hierarchy of myopathy in Mondo.

## Annotate up

- If the term you need is not available, annotate to the 'parent' class/ or superclass (the more general class in the hierarchy).

## Disease Naming

- See the [Mondo Disease Naming guide](https://mondo.monarchinitiative.org/pages/disease-naming/).

## Report issues

- If the term you need is not available, make a new term request on the [Mondo GitHub issue tracker](https://github.com/monarch-initiative/mondo/issues).
  - See this [guide](https://mondo.readthedocs.io/en/latest/editors-guide/c-make-good-term-request/) on how to make a good term request.
- You can also report bugs, request label changes/new names and more on the tracker.
- See this [guide](https://oboacademy.github.io/obook/pathways/ontology-contributor/) on contributing to ontologies.

## Contributors

- We want to acknowledgement your contributions to Mondo. We compiled a [list of our contributors](https://mondo.monarchinitiative.org/pages/contributors/) on our website.
- If your name is not listed on the website, please let us know by creating a ticket on the [Mondo GitHub issue tracker](https://github.com/monarch-initiative/mondo/issues).

## Cite Mondo

Nicole A Vasilevsky, Nicolas A Matentzoglu, Sabrina Toro, Joe E Flack, Harshad Hegde, Deepak R Unni, Gioconda Alyea, Joanna S Amberger, Larry Babb, James P Balhoff, Taylor I Bingaman, Gully A Burns, Tiffany J Callahan, Leigh C Carmody, Lauren E Chan, George S Chang, Michel Dumontier, Laura E Failla, May J Flowers, H A Garrett, Dylan Gration, Tudor Groza, Marc Hanauer, Nomi L Harris, Ingo Helbig, Jason A Hilton, Daniel S Himmelstein, Charles T Hoyt, Megan S Kane, Sebastian Köhler, David Lagorce, Martin Larralde, Antonia Lock, Irene López Santiago, Donna R Maglott, Adriana J Malheiro, Birgit HM Meldal, Julie A McMurry, Moni Munoz-Torres, Tristan H Nelson, David Ochoa, Tudor I Oprea, David Osumi-Sutherland, Helen Parkinson, Zoë M Pendlington, Ana Rath, Heidi L Rehm, Lyubov Remennik, Erin R Riggs, Paola Roncaglia, Justyne E Ross, Marion F Shadbolt, Kent A Shefchek, Morgan N Similuk, Nicholas Sioutos, Rachel Sparks, Ray Stefancsik, Ralf Stephan, Doron Stupp, Jagadish Chandrabose Sundaramurthi, Imke Tammen, Courtney L Thaxton, Eloise Valasek, Alex H Wagner, Danielle Welter, Patricia L Whetzel, Lori L Whiteman, Valerie Wood, Colleen H Xu, Andreas Zankl, Xingmin A Zhang, Christopher G Chute, Peter N Robinson, Christopher J Mungall, Ada Hamosh, Melissa A Haendel, [Mondo: Unifying diseases for the world, by the world](https://www.medrxiv.org/content/10.1101/2022.04.13.22273750v1), medRxiv 2022.04.13.22273750; doi: https://doi.org/10.1101/2022.04.13.22273750

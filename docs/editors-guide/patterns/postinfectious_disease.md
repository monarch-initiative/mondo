# postinfectious_disease 

[http://purl.obolibrary.org/obo/mondo/patterns/postinfectious_disease.yaml](http://purl.obolibrary.org/obo/mondo/patterns/postinfectious_disease.yaml)
## Description 

A design pattern for conditions such as post-herpetic neuralgia or postinfectious encephalitis, where the disease is secondary to the initial infection.
TODO: write better guidelines on what constitutes a secondary disease vs primary. * We do not use this pattern for AIDS-HIV for example, instead representing this is using SubClassOf. * We draw a distinction between infectious and postinfectious encepahlitis. * we do not use this pattern for chickenpox, but we do for shingles 
## Contributors 
* [https://orcid.org/0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165) 
## Name 

postinfectious {disease\([NCBITaxon:1](http://purl.obolibrary.org/obo/NCBITaxon_1)\)} arising from {feature\([MONDO:0005550](http://purl.obolibrary.org/obo/MONDO_0005550)\)}

## Annotations 

* annotation: exact_synonym\([oio:hasExactSynonym](http://purl.obolibrary.org/obo/oio_hasExactSynonym)\)  
text: post-{feature\([MONDO:0005550](http://purl.obolibrary.org/obo/MONDO_0005550)\)} {disease\([NCBITaxon:1](http://purl.obolibrary.org/obo/NCBITaxon_1)\)}

* annotation: related_synonym\([oio:hasRelatedSynonym](http://purl.obolibrary.org/obo/oio_hasRelatedSynonym)\)  
text: {disease\([NCBITaxon:1](http://purl.obolibrary.org/obo/NCBITaxon_1)\)} secondary to {feature\([MONDO:0005550](http://purl.obolibrary.org/obo/MONDO_0005550)\)}

## Definition 

A post-infectious form of {disease\([NCBITaxon:1](http://purl.obolibrary.org/obo/NCBITaxon_1)\)} that arises as a result on an initial {feature\([MONDO:0005550](http://purl.obolibrary.org/obo/MONDO_0005550)\)}.

## Equivalent to 

{disease\([NCBITaxon:1](http://purl.obolibrary.org/obo/NCBITaxon_1)\)} and {disease arises from feature\([RO:0004022](http://purl.obolibrary.org/obo/RO_0004022)\)} some {feature\([MONDO:0005550](http://purl.obolibrary.org/obo/MONDO_0005550)\)}


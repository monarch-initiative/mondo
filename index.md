---
layout: splash
author_profile: true
#title: Mondo Home page
---
{% comment %} This is a comment {% endcomment %}

# Mondo Disease Ontology

The Mondo Disease Ontology (Mondo) aims to harmonize disease definitions across the world. It is a semi-automatically constructed ontology that merges in multiple disease resources to yield a coherent merged ontology. Original versions of Mondo were constructed entirely automatically and used the IDs of source databases and ontologies. Later, additional manually curated cross-ontology axioms were added, and a native Mondo ID system was used to avoid confusion with source databases.

One feature of Mondo is that it goes beyond loose xrefs. It curated precise 1:1 equivalence axioms connecting to other resources, validated by OWL reasoning. This means it is safe to propagate across these from OMIM, Orphanet, EFO, DOID (soon NCIT).

These precise mappings are available in three ways depending on the format:
- the .owl edition uses OWL equivalence axioms directly in the ontology. Note this makes it harder to browse in some portals, but this edition may be preferable for computational use. The owl edition also includes axiomatization using CL, Uberon, GO, HP, RO, NCBITaxon.
- the .obo versions are simpler, lacks inter-ontology axiomatization, and lack equivalence axioms to other databases; instead xrefs are used as the linking mechanism. If the ID is one of Orphanet, OMIM, DOID or EFO then the xref precisely shadows the equivalence axiom.
- the json edition

## Stable release versions

 - [http://purl.obolibrary.org/obo/mondo.obo](http://purl.obolibrary.org/obo/mondo.obo)
 - [http://purl.obolibrary.org/obo/mondo.json](http://purl.obolibrary.org/obo/mondo.json)
 - [http://purl.obolibrary.org/obo/mondo.owl](http://purl.obolibrary.org/obo/mondo.owl)

# GitHub

[https://github.com/monarch-initiative/mondo](https://github.com/monarch-initiative/mondo)

# License

[CC-BY](https://creativecommons.org/licenses/by/3.0/)

# Contact

[Mailing list](https://groups.google.com/forum/#!forum/mondo-users)

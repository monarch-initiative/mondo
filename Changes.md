## 2017-10-18

First release using new pipeline. kboom was used to combine orphanet,
efo, omim and doid. Note ncit is slated for future incorporation.

The resulting ontology was merged using most probably equivalence
axioms. MONDO IDs assigned as clique leaders. Source xrefs were
retained, but these xrefs were annotated with kboom interpretations
(see editors guide for details).

The kboom report was used to examine dubious merge groupings, these
were then manually addressed. Some issues were filed on the old
tracker: https://github.com/monarch-initiative/monarch-disease-ontology/issues

Additional axiomatization was added for straightforward high level
grouping classes.

For the release, we map back to original clique leaders. We also make
a 'pre' release consisting of classes with MONDO IDs as primary. See
obo page for more details:

http://obofoundry.org/ontology/mondo.html

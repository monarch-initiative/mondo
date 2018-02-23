## 2017-11-10 1.0 Release

This is the first release of MONDO with MONDO IDs as primary.

The core ontology is available in 3 formats:

 * http://purl.obolibrary.org/obo/mondo.obo : obo format, use xrefs for equivalence to externals
 * http://purl.obolibrary.org/obo/mondo.owl : owl format, use equivalence axioms to externals
 * http://purl.obolibrary.org/obo/mondo.json : json format, use equivalence axioms to externals

Downloads are also available from https://osf.io/2qk53/files/ but it is recommended you use the purls

All IDs in Orphanet, OMIM, EFO and DOID can be *precisely* mapped
forward using either equivalence axioms (OWL version) or via xrefs
(OBO Format version). Note that for these ID spaces, only precise 1-1
xrefs are included in the release file.

Mapping files for particular subsets available on request.

In the release following this one, NCIT and GARD will join this
precise set.

### Legacy Support

An alternate version of this version of MONDO that retains external
IDs and primary IDs is available in the extid/ folder on OSF, or via
purls

 * http://purl.obolibrary.org/obo/mondo/extid/mondo.obo
 * http://purl.obolibrary.org/obo/mondo/extid/mondo.owl
 * http://purl.obolibrary.org/obo/mondo/extid/mondo.json

Note this support will not be maintained in perpetuity. You are
recommended to use the main MONDO release.

## 2017-10-18 Pre-release

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

## NNNN

Addition of OMIA

https://github.com/monarch-initiative/monarch-disease-ontology/issues/55

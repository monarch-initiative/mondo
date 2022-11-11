# OMIM included entries

## Description

OMIM records have 'included' entries that are described as 'Other entities represented in this entry' on the top of the page, for example [https://omim.org/entry/233910](https://omim.org/entry/233910). These represent distinct, but often related diseases, and information about the disease is included with the OMIM entry and it is not someplace else. An 'included' label in OMIM is not as an alternate title. In most cases, the same genes are implicated for the proper disease and the 'included' term.


## Curation guidelines

In Mondo, 'included' entries in OMIM should be added to Mondo as distinct diseases.

1. If a term is an 'included' entry in OMIM, it should be a split into a new term.
2. Add the OMIM database cross reference, with the source `MONDO:includedEntryInOMIM`

## Related tickets

- [https://github.com/monarch-initiative/mondo/issues/5507](https://github.com/monarch-initiative/mondo/issues/5507)
- https://github.com/monarch-initiative/mondo/issues/2808#issuecomment-902978394

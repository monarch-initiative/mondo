# Community preferred labels

Since Summer 2025, we have a new system to document "community preferred labels" -
by annotating synonyms (currently, as of 15.08.2025, only exact synonyms from ClinGen and NORD). 

Here is an example:

```
[Term]
id: MONDO:0010590
name: FG syndrome 1
...
synonym: "FG Syndrome Type 1" EXACT [NORD:1142, Orphanet:93932] {OMO:0002001="https://w3id.org/information-resource-registry/nord"}
```

With the `OMO:0002001` annotation we express:

"While Mondo curators prefer to refer to `MONDO:0010590` using the primary label (`name`) `FG syndrome 1`, the _National Organization for Rare Disorders_ (NORD) prefers to refer to the same disease with the slightly different label `FG Syndrome Type 1`."

## Notes for curators and implementers

1. The ["preferred label for community"](https://www.ebi.ac.uk/ols4/ontologies/omo/properties/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FOMO_0002001) property is a standard property in OMO.
2. The annotation is added as an _axiom annotation_ straight on the synonym assertion (in the same way as we have done, for a long time, cross-references).
3. The value of `preferred label for community` annotation can technically be any URI, but in Mondo, we want this to be an entry from the [Information Resource Registry](https://biolink.github.io/information-resource-registry/registry/). Note, while _many_ resources / communities are listed there, not all of them are. For example, at the time of writing this, there was no entry for NORD, but there was one for ClinGen. In this case, please [request the resource/community on the issue tracker](https://github.com/biolink/information-resource-registry/issues). You do _not_ have to wait for it to be added to use it.

## How to manually curate "preferred label for community"

1. Select the exact synonym to be assigned as a "community preferred synonym"
2. Add an annotation and pick the Annotation Property: "preferred_label_for_community"
3. In the "literal" box, add the appropriate resource (Datatype is xsd:string)
    1. For ClinGen: https://w3id.org/information-resource-registry/clingen
    1. For NORD (though these are rarely added manually): https://w3id.org/information-resource-registry/nord

This is what an annotation looks like:


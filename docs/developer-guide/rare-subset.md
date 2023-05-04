# The Mondo Rare Disease Subset

The Mondo rare disease subset is a special version of Mondo created for the purpose
of supporting rare disease research and practice.

The central assumption behind the design of the subset is that 
there is _no universally accepted way to define "rare": 

1. Some diseases are considered rare in a specific locale, like Europe, but not globally
2. Specific criteria like maximum incidence rate differ from organisation to organisation


The Mondo Disease Subset does not try to reconcile these differences. Instead, it makes the differences in viewpoint explicit. We incorporate the views on rare disease from the following major organisations:

1. National Organization for Rare Disorders (NORD): https://rarediseases.org/
2. Genetic and Rare Diseases Information Center (GARD): https://rarediseases.info.nih.gov/
3. Orphanet: https://www.orpha.net
4. (TBD: OMIM: https://omim.org/)
5. Mondo: In addition to these we also curate our own view on what we consider rare in the Mondo disease ontology.

The rare disease subset is defined like this:

1. Any term that is considered rare by at least one of the above will be included as a rare disease, and annotated with the organisation that provided the "rare" distinction using a specific "rare" `subset`, for example: nord_rare, gard_rare, orphanet_rare.
2. Any term that meets this criteria is annotated additionally using a generic "rare" subset.
3. When the subset is extracted, all terms of the "rare" subset are selected, **together with all their Mondo Groupings**. In other words, for each rare disease term, we pull in _all_ their parents.

_Note for users_: We do _not_ provide an authoritative list of what is a rare disease with this rare disease subset. However, we believe that the integration of viewpoints of major Rare Disease organisations allows you, the user, to make an informed decision of which rare diseases to consider for your use cases. We have included the grouping classes provided by Mondo for your convenience, but you can filter these out by filterting on the `subsets` element. For example, in the JSON version of the subset, you can see the following for the MONDO:0007200 disease:

```
{
      "id" : "http://purl.obolibrary.org/obo/MONDO_0007200",
      "lbl" : "blepharonasofacial malformation syndrome",
      "type" : "CLASS",
      "meta" : {
        "definition" : {
          "val" : "Blepharonasofacial syndrome is a rare otorhinolaryngological malformation syndrome characterized by a distinctive mask-like facial dysmorphism, lacrimal duct obstruction, extrapyramidal features, digital malformations and intellectual disability.",
          "xrefs" : [ "Orphanet:1252" ]
        },
        "subsets" : [ "http://purl.obolibrary.org/obo/mondo#gard_rare", "http://purl.obolibrary.org/obo/mondo#mondo_rare", "http://purl.obolibrary.org/obo/mondo#ordo_malformation_syndrome", "http://purl.obolibrary.org/obo/mondo#orphanet_rare", "http://purl.obolibrary.org/obo/mondo#rare" ],
        "synonyms" : [...],
        "xrefs" : [...],
        "basicPropertyValues" : [ ... ]
      }
    }
```

The `subsets` listed indicate which authorities consider this disease "rare".

If the list of `subsets` does not include `http://purl.obolibrary.org/obo/mondo#rare`, you can assume that the class was included in the subset as a grouping term, not as a rare disease.


## Rare Disease Slim

We have started developing a rare disease slim, which provides a suggested high-level grouping of all rare disease classes in the ontology. A slim is a set of ontology classes that 

1. cover most of the rare disease classes in the ontology
2. is usally around 20 terms
3. Are not related in a subclass relation (to enable accurate binning without overlap)

The slim is curated using the `rare_grouping` subset tag, but as of 04.05.2023, is not finished yet.
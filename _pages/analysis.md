---
---
# Rare Disease analysis in Mondo

To answer the question of 'How many rare diseases are there?' we analyzed terms in Mondo to get a total count of Rare Diseases as defined in Mondo Disease Ontology (Mondo).

## Methods

This analysis was performed on the [Mondo 2019-09-30 release](http://purl.obolibrary.org/obo/mondo/releases/2019-09-30/mondo.json).


**1. Get all 'Disease' terms from Mondo**

First we get all the terms in Mondo that are a descendants of `MONDO:0000001 'Disease'`.

There are `21633` Mondo disease terms.


**2. Identify terms that are 'rare'**

Any disease term in Mondo is considered rare if the term, or its ancestor, has modifier `MONDO:0021136 'Rare'` in the ontology.

There are `12970` Mondo rare disease terms.


**3. Consider terms in 'gard_rare' subset**

There are `3176` Mondo disease terms that are in `gard_rare` subset that are yet to be treated as 'rare'.

We add these classes to our set of Mondo rare disease terms.

This increases the Mondo rare disease term count to `13922`.


**4. Filter terms that are descendants of 'disease susceptibility'**

We then to filter out terms that are descendants of `MONDO:0042489 'disease susceptibility'`, to avoid counting ambiguous terms that are related to disease susceptibility and not the actual disease itself.

This gives us a list of `13866` Mondo rare disease terms.


But for this analysis, we are interested in terms that are both rare and are leaf nodes in the ontology. 

After considering only leaf nodes, we get `10394` as the final count of Mondo rare disease terms.


## Results

[all-mondo-disease-terms.tsv](artifacts/all-mondo-disease-terms.tsv): As part of our analysis, we generated a TSV containing 21633 Mondo disease terms, each with annotations that signifies whether the term is a rare disease term and whether that term is a leaf node in the ontology.




# Proxy merge

A proxy merge is caused by two equivalentTo mappings two the same external ID:

MONDO:123 skos:exactMatch OMIM:123
MONDO:124 skos:exactMatch OMIM:123

The name proxy merge comes from the fact that MONDO:123 and MONDO:124 are merged "by proxy". This case is strictly forbidden in Mondo and we have QC guarding against it.

However, cases like this, informally referred to as reverse proxy merges, are allowed: two external concepts a considered the same by Mondo, for example:

```
MONDO:124 skos:exactMatch OMIM:123
MONDO:124 skos:exactMatch OMIM:124
```

In this case, OMIM:123 and OMIM:124 are merged together into one MONDO ID. This case is allowed: it does suggest that Mondo considers the two classes (OMIM:123 and OMIM:124) the same, while the upstream source considers them separate. 

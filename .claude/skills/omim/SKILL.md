---
name: omim
description: Use when a Mondo task needs anything from OMIM - titles, synonyms, included entries,
  gene-disease associations, phenotypic series, entry type, moved or removed entries, or entry text -
  while curating, merging, reviewing a PR or validating an OMIM xref
---

# Looking up OMIM

Never fetch omim.org pages. Use `omim.owl` first. Use the API only for what `omim.owl` does not have.

## 1. omim.owl

The mondo-ingest-omim release, the same OMIM data Mondo syncs against. Public, no key. Download it once per session:

```bash
curl -sL -o /tmp/omim.owl https://github.com/monarch-initiative/mondo-ingest-omim/releases/latest/download/omim.owl
```

One axiom per line, so grep is enough. Keep the closing `>`, and drop `IAO_0000142` (PubMed references) unless you need them:

```bash
grep 'entry/188050>' /tmp/omim.owl | grep -v IAO_0000142
```

| Line | Meaning |
|---|---|
| `rdfs:label` | Current title |
| `hasExactSynonym` | Current and alternative titles: EXACT |
| `hasSynonymType ... OMO_0003000` | Abbreviation |
| `hasRelatedSynonym` with `owl:deprecated` | Former title: EXACT in Mondo, see below |
| `mondo#omim_included` | INCLUDED title (`owl:deprecated`: a former one): a separate entity, not a synonym, see below |
| `RO_0004003` to `hgnc/N` | Causal gene. Has no source itself: read the `RO_0004003` line to `entry/<gene MIM>` for where it comes from |
| `RO_0004003` with `source` an ORCID | Gene link confirmed or added by a Mondo curator. Evidence (3) is always added to these, so it does not show what OMIM says. A second evidence line, e.g. (1), is OMIM's own |
| `RO_0003302`, `RO_0003303`, `RO_0003304` | Weaker gene link: several genes, linkage only, contiguous gene syndrome, or excluded by a curator |
| `SubClassOf ... phenotypicSeries/PSN` | Phenotypic series |
| `category ... Gene` | Gene entry, never an xref on a Mondo term |
| `MONDO_excludeTrait` | Entry without a prefix: phenotype not confirmed as Mendelian |
| `skos:exactMatch` to a Mondo term | Not evidence for `equivalentTo`: curator gene links add these too, also to terms for INCLUDED titles |
| `IAO_0100001`, `consider` | Moved to another entry |
| `owl:deprecated` on the entry | Moved or removed |

Gene links are filtered. Provisional (`?`), susceptibility (`{}`), nondisease (`[]`) and most multi-gene associations are missing or weaker. No gene line does not mean OMIM lists no gene: check the API, or leave it to a curator.

### Reporting titles

Always report titles in these two lists, and say "none" when one is empty:

1. **Titles of this entry**: label, alternative and former titles, abbreviations marked. All EXACT in Mondo, also the former titles that `omim.owl` has as RELATED and deprecated ("OMIM synonyms" in `CLAUDE.md` has the details).
2. **INCLUDED titles**: separate entities. Not synonyms of this entry's Mondo term. If Mondo has its own term for one (an `includedEntryInOMIM` xref to this entry, or a matching label), name it. If that term has the `equivalentTo` xref instead, don't move anything: flag it for a curator.

A title in both lists: report it in both, add nothing, and leave it to a curator.

Titles are normalised: lowercased, some Roman numerals made Arabic ("type II" → "type 2"), some abbreviations untyped. Restore proper nouns and gene symbols, and don't change a Mondo name only to match the numeral.

## 2. OMIM API

For entry text, the phenotype map (including `?` and `{}`) and clinical synopsis. Needs the curator's own key in `OMIM_API_KEY`:

```bash
curl -s -H "ApiKey: $OMIM_API_KEY" "https://api.omim.org/api/entry?mimNumber=117000&include=all&format=json"
```

The entry is at `.omim.entryList[0].entry`: text in `textSectionList`, gene associations in `phenotypeMapList` (phenotype entries) or `geneMap` (gene entries), references in `referenceList`.

- Fetch only the entries the task needs, never a whole series or the corpus.
- Do not save, commit or post the response. In Mondo, cite `OMIM:N`. If you must quote, one or two sentences with the MIM number.
- Never print the key or put it in a URL.

## 3. No key, or the call fails

Do not work around it: no web search for entry text, no copies on other sites, no text from memory. Use `omim.owl`, `mondo-edit.obo` and the cited papers, and list in your summary the OMIM checks a curator needs to do by hand.

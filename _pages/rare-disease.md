---
title: Rare Diseases
---
# Rare Diseases and Mondo

## The Global Challenge of Rare Diseases

An estimated **300 million people worldwide**—nearly 4% of the global population—are affected by a rare disease. Despite this enormous collective impact, the majority of rare conditions have only a handful of recorded cases. This limited representation means there is often scarce information about symptoms, causes, and disease progression, leading many patients through a "diagnostic odyssey" of incorrect diagnoses, unnecessary tests, and delayed care.

Consider fibrodysplasia ossificans progressiva (FOP), also known as "Stoneman syndrome" ([MONDO:0007606](https://monarchinitiative.org/disease/MONDO:0007606)): with an estimated prevalence of 1 in 2 million and only about 700 reported cases worldwide, FOP patients endure a high rate of initial misdiagnosis (87%), with many undergoing unnecessary biopsies (67%) and receiving inappropriate therapies (68%) ([PMID:31785620](https://pubmed.ncbi.nlm.nih.gov/31785620/), [PMID:16230464](https://pubmed.ncbi.nlm.nih.gov/16230464/)).

**Mondo brings together the world's rare disease resources to help shorten the diagnostic odysseys.**

---

## What Makes a Disease "Rare"?

There is no universal definition of "rare disease." The concept is typically defined by **prevalence**—the number of affected individuals per population—but these thresholds vary significantly:

| Region | Prevalence Threshold | Equivalent |
|--------|---------------------|------------|
| United States | Fewer than 1 in 1,650 | ~200,000 in US |
| European Union | Fewer than 1 in 2,000 | ~250,000 in EU |
| Japan | Fewer than 1 in 2,500 | ~50,000 in Japan |

Beyond different thresholds, **disease prevalence itself varies by geography**. For example, Kawasaki disease affects approximately 1 in 6,500-20,500 children under 5 in Europe (considered "rare"), but 1 in 324 in Japan (considered "common")([PMID:22307434](https://pmc.ncbi.nlm.nih.gov/articles/PMC3798585/), [PMID:30786118](https://pubmed.ncbi.nlm.nih.gov/30786118/)).

Some organizations also require additional criteria, such as the disease being "life-threatening or chronically debilitating" (EU criterion).

### Why This Matters

These differences have real consequences:
- **Research funding**: Programs like the FDA's Orphan Drug Designation provide incentives only for diseases classified as "rare"
- **Insurance coverage**: Whether a disease is designated "rare" can affect treatment coverage
- **Clinical trials**: Rare disease status influences eligibility for specialized trial pathways
- **Patient advocacy**: Organizations focus resources based on rare disease classifications

---

## How Mondo Handles Rare Diseases

Rather than imposing a single definition of "rare," Mondo takes a pragmatic, inclusive approach:

> **Mondo integrates rare disease information from multiple authoritative sources and transparently tracks which sources consider each disease to be rare.**

This means:
- ✅ You can access **all** diseases considered rare by **any** major authority
- ✅ You can filter to diseases considered rare by **specific** authorities relevant to your region or use case
- ✅ You always know the **provenance** of the "rare" designation

### Sources of Rare Disease Information in Mondo

| Source | What it provides | Subset annotation |
|--------|-----------------|-------------------|
| **[Orphanet](https://www.orpha.net/)** | European reference for rare diseases; comprehensive disease descriptions, diagnostic tests, orphan drug data | `orphanet_rare` |
| **[GARD](https://rarediseases.info.nih.gov/)** | NIH's Genetic and Rare Diseases Information Center; patient-friendly information for US audiences | `gard_rare` |
| **[NORD](https://rarediseases.org/)** | National Organization for Rare Disorders; patient advocacy, education, and research support | `nord_rare` |
| **Literature** | Diseases reported as rare in peer-reviewed publications but not yet in authoritative lists | `mondo_rare` |
| **Ontology inference** | Children of rare disease terms inherit the "rare" designation | `inferred_rare` |

### Understanding the Overlap

Not all sources agree on which diseases are rare. Our analysis shows:
- Only ~35% of diseases in Mondo's rare subset are considered rare by **all** authoritative sources
- ~40% are recognized by Orphanet
- Different sources use different criteria for what counts as a distinct "rare disease" (e.g., Orphanet counts only "disorders," while NORD and GARD also count disease subtypes)

This reflects genuine scientific and policy disagreement—not a problem to solve, but a reality to represent accurately.

---

## Finding Rare Diseases in Mondo

### For Patients and Advocates

If you're looking for information about a specific rare disease:

1. **Search on Monarch Initiative**: Visit [monarchinitiative.org](https://monarchinitiative.org/) and search for your disease
3. **Follow links to authoritative sources**: Each Mondo term links to original sources (Orphanet, GARD, NORD, OMIM, etc.) for detailed information

### For Researchers and Developers

#### Download the Rare Disease Subset

The Mondo rare disease subset includes all diseases considered rare by at least one authoritative source:

| Format | Download Link |
|--------|--------------|
| OBO | [mondo-rare.obo](http://purl.obolibrary.org/obo/mondo/subsets/mondo-rare.obo) |
| JSON | [mondo-rare.json](http://purl.obolibrary.org/obo/mondo/subsets/mondo-rare.json) |

#### Filter by Source

To get rare diseases according to a specific authority, filter by the `in_subset` annotation:

```
# Example: Get only Orphanet rare diseases
Filter where in_subset contains "orphanet_rare"

# Example: Get diseases rare in the US (GARD or NORD)
Filter where in_subset contains "gard_rare" OR "nord_rare"
```

#### Understanding Subset Annotations

Each rare disease term in Mondo has:

- **`rare`**: Present on ALL terms in the rare disease subset (union of all sources)
- **`orphanet_rare`**, **`gard_rare`**, **`nord_rare`**: Indicates the specific authority
- **`mondo_rare`**: Manually curated from literature (community-reported)
- **`inferred_rare`**: Inherited from a parent term that is rare
- **`rare_grouping`**: Parent terms included for classification context (not themselves rare diseases)

**Example**: Calciphylaxis ([MONDO:0017215](https://monarchinitiative.org/disease/MONDO:0017215)) is annotated with `nord_rare`, `gard_rare`, and `orphanet_rare`—indicating consensus across all three authorities.

---

## Real-World Applications

### COVID-19 and Rare Disease Research

The National COVID Cohort Collaborative (N3C) used Mondo to study outcomes for rare disease patients during the pandemic:

1. Imported Mondo's KGX format into the N3C research enclave
2. Selected terms with the "rare" designation
3. Leveraged Mondo's mappings to clinical codes (SNOMED, ICD-10, MeSH) to identify patients
4. Created a [rare disease dashboard](https://covid.cd2h.org/dashboard/) enabling researchers to explore rare disease cohorts

### Diagnostic Tools

Tools like [Exomiser](https://exomiser.monarchinitiative.org/) use Mondo's rare disease classifications alongside phenotype data to help clinicians navigate diagnostic odysseys and identify potentially pathogenic variants.

### Drug Repurposing

Mondo's integration of rare diseases with broader disease classifications enables researchers to identify common biological pathways between rare and common diseases—opening opportunities for drug repurposing.

---

## How Rare Disease Data is Maintained

Mondo maintains rare disease annotations through automated pipelines that synchronize monthly with authoritative sources:

- **GARD and NORD**: Partner organizations maintain spreadsheets with Mondo IDs; automated workflows update Mondo accordingly
- **Orphanet**: Automated integration from Orphanet's published data files
- **Community curation**: Researchers can report rare diseases not yet in authoritative lists via [GitHub issues](https://github.com/monarch-initiative/mondo/issues)

This system ensures:
- Authoritative sources remain the "source of truth"
- Updates propagate to Mondo within one month
- Full transparency about data provenance

---

## When Terms Change

### If a Mondo term is obsoleted
The term will not appear in the rare disease subset. The relevant authoritative source(s) will be notified.

### If a source removes a disease from their rare list
Only that source's annotation is removed (e.g., `gard_rare`). Other source annotations remain unchanged.

### If two Mondo terms are merged
Rare disease annotations will be transferred to the surviving term as soon as the update is made at the authoritative source.

---

## Get Involved

### Report a Missing Rare Disease
If you know of a rare disease not represented in Mondo or missing from the rare disease subset, please [open a GitHub issue](https://github.com/monarch-initiative/mondo/issues/new?template=rare_disease_request.md).

### Connect with Rare Disease Communities
Mondo works closely with rare disease organizations worldwide. [Contact us](info@monarchinitiative.org) to discuss collaboration opportunities.

### Rare Disease Day
Join us in recognizing [Rare Disease Day](https://www.rarediseaseday.org/) on the last day of February each year, raising awareness for the 300 million people living with rare diseases worldwide.

---

## Quick Reference

| I want to... | Action |
|-------------|--------|
| Find if my disease is considered rare | Search on [Monarch Initiative](https://monarchinitiative.org/) and check subset annotations |
| Download all rare diseases | Get [mondo-rare.obo](http://purl.obolibrary.org/obo/mondo/subsets/mondo-rare.obo) or [mondo-rare.json](http://purl.obolibrary.org/obo/mondo/subsets/mondo-rare.json) |
| Get rare diseases for a specific region | Filter by `orphanet_rare` (Europe), `gard_rare` or `nord_rare` (US) |
| Report a missing rare disease | [Open a GitHub issue](https://github.com/monarch-initiative/mondo/issues) |
| Learn more about a specific rare disease | Follow cross-references to OMIM, Orphanet, GARD, or NORD |

---

## Further Reading

- [Mondo Disease Ontology Documentation](https://mondo.readthedocs.io/)
- [Mondo: Integrating Disease Terminology Across Communities (Genetics, 2025)](https://doi.org/10.1093/genetics/iyaf215)
- [Orphanet - The portal for rare diseases](https://www.orpha.net/)
- [GARD - Genetic and Rare Diseases Information Center](https://rarediseases.info.nih.gov/)
- [NORD - National Organization for Rare Disorders](https://rarediseases.org/)
- [Rare Diseases International](https://www.rarediseasesinternational.org/)

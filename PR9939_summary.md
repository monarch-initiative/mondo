# PR #9939: Cystic fibrosis gap analysis — definition improvements, new terms, and classification

## Background

A comprehensive gap analysis comparing MONDO's CF representation against current medical literature identified several issues: a sparse CF definition, a typo in the CRMS term, missing internationally recognized disease entities (CFRD, CFTR-RD, CFLD), and absent classification relationships. This PR addresses these gaps.

## Changes to existing terms

### MONDO:0009061 — cystic fibrosis

- **Definition rewritten**: Old definition was a single sentence mentioning only "high salt sweat" and "abnormal mucus viscosity" (sourced from Wikipedia). New definition includes CFTR gene, autosomal recessive inheritance, diagnostic criteria (sweat chloride ≥60 mmol/L, two CF-causing variants, or abnormal NPD), and multi-organ manifestations. References updated to PMID:20301428, PMID:27140670, PMID:37278811.
- **Comment added** with structured diagnostic criteria and cross-reference to CFTR-related disorders (MONDO:7770004).
- **Synonym added**: "fibrocystic disease of the pancreas" (RELATED, PMID:27140670).

### MONDO:0100627 — CRMS/CFSPID

- **Definition rewritten**: Fixed typo ("CRTR gene" → "CFTR"), added international CFSPID designation, clarified diagnostic criteria. Added PMID:25630966.
- **Name updated** to "CFTR-related metabolic syndrome/CF screen positive, inconclusive diagnosis".
- **Synonyms added**: "CFSPID" (ABBREVIATION), "CRMS/CFSPID" (EXACT), "CF screen positive, inconclusive diagnosis" (EXACT), "CFTR-related metabolic syndrome" (EXACT).

### MONDO:0009062 — cystic fibrosis-gastritis-megaloblastic anemia syndrome

- **Classification axiom added**: `is_a: MONDO:0009061 {source="OMIM:219721"}` — patients meet full CF diagnostic criteria plus additional features.

### MONDO:0010178 — congenital bilateral aplasia of vas deferens from CFTR mutation

- **Classification axiom added**: `is_a: MONDO:7770004 {source="PMID:21658649"}` — CBAVD is the prototypical single-organ CFTR-related disorder.

## New terms

### MONDO:7770003 — cystic fibrosis-related diabetes (CFRD)

- `is_a:` diabetes mellitus (MONDO:0005015)
- `disease_arises_from_feature:` cystic fibrosis (MONDO:0009061)
- Distinct from type 1/2 diabetes; affects 20% of adolescents and 40-50% of adults with CF.
- Refs: PMID:21115772, PMID:29515516. Xref: ICD10CM:E13.

### MONDO:7770004 — CFTR-related disorder (CFTR-RD)

- `is_a:` hereditary disease (MONDO:0003847)
- `has_material_basis_in_germline_mutation_in:` HGNC:1884 (CFTR)
- Grouping term for conditions with CFTR dysfunction that do not meet CF diagnostic criteria (single-organ, sweat Cl⁻ <60 mmol/L). Based on international consensus (Bombieri et al. 2011).
- Ref: PMID:21658649, PMID:20301428.

### MONDO:7770005 — cystic fibrosis-related liver disease (CFLD)

- `is_a:` liver disorder (MONDO:0005154)
- `disease_arises_from_feature:` cystic fibrosis (MONDO:0009061)
- Spectrum of hepatobiliary abnormalities from CFTR dysfunction in cholangiocytes; affects 5-10% of CF patients.
- Refs: PMID:28753176, PMID:37278811.

## Classification design

CFRD and CFLD use `disease_arises_from_feature` (RO:0004022) — they are **complications** of CF, not subtypes. Their primary `is_a` parents are diabetes mellitus and liver disorder respectively. This follows the same pattern used for diabetic encephalopathy (MONDO:0000489) and diabetic nephropathy.

CF-gastritis syndrome uses `is_a` CF because patients meet full CF diagnostic criteria. CBAVD uses `is_a` CFTR-RD because it is a single-organ CFTR disorder not meeting CF criteria.

```
hereditary disease
  ├── cystic fibrosis (MONDO:0009061)
  │     └── CF-gastritis syndrome (MONDO:0009062)  [is_a]
  │     ── CFRD (MONDO:7770003)  [disease_arises_from_feature]
  │     ── CFLD (MONDO:7770005)  [disease_arises_from_feature]
  │
  ├── CFTR-related disorder (MONDO:7770004)
  │     └── CBAVD from CFTR (MONDO:0010178)  [is_a]
  │
  └── CRMS/CFSPID (MONDO:0100627)  [separate]
```

## Validation

Normalization (`make NORM`) and syntax validation (`robot convert`) both pass. All PMIDs verified.

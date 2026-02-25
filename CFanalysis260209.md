# Cystic Fibrosis & CFTR-Related Disorders: Analysis and Proposed MONDO Updates

**Date:** 2026-02-09 | **Branch:** cystic-fibrosis-updates

---

## Acronyms

| Acronym | Full Name |
|---------|-----------|
| **CF** | Cystic fibrosis |
| **CFTR** | Cystic fibrosis transmembrane conductance regulator (gene; HGNC:1884) |
| **CFTR-RD** | CFTR-related disorder |
| **CRMS** | CFTR-related metabolic syndrome (US designation) |
| **CFSPID** | CF screen positive, inconclusive diagnosis (international designation) |
| **CFRD** | Cystic fibrosis-related diabetes |
| **CFLD** | Cystic fibrosis-related liver disease |
| **CBAVD** | Congenital bilateral absence of the vas deferens |

---

## 1. CF vs CFTR-Related Disorder: Key Distinctions

Cystic fibrosis and CFTR-related disorders both involve dysfunction of the CFTR protein, but they are distinct clinical entities separated by diagnostic criteria, extent of organ involvement, and genotype.

| Feature | Cystic Fibrosis (CF) | CFTR-Related Disorder (CFTR-RD) |
|---|---|---|
| **Sweat chloride** | ≥60 mmol/L | Typically <60 mmol/L (normal or intermediate 30-59) |
| **Organ involvement** | Multi-organ (lungs, pancreas, GI, reproductive, hepatobiliary) | Single organ system |
| **CFTR variants** | Two CF-causing variants | At least one variant, often with ≥1 non-CF-causing allele |
| **Diagnostic criteria** | Meets formal CF diagnostic criteria | Does NOT meet CF diagnostic criteria |
| **Disease course** | Progressive, life-limiting | Variable; generally milder |
| **Examples** | Classic CF, non-classic/atypical CF | CBAVD, chronic pancreatitis, disseminated bronchiectasis |
| **MONDO term** | MONDO:0009061 | MONDO:7770004 (new) |
| **Key reference** | PMID:20301428 (GeneReviews) | PMID:21658649 (Bombieri et al. 2011) |

### Diagnostic criteria for CF

Diagnosis of CF requires **one clinical indicator** (positive newborn screen, symptoms consistent with CF, or family history) **plus one functional/genetic indicator**:

1. Sweat chloride concentration ≥60 mmol/L, or
2. Identification of two CF-causing CFTR pathogenic variants, or
3. Abnormal nasal potential difference measurement

### Definition of CFTR-RD

A CFTR-related disorder is defined as a clinical entity with evidence of CFTR dysfunction in at least one organ system that **does not meet** the diagnostic criteria for CF. Typically this means:

- Sweat chloride below the CF diagnostic threshold (<60 mmol/L)
- Clinical involvement limited to a single organ system
- CFTR genotype that includes at least one variant not classified as CF-causing

### Where does CRMS/CFSPID fit?

CRMS/CFSPID describes asymptomatic infants identified through newborn screening who have an inconclusive diagnosis. These infants have either:

- **Pattern A:** Normal sweat chloride (<30 mmol/L) + two CFTR variants with at least one of uncertain significance, or
- **Pattern B:** Intermediate sweat chloride (30-59 mmol/L) + one or no CF-causing CFTR variants identified

CRMS/CFSPID is neither CF nor CFTR-RD at the time of identification; a proportion of these infants may later develop CF or a CFTR-related disorder.

---

## 2. Proposed Updated Definitions for Existing MONDO Terms

### 2a. MONDO:0009061 — Cystic fibrosis

**Current definition (before this work):**
> "characterized by the production of sweat with a high salt content and mucus secretions with an abnormal viscosity"

**Proposed definition:**
> "Cystic fibrosis (CF) is an autosomal recessive disorder caused by pathogenic variants in the CFTR gene (cystic fibrosis transmembrane conductance regulator), which encodes a chloride and bicarbonate channel expressed in epithelial cells. Diagnosis requires evidence of CFTR dysfunction, defined as a sweat chloride concentration of 60 mmol/L or greater, or identification of two CF-causing CFTR pathogenic variants, or an abnormal nasal potential difference measurement. CF is a progressive, multi-organ disease characterized by chronic obstructive lung disease with recurrent infections, exocrine pancreatic insufficiency, intestinal obstruction (including meconium ileus in neonates), male infertility due to obstructive azoospermia, hepatobiliary complications, and elevated sweat chloride concentrations. CF is distinguished from CFTR-related disorders, which involve CFTR dysfunction limited to a single organ system and do not meet CF diagnostic criteria. CF is the most common life-limiting autosomal recessive disease in populations of European descent."

**References:** Orphanet:586, PMID:20301428, PMID:27140670, PMID:37278811

**Additional change:** Added historical synonym "fibrocystic disease of the pancreas" (RELATED).

### 2b. MONDO:0100627 — CFTR-related metabolic syndrome/CF screen positive, inconclusive diagnosis

**Current definition (before this work):**
> Contained typo "CRTR gene" instead of "CFTR gene"; used US-only "CRMS" designation without international "CFSPID" equivalent.

**Proposed definition:**
> "A condition identified in infants with hypertrypsinogenemia on newborn screening who have an inconclusive diagnosis, defined as having a sweat chloride value less than 60 mmol/L and two CFTR variants, at least one of which has unclear phenotypic consequences, and who thus do not meet diagnostic criteria for cystic fibrosis (CF). CRMS is the designation used in the United States; CFSPID (CF screen positive, inconclusive diagnosis) is the international equivalent. A proportion of these infants may later develop CFTR-related symptoms."

**References:** PMID:19914443, PMID:25630966

**Additional changes:**
- Name updated to: "CFTR-related metabolic syndrome/CF screen positive, inconclusive diagnosis"
- Added synonyms: "CFSPID" (ABBREVIATION), "CRMS/CFSPID" (EXACT), "CF screen positive, inconclusive diagnosis" (EXACT), "CFTR-related metabolic syndrome" (EXACT), "CRMS" (ABBREVIATION)

---

## 3. Proposed New Terms

### 3a. MONDO:7770003 — Cystic fibrosis-related diabetes (CFRD)

**Rationale:** CFRD affects 20% of adolescents and 40-50% of adults with CF. It is a distinct clinical entity with its own diagnostic criteria and management guidelines, sharing features with both type 1 and type 2 diabetes but classified as neither.

**Definition:**
> "A form of diabetes mellitus unique to individuals with cystic fibrosis (CF), arising primarily from progressive fibrotic destruction of the pancreas leading to insulin deficiency, with additional contributions from insulin resistance. CFRD affects approximately 20% of adolescents and 40-50% of adults with CF. It shares features with both type 1 and type 2 diabetes but is a distinct clinical entity with its own diagnostic criteria and management guidelines."

**References:** PMID:21115772, PMID:29515516

**Logical structure:**
- `is_a:` MONDO:0005015 (diabetes mellitus)
- `intersection_of:` MONDO:0005015 (diabetes mellitus) AND `disease_arises_from_feature` MONDO:0009061 (cystic fibrosis)
- `xref:` ICD10CM:E13

**Synonyms:** "CF-related diabetes" (EXACT), "CFRD" (ABBREVIATION)

### 3b. MONDO:7770004 — CFTR-related disorder

**Rationale:** CFTR-related disorder is an internationally recognized clinical entity (Bombieri et al. 2011) encompassing conditions with CFTR dysfunction that do not meet CF diagnostic criteria. It serves as a grouping term for CBAVD, CFTR-associated pancreatitis, and disseminated bronchiectasis with CFTR dysfunction.

**Definition:**
> "A clinical entity associated with CFTR dysfunction that does not fulfill the diagnostic criteria for cystic fibrosis (CF). Unlike CF, which is a progressive multi-organ disease diagnosed by a sweat chloride concentration of 60 mmol/L or greater (or two CF-causing CFTR variants), CFTR-related disorders are characterized by clinical evidence of CFTR dysfunction limited to a single organ system, a sweat chloride concentration below the CF diagnostic threshold (typically less than 60 mmol/L), and CFTR genotypes that often include at least one variant not classified as CF-causing. Recognized CFTR-related disorders include congenital bilateral absence of the vas deferens (CBAVD), acute recurrent or chronic pancreatitis, and disseminated bronchiectasis."

**References:** PMID:20301428, PMID:21658649

**Logical structure:**
- `is_a:` MONDO:0003847 (hereditary disease)
- `has_material_basis_in_germline_mutation_in:` HGNC:1884 (CFTR)

**Synonyms:** "CFTR-RD" (ABBREVIATION), "CFTR-related disease" (RELATED)

### 3c. MONDO:7770005 — Cystic fibrosis-related liver disease (CFLD)

**Rationale:** CF-related liver disease affects 5-10% of CF patients and is a significant cause of non-pulmonary morbidity and mortality. It encompasses a distinct spectrum of hepatobiliary abnormalities caused by CFTR dysfunction in cholangiocytes.

**Definition:**
> "A liver disorder that arises as a consequence of cystic fibrosis. Cystic fibrosis-related liver disease encompasses a spectrum of hepatobiliary abnormalities caused by CFTR dysfunction in cholangiocytes, including focal biliary cirrhosis, multilobular biliary cirrhosis, hepatic steatosis, and cholangiopathy. It is a significant cause of non-pulmonary morbidity and mortality in CF, affecting approximately 5-10% of CF patients."

**References:** PMID:28753176, PMID:37278811

**Logical structure:**
- `is_a:` MONDO:0005154 (liver disorder)
- `intersection_of:` MONDO:0005154 (liver disorder) AND `disease_arises_from_feature` MONDO:0009061 (cystic fibrosis)

**Synonyms:** "CF liver disease" (EXACT), "CF-related liver disease" (EXACT), "CFLD" (ABBREVIATION)

---

## 4. Proposed Classification

The proposed classification distinguishes terms by **diagnostic category** (CF vs CFTR-RD vs CRMS/CFSPID), not by variant class or phenotypic severity. This reflects the consensus approach in the literature (Bombieri et al. 2011; GeneReviews).

### 4a. Classification hierarchy

```
MONDO:0003847 hereditary disease
  |
  +-- MONDO:0009061 cystic fibrosis
  |     |
  |     +-- MONDO:7770003 cystic fibrosis-related diabetes (CFRD)
  |     |     [disease_arises_from_feature MONDO:0009061]
  |     |
  |     +-- MONDO:7770005 cystic fibrosis-related liver disease (CFLD)
  |     |     [disease_arises_from_feature MONDO:0009061]
  |     |
  |     +-- MONDO:0009062 cystic fibrosis-gastritis-megaloblastic anemia syndrome
  |           [is_a MONDO:0009061]
  |
  +-- MONDO:7770004 CFTR-related disorder
  |     |
  |     +-- MONDO:0010178 congenital bilateral aplasia of vas deferens from CFTR mutation (CBAVD)
  |           [is_a MONDO:7770004]
  |
  +-- MONDO:0100627 CRMS/CFSPID
        [separate from both CF and CFTR-RD; screening designation]
```

### 4b. Classification rationale

| Term | Proposed parent | Rationale |
|------|----------------|-----------|
| **MONDO:7770003 (CFRD)** | MONDO:0005015 (diabetes mellitus) + `disease_arises_from_feature` MONDO:0009061 (CF) | CFRD arises as a complication of CF; dual parentage captures both the diabetes nature and CF origin |
| **MONDO:7770005 (CFLD)** | MONDO:0005154 (liver disorder) + `disease_arises_from_feature` MONDO:0009061 (CF) | Same pattern as CFRD: a liver complication arising from CF |
| **MONDO:0009062 (CF-gastritis-megaloblastic anemia)** | MONDO:0009061 (CF) | Patients meet full CF diagnostic criteria plus additional features; it is a syndromic form of CF |
| **MONDO:0010178 (CBAVD from CFTR)** | MONDO:7770004 (CFTR-RD) | CBAVD is the prototypical single-organ CFTR-related disorder; patients do not meet CF criteria |
| **MONDO:0100627 (CRMS/CFSPID)** | No change (remains under metabolic disease) | CRMS/CFSPID is a screening designation for inconclusive cases, not a disease per se; kept separate from both CF and CFTR-RD |

### 4c. What is NOT proposed

- **No classical/non-classical CF distinction**: The literature treats this as a continuum within CF, not separate entities. No separate codes exist in OMIM, Orphanet, or ICD.
- **No variant-class subtypes**: CFTR variant classes (I-VI) are molecular classifications relevant to treatment eligibility, not distinct disease entities.
- **No top-level "disorder of CFTR function" umbrella**: CF and CFTR-RD are deliberately kept as separate hierarchies because they have distinct diagnostic criteria, prognoses, and management pathways.

### 4d. Current implementation status

| Classification axiom | Status |
|---------------------|--------|
| CFRD `disease_arises_from_feature` CF | Applied |
| CFLD `disease_arises_from_feature` CF | Applied |
| CF-gastritis syndrome `is_a` CF | **Not applied** (pending review) |
| CBAVD from CFTR `is_a` CFTR-RD | **Not applied** (pending review) |

---

## 5. References

| PMID | Citation |
|------|----------|
| PMID:19914443 | Borowitz D et al. "CFTR-related metabolic syndrome." Pediatrics. 2009. |
| PMID:20301428 | Cutting GR. "CFTR-Related Disorders." GeneReviews. |
| PMID:21115772 | Moran A et al. "Clinical care guidelines for CFRD." Diabetes Care. 2010. |
| PMID:21658649 | Bombieri C et al. "Recommendations for the classification of diseases as CFTR-related disorders." J Cyst Fibros. 2011. |
| PMID:25630966 | Munck A et al. "CFSPID: a new designation." J Cyst Fibros. 2015. |
| PMID:27140670 | Elborn JS. "Cystic fibrosis." Lancet. 2016. |
| PMID:28753176 | Debray D et al. "CF-related liver disease." J Hepatol. 2017. |
| PMID:29515516 | Kayani K et al. "CFRD." Front Endocrinol. 2018. |
| PMID:37278811 | Ong T, Ramsey BW. "Cystic Fibrosis -- A Review." JAMA. 2023. |

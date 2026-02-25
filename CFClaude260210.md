# CF in MONDO: Full Conversation Context for Claude Code

**Date:** 2026-02-10 | **Purpose:** Comprehensive context document so a new Claude Code session can continue this work.

---

## 1. What This Project Is About

We are improving the representation of cystic fibrosis (CF) and related conditions in the MONDO disease ontology. The work was guided by a gap analysis comparing MONDO's current CF terms against the medical literature, followed by iterative discussion about definitions, new terms, and classification hierarchy.

### Key documents in this repo

| File | Purpose |
|------|---------|
| `CFplan260209.md` | Original comprehensive gap analysis and action plan (literature review, gap tables, proposed phases) |
| `CFanalysis260209.md` | Focused analysis document: CF vs CFTR-RD distinction, proposed definitions, new terms, classification hierarchy |
| `CFClaude260210.md` | This file: full conversation context for session continuity |

---

## 2. Current State of Edits

### Branch: `cystic-fibrosis-updates` (based on `master`)

All edits are in `src/ontology/mondo-edit.obo`. The file has been **normalized** (`make NORM`) and **syntax-validated** (`robot convert`) successfully. **No commits have been made yet** — all changes are uncommitted.

### Summary of changes (44 insertions, 3 deletions)

#### 2a. MONDO:0009061 — Cystic fibrosis (EDITED)

**What changed:**
- **Definition rewritten** — Old definition was a single sentence mentioning only "high salt sweat" and "abnormal viscosity mucus". New definition includes: CFTR gene, autosomal recessive inheritance, diagnostic criteria (sweat chloride >=60 mmol/L, two CF-causing variants, or abnormal NPD), multi-organ manifestations, explicit distinction from CFTR-RD, and epidemiology.
- **Definition references updated** — Old: `[Orphanet:586, Wikipedia:Cystic_fibrosis]`. New: `[Orphanet:586, PMID:20301428, PMID:27140670, PMID:37278811]`
- **Historical synonym added** — `synonym: "fibrocystic disease of the pancreas" RELATED [PMID:27140670]`

**Current definition text:**
> "Cystic fibrosis (CF) is an autosomal recessive disorder caused by pathogenic variants in the CFTR gene (cystic fibrosis transmembrane conductance regulator), which encodes a chloride and bicarbonate channel expressed in epithelial cells. Diagnosis requires evidence of CFTR dysfunction, defined as a sweat chloride concentration of 60 mmol/L or greater, or identification of two CF-causing CFTR pathogenic variants, or an abnormal nasal potential difference measurement. CF is a progressive, multi-organ disease characterized by chronic obstructive lung disease with recurrent infections, exocrine pancreatic insufficiency, intestinal obstruction (including meconium ileus in neonates), male infertility due to obstructive azoospermia, hepatobiliary complications, and elevated sweat chloride concentrations. CF is distinguished from CFTR-related disorders, which involve CFTR dysfunction limited to a single organ system and do not meet CF diagnostic criteria. CF is the most common life-limiting autosomal recessive disease in populations of European descent."

#### 2b. MONDO:0100627 — CRMS/CFSPID (EDITED)

**What changed:**
- **Name updated** — Old: "CFTR-related metabolic syndrome". New: "CFTR-related metabolic syndrome/CF screen positive, inconclusive diagnosis"
- **Definition rewritten** — Fixed "CRTR gene" typo to "CFTR"; added international CFSPID designation; clarified diagnostic criteria
- **Definition references updated** — Added PMID:25630966
- **Synonyms added** — "CF screen positive, inconclusive diagnosis" (EXACT), "CFSPID" (ABBREVIATION), "CFTR-related metabolic syndrome" (EXACT), "CRMS/CFSPID" (EXACT). Pre-existing "CRMS" (ABBREVIATION) kept.

#### 2c. MONDO:7770003 — Cystic fibrosis-related diabetes (NEW TERM)

- **Parent:** MONDO:0005015 (diabetes mellitus)
- **Logical definition:** diabetes mellitus AND disease_arises_from_feature cystic fibrosis
- **Xref:** ICD10CM:E13
- **Synonyms:** "CF-related diabetes" (EXACT), "CFRD" (ABBREVIATION)
- **References:** PMID:21115772, PMID:29515516

#### 2d. MONDO:7770004 — CFTR-related disorder (NEW TERM)

- **Parent:** MONDO:0003847 (hereditary disease)
- **Gene:** has_material_basis_in_germline_mutation_in HGNC:1884 (CFTR)
- **No intersection_of** (grouping term, not a genus-differentia defined class)
- **Synonyms:** "CFTR-RD" (ABBREVIATION), "CFTR-related disease" (RELATED)
- **References:** PMID:20301428, PMID:21658649

#### 2e. MONDO:7770005 — Cystic fibrosis-related liver disease (NEW TERM)

- **Parent:** MONDO:0005154 (liver disorder)
- **Logical definition:** liver disorder AND disease_arises_from_feature cystic fibrosis
- **Synonyms:** "CF liver disease" (EXACT), "CF-related liver disease" (EXACT), "CFLD" (ABBREVIATION)
- **References:** PMID:28753176, PMID:37278811

---

## 3. Decisions Made During the Conversation

### 3a. Classical vs non-classical CF — NO separate terms

**Question:** Should MONDO distinguish "classical CF" from "non-classical/atypical CF"?

**Decision:** No. The literature (Bombieri 2011, De Boeck & Amaral 2016, GeneReviews) treats the CF spectrum as a continuum. No separate OMIM, Orphanet, or ICD codes exist for classical vs non-classical CF. Both meet CF diagnostic criteria; the difference is severity, not category.

### 3b. Classification approach — by diagnostic category

**Question:** How should the CF-related terms be organized hierarchically?

**Decision:** Distinguish by **diagnostic category** (CF vs CFTR-RD vs CRMS/CFSPID), not by variant class or phenotypic severity. Rationale:
- CF, CFTR-RD, and CRMS/CFSPID have distinct diagnostic criteria, prognoses, and management
- Variant classes (I-VI) are molecular classifications relevant to treatment, not distinct diseases
- A top-level "disorder of CFTR function" umbrella was considered but rejected — CF and CFTR-RD should remain in separate hierarchies

### 3c. Proposed classification hierarchy

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
  |           [proposed: is_a MONDO:0009061]
  |
  +-- MONDO:7770004 CFTR-related disorder
  |     |
  |     +-- MONDO:0010178 congenital bilateral aplasia of vas deferens from CFTR mutation
  |           [proposed: is_a MONDO:7770004]
  |
  +-- MONDO:0100627 CRMS/CFSPID
        [separate; remains under metabolic disease]
```

### 3d. Classification axioms — status

The classification axioms for CFRD and CFLD (`disease_arises_from_feature`) are **applied** as part of the new terms' logical definitions.

Two additional classification axioms were **proposed but NOT applied** (the user asked me to undo them when they were briefly applied):

| Axiom | Status | What it would do |
|-------|--------|-----------------|
| `MONDO:0009062 is_a MONDO:0009061` | **NOT applied** — pending review | Make CF-gastritis syndrome a child of CF |
| `MONDO:0010178 is_a MONDO:7770004` | **NOT applied** — pending review | Make CBAVD from CFTR a child of CFTR-RD |

The user may want to revisit these. The rationale for each is documented in `CFanalysis260209.md` section 4b.

---

## 4. PMID Verification Results

Three PMIDs from the original plan (`CFplan260209.md`) were found to be incorrect. The plan document was updated with corrected PMIDs before any edits were made to the ontology.

| Claimed PMID | What plan said it was | What it actually is | Correct PMID |
|---|---|---|---|
| PMID:37191702 | Ong & Ramsey, CF review, JAMA 2023 | "Excess Mortality Among Black Population" | **PMID:37278811** |
| PMID:27527667 | CFRD guidelines | A urology paper | **PMID:21115772** (Moran et al. ADA/CFF CFRD guidelines) |
| PMID:25953076 | CRMS/CFSPID paper | An influenza vaccine paper | **PMID:25630966** (Munck et al. CFSPID) |

All PMIDs used in the actual ontology edits have been verified.

---

## 5. Key Research Findings

### 5a. CF vs CFTR-RD distinction

| Feature | Cystic Fibrosis (CF) | CFTR-Related Disorder (CFTR-RD) |
|---|---|---|
| **Sweat chloride** | >=60 mmol/L | Typically <60 mmol/L (normal or intermediate 30-59) |
| **Organ involvement** | Multi-organ (lungs, pancreas, GI, reproductive, hepatobiliary) | Single organ system |
| **CFTR variants** | Two CF-causing variants | At least one variant, often with >=1 non-CF-causing allele |
| **Diagnostic criteria** | Meets formal CF diagnostic criteria | Does NOT meet CF diagnostic criteria |
| **Disease course** | Progressive, life-limiting | Variable; generally milder |
| **Examples** | Classic CF, non-classic/atypical CF | CBAVD, chronic pancreatitis, disseminated bronchiectasis |

### 5b. CRMS/CFSPID

- Screening designation for asymptomatic infants with inconclusive diagnosis
- Two patterns: (A) normal sweat Cl + two CFTR variants with >=1 VUS, (B) intermediate sweat Cl + <=1 CF-causing variant
- Not a disease per se; some infants later develop CF or CFTR-RD
- "CRMS" is the US term; "CFSPID" is the international equivalent; "CRMS/CFSPID" is the harmonized designation

### 5c. CFRD

- Affects ~20% adolescents, 40-50% adults with CF
- Distinct from type 1 and type 2 diabetes
- Arises from pancreatic destruction (insulin deficiency) + insulin resistance
- Has its own clinical guidelines (Moran et al. 2010, PMID:21115772)
- ICD-10-CM code: E13 ("Other specified diabetes mellitus")

### 5d. CFLD

- Affects 5-10% of CF patients
- Spectrum: focal biliary cirrhosis, multilobular cirrhosis, hepatic steatosis, cholangiopathy
- Caused by CFTR dysfunction in cholangiocytes
- Significant non-pulmonary cause of morbidity/mortality

### 5e. Existing MONDO terms NOT modified

| MONDO ID | Name | Notes |
|----------|------|-------|
| MONDO:0005413 | CF associated meconium ileus | Has `excluded_subClassOf MONDO:0009061` — deliberate curation decision |
| MONDO:0009062 | CF-gastritis-megaloblastic anemia syndrome | Classification under CF was proposed but not applied |
| MONDO:0010178 | CBAVD from CFTR mutation | Classification under CFTR-RD was proposed but not applied |
| MONDO:0018801 | CBAVD (grouping) | Not modified |
| MONDO:0008887 | BESC1 | Missing gene association flagged but not addressed |

---

## 6. Technical Notes

### 6a. How to edit MONDO

- **Do NOT edit `src/ontology/mondo-edit.obo` with generic grep/sed** — use `obo-grep.pl` to search
- `obo-grep.pl` is at `src/ontology/obo-grep.pl` and `src/scripts/obo-grep.pl`; add to PATH: `export PATH="/Users/torosa/Documents/GitHub/mondo/src/ontology:/Users/torosa/Documents/GitHub/mondo/src/scripts:$PATH"`
- `obo-checkout.pl` and `obo-checkin.pl` are referenced in CLAUDE.md but **do not exist** in this repo — edit `mondo-edit.obo` directly
- For searching: `obo-grep.pl --noheader -r 'id: MONDO:NNNNNNN' src/ontology/mondo-edit.obo`
- `aurelian` is referenced in CLAUDE.md but was not functional in this session; use PubMed E-utilities API or WebFetch as alternatives for PMID verification

### 6b. Normalization

```bash
cd src/ontology
docker run --rm -v "/Users/torosa/Documents/GitHub/mondo:/work" -w /work/src/ontology obolibrary/odkfull:v1.6 make NORM
mv NORM mondo-edit.obo
```

Note: `sh run.sh make NORM` gives TTY errors; use the direct `docker run` command instead.

### 6c. Syntax validation

```bash
docker run --rm -v "/Users/torosa/Documents/GitHub/mondo:/work" -w /work obolibrary/odkfull:v1.6 robot convert --catalog src/ontology/catalog-v001.xml -i src/ontology/mondo-edit.obo -f obo -o src/ontology/mondo-edit.TMP.obo
```

Clean up: `rm src/ontology/mondo-edit.TMP.obo src/ontology/NORM.norm`

### 6d. New term IDs

- New terms use MONDO:777xxxx prefix
- Before creating: `grep 'id: MONDO:777' src/ontology/mondo-edit.obo` to check for clashes
- MONDO:7770001 and 7770002 already existed before this work
- This work added: 7770003 (CFRD), 7770004 (CFTR-RD), 7770005 (CFLD)

### 6e. Design pattern used

CFRD and CFLD follow the `consequence_of_infectious_disease` / `disease_arises_from_feature` pattern (see `src/patterns/dosdp-patterns/consequence_of_infectious_disease.yaml`), adapted for a non-infectious context. The relationship `disease_arises_from_feature` (RO:0004022) was used, following the precedent of MONDO:0000489 (diabetic encephalopathy).

CFTR-RD is a grouping term and does not use a genus-differentia logical definition.

---

## 7. Verified PMIDs Used in Edits

| PMID | Citation | Used in |
|------|----------|---------|
| PMID:19914443 | Borowitz D et al. CFTR-related metabolic syndrome. Pediatrics. 2009. | MONDO:0100627 def |
| PMID:20301428 | Cutting GR. CFTR-Related Disorders. GeneReviews. | MONDO:0009061 def, MONDO:7770004 def |
| PMID:21115772 | Moran A et al. Clinical care guidelines for CFRD. Diabetes Care. 2010. | MONDO:7770003 def, relationship source |
| PMID:21658649 | Bombieri C et al. Classification of CFTR-related disorders. J Cyst Fibros. 2011. | MONDO:7770004 def, relationship source |
| PMID:25630966 | Munck A et al. CFSPID. J Cyst Fibros. 2015. | MONDO:0100627 def, synonyms |
| PMID:27140670 | Elborn JS. Cystic fibrosis. Lancet. 2016. | MONDO:0009061 def, synonym source |
| PMID:28753176 | Debray D et al. CF-related liver disease. J Hepatol. 2017. | MONDO:7770005 def, relationship source |
| PMID:29515516 | Kayani K et al. CFRD. Front Endocrinol. 2018. | MONDO:7770003 def |
| PMID:37278811 | Ong T, Ramsey BW. CF review. JAMA. 2023. | MONDO:0009061 def, MONDO:7770005 def |

---

## 8. Outstanding Work / Next Steps

### Pending decisions (require user input)

1. **Apply classification axiom: MONDO:0009062 is_a MONDO:0009061** — Make CF-gastritis-megaloblastic anemia syndrome a child of CF. Rationale: patients meet full CF criteria plus additional features.

2. **Apply classification axiom: MONDO:0010178 is_a MONDO:7770004** — Make CBAVD from CFTR a child of CFTR-related disorder. Rationale: CBAVD is the prototypical single-organ CFTR-RD.

3. **Commit and branch management** — All changes are uncommitted on branch `cystic-fibrosis-updates`. User has not yet requested a commit.

### Lower-priority items identified but not addressed

4. **BESC1 (MONDO:0008887) missing gene association** — Literature links it to CFTR variants but no gene relationship exists in MONDO.

5. **CF-related bone disease** — Affects 50-75% of CF adults; no MONDO term exists. Lower priority.

6. **CFTR-associated pancreatitis** — CFTR variants found in ~30% of idiopathic chronic pancreatitis. Could be a subtype of MONDO:0008185.

7. **Non-classic/atypical CF** — Decided not to create a separate term (continuum with classic CF), but could be revisited.

8. **GitHub issue references** — New terms should ideally be linked to GitHub issues via `property_value: IAO:0000233`. No issues have been created for these changes yet.

### User restrictions (from CLAUDE.local.md)

- NEVER create or post comments on GitHub issues/PRs
- NEVER push branches to remote
- NEVER open pull requests
- NEVER modify remote state
- Always report current git branch when completing a task

---

## 9. Full Git Diff

The complete diff of all changes made (44 insertions, 3 deletions in `src/ontology/mondo-edit.obo`):

```diff
--- a/src/ontology/mondo-edit.obo
+++ b/src/ontology/mondo-edit.obo

## MONDO:0009061 (cystic fibrosis) — definition rewritten, synonym added

-def: "Cystic fibrosis (CF) is a genetic disorder characterized by the production
-  of sweat with a high salt content and mucus secretions with an abnormal
-  viscosity." [Orphanet:586, Wikipedia:Cystic_fibrosis]
+def: "Cystic fibrosis (CF) is an autosomal recessive disorder caused by
+  pathogenic variants in the CFTR gene (cystic fibrosis transmembrane
+  conductance regulator), which encodes a chloride and bicarbonate channel
+  expressed in epithelial cells. Diagnosis requires evidence of CFTR
+  dysfunction, defined as a sweat chloride concentration of 60 mmol/L or
+  greater, or identification of two CF-causing CFTR pathogenic variants, or
+  an abnormal nasal potential difference measurement. CF is a progressive,
+  multi-organ disease characterized by chronic obstructive lung disease with
+  recurrent infections, exocrine pancreatic insufficiency, intestinal
+  obstruction (including meconium ileus in neonates), male infertility due
+  to obstructive azoospermia, hepatobiliary complications, and elevated
+  sweat chloride concentrations. CF is distinguished from CFTR-related
+  disorders, which involve CFTR dysfunction limited to a single organ system
+  and do not meet CF diagnostic criteria. CF is the most common
+  life-limiting autosomal recessive disease in populations of European
+  descent." [Orphanet:586, PMID:20301428, PMID:27140670, PMID:37278811]

+synonym: "fibrocystic disease of the pancreas" RELATED [PMID:27140670]

## MONDO:0100627 (CRMS/CFSPID) — name, definition, synonyms updated

-name: CFTR-related metabolic syndrome
-def: "Any metabolic syndrome in which the cause of the disease is a variation
-  in the CRTR gene. ..." [PMID:19914443]
+name: CFTR-related metabolic syndrome/CF screen positive, inconclusive diagnosis
+def: "A condition identified in infants with hypertrypsinogenemia on newborn
+  screening who have an inconclusive diagnosis, defined as having a sweat
+  chloride value less than 60 mmol/L and two CFTR variants, at least one
+  of which has unclear phenotypic consequences, and who thus do not meet
+  diagnostic criteria for cystic fibrosis (CF). CRMS is the designation
+  used in the United States; CFSPID (CF screen positive, inconclusive
+  diagnosis) is the international equivalent. A proportion of these infants
+  may later develop CFTR-related symptoms." [PMID:19914443, PMID:25630966]
+synonym: "CF screen positive, inconclusive diagnosis" EXACT [PMID:25630966]
+synonym: "CFSPID" EXACT ABBREVIATION [PMID:25630966]
+synonym: "CFTR-related metabolic syndrome" EXACT [PMID:19914443]
+synonym: "CRMS/CFSPID" EXACT [PMID:25630966]

## 3 new terms inserted after MONDO:7770002

+[Term]
+id: MONDO:7770003
+name: cystic fibrosis-related diabetes
+  ... (CFRD — see section 2c above)

+[Term]
+id: MONDO:7770004
+name: CFTR-related disorder
+  ... (CFTR-RD — see section 2d above)

+[Term]
+id: MONDO:7770005
+name: cystic fibrosis-related liver disease
+  ... (CFLD — see section 2e above)
```

# CFTR Variants Associated with CF and CF-Related MONDO Terms

**Date:** 2026-02-10

---

## Overview

This report maps each MONDO term involving CFTR gene dysfunction to the specific CFTR variants (mutations) associated with it. The CFTR gene (HGNC:1884, chromosome 7q31.2, OMIM *602421) has over 2,100 identified variants; the CFTR2 database (cftr2.org) classifies 1,085 as CF-causing (as of the 2024 update).

**Note on variant nomenclature:** Both legacy names (e.g., F508del, G542X) and HGVS nomenclature (e.g., p.Phe508del, c.1521_1523delCTT) are used in the literature. This report uses legacy names for readability, with HGVS provided where helpful.

---

## 1. MONDO:0009061 — Cystic Fibrosis

**CFTR variant status in MONDO:** `has_material_basis_in_germline_mutation_in HGNC:1884`

Classic CF requires two CF-causing CFTR variants (homozygous or compound heterozygous). Over 1,085 CF-causing variants are recognized (CFTR2, 2024 update).

### Most common CF-causing variants worldwide

| Variant (legacy) | HGVS | Class | Global allele frequency | Geographic enrichment |
|---|---|---|---|---|
| **F508del** | p.Phe508del | II (misfolding) | ~70% | Northern Europe (87% in Denmark) |
| **G542X** | p.Gly542X | I (nonsense) | ~2.6% | Mediterranean, North Africa |
| **N1303K** | p.Asn1303Lys | II (misfolding) | ~1.6% | Mediterranean, Tunisia (17%) |
| **G551D** | p.Gly551Asp | III (gating) | ~1.5% | Northwestern/Central Europe |
| **W1282X** | p.Trp1282X | I (nonsense) | ~1.0% | Ashkenazi Jewish populations |
| **R553X** | p.Arg553X | I (nonsense) | ~0.75% | Northern Europe |
| **621+1G>T** | c.489+1G>T | I (splice) | ~0.54% | Southern Europe (Greece ~6.4%) |
| **1717-1G>A** | c.1585-1G>A | I (splice) | ~0.5% | Various |
| **R117H** | p.Arg117His | IV (conductance) | ~0.3% | Various (CF-causing only with 5T in cis) |
| **3849+10kbC>T** | c.3718-2477C>T | V (splicing) | ~0.2% | Various |
| **2789+5G>A** | c.2657+5G>A | V (splicing) | ~0.2% | Various |
| **A455E** | p.Ala455Glu | V (reduced quantity) | ~0.1% | Northern Europe |
| **R1162X** | p.Arg1162X | I (nonsense) | ~0.3% | Various |
| **R560T** | p.Arg560Thr | III (gating) | Rare | Various |
| **S549N** | p.Ser549Asn | III (gating) | Rare | Various |

### Common genotype combinations in CF

| Genotype | Approximate frequency | Phenotype |
|---|---|---|
| F508del / F508del | ~50% of CF patients | Severe; pancreatic insufficient (PI) |
| F508del / G542X | ~3-4% | Severe; PI |
| F508del / N1303K | ~2% | Severe; PI |
| F508del / W1282X | ~1-2% | Severe; PI |
| F508del / G551D | ~1-2% | Severe; PI (modulator-responsive) |
| F508del / R117H-7T | Variable | Often milder; may be pancreatic sufficient (PS) |
| F508del / 3849+10kbC>T | Variable | Often milder; PS |

**Key references:** PMID:24141786 (Sosnay et al. CFTR2), PMID:37278811 (Ong & Ramsey 2023)

---

## 2. MONDO:0009062 — Cystic Fibrosis-Gastritis-Megaloblastic Anemia Syndrome

**CFTR variant status in MONDO:** No gene relationship (no CFTR or other gene specified)

**Known variants:** None. This condition was described in 1991 in two siblings of consanguineous Arab parents (PMID:2029916, Lubani et al.). The report predated routine CFTR genotyping. No molecular characterization has been published. Whether this condition involves CFTR mutations or represents a distinct genetic entity is unknown.

---

## 3. MONDO:0100627 — CRMS/CFSPID

**CFTR variant status in MONDO:** `has_material_basis_in_germline_mutation_in HGNC:1884`

CRMS/CFSPID is a screening designation, not a specific genotype. These infants carry two CFTR variants, with at least one classified as a "variant of varying clinical consequence" (VVCC) or "variant of unknown significance" (VUS) per CFTR2.

### Typical genotype patterns

| Pattern | Sweat chloride | CFTR genotype |
|---|---|---|
| **Pattern A** | Normal (<30 mmol/L) | Two CFTR variants, at least one VUS/VVCC |
| **Pattern B** | Intermediate (30-59 mmol/L) | 0 or 1 CF-causing variant identified |

### Common VVCC variants found in CRMS/CFSPID

| Variant | Notes |
|---|---|
| R117H-7T | CF-causing only with 5T; VVCC with 7T |
| D1152H | VVCC per CFTR2 |
| R74W | VVCC per CFTR2 |
| D1270N | VVCC per CFTR2 |
| L997F | VVCC per CFTR2 |
| R75Q | VVCC per CFTR2 |
| M470V | Common polymorphism; modulator of other variants |
| 5T/TG11 | Low-penetrance splicing variant |

The 2024 CFTR2 reclassification changed many variants from "unknown significance" to either "CF-causing" or "VVCC", which directly affects how many infants are designated as CRMS/CFSPID vs CF (PMID not yet available for 2024 update; see Castellani et al. MDPI 2024).

**Key references:** PMID:19914443 (Borowitz et al. 2009), PMID:25630966 (Munck et al. 2015)

---

## 4. MONDO:7770003 — Cystic Fibrosis-Related Diabetes (CFRD)

**CFTR variant status in MONDO:** Linked to CF via `disease_arises_from_feature MONDO:0009061`

CFRD is not caused by specific CFTR variants. Rather, **any severe CFTR genotype causing pancreatic insufficiency** is the prerequisite. Risk is determined by the degree of residual CFTR function plus non-CFTR modifier genes.

### CFTR genotype and CFRD risk

| CFTR genotype severity | CFRD risk | Notes |
|---|---|---|
| Class I/II homozygous (e.g., F508del/F508del) | Highest — ~80% by age 50 | Pancreatic insufficient from birth |
| Class I/II compound heterozygous (e.g., F508del/G542X) | High | Pancreatic insufficient |
| Class I-III / Class IV-V (e.g., F508del/R117H) | Lower | Often pancreatic sufficient; lower CFRD risk |
| Class IV/V homozygous | Lowest | Preserved pancreatic function |

Patients with severe CFTR mutations (Class I/II) have a relative risk of 1.70 for incident diabetes compared to milder genotypes (PMID:18535191).

### Non-CFTR modifier genes for CFRD

| Gene | Role | Reference |
|---|---|---|
| **TCF7L2** | Type 2 diabetes risk locus; also increases CFRD risk | PMID:23970970 |
| **SLC26A9** | Alternative chloride channel; modifies pancreatic damage | PMID:24057835 |
| **CDKAL1, CDKN2A/B, IGF2BP2** | Overlap with type 2 diabetes GWAS loci | PMID:32381652 |

**Key references:** PMID:18535191 (Blackman et al. 2008), PMID:21115772 (Moran et al. 2010), PMID:32381652 (Aksit et al. 2020)

---

## 5. MONDO:7770004 — CFTR-Related Disorder (grouping term)

**CFTR variant status in MONDO:** `has_material_basis_in_germline_mutation_in HGNC:1884`

This is a grouping term. CFTR-RDs are typically associated with compound heterozygosity involving at least one mild or VVCC CFTR variant. The specific variants depend on the organ involved (see CBAVD below for the most characterized CFTR-RD).

### General variant patterns in CFTR-RD

| Pattern | Example |
|---|---|
| One severe + one mild variant | F508del / R117H-5T |
| One severe + 5T allele | F508del / 5T |
| Two mild variants | R117H / R117H |
| One severe + VVCC | F508del / D1152H |

**Key reference:** PMID:21658649 (Bombieri et al. 2011)

---

## 6. MONDO:0010178 — Congenital Bilateral Aplasia of Vas Deferens from CFTR Mutation (CBAVD)

**CFTR variant status in MONDO:** `has_material_basis_in_germline_mutation_in HGNC:1884`

CBAVD is the best-characterized CFTR-related disorder. Approximately 80-97% of CBAVD patients carry at least one CFTR variant; 63-83% carry variants on both alleles.

### CFTR variants most commonly associated with CBAVD

| Variant | Role in CBAVD | Frequency in CBAVD patients |
|---|---|---|
| **5T allele** (IVS8-5T) | Most characteristic CBAVD variant; reduces exon 9 splicing | 25-45% of CBAVD chromosomes (vs ~5% in general population) |
| **F508del** | Most common severe variant found in CBAVD compound hets | ~20% of CBAVD chromosomes |
| **R117H** | Mild variant; common in CBAVD compound heterozygotes | ~5-10% |
| **TG12-5T** or **TG13-5T** | Longer TG repeat increases 5T penetrance (80%+ for TG13-5T) | High in CBAVD with 5T |
| **D1152H** | VVCC; found in CBAVD patients | Rare |
| **R74W** | Mild/VVCC; found in CBAVD patients | Rare |

### Typical CBAVD genotype combinations

| Genotype | Frequency | Notes |
|---|---|---|
| F508del / 5T (with TG12 or TG13) | Most common | ~30% of CBAVD cases |
| F508del / R117H-5T | Common | Compound het with mild allele |
| Severe variant / 5T | Common | Various severe alleles in trans with 5T |
| R117H / 5T | Less common | Two mild variants |
| No identifiable CFTR variants | ~3-20% | Possible non-CFTR causes (ADGRG2) |

**Key references:** PMID:7739684 (Chillon et al. NEJM 1995), PMID:8557264 (Casals et al. 1995), PMID:29255258 (Bieth et al. 2021)

---

## 7. MONDO:7770005 — Cystic Fibrosis-Related Liver Disease (CFLD)

**CFTR variant status in MONDO:** Linked to CF via `disease_arises_from_feature MONDO:0009061`

Like CFRD, CFLD is not associated with specific CFTR variants. Any CF genotype can lead to liver disease. The primary genetic modifier is **SERPINA1** (alpha-1 antitrypsin gene), not a CFTR variant.

### CFTR genotype and CFLD risk

| CFTR genotype | CFLD risk | Notes |
|---|---|---|
| Severe/severe (Class I-III) | Higher baseline risk | But not predictive alone |
| Any CF genotype | ~5-10% develop CFLD | CFTR genotype is necessary but not sufficient |

### Non-CFTR modifier genes for CFLD

| Gene | Variant | Effect | Reference |
|---|---|---|---|
| **SERPINA1** | Z allele (Glu342Lys) | OR ~5 for severe liver disease with portal hypertension; cumulative CFLD incidence 47% by age 25 (vs 30% in non-carriers) | PMID:30739910 |
| **ACE** | D/D genotype | Associated with liver disease severity | PMID:19738092 |
| **TGFB1** | Codon 10/25 variants | Modifies liver fibrosis risk | PMID:19738092 |
| **MBL2** | Deficiency alleles | Variable association | PMID:19738092 |

**Key references:** PMID:30739910 (Bartlett et al. 2019), PMID:19738092 (Bartlett et al. 2009), PMID:28753176 (Debray et al. 2017)

---

## 8. MONDO:0005413 — Cystic Fibrosis Associated Meconium Ileus

**CFTR variant status in MONDO:** No gene relationship (classified under meconium ileus, not under CF)

Meconium ileus occurs in ~15-20% of CF neonates. It requires a severe CF genotype (pancreatic insufficient) but the specific CFTR variant does not strongly predict meconium ileus risk. Instead, non-CFTR modifier genes at several loci determine susceptibility.

### CFTR genotype context

Meconium ileus only occurs in the context of severe CF (Class I-III genotypes). However, among patients with the same severe genotype (e.g., F508del/F508del), only ~15-20% develop meconium ileus, indicating strong modifier gene effects.

### Non-CFTR modifier genes for meconium ileus

| Gene/Locus | Variant/Region | Effect | Reference |
|---|---|---|---|
| **SLC26A9** | rs7512462 | Alternative chloride channel; significantly associated with MI risk (p=0.002) | PMID:24057835 |
| **SLC6A14** | rs12839137 | Amino acid transporter; replicated association | PMID:22466613 |
| **SLC9A3** | Various SNPs | Sodium-hydrogen exchanger | PMID:19662435 |
| **MSRA** (12q24) | Various SNPs | Methionine sulfoxide reductase A | PMID:19662435 |

These modifier genes show pleiotropic effects — the same variants that increase meconium ileus risk also modify pancreatic damage and other early CF morbidities (PMID:24057835).

**Key references:** PMID:19662435 (Dorfman et al. 2009), PMID:22466613 (Sun et al. 2012), PMID:24057835 (Miller et al. 2013)

---

## 9. MONDO:0008887 — Bronchiectasis With or Without Elevated Sweat Chloride 1 (BESC1)

**CFTR variant status in MONDO:** No gene relationship currently assigned

**Note:** BESC1 (OMIM:211400) is complex. It was originally mapped as a CF-like phenocopy and the gene(s) responsible have not been definitively identified. OMIM lists it as a susceptibility locus. Some literature associates it with SCNN1B (ENaC beta subunit) variants, while CFTR variants (particularly heterozygous F508del and the 5T allele) are overrepresented in disseminated bronchiectasis patients and may contribute through an oligogenic mechanism.

BESC2 (MONDO:0013087) is caused by SCNN1A variants and BESC3 (MONDO:0013112) by SCNN1G variants — these are ENaC subunit genes, not CFTR.

---

## Summary Table

| MONDO ID | Term | CFTR variants | Variant pattern | Key modifier genes |
|---|---|---|---|---|
| **MONDO:0009061** | Cystic fibrosis | >1,085 CF-causing variants; F508del ~70% | Two CF-causing variants (homozygous or compound het) | TGFB1, SLC26A9, IFRD1, MBL2 |
| **MONDO:0009062** | CF-gastritis syndrome | Unknown | Unknown (pre-genotyping era report) | Unknown |
| **MONDO:0100627** | CRMS/CFSPID | Involves VUS/VVCC variants (R117H-7T, D1152H, D1270N, etc.) | Two variants, at least one not CF-causing | N/A |
| **MONDO:7770003** | CFRD | No specific variants; any severe CF genotype | Severe (Class I-III) genotypes = highest risk | TCF7L2, SLC26A9, CDKAL1 |
| **MONDO:7770004** | CFTR-RD (grouping) | Mild/VVCC variants (5T, R117H, D1152H) | Compound het with at least one non-CF-causing | N/A |
| **MONDO:0010178** | CBAVD from CFTR | 5T allele (25-45%), F508del, R117H, TG12/13-5T | Severe + mild/5T compound het | ADGRG2 (non-CFTR CBAVD) |
| **MONDO:7770005** | CFLD | No specific variants; any CF genotype | Severe genotypes = higher baseline risk | **SERPINA1 Z allele** (OR ~5), ACE, TGFB1 |
| **MONDO:0005413** | CF meconium ileus | No specific variants; requires severe CF genotype | Severe (Class I-III) = prerequisite | SLC26A9, SLC6A14, SLC9A3 |
| **MONDO:0008887** | BESC1 | Possibly CFTR heterozygosity + ENaC variants | Oligogenic (CFTR + SCNN1B?) | SCNN1B |

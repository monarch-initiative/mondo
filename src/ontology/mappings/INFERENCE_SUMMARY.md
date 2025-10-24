# MONDO-ICD Mapping Inference Summary

## Overview
This document summarizes the chain inference analysis performed using SeMRA to discover new MONDO to ICD10WHO and ICD11Foundation mappings.

## Input Files
1. **mondo.sssom.tsv** (12M, 108,175 mappings)
   - Existing MONDO mappings including:
     - 209 MONDO→ICD10WHO mappings
     - 4,170 MONDO→ICD11Foundation mappings
   - Total: 4,379 existing MONDO→ICD mappings

2. **who-icd10-to-icd11.sssom.tsv** (2.2M, 12,606 mappings)
   - WHO bridge mappings connecting ICD-10 codes to ICD-11 Foundation entities
   - Provides transitive inference paths

## Inference Process
Using SeMRA's chain inference capabilities:
1. Merged both mapping sets (120,712 total mappings)
2. Applied reversible inference to enable bidirectional reasoning (241,424 mappings)
3. Assembled evidences to consolidate duplicate mappings
4. Applied chain inference with:
   - Maximum chain length: 3 hops (e.g., MONDO→ICD10→ICD11)
   - Bidirectional inference enabled
   - Component size constraints: 2-1,000 nodes

The inference process generated 735,464 total mappings including transitive closures.

## Results

### New Mappings Discovered: **1,527**
- **1,471** new MONDO→ICD10WHO mappings
- **56** new MONDO→ICD11Foundation mappings

### Output File
**inferred_mondo_icd_new.sssom.tsv** (372K, 1,528 rows including header)

## Example Inferred Mappings

### Chain Reasoning Examples

1. **Benign Neoplasm (MONDO:0005165)**
   ```
   Chain: mondo:0005165 → icd10:D10-D36 → icd11:1630407678
   Result: mondo:0005165 skos:broadMatch icd11:1630407678 (Neoplasms)
   ```

2. **Osteoporosis (MONDO:0005298)**
   ```
   Chain: mondo:0005298 → icd11:2113001430 → icd10:M80
   Result: mondo:0005298 skos:narrowMatch icd10:M80 (Osteoporosis with pathological fracture)
   ```
   - Discovered 22 specific ICD-10 osteoporosis codes through this chain
   - Includes variants: M80.0-M80.9, M81.0-M81.9, M82.0-M82.8

3. **Myocarditis (MONDO:0004496)**
   ```
   Chain: mondo:0004496 → icd11:1018829714 → icd10:I40/I41/I51.4
   Result: Multiple ICD-10 myocarditis codes (exactMatch and narrowMatch)
   ```

4. **Viral CNS Infection (MONDO:0024318)**
   ```
   Chain: mondo:0024318 → icd10:A80-A89 → icd11:1104303944
   Result: mondo:0024318 skos:exactMatch icd11:1104303944
   ```

## Mapping Characteristics

### Predicate Distribution
- **skos:narrowMatch**: Most common (for specific ICD-10 codes mapping to broader MONDO terms)
- **skos:broadMatch**: For general MONDO terms mapping to ICD-11 categories
- **skos:exactMatch**: For direct semantic equivalences

### Justification
- All mappings use `semapv:MappingChaining` as justification
- Each mapping includes chain provenance in the comment field
- Confidence: 1.0 (reflects chain inference from existing mappings)

## Key Insights

1. **Transitive Coverage**: The WHO ICD10-ICD11 bridge mappings enable discovery of many MONDO→ICD10 mappings that were previously implicit

2. **Granularity Expansion**: Particularly effective for diseases with multiple specific ICD-10 codes (e.g., osteoporosis subtypes)

3. **Bidirectional Discovery**: Both MONDO→ICD10→ICD11 and MONDO→ICD11→ICD10 chains productive

4. **Quality Indicators**:
   - Chains properly handle predicate specificity (exact/broad/narrow)
   - Provenance fully traceable through comment field
   - No circular inferences detected

## Technical Notes

- SeMRA version used chain inference with cutoff=3
- Prefix normalization: `ICD10WHO`→`icd10`, `icd11.foundation`→`icd11`
- 4 WHO mapping rows with non-standard ICD10 identifiers were skipped during parsing

## Generated Files
- **infer_icd_mappings.py**: Reusable inference script
- **inferred_mondo_icd_new.sssom.tsv**: New mappings in SSSOM format

## Next Steps
Consider:
1. Manual review of high-impact mappings
2. Integration into mondo.sssom.tsv (if validated)
3. Analysis of which MONDO disease classes benefited most from inference
4. Potential for similar inference with other coding systems

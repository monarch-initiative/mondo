# MONDO Ontology Project Guide

This includes instructions for editing the npso ontology. 

## Project Layout
- Main development file is `src/ontology/mondo-edit.obo`
- individual terms checked out in `terms`

## Querying ontology

- To look at a specific term if you know the ID:
    - `obo-grep.pl --noheader -r 'id: MONDO:0004177' src/ontology/mondo-edit.obo`
- All mentions of an ID
    - `obo-grep.pl --noheader -r 'MONDO:0004177' src/ontology/mondo-edit.obo`
- Regexes; all mentions of hand or foot:
    - `obo-grep.pl --noheader -r '(hand|foot)' src/ontology/mondo-edit.obo`
- Note that `obo-grep.pl` is in your PATH, no need to search for it    
- Only search over `src/ontology/mondo-edit.obo`
- DO NOT bother doing your own greps over the file, or looking for other files, unless otherwise asked, you will just waste time.
- ONLY use the methods above for searching the ontology

## Before making edits
- Read the request carefully and make a plan, especially if there is nuance
- if a PMID is mentioned in the issue, ALWAYS try and read it
- Use this command to fetch full text: `aurelian fulltext PMID:NNNNNN` (using the actual ID)
- This also works for other URLs for scientific papers and for DOIs, if there are no access restrictions
- ALWAYS check proposed parent terms for consistency

## Edits
- IMPORTANT: Do not edit the edit file directly, it's large
- Add edits should be made in the `terms/` folder
- check out a term into `terms/`: `obo-checkout.pl src/ontology/mondo-edit.obo MONDO:1234567 [OTHER IDS]`
- This will create a single stanza obo files `terms/npso_1234567.obo` which you can easily edit
     - (note the colon is replaced with an underscore)
- You can go ahead and edit the smallers files in the `terms/` folder
- After edits, check back in: `obo-checkin.pl src/ontology/mondo-edit.obo MONDO:1234567 [OTHER IDS]`
- if you like you can edit multiple terms in one batch, e.g. `terms/my_batch.obo`
     - `obo-checkout.pl src/ontology/mondo-edit.obo terms/my_batch.obo`
- checking in will update the edit file and remove the file from `terms/`
- Commits are then made on src/ontology/mondo-edit.obo as appropriate
- Note that `obo-checkin.pl` and `obo-checkin.pl` are in your PATH, no need to search for it    


## OBO Format Guidelines
- Term ID format: MONDO:NNNNNNN (7-digit number)
- Handling New Term Requests (NTRs):
  - New terms start  MONDO:777xxxx
  - Do do `grep id: MONDO:777 src/ontology/mondo-edit.obo` to check for clashes
- Each term requires: id, name, namespace, definition with references
- NEVER guess MONDO IDs, use search tools above to determine actual term
- NEVER guess PMIDs for references, do a web search if needed
- Use standard relationship types: is_a, part_of, has_part, etc.
- Follow existing term patterns for consistency

## Publications
- Run the command `aurelian fulltext <PMID:nnn>` to fetch full text for a publication. A doi or URL can also be used
- You should cite publications appropriately, e.g. `def: "...." [PMID:nnnn, doi:mmmm]

## Syntax Checking

- To validate syntax: `robot convert --catalog src/ontology/catalog-v001.xml -i src/ontology/mondo-edit.obo -f obo -o mondo-edit.TMP.obo`
- Use `-vvv` for a full stack trace if there are errors.

## Mondo Guidelines

## Mappings

Mappings are an integral part of Mondo. You should never create mappings unless requested by a user, if they do, make sure metadata is correct

Mondo has an idiosyncratic way of adding metadata to mappings. Indicating the kind of mapping is important, this is dome by overloading
the source qualifier and using an ID like MONDO:equivalentTo. Also the original source can be included:

```
[Term]
id: MONDO:0800447
name: bleeding disorder, platelet-type, 13, susceptibility to
subset: predisposition
synonym: "BDPLT13" EXACT ABBREVIATION [MONDO:Lexical, OMIM:614009]
synonym: "bleeding disorder, platelet-type, 13, susceptibility to" EXACT [MONDO:Lexical, OMIM:614009]
synonym: "bleeding disorder, susceptibility to, due to defective platelet thromboxane A2 receptor" EXACT [OMIM:614009]
synonym: "susceptibility to platelet-type bleeding disorder 13" EXACT []
xref: MEDGEN:481244 {source="MONDO:equivalentTo", source="MONDO:MEDGEN"}
xref: OMIM:614009 {source="Orphanet:220443", source="MONDO:equivalentTo", source="Orphanet:220443/e"}
xref: UMLS:C3279614 {source="MONDO:equivalentTo", source="MONDO:MEDGEN", source="MEDGEN:481244"}
is_a: MONDO:0020573 {source="OMIM:614009"} ! inherited disease susceptibility
relationship: has_material_basis_in_germline_mutation_in http://identifiers.org/hgnc/11608 {source="MONDO:mim2gene_medgen"} ! TBXA2R
relationship: predisposes_towards MONDO:0800446 {source="OMIM:614009"} ! bleeding diathesis due to thromboxane synthesis deficiency
property_value: curated_content_resource "https://www.malacards.org/card/bleeding_disorder_platelet_type_13" xsd:anyURI {source="MONDO:MalaCards"}
property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/6419" xsd:string
```

## Obsoleting terms

obsolete terms should have no logical axioms (is_a, relationship,
intersection_of) on them. Obsolete terms may be replaced by a single
term (so-called obsoletion with exact replacement), or by zero to many `consider` tags.

```
[Term]
id: MONDO:0100229
name: obsolete Heimler syndrome
def: "OBSOLETE. A peroxisoome biogenesis disorder characterized by sensorineural hearing loss, enamel hypoplasia of the secondary dentition, nail abnormalities and occasional or late-onset retinal pigmentation abnormalities, in which the cause of the disease is a mutation in peroxisomal biogenesis factor 1 (PEX1) or peroxisomal biogenesis factor 6 (PEX6) genes." [MONDO:patterns/disease_series_by_gene, PMID:26387595]
subset: ordo_disorder {source="Orphanet:3220"}
subset: ordo_malformation_syndrome {source="Orphanet:3220"}
synonym: "bilateral sensorineural hearing loss, enamel hypoplasia and nail defects" RELATED [GARD:0001687]
synonym: "deafness enamel hypoplasia nail defects" RELATED [GARD:0001687]
synonym: "deafness-enamel hypoplasia-nail defects syndrome" EXACT [MONDO:0009325]
synonym: "Heimler syndrome" EXACT []
synonym: "sensorineural hearing loss, enamel hypoplasia, and nail abnormalities" RELATED [GARD:0001687]
xref: MESH:C535994 {source="MONDO:obsoleteEquivalent", source="Orphanet:3220/e", source="Orphanet:3220"}
xref: Orphanet:3220 {source="OMIM:234580", source="MONDO:obsoleteEquivalent"}
xref: SCTID:721085000 {source="MONDO:obsoleteEquivalent"}
property_value: http://purl.org/dc/terms/creator https://orcid.org/0000-0001-5208-3432
property_value: IAO:0000231 OMO:0001000
property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/3222" xsd:anyURI
is_obsolete: true
consider: MONDO:0100259
```

Synonyms and xrefs can be migrated judiciously,

We never do complete merges now, so there should be no `alt_ids` or
disappearing stanzas. If a user asks for a merge, they usually mean
obsoletion with direct replacement, as here:

Example:

```
[Term]
id: MONDO:0100334
name: obsolete viral infectious disease or sequela
property_value: http://purl.org/dc/terms/creator https://orcid.org/0000-0001-5208-3432
property_value: IAO:0000231 MONDO:TermsMerged
property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/pull/3118#issuecomment-871858054" xsd:anyURI
is_obsolete: true
replaced_by: MONDO:0100321
```

No relationship should point to an obsolete term - when you obsolete a term, you may need to also rewire
terms to "skip" the obsoleted term.

## Other metadata

- Link back to the issue you are dealing with using the `term_tracker_item`
- All terms should have definitions, with at least one definition xref, ideally a PMID


You can sign NEW terms using with a tag-value like this: (don't tag pre-existing terms)

```
property_value: http://purl.org/dc/terms/creator doi:10.1186/s13326-024-00320-3
```

You don't need to add a date, this will be handled for you

## Relationships

All terms should have at least one `is_a` (this can be implicit by a logical definition, see below).

Some other terms may have relationships but these will generally follow existing patterns.

## Logical definitions

These should follow genus-differentia form, and the text definition should mirror the logical definition. Example:

```
[Term]
id: MONDO:0000715
name: lymph node adenoid cystic carcinoma
def: "A adenoid cystic carcinoma that involves the lymph node." [MONDO:patterns/location]
subset: gard_rare {source="MONDO:GARD"}
subset: rare
synonym: "lymph node adenoid cystic cancer" RELATED []
synonym: "lymph node adenoid cystic carcinoma" EXACT [DOID:0060219, MONDO:patterns/location]
xref: DOID:0060219 {source="MONDO:equivalentTo"}
is_a: MONDO:0001082 {source="DOID:0060219", source="MONDO:Entailed", source="MONDO:Redundant"} ! lymph node cancer
intersection_of: MONDO:0004971 ! adenoid cystic carcinoma
intersection_of: disease_has_location UBERON:0000029 ! lymph node
property_value: curated_content_resource "https://www.malacards.org/card/lymph_node_adenoid_cystic_carcinoma" xsd:anyURI {source="MONDO:MalaCards"}
```

The reasoner can find the most specific `is_a`, so it's OK to leave this off, unless there is provenance to be added.

## Design patterns

Check:

`src/patterns/dosdp-patterns/*yaml`

For the DOSDP design pattern which guides how the term should be created.

## 1. Gene-Related Disease Naming Conventions

The documentation should include explicit naming patterns for gene-related diseases:

```markdown
## Gene-Disease Naming Conventions

For monogenic diseases, MONDO follows the pattern: `{GENE}-related {disease description}`

Examples:
- ALG8-related autosomal dominant polycystic kidney and/or liver disease
- MYCBP2-related developmental delay with corpus callosum defects
- TUBB4B-related ciliopathy

This pattern should be used even when users request alternative formats like "disease - GENE" format.
```

## 2. Synonym Attribution and Citation Requirements

The current documentation lacks specific guidance on synonym citations:

```markdown
## Synonym Citation Requirements

ALL synonyms must include proper citations:

**Correct examples:**
```
synonym: "EBV-associated lymphoproliferative disorder" EXACT [PMID:38882456]
synonym: "MDCD" EXACT ABBREVIATION [PMID:36200388]
synonym: "CHD4-related neurodevelopmental disorder" EXACT [https://orcid.org/0000-0001-9310-0163, Orphanet:653712]
```

**Never use empty brackets:**
```
synonym: "term name" EXACT []  # INCORRECT
```

### ClinGen Label Handling
When ClinGen provides preferred labels, use the CLINGEN_LABEL qualifier:
```
synonym: "Hajdu-Cheney syndrome-NOTCH2" EXACT CLINGEN_LABEL [https://clinicalgenome.org/affiliation/40066/]
```
```

## 3. Design Pattern Recognition and Application

```markdown
## Design Pattern Compliance

Before creating new terms, ALWAYS check for applicable design patterns:

1. Search `src/patterns/dosdp-patterns/*.yaml` for relevant patterns
2. Common patterns include:
   - `disease_series_by_gene.yaml` - for diseases caused by mutations in specific genes
   - `susceptibility_by_gene.yaml` - for genetic susceptibility factors
   - `childhood.yaml` - for childhood-onset conditions

### Gene-Based Disease Pattern Requirements

When following the disease_series_by_gene pattern:

**Required logical structure:**
```
is_a: MONDO:0700092 ! neurodevelopmental disorder
intersection_of: MONDO:0700092 ! neurodevelopmental disorder
intersection_of: has_material_basis_in_germline_mutation_in http://identifiers.org/hgnc/23386 ! MYCBP2
relationship: has_material_basis_in_germline_mutation_in http://identifiers.org/hgnc/23386 {source="PMID:36200388"} ! MYCBP2
```

**Definition template:**
```
def: "Any [parent disease class] in which the cause of the disease is a mutation in the [GENE] gene." [PMID:references]
```
```

## 4. Parent Term Selection Guidelines

```markdown
## Parent Term Selection Guidelines

### For Gene-Related Diseases
- Use the most general appropriate disease category that encompasses all known phenotypes
- For multi-system diseases, consider dual parentage rather than single broad syndromic parent
- Example: For neuro-urological conditions, use both `nervous system disorder` AND `urinary system disorder`

### Avoid Over-Specific Parents
- Don't default to "inherited disease" unless inheritance is the primary distinguishing feature
- Consider the full phenotypic spectrum, not just the most common presentations
```

## 5. Source Attribution in Relationships

```markdown
## Source Attribution Requirements

All logical axioms must include source attribution when based on literature:

```
is_a: MONDO:0700092 {source="PMID:36200388", source="https://orcid.org/0000-0001-9310-0163"} ! neurodevelopmental disorder
relationship: has_material_basis_in_germline_mutation_in http://identifiers.org/hgnc/23386 {source="PMID:36200388"} ! MYCBP2
```

Multiple sources can be cited for the same relationship.
```

## 6. Gene Identifier Verification

```markdown
## Gene Identifiers

**CRITICAL**: Always verify gene identifiers using the official HGNC database:
- Search at https://www.genenames.org/
- Use format: `http://identifiers.org/hgnc/[HGNC_ID]`
- NEVER guess gene identifiers

Example: For MYCBP2 gene, use `http://identifiers.org/hgnc/23386`, NOT `http://identifiers.org/hgnc/7557`
```

## 7. Susceptibility vs Disease Relationships

```markdown
## Susceptibility Term Guidelines

Susceptibility terms should use `predisposes_towards` relationships, NOT `is_a` relationships:

**Correct:**
```
[Term]
id: MONDO:1060111
name: SAMD9L-related spectrum and myeloid neoplasm risk
is_a: MONDO:0020573 ! inherited disease susceptibility
relationship: predisposes_towards MONDO:0008038 ! ataxia-pancytopenia syndrome
relationship: predisposes_towards MONDO:0018881 ! myelodysplastic syndrome
```

**Incorrect:**
```
[Term]
id: MONDO:0008038
name: ataxia-pancytopenia syndrome
is_a: MONDO:1060111 ! SAMD9L-related spectrum and myeloid neoplasm risk
```
```

## 8. Term Obsolescence and Merging

```markdown
## Term Obsolescence Guidelines

### For Simple Obsolescence
```
[Term]
id: MONDO:0100334
name: obsolete viral infectious disease or sequela
property_value: IAO:0000231 OMO:0001000 {source="MONDO:excludePhenotype"}
property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/XXXX" xsd:anyURI
is_obsolete: true
replaced_by: MONDO:0100321
```

### For Term Merging
Use `MONDO:TermsMerged` and migrate ALL relevant content to the surviving term:
- Synonyms with proper source attribution
- Cross-references with updated source qualifiers
- Relevant subsets

Remove ALL logical axioms and definitions from obsoleted terms.
```

## 9. Definition Enhancement Standards

```markdown
## Definition Guidelines

### Gene-Related Diseases
Use the pattern: "Any [parent disease] in which the cause of the disease is a mutation in the [GENE] gene."

### Clinical Descriptions  
- Use sentence case for medical terms
- Be specific but broadly applicable
- Include inheritance patterns when known
- Cite multiple sources when available: `[https://clinicalgenome.org/affiliation/40066/, PMID:29535429]`
```

## 10. Quality Control Exclusions

```markdown
## QC Check Exclusions

Some terms may legitimately violate QC checks and need exclusions:

```
relationship: excluded_from_qc_check http://purl.obolibrary.org/obo/mondo/sparql/qc/general/qc-single-child.sparql
```

Common cases include:
- Terms with initially single children pending additional curation
- Terms created for organizational purposes by domain experts
```

## 11. Complete Exemplar Stanzas

The documentation should include complete examples showing all required elements:

```obo
[Term]
id: MONDO:1060117
name: MYCBP2-related developmental delay with corpus callosum defects
def: "Any neurodevelopmental disorder in which the cause of the disease is a mutation in the MYCBP2 gene. This condition is characterized by variable corpus callosum defects consistent with dysgenesis, and a broad spectrum of neurobehavioural deficits including developmental delay, intellectual disability, epilepsy, and autistic features." [https://orcid.org/0000-0001-9310-0163, PMID:36200388]
synonym: "MDCD" EXACT ABBREVIATION [PMID:36200388]
is_a: MONDO:0700092 {source="PMID:36200388", source="https://orcid.org/0000-0001-9310-0163"} ! neurodevelopmental disorder
intersection_of: MONDO:0700092 ! neurodevelopmental disorder
intersection_of: has_material_basis_in_germline_mutation_in http://identifiers.org/hgnc/23386
relationship: has_material_basis_in_germline_mutation_in http://identifiers.org/hgnc/23386 {source="PMID:36200388", source="https://orcid.org/0000-0001-9310-0163"} ! MYCBP2
property_value: http://purl.org/dc/terms/creator https://orcid.org/0000-0002-7638-4659
property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/XXXX" xsd:anyURI
```

These improvements would help AI systems better understand MONDO's specific conventions and produce changes that more closely align with human expert curation practices.

## IMPORTANT

- never guess identifiers of any kind
- if you include some identifier that was not provided by the user, you MUST check it
- PMIDs can be checked with aurelian or web search

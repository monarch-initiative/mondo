---
name: merge-terms-owltools
description: Merge two MONDO terms using owltools --obsolete-replace, then manually clean up
  the result following MONDO curation standards
---

# Merge two MONDO terms (owltools version)

## Instructions

When merging MONDO terms, one term is obsoleted and its metadata is transferred to a surviving (replacement) term. This skill uses **owltools** (recommended) to perform the initial merge, then applies manual cleanup.

### Required inputs

The user must provide:
- **Term to obsolete** (CURIE 1): the MONDO ID of the term being retired
- **Replacement term** (CURIE 2): the MONDO ID of the surviving term
- **GitHub issue number**: the issue requesting the merge

If not provided, ask for these before proceeding.

### Step 1: Run owltools merge

Navigate to `src/ontology` and run:

```bash
docker run --memory=8g -v /path/to/mondo:/work -w /work/src/ontology -e ROBOT_JAVA_ARGS=-Xmx8G -e JAVA_OPTS=-Xmx8G --rm -i obolibrary/odkfull:v1.6 owltools --use-catalog mondo-edit.obo --obsolete-replace MONDO:XXXXXXX MONDO:YYYYYYY -o -f obo mondo-edit.obo
```

Where MONDO:XXXXXXX = term to obsolete, MONDO:YYYYYYY = replacement term.

**What owltools does automatically:**
- Renames the obsoleted term to "obsolete [name]"
- Marks it as deprecated (`is_obsolete: true`)
- Adds `replaced_by` pointing to the surviving term
- Moves xrefs, synonyms, subsets, and other annotations to the surviving term
- Adds an `alt_id` on the surviving term (this must be removed in cleanup)

### Step 2: Review the diff

Run `git diff src/ontology/mondo-edit.obo` and review carefully. owltools does a lot but leaves several things that need manual cleanup.

### Step 3: Checkout both terms for manual cleanup

```bash
obo-checkout.pl src/ontology/mondo-edit.obo MONDO:XXXXXXX MONDO:YYYYYYY
```

Read both checked-out term files.

### Step 4: Clean up the OBSOLETED term (CURIE 1)

The obsoleted term should contain ONLY obsoletion metadata. owltools may leave extra annotations. Strip it down to:

```
[Term]
id: MONDO:XXXXXXX
name: obsolete [original name]
property_value: IAO:0000231 MONDO:TermsMerged
property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/NNNN" xsd:anyURI
is_obsolete: true
replaced_by: MONDO:YYYYYYY
```

Remove ALL of the following (owltools may have left some behind):
- Definition (`def:`) — should already be on surviving term, remove here
- Comment (`comment:`) — especially scheduled-for-obsoletion comments
- All xrefs (`xref:`) — owltools should have moved these, but verify
- All synonyms (`synonym:`) — owltools should have moved these, but verify
- All subsets (`subset:`)
- All is_a (superclass) axioms
- All intersection_of axioms (logical definitions)
- All relationship axioms
- All property_value annotations except IAO:0000231 and IAO:0000233

### Step 5: Clean up the SURVIVING term (CURIE 2)

Review what owltools transferred and fix any issues:

1. **Remove alt_id**: owltools adds `alt_id: MONDO:XXXXXXX` — **remove it**. The diff should not show an alt_id.

2. **Check synonyms**:
   - owltools may have created duplicate synonyms. If the same synonym text exists twice, merge the evidence/citations into one line (e.g., `synonym: "CMT2T" EXACT ABBREVIATION [DOID:0110160, OMIM:617017, Orphanet:495274]`)
   - Add the obsoleted term's original name as a synonym (EXACT) if it differs from the surviving term's name. Use one of the transferred xrefs as evidence (e.g., `[MESH:D018352]`), NOT the obsoleted MONDO ID
   - Remove any empty-bracket synonyms (`synonym: "..." EXACT []`) — ensure all have proper citations

3. **Check xrefs**:
   - owltools moves xrefs but does NOT update source qualifiers correctly
   - Xrefs on the surviving term should keep `source="MONDO:equivalentTo"`
   - **Check if any transferred xref is deprecated/obsolete in its source database**: if so, use `source="MONDO:equivalentObsolete"`
   - **If an identical xref exists twice**, merge the source annotations into one line
   - **Check for duplicate xref prefixes** (same database, different IDs): if both have `source="MONDO:equivalentTo"`, add `source="MONDO:preferredExternal"` to the one with more information. `MONDO:preferredExternal` only applies to equivalentTo xrefs — not MONDO:GARD, MONDO:NANDO, etc.
   - **Check the issue for new xrefs**: if the issue mentions new database cross-references (e.g., a replacement SCTID), verify and add them

4. **Check subsets**:
   - If a subset exists twice, merge sources into one line
   - Remove `obsoletion_candidate` if present
   - Remove `scheduled for obsoletion on or after` annotations

5. **Check superclass (is_a) axioms**:
   - owltools may create duplicate is_a axioms. If the same parent exists twice, merge the source annotations into one line
   - Verify all is_a axioms from the obsoleted term were transferred

6. **Check intersection_of axioms** (logical definitions):
   - Verify logical definitions were transferred. If duplicates, keep one

7. **Check relationship axioms**:
   - Verify relationships (has_material_basis_in, has_characteristic, etc.) were transferred
   - If duplicates, merge source annotations into one line

8. **Check property_value annotations**:
   - Verify `seeAlso`, `curated_content_resource` were transferred
   - Remove any obsoletion-related metadata that shouldn't be here (IAO:0006012 obsoletion dates, creator/date from obsoleted term)

9. **Check definition**:
   - If the surviving term has no definition, it should have received the obsoleted term's definition
   - If both had definitions, keep the surviving term's definition

10. **Add term tracker** for the GitHub issue (if not already present):
    ```
    property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/NNNN" xsd:anyURI
    ```

11. **Add obsoletion reason** to the obsoleted term (if owltools didn't):
    ```
    property_value: IAO:0000231 MONDO:TermsMerged
    ```

### Step 6: Handle children of the obsoleted term

Search for any terms that have the obsoleted term as a parent:

```bash
grep "is_a: MONDO:XXXXXXX" src/ontology/mondo-edit.obo
```

If children exist:
- Checkout those children
- Update their `is_a` axioms to point to the surviving term instead
- Check in those children

### Step 7: Check in and normalize

1. Check in all edited terms:
   ```bash
   obo-checkin.pl src/ontology/mondo-edit.obo MONDO:XXXXXXX MONDO:YYYYYYY [any children IDs]
   ```

2. Normalize the file:
   ```bash
   cd src/ontology && sh run.sh make NORM && mv NORM mondo-edit.obo
   ```

3. Validate syntax:
   ```bash
   robot convert --catalog src/ontology/catalog-v001.xml -i src/ontology/mondo-edit.obo -f obo -o mondo-edit.TMP.obo
   ```

### Step 8: Review the diff and show checklist

Show the user the diff and a **checklist table** summarizing what was transferred:

| What | From obsoleted | Status |
|------|---------------|--------|
| **Synonyms** | "synonym text" [evidence] | transferred / merged citations / already on surviving |
| **Xrefs** | PREFIX:ID | transferred / merged sources / skipped (duplicate) |
| **Subsets** | subset_name | transferred / source merged / already on surviving |
| **is_a** | MONDO:NNNNNNN parent name | transferred / source merged |
| **intersection_of** | ... | transferred / already on surviving |
| **Relationships** | ... | transferred / source merged |
| **Property values** | seeAlso, curated_content_resource, etc. | transferred |
| **Definition** | | transferred / surviving already had one |
| **Children** | MONDO:NNNNNNN | rewired / none |
| **New xrefs from issue** | PREFIX:ID | added / n/a |

Always show this table so the user can verify completeness at a glance.

## Obsoletion reason codes

Use the appropriate reason code in `property_value: IAO:0000231`:

| Code | Meaning |
|------|---------|
| `MONDO:TermsMerged` | Terms merged (use this for merges) |
| `OMO:0001000` | Out of scope |
| `IAO:0000423` | To be replaced with external ontology term |
| `IAO:0000229` | Term split |

## Xref source qualifier reference

| Qualifier | When to use |
|-----------|-------------|
| `MONDO:equivalentTo` | Both MONDO and external are active |
| `MONDO:obsoleteEquivalent` | MONDO is obsolete, external is active |
| `MONDO:equivalentObsolete` | External is obsolete, MONDO is active |
| `MONDO:obsoleteEquivalentObsolete` | Both MONDO and external are obsolete |
| `MONDO:preferredExternal` | Disambiguate duplicate xrefs from same database after merge |

## Important reminders

- ALWAYS ask for approval before committing
- NEVER push without separate explicit approval
- Combine all changes into ONE commit per issue
- Never guess MONDO IDs - always verify by searching
- Transfer all xrefs from the obsoleted term to the surviving term (do not keep them on the obsoleted term)
- Remove alt_id from the surviving term (owltools adds this, we don't want it)
- Check for proxy merges (duplicate equivalent xrefs from same source on surviving term)

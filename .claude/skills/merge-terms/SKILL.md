---
name: merge-terms
description: Merge two MONDO terms by obsoleting one and transferring its metadata to the surviving term,
  following MONDO curation standards for xref handling, synonym migration, and obsoletion annotations
---

# Merge two MONDO terms

## Instructions

When merging MONDO terms, one term is obsoleted and its metadata is transferred to a surviving (replacement) term. This skill handles the full merge workflow.

### Required inputs

The user must provide:
- **Term to obsolete** (CURIE 1): the MONDO ID of the term being retired
- **Replacement term** (CURIE 2): the MONDO ID of the surviving term
- **GitHub issue number**: the issue requesting the merge

If not provided, ask for these before proceeding.

### Step 1: Checkout both terms

```bash
obo-checkout.pl src/ontology/mondo-edit.obo MONDO:XXXXXXX MONDO:YYYYYYY
```

This creates individual stanza files in `terms/` for editing.

### Step 2: Review both terms

Read both checked-out term files carefully. Identify:
- All xrefs and their source qualifiers
- All synonyms
- All subsets
- All relationships (is_a, intersection_of, etc.)
- Any children of the term being obsoleted (search the edit file)
- Any logical definitions (intersection_of axioms)

### Step 3: Edit the OBSOLETED term (CURIE 1)

Apply these changes to the term being obsoleted:

1. **Rename the label**: prepend "obsolete " to the name
   ```
   name: obsolete [original name]
   ```

2. **Mark as deprecated**:
   ```
   is_obsolete: true
   ```

3. **Add replaced_by** pointing to the surviving term:
   ```
   replaced_by: MONDO:YYYYYYY
   ```

4. **Add obsoletion reason**:
   ```
   property_value: IAO:0000231 MONDO:TermsMerged
   ```

5. **Add term tracker** for the GitHub issue:
   ```
   property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/NNNN" xsd:anyURI
   ```

6. **Remove scheduled-for-obsoletion comments**: if the term has a `comment:` about being scheduled for obsoletion/merge, remove it (the merge is now done)

7. **Remove xrefs from the obsoleted term**:
   - All xrefs should be transferred to the surviving term (see Step 4), not kept on the obsoleted term
   - Remove all xref lines from the obsoleted term

8. **Remove all is_a (superclass) axioms**

9. **Remove all intersection_of axioms** (logical definitions)

10. **Remove all relationship axioms** (has_material_basis_in, disease_has_location, etc.)

11. **Remove all subset annotations** (rare, gard_rare, ordo_*, orphanet_rare, etc.)

12. **Remove all property_value annotations** that are not related to obsoletion metadata (e.g., remove curated_content_resource, but keep IAO:0000231, IAO:0000233). Transfer `seeAlso` annotations to the surviving term.

13. **Prepend "OBSOLETE." to the definition** if one exists:
    ```
    def: "OBSOLETE. [original definition text]" [original refs]
    ```

14. **Move synonyms** to the surviving term (see Step 4). Remove them from the obsoleted term.

### Step 4: Edit the SURVIVING term (CURIE 2)

Apply these changes to the replacement/surviving term:

1. **Transfer synonyms** from the obsoleted term:
   - Move all synonyms, preserving their type (EXACT, RELATED, etc.) and citations
   - Add the obsoleted term's original name as a synonym (EXACT) if it differs from the surviving term's name. Use one of the transferred xrefs as the evidence source (e.g., `[MESH:D018352]`), NOT the obsoleted MONDO ID
   - Do NOT create duplicate synonyms - check if the synonym already exists

2. **Transfer xrefs** from the obsoleted term:
   - Move xrefs that had `source="MONDO:equivalentTo"` on the obsoleted term
   - On the surviving term, keep the source as `source="MONDO:equivalentTo"`
   - **Check if any transferred xref is deprecated/obsolete in its source database**: if so, use `source="MONDO:equivalentObsolete"` instead of `source="MONDO:equivalentTo"`
   - **Check for duplicate xref prefixes**: if the surviving term already has an xref from the same database (e.g., two OMIM IDs, two MEDGEN IDs) AND both have `source="MONDO:equivalentTo"`, add `source="MONDO:preferredExternal"` to the one that contains more information (e.g., more source annotations, more associated metadata). `MONDO:preferredExternal` only applies to xrefs with `MONDO:equivalentTo` source — not to xrefs with other source qualifiers (e.g., MONDO:GARD, MONDO:NANDO)
   - When moving xrefs, also move associated subsets sourced from that xref (e.g., ordo_disorder, orphanet, orphanet_rare, etc.)
   - Move any secondary xrefs solely sourced from the moved xref (e.g., ICD10CM, MedDRA with Orphanet sources)
   - **Check the issue for new xrefs**: if the issue mentions new database cross-references (e.g., a replacement SCTID, updated CUI), verify they are valid and add them to the surviving term with appropriate source qualifiers

3. **Transfer relevant subsets** from the obsoleted term:
   - Move subset annotations that are sourced from xrefs being transferred
   - Do NOT create duplicate subset entries

4. **Review superclass (is_a) axioms**:
   - Do NOT add duplicate is_a axioms
   - If the obsoleted term had children, those children's is_a axioms pointing to the obsoleted term should now point to the surviving term (check for this in the full edit file)

5. **Add term tracker** for the GitHub issue (if not already present):
   ```
   property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/NNNN" xsd:anyURI
   ```

6. **Remove from the surviving term** (if present):
   - "in subset obsoletion_candidate"
   - "scheduled for obsoletion on or after" annotations
   - Any alt_id that was added

### Step 5: Handle children of the obsoleted term

Search the ontology for any terms that have the obsoleted term as a parent:

```bash
grep "is_a: MONDO:XXXXXXX" src/ontology/mondo-edit.obo
```

If children exist:
- Checkout those children
- Update their `is_a` axioms to point to the surviving term instead
- Check in those children

### Step 6: Check in and normalize

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

### Step 7: Review the diff

Show the user the diff of `src/ontology/mondo-edit.obo` for review before committing.

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

## Example: Obsoleted term after merge

```obo
[Term]
id: MONDO:0000075
name: obsolete neuronopathy, distal hereditary motor
subset: clingen {source="MONDO:CLINGEN"}
subset: otar {source="MONDO:OTAR"}
property_value: IAO:0000231 MONDO:TermsMerged
property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/6845" xsd:string
is_obsolete: true
replaced_by: MONDO:0018894
```

## Important reminders

- ALWAYS ask for approval before committing
- NEVER push without separate explicit approval
- Combine all changes into ONE commit per issue
- Never guess MONDO IDs - always verify by searching
- Transfer all xrefs from the obsoleted term to the surviving term (do not keep them on the obsoleted term)
- Check for proxy merges (duplicate equivalent xrefs from same source on surviving term)

---
name: merge-terms
description: Merge two MONDO terms by obsoleting one and transferring its metadata to the surviving term,
  following MONDO curation standards
---

# Merge two MONDO terms

## Instructions

When merging MONDO terms, one term is obsoleted and its metadata is transferred to a surviving (replacement) term.

### Required inputs

The user must provide:
- **Term to obsolete** (CURIE 1): the MONDO ID of the term being retired
- **Replacement term** (CURIE 2): the MONDO ID of the surviving term
- **GitHub issue number**: the issue requesting the merge

If not provided, ask for these before proceeding.

### Step 1: Run owltools merge

First, read `src/ontology/run.sh` to determine the current ODK image version (look for `IMAGE=${IMAGE:-odkfull:vX.X}`). Then run:

```bash
docker run --memory=8g -v /path/to/mondo:/work -w /work/src/ontology -e ROBOT_JAVA_ARGS=-Xmx8G -e JAVA_OPTS=-Xmx8G --rm -i obolibrary/odkfull:<VERSION> owltools --use-catalog mondo-edit.obo --obsolete-replace MONDO:XXXXXXX MONDO:YYYYYYY -o -f obo mondo-edit.obo
```

Where MONDO:XXXXXXX = term to obsolete, MONDO:YYYYYYY = replacement term, and `<VERSION>` is from run.sh.

**What owltools does automatically:**
- Renames the obsoleted term to "obsolete [name]"
- Marks it as deprecated (`is_obsolete: true`)
- Adds `replaced_by` pointing to the surviving term
- Moves xrefs, synonyms, subsets, and other annotations to the surviving term
- Adds an `alt_id` on the surviving term (this must be removed)

### Step 2: Normalize immediately

Run normalization right after owltools to get a clean serialization before manual edits:

```bash
cd src/ontology && sh run.sh make NORM && mv NORM mondo-edit.obo
```

(If `run.sh` fails due to TTY issues, run docker directly without `-ti` flag.)

### Step 3: Review the diff and checkout for cleanup

Review `git diff src/ontology/mondo-edit.obo` to understand what owltools changed.

Then checkout both terms for manual cleanup:

```bash
obo-checkout.pl src/ontology/mondo-edit.obo MONDO:XXXXXXX MONDO:YYYYYYY
```

(`obo-checkout.pl` is in your PATH via the curation-skills plugin.)

### Step 4: Clean up the OBSOLETED term (CURIE 1)

The obsoleted term should contain ONLY obsoletion metadata. owltools leaves extra annotations that must be removed. Strip it down to:

```
[Term]
id: MONDO:XXXXXXX
name: obsolete [original name]
property_value: IAO:0000231 MONDO:TermsMerged
property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/NNNN" xsd:anyURI
is_obsolete: true
replaced_by: MONDO:YYYYYYY
```

Remove ALL of the following (after verifying they are on the surviving term):
- Definition (`def:`) — verify surviving term has a definition first
- Comment (`comment:`) — especially scheduled-for-obsoletion comments
- All xrefs (`xref:`) — owltools moved these
- All synonyms (`synonym:`) — owltools moved these
- All subsets (`subset:`)
- All is_a (superclass) axioms
- All intersection_of axioms (logical definitions)
- All relationship axioms
- All property_value annotations except IAO:0000231 and IAO:0000233

### Step 5: Clean up the SURVIVING term (CURIE 2)

owltools transfers most annotations but does not handle all conventions correctly. Review and fix:

1. **Remove alt_id**: owltools always adds `alt_id: MONDO:XXXXXXX` — remove it.

2. **Verify definition**: Check which definition the surviving term has. If both terms had definitions, verify the correct one was kept. If the surviving term originally had no definition and the obsoleted term did, ensure it was transferred.

3. **Fix duplicate synonyms**: owltools may create duplicates. If the same synonym text exists twice, merge the evidence/citations into one line. Add the obsoleted term's original name as a synonym (EXACT) if it differs from the surviving term's name — use one of the transferred xrefs as evidence (e.g., `[MESH:D018352]`), NOT the obsoleted MONDO ID.

4. **Fix xref source qualifiers**: owltools does not set these correctly.
   - Xrefs with `source="MONDO:equivalentTo"` should keep that source
   - If an identical xref exists twice, merge the source annotations into one line
   - For duplicate xref prefixes (same database, different IDs) where both have `source="MONDO:equivalentTo"`, add `source="MONDO:preferredExternal"` to the one with more information. `MONDO:preferredExternal` only applies to equivalentTo xrefs — not MONDO:GARD, MONDO:NANDO, etc.
   - Check the issue for new xrefs mentioned (e.g., replacement SCTIDs) — verify and add them

5. **Fix duplicate subsets**: If a subset exists twice, merge sources into one line. Remove `obsoletion_candidate` and `scheduled for obsoletion on or after` if present.

6. **Fix duplicate is_a axioms**: If the same parent exists twice, merge the source annotations into one is_a line. Verify all is_a axioms from the obsoleted term were transferred.

7. **Verify intersection_of, relationship, and property_value** annotations transferred correctly. For duplicates, normalisation will handle merging.

8. **Add term tracker** for the GitHub issue (if not already present):
   ```
   property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/NNNN" xsd:anyURI
   ```

9. **Add obsoletion reason** to the obsoleted term (owltools does not add this):
   ```
   property_value: IAO:0000231 MONDO:TermsMerged
   ```

### Step 6: Handle children of the obsoleted term

owltools should have rewired children automatically. Verify by checking:

```bash
grep "is_a: MONDO:XXXXXXX" src/ontology/mondo-edit.obo
```

If any children still point to the obsoleted term, checkout those children, update their `is_a` axioms to point to the surviving term, and check them in.

### Step 7: Check in, normalize, and run QC

1. Check in all edited terms:
   ```bash
   obo-checkin.pl src/ontology/mondo-edit.obo MONDO:XXXXXXX MONDO:YYYYYYY [any children IDs]
   ```

2. Normalize the file:
   ```bash
   cd src/ontology && sh run.sh make NORM && mv NORM mondo-edit.obo
   ```

3. Run merge-related QC checks from `src/sparql/qc/general/`:
   ```bash
   robot query --catalog src/ontology/catalog-v001.xml -i src/ontology/mondo-edit.obo \
     --query src/sparql/qc/general/qc-proxy-merge-missing-preferred.sparql results/qc-proxy-merge.tsv \
     --query src/sparql/qc/general/qc-misused-replaced-by.sparql results/qc-replaced-by.tsv \
     --query src/sparql/qc/general/qc-obsoletion-reason.sparql results/qc-obsoletion-reason.tsv \
     --query src/sparql/qc/general/qc-deprecated-class-reference.sparql results/qc-deprecated-ref.tsv \
     --query src/sparql/qc/general/qc-xref-without-precision.sparql results/qc-xref-precision.tsv \
     --query src/sparql/qc/general/qc-duplicate-exact-synonym-no-abbrev.sparql results/qc-dup-synonym.tsv
   ```
   Review any results — empty files mean no violations.

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
- Remove alt_id from the surviving term (owltools adds this, we don't want it)
- Check for proxy merges (duplicate equivalent xrefs from same source on surviving term)

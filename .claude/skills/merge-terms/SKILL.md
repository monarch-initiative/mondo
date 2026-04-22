---
name: merge-terms
description: Merge two MONDO terms by obsoleting one and transferring its metadata to the surviving term,
  following MONDO curation standards
---

# Merge two MONDO terms

## ⚠️ Important: how to run commands

All ODK-backed commands (`owltools`, `robot`, and `make` targets) MUST be run via the `run.sh` wrapper from `src/ontology/`:

```bash
cd src/ontology && sh run.sh <command>
```

`run.sh` already pins the correct ODK image version and sets memory and volume mounts. Do **NOT** construct raw `docker run` commands and do **NOT** hard-code the ODK image tag — `run.sh` is the single source of truth.

## Instructions

When merging MONDO terms, one term is obsoleted and its metadata is transferred to a surviving (replacement) term.

### Required inputs

The user must provide:
- **Term to obsolete** (CURIE 1): the MONDO ID of the term being retired
- **Replacement term** (CURIE 2): the MONDO ID of the surviving term
- **GitHub issue number**: the issue requesting the merge

If not provided, ask for these before proceeding.

### Step 1: Run owltools merge

From `src/ontology/`:

```bash
sh run.sh owltools --use-catalog mondo-edit.obo \
  --obsolete-replace MONDO:XXXXXXX MONDO:YYYYYYY \
  -o -f obo mondo-edit.obo
```

Where MONDO:XXXXXXX = term to obsolete and MONDO:YYYYYYY = replacement term.

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

### Step 3: Review the diff and checkout for cleanup

Review `git diff src/ontology/mondo-edit.obo` to understand what owltools changed.

Then checkout both terms for manual cleanup:

```bash
obo-checkout.pl src/ontology/mondo-edit.obo MONDO:XXXXXXX MONDO:YYYYYYY
```

(`obo-checkout.pl` is in your PATH via the curation-skills plugin.)

### Step 4: Clean up the OBSOLETED term (CURIE 1)

The obsoleted term should retain ONLY the following lines; delete anything else owltools left on the stanza (def, comment, xref, synonym, subset, is_a, intersection_of, relationship, other property_value annotations). Before deleting, verify the content is on the surviving term.

| Allowed line | Notes |
|---|---|
| `id: MONDO:XXXXXXX` | unchanged |
| `name: obsolete [original name]` | owltools sets this |
| `property_value: IAO:0000231 MONDO:TermsMerged` | obsoletion reason — add this; owltools does not |
| `property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/NNNN" xsd:anyURI` | issue link |
| `is_obsolete: true` | owltools sets this |
| `replaced_by: MONDO:YYYYYYY` | owltools sets this |

### Step 5: Clean up the SURVIVING term (CURIE 2)

owltools transfers most annotations but does not handle all conventions correctly. Review and fix:

1. **Remove alt_id**: owltools always adds `alt_id: MONDO:XXXXXXX` — remove it.

2. **Decide which definition to keep.** Pick one explicitly:
   - Default to keeping the surviving term's original definition.
   - If the surviving term had no definition and the obsoleted term did, use the obsoleted term's.
   State the choice in the final summary so the user can override.

3. **Add the obsoleted term's original name as a synonym** (EXACT) if it differs from the surviving term's name — use one of the transferred xrefs as evidence (e.g., `[MESH:D018352]`), NOT the obsoleted MONDO ID. (Normalisation will merge any duplicate synonym lines.)

4. **Fix xref source qualifiers**: owltools does not set these correctly.
   - Xrefs with `source="MONDO:equivalentTo"` should keep that source
   - Check the issue for new xrefs mentioned (e.g., replacement SCTIDs) — verify and add them

5. **Remove obsoletion-tracking subsets** if present on the surviving term: `obsoletion_candidate` and `scheduled for obsoletion on or after`.

6. **Verify intersection_of, relationship, and property_value annotations transferred correctly.** Check by listing what was on the obsoleted term before merge and confirming each line has an equivalent on the surviving term:
   ```bash
   git show HEAD:src/ontology/mondo-edit.obo | obo-grep.pl --noheader -r 'id: MONDO:XXXXXXX' -
   obo-grep.pl --noheader -r 'id: MONDO:YYYYYYY' src/ontology/mondo-edit.obo
   ```
   Compare the `intersection_of:`, `relationship:`, and `property_value:` lines. Normalisation will merge any duplicates.

7. **Add term tracker** for the GitHub issue (if not already present):
   ```
   property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/NNNN" xsd:anyURI
   ```

8. **Add obsoletion reason** to the obsoleted term (owltools does not add this):
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

3. Run the QC checks most likely to catch merge regressions via `robot verify`:
   ```bash
   cd src/ontology && sh run.sh robot verify \
     --catalog catalog-v001.xml -i mondo-edit.obo \
     --queries \
       ../sparql/qc/general/qc-proxy-merge-missing-preferred.sparql \
       ../sparql/qc/general/qc-misused-replaced-by.sparql \
       ../sparql/qc/general/qc-obsoletion-reason.sparql \
       ../sparql/qc/general/qc-deprecated-class-reference.sparql \
       ../sparql/qc/general/qc-xref-without-precision.sparql \
       ../sparql/qc/general/qc-duplicate-exact-synonym-no-abbrev.sparql \
     -O reports/
   ```
   `robot verify` exits non-zero and writes a TSV per failing query if any violations are found.

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
| `MONDO:preferredExternal` | Marks the preferred xref when two equivalentTo xrefs share a prefix |


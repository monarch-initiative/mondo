---
name: merge-terms
description: Use when asked to merge two MONDO terms — obsoleting one and transferring its
  metadata to the surviving term
---

# Merge two MONDO terms

## ⚠️ Running ODK commands

Every step below uses ODK tools (`owltools`, `robot`, `make NORM`). **Read the `odk` skill first** for how to invoke them — `sh run.sh <cmd>` if you have a TTY, otherwise direct `docker run ... -i obolibrary/odkfull:<tag>` (the tag lives in `src/ontology/run.sh`).

The commands below show the *body* (what goes after `sh run.sh ` or after the docker prefix). Pick the wrapper based on your environment.

## Required inputs

- **Term to obsolete** (the duplicate / less-rich term)
- **Replacement / surviving term** (the term content gets transferred to)
- **GitHub issue number** (the issue requesting the merge)

If any are missing, ask before proceeding.

## Step 1 — Run owltools merge

From `src/ontology/`:

```
owltools --use-catalog mondo-edit.obo \
  --obsolete-replace MONDO:XXXXXXX MONDO:YYYYYYY \
  -o -f obo mondo-edit.obo
```

Where `MONDO:XXXXXXX` = obsoleted, `MONDO:YYYYYYY` = surviving.

What owltools does:
- Renames the obsoleted term to `obsolete <original name>`
- Sets `is_obsolete: true` and `replaced_by: MONDO:YYYYYYY` on the obsoleted term
- Strips definition, comment, xrefs, synonyms, subsets, is_a, intersection_of, relationship, property_value from the obsoleted term
- Transfers xrefs, synonyms, subsets, is_a, relationships, property_values onto the surviving term — including stale "obsoletion-tracking" metadata (see Step 5)
- Adds the obsoleted term's name as a synonym on the surviving term, citing the obsoleted MONDO ID as evidence (must be fixed in Step 5)

## Step 2 — Normalize immediately

```
make NORM
```

Then `mv NORM mondo-edit.obo`. This deduplicates source qualifiers on identical subset/xref/is_a lines and re-quotes property_value URIs that owltools mangles.

NORM does **not** dedupe synonyms across different scopes (e.g. an EXACT and a RELATED with the same text both stay) — handle in Step 5.

## Step 3 — Checkout both terms

```bash
obo-checkout.pl src/ontology/mondo-edit.obo MONDO:XXXXXXX MONDO:YYYYYYY
```

## Step 4 — Clean up the OBSOLETED term

The obsoleted stanza must contain ONLY the lines below. Delete anything else owltools left behind (def, comment, xref, synonym, subset, is_a, intersection_of, relationship, other property_value) — but only after verifying the content is on the surviving term.

| Allowed line | Source |
|---|---|
| `id: MONDO:XXXXXXX` | unchanged |
| `name: obsolete <original name>` | set by owltools |
| `property_value: IAO:0000231 MONDO:TermsMerged` | **add manually** (obsoletion reason) |
| `property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/NNNN" xsd:anyURI` | **add manually** (issue link) |
| `is_obsolete: true` | set by owltools |
| `replaced_by: MONDO:YYYYYYY` | set by owltools |

## Step 5 — Clean up the SURVIVING term

owltools transfers content but several things need manual attention:

1. **Fix synonym evidence.** owltools added a synonym like `synonym: "<obsoleted name>" EXACT [MONDO:XXXXXXX]`. Replace `MONDO:XXXXXXX` with one of the *transferred* xrefs (e.g. `[Orphanet:NNNNNN]`). If the obsoleted name is identical to an existing synonym with a different scope, reconcile manually — pick the correct scope, drop the duplicate.

2. **Remove obsoletion-tracking metadata** that came from the obsoleted term:
   - `subset: obsoletion_candidate`
   - `subset: scheduled for obsoletion on or after` (if present)
   - `property_value: IAO:0006012 "<date>" xsd:string` (scheduled-obsoletion date — would otherwise claim the surviving term is scheduled for obsoletion)

3. **Decide which definition to keep.** Default = whichever the **issue** says is correct. If the issue is silent, keep the surviving term's existing definition. If the surviving term had no definition and the obsoleted one did, use the obsoleted one's. State the choice in the final summary so the user can override.

4. **Check for redundant `is_a`.** If a transferred `is_a` is a superclass of another `is_a` already on the surviving term (e.g. `MONDO:0000001` "disease" alongside a more specific class), remove the redundant one along with its source qualifiers.

5. **Check for an unwanted `alt_id`.** Some owltools versions add `alt_id: MONDO:XXXXXXX` to the surviving term. If present, remove it (Mondo policy: no `alt_id` for merges).

(Step 7.5 #8 will verify that all meaningful content from the obsolete stanza actually made it onto the surviving term — don't duplicate that check here.)

## Step 6 — Rewire children of the obsoleted term

owltools usually rewires `is_a` children, but does **not** touch references in `relationship:`, `intersection_of:`, `disjoint_from:`, etc. Sweep for ANY remaining reference:

```bash
obo-grep.pl --noheader -r 'MONDO:XXXXXXX' src/ontology/mondo-edit.obo
```

For each hit outside the obsoleted stanza itself, checkout that term, repoint the axiom to `MONDO:YYYYYYY`, and check it back in.

## Step 7 — Check in, normalize, run QC

1. Check in:
   ```bash
   obo-checkin.pl src/ontology/mondo-edit.obo MONDO:XXXXXXX MONDO:YYYYYYY [any rewired children]
   ```

2. Normalize:
   ```
   make NORM
   ```
   then `mv NORM mondo-edit.obo`.

3. Run targeted QC. The merge-relevant SPARQL checks live under `src/sparql/qc/general/`. Run them via `robot verify` (this is a body — wrap with `sh run.sh` or docker per the warning at the top of the skill):

   ```
   robot verify --catalog catalog-v001.xml -i mondo-edit.obo \
     --queries \
       ../sparql/qc/general/qc-proxy-merge-missing-preferred.sparql \
       ../sparql/qc/general/qc-misused-replaced-by.sparql \
       ../sparql/qc/general/qc-obsoletion-reason.sparql \
       ../sparql/qc/general/qc-deprecated-class-reference.sparql \
       ../sparql/qc/general/qc-xref-without-precision.sparql \
       ../sparql/qc/general/qc-duplicate-exact-synonym-no-abbrev.sparql \
     -O reports/
   ```

   Empty exit + `PASS Rule ... 0 violation(s)` per query = clean. **Note:** these queries do NOT catch a missing `IAO:0000231 MONDO:TermsMerged` on the obsoleted term — the Step 8 checklist is the real safety net.

## Step 7.5 — Self-verify

Before claiming done, run every check below. **If any fails, fix it before moving to Step 8 — do not just note it.**

### Mechanical checks

Run these greps. Replace `XXXXXXX` with the obsoleted ID and `YYYYYYY` with the surviving ID.

```bash
# 1. Obsolete stanza must contain ONLY: id, name, IAO:0000231, IAO:0000233, is_obsolete, replaced_by.
#    Any other line (def, comment, subset, xref, synonym, is_a, relationship, other property_value) is a failure.
obo-grep.pl --noheader -r 'id: MONDO:XXXXXXX' src/ontology/mondo-edit.obo

# 2. Surviving stanza must NOT contain obsoletion-tracking metadata.
obo-grep.pl --noheader -r 'id: MONDO:YYYYYYY' src/ontology/mondo-edit.obo \
  | grep -E 'subset: obsoletion_candidate|IAO:0006012|scheduled for obsoletion'
# Expected: no output. Any hit = failure.

# 3. No synonym on the surviving term should cite the obsoleted MONDO ID as evidence.
obo-grep.pl --noheader -r 'id: MONDO:YYYYYYY' src/ontology/mondo-edit.obo \
  | grep "\[MONDO:XXXXXXX\]"
# Expected: no output.

# 4. No alt_id anywhere referencing the obsoleted ID.
grep "alt_id: MONDO:XXXXXXX" src/ontology/mondo-edit.obo
# Expected: no output.

# 5. No reference to the obsoleted ID outside its own stanza (catches missed children).
obo-grep.pl --noheader -r 'MONDO:XXXXXXX' src/ontology/mondo-edit.obo
# Expected: only the line "id: MONDO:XXXXXXX" inside the obsolete stanza itself.
# Anything else (a leftover synonym evidence on the surviving term, an unrewired
# child term still pointing at the obsolete) = failure, fix it before continuing.

# 6. Flag any duplicate synonym text on the surviving term (different scopes, same text).
obo-grep.pl --noheader -r 'id: MONDO:YYYYYYY' src/ontology/mondo-edit.obo \
  | awk '/^synonym:/ {match($0, /"[^"]*"/); print substr($0, RSTART, RLENGTH)}' \
  | sort | uniq -d
# Expected: no output. Any duplicate text = manual reconciliation needed (pick correct scope, drop the other).
```

### Source-rereads (cheap — you already have what you need)

7. **Definition matches issue intent.** Re-read the GitHub issue body. If it specifies which definition to keep (or supplies a new one), confirm the surviving term reflects that. If the issue is silent, the surviving term's pre-merge definition should be unchanged.

8. **All meaningful content transferred.** Compare the pre-merge obsolete stanza to the post-merge surviving stanza:

   ```bash
   git show HEAD:src/ontology/mondo-edit.obo | obo-grep.pl --noheader -r 'id: MONDO:XXXXXXX' -
   obo-grep.pl --noheader -r 'id: MONDO:YYYYYYY' src/ontology/mondo-edit.obo
   ```

   Walk through every `xref:`, `synonym:`, `is_a:`, `relationship:`, `intersection_of:`, and `property_value:` on the obsolete stanza. Each must have an equivalent on the surviving term unless it was explicitly dropped. Allowed drops:
   - obsoletion-tracking metadata (see Step 5.2)
   - a redundant superclass `is_a` (see Step 5.4)
   - the owltools-injected `[MONDO:XXXXXXX]` synonym evidence
   - any `MONDO:Lexical`-qualified xref — these are auto-generated string-match cross-refs and don't need to survive a merge

   If you can't account for a line, fix it.

## Step 8 — Show diff and summary checklist

Show the user `git diff src/ontology/mondo-edit.obo` and the table below, filled in:

| What | From obsoleted | Status |
|------|---------------|--------|
| Synonyms | "..." [evidence] | transferred / merged citations / already on surviving / scope reconciled |
| Xrefs | PREFIX:ID | transferred / merged sources / skipped (duplicate) |
| Subsets | subset_name | transferred / source merged / removed (obsoletion-tracking) |
| `is_a` | MONDO:NNNNNNN ! parent | transferred / source merged / removed (redundant) |
| `intersection_of` | ... | transferred / already on surviving |
| Relationships | ... | transferred / source merged |
| Property values | curated_content_resource, etc. | transferred / removed (`IAO:0006012` scheduled date) |
| Definition | ... | kept surviving / replaced from obsoleted (per issue) |
| Children rewired | MONDO:NNNNNNN | rewired / none |
| New xrefs from issue | PREFIX:ID | added / n/a |
| Obsoleted-stanza cleanup | — | reduced to id+name+TermsMerged+issue+is_obsolete+replaced_by |
| `alt_id` | — | none / removed |

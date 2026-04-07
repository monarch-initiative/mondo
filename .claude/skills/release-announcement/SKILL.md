---
name: release-announcement
description: Generate a formatted Mondo release announcement with statistics table from release diff reports
---

# Generate Mondo Release Announcement

## Instructions

Generate a formatted release announcement markdown file and statistics table for a Mondo ontology release.

## Input Documents

Read these source files to extract all data:

1. **`src/ontology/reports/mondo_release_diff.md`** — The primary release diff report. Contains:
   - Overview section with summary counts
   - New terms table (with Mondo ID, Label, Definition columns)
   - Changed labels table (renamed terms, with old and new labels)
   - Changed definitions table
   - Obsoleted terms section
   - New obsoletion candidates table
   - Terms no longer obsoletion candidates table

2. **`src/ontology/reports/difference_release_base.md`** — The detailed base diff report. Contains:
   - Classes added (for cross-referencing new terms)
   - Text definitions changed
   - Nodes renamed
   - Relationships added/removed
   - Mappings added/removed

3. **`src/ontology/reports/mondo_obsoletioncandidates.tsv`** — Current total obsoletion candidates list (needed for the "total number of obsoletion candidates" statistic; count the rows excluding the header).

## Reference Examples

Look at the GitHub release notes for the `monarch-initiative/mondo` repository as formatting examples. To view the most recent release, use:
```
gh release view --repo monarch-initiative/mondo
```
Always use the most recent release as the formatting template.

## Task 1: Statistics Table

Include a **statistics summary table** at the top of the release announcement file (before the detailed sections). The table should be in this format:

| Statistic | Count |
|:---|---:|
| New terms | N |
| New terms with definitions | N |
| ... | ... |

### Statistics to compute:

| Statistic | How to compute |
|:---|:---|
| New terms | Count rows in "New terms" table from `mondo_release_diff.md` |
| New terms with definitions | Count rows in "New terms" table that have a non-empty Definition column |
| Terms renamed (including obsolete renames) | Count ALL rows in "Changed labels"/"Nodes renamed" sections |
| Terms renamed (excluding obsolete renames) | Count rows in "Changed labels" where the new label does NOT start with "obsolete" |
| Text definitions added (new + existing terms) | Count new terms that have definitions PLUS definitions added to existing terms |
| Text definitions added to existing terms only | Count entries in "Changed definitions" where the old definition is empty and the new definition is non-empty (excluding new terms) |
| Text definitions changed (excluding obsolete) | Count entries in "Changed definitions" where BOTH old and new definitions are non-empty, AND the new definition does NOT start with "OBSOLETE." |
| Text definitions removed | Count entries in "Changed definitions" where the old definition is non-empty and the new definition is empty |
| Terms obsoleted without replacement | Count obsoleted terms that have NO `replaced_by` |
| Terms obsoleted with replacement (merged) | Count obsoleted terms that HAVE a `replaced_by` |
| New obsoletion candidates | Count rows in "New obsoletion candidates" table |
| Terms no longer obsoletion candidates | Count rows in "previously candidates... not anymore" table |
| Total obsoletion candidates (current) | Count data rows (excluding header) in `src/ontology/reports/mondo_obsoletioncandidates.tsv` |

## Task 2: Release Notes Markdown

Create the detailed sections using the **exact same format** as the most recent GitHub release (with `<details>/<summary>` collapsible sections and markdown tables).

### Sections to include (in this order):

1. **New terms** — Table with: Mondo ID, Label, Definition. Source: `mondo_release_diff.md` "New terms" section.

2. **Terms renamed (excluding obsoleted terms)** — Table with: ID, Old Label, New Label. Source: `mondo_release_diff.md` "Changed labels" section. Exclude any terms that were renamed only because they were obsoleted (i.e., exclude renames where the new label starts with "obsolete").

3. **Text definitions added to existing terms** — Table with: Mondo ID, Label, New Text Definition. These are terms that previously had NO definition and now have one (excluding new terms). Source: cross-reference `mondo_release_diff.md` "Changed definitions" section — entries where the old definition was empty or the term already existed.

4. **Text definitions changed** — Table with: Mondo ID, Label, Old Text Definition, New Text Definition. Entries where BOTH old and new definitions are non-empty. Exclude obsoleted terms (where the new definition starts with "OBSOLETE."). Source: `mondo_release_diff.md` "Changed definitions" section.

5. **Terms obsoleted with replacement** — Table with: Mondo ID, Label, Replacement. These are terms marked obsolete that have a `replaced_by` tag (i.e., merges). Source: `mondo_release_diff.md` "Obsolete terms" section, filtered for those with replacements.

6. **Terms obsoleted without replacement** — Table with: Mondo ID, Label. Obsoleted terms that only have `consider` tags or no replacement at all. Source: `mondo_release_diff.md` "Obsolete terms" section, filtered for those without direct replacements.

7. **New obsoletion candidates** — Table with: Mondo ID, Label. Source: `mondo_release_diff.md` "New obsoletion candidates" section.

8. **Terms that were previously candidates for obsoletion and are now not anymore** — Table with: Mondo ID, Label. Source: `mondo_release_diff.md` corresponding section.

### Output file

Save the file as: `src/ontology/reports/release_announcement_YYMMDD.md` where YYMMDD is today's date.

## Important Notes

- The `mondo_release_diff.md` file begins with a log block between `---START LOG---` and `---END LOG---` markers. Do NOT include this log in the output.
- Each `<details>/<summary>` section should include the count in the summary line, e.g., `<summary>New terms: 11</summary>`.
- If a section has zero entries, still include it with an empty table and count of 0.
- Use the same markdown table formatting style as the most recent GitHub release.
- The output file title should be `# Mondo Release Statistics`.

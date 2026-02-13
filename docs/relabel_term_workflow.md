# Relabel Term Workflow

This document outlines the steps for relabeling (renaming) a MONDO term.

## 1. Fetch Latest Changes and Create Branch

```bash
git fetch origin
git checkout master
git pull
git checkout -b issue-<issue_number>-relabel-<short-description>
```

## 2. Find the Term

Search for the term to get its current details:
```bash
grep -A 25 '^id: MONDO:<id>' src/ontology/mondo-edit.obo
```

## 3. Make the Changes

### Change the Name
Update the `name:` field to the new label.

### Keep Old Name as Synonym
The old name should be kept as an exact synonym with appropriate references.

### Add Term Tracker
Add the GitHub issue reference:
```obo
property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/<issue_number>" xsd:anyURI
```

## 4. Optional Updates

### Update Definition References
Add new references to the definition:
```obo
def: "Definition text." [PMID:12345678, https://example.com/reference]
```

### Add Abbreviation Synonyms
```obo
synonym: "ABBREV" EXACT ABBREVIATION [PMID:12345678, https://orcid.org/0000-0000-0000-0000]
```

## 5. Commit and Create PR

```bash
git add src/ontology/mondo-edit.obo
git commit -m "Relabel MONDO:<id> <old name> to <new name>

Closes #<issue_number>

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
git push -u origin <branch-name>
```

Then create a PR via GitHub or CLI:
```bash
gh pr create --title "Relabel MONDO:<id> <old name> to <new name>" --body "Closes #<issue_number>

## Summary
- Changed name from \"<old name>\" to \"<new name>\"
- Kept \"<old name>\" as exact synonym
- <other changes>
"
```

## Example

### Before
```obo
[Term]
id: MONDO:0001252
name: Plummer disease
def: "Nodular enlargement of the thyroid gland associated with hyperthyroidism." [NCIT:P378]
synonym: "Plummer disease" EXACT [DOID:11277, icd11.foundation:999910988]
...
```

### After
```obo
[Term]
id: MONDO:0001252
name: toxic multinodular goitre
def: "Nodular enlargement of the thyroid gland associated with hyperthyroidism." [https://bestpractice.bmj.com/topics/en-gb/714, https://en.wikipedia.org/wiki/Toxic_multinodular_goitre, https://www.accessdata.fda.gov/drugsatfda_docs/label/2012/040350s016lbl.pdf, NCIT:P378, PMID:33351415]
synonym: "Plummer disease" EXACT [DOID:11277, icd11.foundation:999910988]
synonym: "Plummer's disease" EXACT [doi:10.1093/jama/9780195176339.003.0016, DOID:11277]
synonym: "Toxic goiter" EXACT [NCIT:C35171]
synonym: "Toxic goitre" EXACT OMO:0003005 []
synonym: "toxic nodular goiter" EXACT [DOID:11277, NCIT:C35171]
synonym: "toxic nodular goitre" EXACT OMO:0003005 []
synonym: "TMNG" EXACT ABBREVIATION [https://en.wikipedia.org/wiki/Toxic_multinodular_goitre, https://orcid.org/0000-0002-1149-7767]
synonym: "MNG" EXACT ABBREVIATION [https://bestpractice.bmj.com/topics/en-gb/714, https://orcid.org/0000-0002-1149-7767, PMID:33351415]
...
property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/9752" xsd:anyURI
```

## Checklist

- [ ] Old name kept as exact synonym
- [ ] Definition references updated (if applicable)
- [ ] New abbreviation synonyms added (if applicable)
- [ ] Term tracker item added
- [ ] PR title follows format: "Relabel MONDO:XXXXXXX old name to new name"
- [ ] PR body starts with "Closes #issue_number"

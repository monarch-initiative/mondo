# New Term Request Workflow

This document outlines the steps for creating a new MONDO term.

## 1. Find Parent Term ID

Search for the parent term to get its MONDO ID:
```bash
grep -i 'name: <parent term name>' src/ontology/mondo-edit.obo
```

## 2. Check ID Availability

Verify the proposed MONDO ID doesn't already exist:
```bash
grep 'MONDO:<proposed_id>' src/ontology/mondo-edit.obo
```

## 3. Create Term File

Create a new file in `terms/` folder with naming convention `MONDO_<id>.obo`:

```obo
[Term]
id: MONDO:<id>
name: <term name>
def: "<definition>" [<references>]
synonym: "<term name>" EXACT [<reference>] {OMO:0002001="https://w3id.org/information-resource-registry/clingen"}
is_a: MONDO:<parent_id> {source="<source>"} ! <parent name>
property_value: http://purl.org/dc/terms/creator https://orcid.org/0000-0002-7638-4659
property_value: IAO:0000233 "<github_issue_url>" xsd:anyURI
```

## 4. Required Elements

| Element | Description | Example |
|---------|-------------|---------|
| `id` | MONDO ID (7 digits) | `MONDO:1060197` |
| `name` | Term name | `congenital heart disease with heterotaxy syndrome` |
| `def` | Definition with references | `"Definition text." [PMID:12345678]` |
| `is_a` | Parent term(s) with source | `is_a: MONDO:0005453 {source="..."} ! congenital heart disease` |
| `property_value: creator` | Creator attribution | `https://orcid.org/0000-0002-7638-4659` |
| `property_value: IAO:0000233` | GitHub issue tracker | `"https://github.com/monarch-initiative/mondo/issues/XXXX" xsd:anyURI` |

## 5. Optional Elements

### Synonyms
```obo
synonym: "alternative name" EXACT [PMID:12345678]
synonym: "ABBREV" EXACT ABBREVIATION [PMID:12345678]
```

### ClinGen Preferred Label
```obo
synonym: "term name" EXACT [https://clinicalgenome.org/affiliation/XXXXX/] {OMO:0002001="https://w3id.org/information-resource-registry/clingen"}
```

### Multiple Parent Terms
```obo
is_a: MONDO:0002254 {source="https://clinicalgenome.org/affiliation/XXXXX/"} ! syndromic disease
is_a: MONDO:0005453 {source="https://clinicalgenome.org/affiliation/XXXXX/"} ! congenital heart disease
```

## 6. Reference Formats

| Type | Format | Example |
|------|--------|---------|
| PubMed | `PMID:<id>` | `PMID:19064609` |
| DOI | `doi:<id>` | `doi:10.1186/s13326-024-00320-3` |
| ClinGen | URL | `https://clinicalgenome.org/affiliation/40130/` |
| ORCID | URL | `https://orcid.org/0000-0001-5208-3432` |

## 7. Check In Term

Once the term is ready, check it into the main ontology:
```bash
obo-checkin.pl src/ontology/mondo-edit.obo MONDO:<id>
```

## 8. Validate Syntax

```bash
robot convert --catalog src/ontology/catalog-v001.xml -i src/ontology/mondo-edit.obo -f obo -o /dev/null
```

## 9. Create Pull Request

Before creating a PR, always fetch the latest changes:
```bash
git fetch origin
git checkout -b <branch-name>
git add src/ontology/mondo-edit.obo
git commit -m "Add new term: <term name> (MONDO:<id>)"
git push -u origin <branch-name>
```

Then create a PR via GitHub or CLI:
```bash
gh pr create --title "Add new term: <term name> (MONDO:<id>)" --body "Closes #<issue_number>

## Summary
- <bullet points describing changes>
"
```

## Example Complete Term

```obo
[Term]
id: MONDO:1060197
name: congenital heart disease with heterotaxy syndrome
def: "A heart disease that is present at birth that occurs with variable extracardiac laterality defects. Features of visceral heterotaxy are not always present but can include abnormal location of the organs within the thoracic, abdominal, or peritoneal cavities. Anatomic and functional problems can include intestinal malrotation leading to volvulus, biliary atresia, and various defects of the central nervous system, urinary tract, and skeleton." [https://clinicalgenome.org/affiliation/40130/, PMID:19064609, PMID:30293987, PMID:34666056]
synonym: "congenital heart disease with heterotaxy syndrome" EXACT [https://clinicalgenome.org/affiliation/40130/] {OMO:0002001="https://w3id.org/information-resource-registry/clingen"}
is_a: MONDO:0002254 {source="https://clinicalgenome.org/affiliation/40130/"} ! syndromic disease
is_a: MONDO:0005453 {source="https://clinicalgenome.org/affiliation/40130/"} ! congenital heart disease
property_value: http://purl.org/dc/terms/creator https://orcid.org/0000-0002-7638-4659
property_value: IAO:0000233 "https://github.com/monarch-initiative/mondo/issues/9463" xsd:anyURI
```

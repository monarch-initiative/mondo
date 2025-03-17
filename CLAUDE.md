# MONDO Ontology Project Guide

## Project Layout
- Main development file is `src/ontology/mondo-edit.obo`
- This file is LARGE, never Search or grep this directly EXCEPT using the tools below
- individual terms checked out in `terms`

## Querying ontology

- For most searches we STRONGLY RECOMMEND using OLS
    - `runoak -i ols:mondo info "diabetic"`
- synonyms may be incomplete, if you don't find what you expect, try similar terms
- To look at a specific term if you know the ID:
    - `obo-grep.pl -r 'id: MONDO:1234567' srcology/mono-edit.obo`
- All mentions of an ID
    - `obo-grep.pl -r 'MONDO:1234567' src/ontology/mondo-edit.obo`
- DO NOT bother doing your own greps over the file, or looking for other files, unless otherwise asked, you will just waste time.
- ONLY use the methods above for searching the ontology

## Before making edits
- Read the request carefully and make a plan, especially if there is nuance
- If related issues are mentioned read them: `gh issue view GITHUB-ISSUE-NUMBER`
- Do a background search e.g. using `aurelian websearch "SEARCH TERM"`
- Retrieve URLs like `aurelian geturl https://en.wikipedia.org/wiki/Apoptosis`
- Retrieve full text (or abstract if full text not availables): `aurelian fulltext "PMID:19173642"`
- if a PMID is mentioned in the issue, ALWAYS try and read it
- ALWAYS check proposed parent terms for consistency
- For terms that are compositional, check `src/patterns/dosdp-patterns/*yaml`

## Edits
- Do not edit the edit file directly, it's large
- Add edits should be made in the `terms/` folder
- check out a term into `terms/`: `obo-checkout.pl src/ontology/mondo-edit.obo MONDO:1234567 [OTHER IDS]`
- This will create a single stanza obo file `terms/MONDO_1234567.obo` which you can easily edit
- check back in: `obo-checkin.pl src/ontology/mono-edit.obo MINDO:1234567 [OTHER IDS]`
- checking in will update the edit file and remove the file from terms
- Commits are then made on mondo-edit.obo as appropriate

## OBO Format Guidelines
- Term ID format: MONDO:NNNNNNN (7-digit number)
- Handling New Term Requests (NTRs):
  - New terms start MONDO:009xxxxx
  - Do do `grep id: MONDO:009 src/ontology/mondo-edit.obo` to check for clashes
- Each term requires: id, name, namespace, definition with references
- Never guess MONDO IDs, use search tools above to determine actual term
- Never guess PMIDs for references, do a web search if needed
- Use standard relationship types: is_a, disease_disrupts, etc
- Follow existing term patterns for consistency

## GitHub Contribution Process
- Check existing terms before adding new ones
- For new terms: provide name, definition, place in hierarchy, and references
- Include PMIDs for all assertions
- Follow naming conventions from parent terms
- File PRs with clear descriptions

## Build Commands
- `cd src/ontology && make test` - Run validation tests


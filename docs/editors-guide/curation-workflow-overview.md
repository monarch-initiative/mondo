# Mondo Curation Workflow Overview

## Description
This document describes the community curation workflow in Mondo, including how new terms are added to Mondo, when terms are obsoleted, and Mondo releases. 

## Adding new terms to Mondo
- New terms are added to Mondo via two processes:
  1. User requests via our [GitHub tracker](https://github.com/monarch-initiative/mondo/issues)
  2. 'Slurping' from [external sources](https://mondo.monarchinitiative.org/pages/sources/) - this is our pipeline to ingest new terms from external sources (such as OMIM, Orphanet), to keep Mondo synched with the external sources.

### Term Maturity levels, public opinion period, and conflict resolution

- **Proposed terms**: Proposed new terms are publicly shared on our [GitHub tracker](https://github.com/monarch-initiative/mondo/issues) and labeled with ['new term request'](https://github.com/monarch-initiative/mondo/issues?q=is%3Aopen+is%3Aissue+label%3A%22New+term+request%22).
    - Terms are open for community comment for at least two weeks.
- **Provisional terms**: New terms are added to Mondo by the Mondo Curation team on a [Pull Request (PR)](https://github.com/monarch-initiative/mondo/pulls). Pull Requests undergo automatic quality control checks and are reviewed by members of the Mondo Curation team to check for accuracy, scientific soundness and other potential mistakes that are not identified by our automatic checks. Pull Requests are publicly available and anyone can comment on an open PR to request changes or make comments.
- Pull Requests are merged and new terms are added to the [mondo-edit.obo](https://github.com/monarch-initiative/mondo/blob/master/src/ontology/mondo-edit.obo) file. At this stage, new terms have a new Mondo ID.
- **Mature terms**:  Mondo is released on a monthly basis around the first of every month. After the Mondo release, the new terms are available in the [release files](https://github.com/monarch-initiative/mondo/releases).
- Terms will be visible in [OLS](https://www.ebi.ac.uk/ols4/ontologies/mondo) approximately a few days after the release.

## Obsoleting terms in Mondo
1. Terms in Mondo may be obsoleted for various reasons. Some examples of when to obsolete and/or merge a term are:  

- **Duplicate terms** (for example MONDO:0019055 mitochondrial disease was obsoleted and replaced by MONDO:0004069 'inborn mitochondrial metabolism disorder')  
- **Out of scope**- Some terms are excluded from Mondo based on certain criteria, which are outlined in the [exclusion reason table](editors-guide/exclusion-reasons.md). For example, terms that are not truly diseases, (ie phenotype terms, such as MONDO:0007348 Colchicine resistance). For another example, see [see #503](https://github.com/monarch-initiative/mondo/issues/503).
- **obsoleted in source**: for example, OMIM, Orphanet or GARD may retire or obsolete a term. For example, MONDO:0015173 obsolete autoimmune enteropathy type 2
is a phenotype and not a disease: for example, MONDO:0043606 'obsolete pathologic fracture'

2.  
3. More details about the obsoletion workflow is [here](https://mondo.readthedocs.io/en/latest/editors-guide/merging-and-obsoleting/).

## Conflict resolution

## Mondo Releases

Term Maturity levels, public opinion period, and conflict resolution: We will define the process for community vetting of proposed terms. For example, proposed new terms will be shared with the community for their comments before promoting the terms to the next maturity level (e.g. “proposed”, “provisional”, “mature” or “obsolete.”). The goal is to garner community agreement on what will best balance currency of information delivered to clinical settings with robustness of knowledge and ease of evidence interpretation.
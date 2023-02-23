# Mondo Curation Workflow Overview

## Description
This document describes the community curation workflow in Mondo, including how new terms are added to Mondo, when terms are obsoleted, and Mondo releases. 

## Adding new terms to Mondo
- New terms are added to Mondo via two processes:
  1. User requests via our [GitHub tracker](https://github.com/monarch-initiative/mondo/issues).
  2. 'Slurping' from [external sources](https://mondo.monarchinitiative.org/pages/sources/) - this is our pipeline to ingest new terms from external sources (such as OMIM, Orphanet), to keep Mondo synched with the external sources.
  
### How to request new terms in Mondo
1. New term requests should go on our [GitHub tracker](https://github.com/monarch-initiative/mondo/issues).
    - Guidelines on how to make new term requests are available [here](c-make-good-term-request.md)
2. Alternatively, you may contact us by email or via Slack to inquire about adding a new term. Please email info@monarchinitative.org with questions or to request to be added to our Slack channel.
3. Users are always welcome to join our weekly Curation calls,  please email info@monarchinitative.org and request to be added to the invitation.

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

2. If a term is a candidate for obsoletion and/or merging, it will be reported on the [GitHub issue tracker](https://github.com/monarch-initiative/mondo/issues) and labeled 'obsolete' or 'merge'. See [obsoletion candidates here](https://github.com/monarch-initiative/mondo/issues?q=is%3Aissue+is%3Aopen+label%3Aobsolete) or [merge candidates here](https://github.com/monarch-initiative/mondo/issues?q=is%3Aissue+is%3Aopen+label%3Amerge).
3. Issues will remain open for at least two months to allow for the community to comment and bring up any objections. All obsoletions will be done via a pull request and reviewed by Mondo developers.
4. Terms in the ontology file will be labeled as 'obsoletion candidates' and a proposed date for obsoletion will be added to the term.
4. With every Mondo release, we will report the terms that have been obsoleted from Mondo and the new obsoletion candidates (for example, see the [2023-02-06 release notes](https://github.com/monarch-initiative/mondo/releases/tag/v2023-02-06)).
5. When a term is tagged for obsoletion, the community has the opportunity to provide input about the potential obsoletion of the term. 
6. More details about the obsoletion workflow is [here](https://mondo.readthedocs.io/en/latest/editors-guide/merging-and-obsoleting/).

### Request to remove a term from the obsoletion list

If a Mondo terms has been tagged for obsoletion but it is in use by your project or you would like it to remain available, simply comment on the GitHub ticket or contact the Mondo Curation team via email or Slack and request that it be removed from the obsoletion candidate list. The Mondo Curation team is happy to oblige all requests.

## Mondo releases
- Mondo is released on a monthly basis around the 1st of each month.
- All of the Mondo releases are available [here](https://github.com/monarch-initiative/mondo/releases).
- Release notes includes:
    - list of all new terms
    - list of terms with updated label
    - list of terms with changed definitions
    - list of obsoleted terms
    - list of new obsoletion candidates
- Mondo users are notified of the latest release via our Mondo users email list. To be added to the email list, please contact email us at info@monarchinitative.org.

## Conflict resolution

The Mondo development team strives to provide an inclusive, community-based development process and we thrive based on our user and community feedback and participation. 

In the case that there are disagreements about our development approaches, we will work to resolve the issues. Some approaches include:
- Vetting process by members of the community is done on GitHub issues that are visible to (and can be commented on by) the community
- Open weekly Mondo Curation calls - any member of the community is welcome to join our calls. Please email info@monarchinitative.org and request to be added to the invitation.
- We host community workshops to discuss larger topics and workflows. A list of past workshops is available [here](https://mondo.monarchinitiative.org/pages/workshop/).

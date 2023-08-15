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
If should be noted that every new term request will be represented as a GitHub issue. This allows the community to review and comment on these proposed new terms, and offer guidance on classification, definition, etc... This open process ensures transparency and representation of the disease view of the community.

### Term Maturity levels, public opinion period, and conflict resolution

- **Proposed terms**: Proposed new terms are publicly shared on our [GitHub tracker](https://github.com/monarch-initiative/mondo/issues) and labeled with ['new term request'](https://github.com/monarch-initiative/mondo/issues?q=is%3Aopen+is%3Aissue+label%3A%22New+term+request%22).
    - GitHub issues for New Term Request are open for community comment for at least two weeks.
- **Provisional terms**: New terms are added to Mondo by the Mondo Curation team on a [Pull Request (PR)](https://github.com/monarch-initiative/mondo/pulls). Pull Requests undergo automatic quality control checks and are reviewed by members of the Mondo Curation team to check for accuracy, scientific soundness and other potential mistakes that are not identified by our automatic checks. Similar to GitHub issues, Pull Requests are publicly available and anyone can request changes or make comments on an open PR.
- Pull Requests are merged and new terms are added to the [mondo-edit.obo](https://github.com/monarch-initiative/mondo/blob/master/src/ontology/mondo-edit.obo) file. At this stage, new terms have a new Mondo ID.
- **Mature terms**:  Mondo is released on a monthly basis around the first of every month. After the Mondo release, the new terms are available in the [release files](https://github.com/monarch-initiative/mondo/releases).
- Terms will be visible in [OLS](https://www.ebi.ac.uk/ols4/ontologies/mondo) approximately a few days after the release.

## Obsoleting terms in Mondo
1. Terms in Mondo may be obsoleted for various reasons. Some examples of when to obsolete and/or merge a term are:  

- **Duplicate terms** : When terms represent the same concept, these terms will be merged and one of them will be obsoleted in the process (for example MONDO:0019055 mitochondrial disease was obsoleted and replaced by MONDO:0004069 'inborn mitochondrial metabolism disorder')  
- **Out of scope**- Some terms are excluded from Mondo because they are out of scope for Mondo. "Out of scope" criteria are outlined in the [exclusion reason table](editors-guide/exclusion-reasons.md). For example, terms that are not truly diseases, (ie phenotype terms, such as MONDO:0007348 Colchicine resistance). For another example, see [see #503](https://github.com/monarch-initiative/mondo/issues/503).
- **obsoleted in source**: Sources integrated in Mondo, for example OMIM, Orphanet or GARD, may retire or obsolete a term. For example, MONDO:0015173 obsolete autoimmune enteropathy type 2
- **phenotype not a disease**: The term concept represents a phenotype and not a disease: for example, MONDO:0043606 'obsolete pathologic fracture'

2. If a term is a candidate for obsoletion and/or merging, it will be reported on the [GitHub issue tracker](https://github.com/monarch-initiative/mondo/issues) and labeled 'obsolete' or 'merge'. See [obsoletion candidates here](https://github.com/monarch-initiative/mondo/issues?q=is%3Aissue+is%3Aopen+label%3Aobsolete) or [merge candidates here](https://github.com/monarch-initiative/mondo/issues?q=is%3Aissue+is%3Aopen+label%3Amerge).
3. Obsolete/merge related GitHub issues will remain open for at least two months to allow the community to comment and bring up any objections. All obsoletions will be done via a pull request and reviewed by Mondo developers.
4. Terms in the ontology file will be labeled as 'obsoletion candidates' and a proposed date for obsoletion will be added to the term.
4. With every Mondo release, we will report the terms that have been obsoleted from Mondo and the new obsoletion candidates (for example, see the [2023-02-06 release notes](https://github.com/monarch-initiative/mondo/releases/tag/v2023-02-06)).
5. When a term is tagged for obsoletion, the community has the opportunity to provide input about the potential obsoletion of the term. 
6. More details about the obsoletion workflow is [here](https://mondo.readthedocs.io/en/latest/editors-guide/merging-and-obsoleting/).

### Request to remove a term from the obsoletion list

Once a Mondo term is tagged as “obsoletion candidate”, the community has two months to dispute, comment, or inquire about the obsoletion of this term. All discussions (disputes, comments, or inquiries) **must be reported on the GitHub issue** linked to the obsoletion (reported in the [obsoletion candidates report](https://github.com/monarch-initiative/mondo/blob/master/src/ontology/reports/mondo_obsoletioncandidates.tsv)). Disputes and requests to retain the term in Mondo must include the justifications below. There are two main reasons to retain a term in Mondo: 
1. The **obsoletion candidate is an actual disease or a useful grouping class**, and therefore the concept should be retained in Mondo. In this case, justifications must include
    1. Supporting evidence(s), such as PMID or DOI, that the term represents an actual disease concept or a grouping term used by the community at large
    2. ORCID of the individual or link to the expert group requesting this removal from the obsoletion candidate list.
    3. If obsoletion candidate is a grouping term:
          1. report of other similar grouping terms (ie sibling terms). For example, if grouping by inheritance type, grouping terms by all inheritance types should exist).
          2. Suggestions for maintaining the diseases grouped by this term
             
Please note that a request to retain a term in Mondo does not imply that the term will be removed from the obsoletion list: further discussion with the Mondo team and the user community will be required before the final decision.

2. The **obsoletion candidate is used in disease annotations**. Annotations using terms tagged for obsoletion should be reviewed and updated accordingly. We do understand that it might take longer than 2 months to review all annotations, and therefore we will accommodate requests for delaying term obsoletion up to one year (unless ongoing discussions indicate otherwise). Please note that unless there is strong evidence that the obsoletion candidate represents an actual disease or a useful grouping class (see above), obsoletion candidates will eventually be obsoleted from Mondo. 

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

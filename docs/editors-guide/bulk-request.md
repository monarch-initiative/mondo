# How to request multiple new disease terms in Mondo

When requesting a lot of new disease terms (e.g. 100 chromosomal diseases) at once, one should submit their request by filling out and submitting [this template](https://github.com/monarch-initiative/mondo/blob/master/src/templates/Mondo_bulk_submission.tsv).

## Prepare for submission  
We advise submitters to [create a GitHub issue](https://github.com/monarch-initiative/mondo/issues) and communicate their intention to submit a bulk term request using the template.
While using the template ensures that the basic information required to create new terms are submitted, some diseases might require other specific information (e.g. affected gene). A curator will review the submission, advise, and (if necessary) send an updated template fitting the disease terms to be submitted.


## Fill out the template

The [template](https://github.com/monarch-initiative/mondo/blob/master/src/templates/Mondo_bulk_submission.tsv) contains the minimal information required to create a new term in Mondo.  

1. **Disease label** - required for new term request.  
1. **Disease ID** - if the disease is already in Mondo, and the request is to add more information for this existing term, please add the Mondo ID in the format MONDO:XXXXXXX.  
1. **Definition.** - required - Please try to formulate a definition of your term that will be comprehensible to non-specialists. When submitting multiple diseases of the same "type", a pattern should be used for consistency, and ease of the submitter (see [DOSDP patterns](https://mondo.readthedocs.io/en/latest/editors-guide/e-design-patterns/#design-pattern-dp-docs) for examples). A Mondo curator can assist with this if needed.  
1. **References.** - required - should be included with the definition. Please include link(s) to a published paper (preferably in the format PMID:XXXXX) or other sources (e.g. ORCID). Each reference should be separated by | (pipe, no space)
1. **Synonyms.** - optional - multiple synonyms should be separated by | (pipe, no space)  
1. **Parent term label** - required - Please provide the name of the parent term under which the term will be classified  
1. **Parent term ID** If the parent term is already in Mondo, please add the Mondo ID  
1. **Children term label** Please provide the name of term(s) which would be classified under the requested term. If multiple children label should be separated by | (pipe, no space)  
1. **Children term ID** If the children term is already in Mondo, please add the Mondo ID. Multiple children ID should be separated by | (pipe, no space)  
1. **ORCID**  This allows requesters' contribution to get attributed. Please include your [ORCID](https://orcid.org/). If you do not have an ORCID, you can register for free online.  
1. **Additional Information** this field might include gene affected, process affected, chromosomal anomaly, etc., that are used to define a disease. We recommend that requesters contact the Mondo team (preferably via a GitHub issue) to discuss additional required fields.  

Note about the [template](https://github.com/monarch-initiative/mondo/blob/master/src/templates/Mondo_bulk_submission.tsv):    

the template contains 4 rows:  

1. row 1: information requested (as listed above)    
1. row 2: simple explanation of the information requested for this field, as well as the requested format.  
1. row 3: this row contains the strings for merging the template into MONDO using ROBOT. This row is only for the Mondo team; requesters can ignore this line.  
1. row 4: is an example of term request. This row can be removed from the submission.  


## Process for requesting multiple Mondo terms by submitting a template

1. Prepare your submission: [create a GitHub issue](https://github.com/monarch-initiative/mondo/issues) and communicate their intend to submit term using the template.
1. Fill out the template.
1. Submit the template (.tsv format) by uploading it to the GitHub issue.
1. A Mondo curator will review the template for quality control and to insure that all the required fields have been added in the correct format.
1. The template will be merged to Mondo using ROBOT.
1. After QC checks have passed, the terms will be officially added to Mondo and available in the following Mondo release.

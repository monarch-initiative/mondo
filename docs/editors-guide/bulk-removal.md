## Removing annotations in bulk

### Use cases:
- removal of annotations in bulk.  For example: removing an obsoletion-candidate tag from a lot of terms.
- update of annotations in bulk. For example: updating exclusion code from a lot of terms because these codes were updated.

### Overview of the process:
1. A ROBOT template is created, including the annotations to remove.
1. An `.owl` version of the ROBOT template is created. This .owl file contains the annotations to be removed.
1. The .owl file created (containing the annotations to remove) is removed from the ontology using the "unmerge" command
1. _(if updating the annotations)_
    1. A ROBOT template is created, including the annotations replacing the one removed.
    1. the ROBOT template is merged using the regular "[Merging a ROBOT template](https://mondo.readthedocs.io/en/latest/editors-guide/robot-template/)" process

### Removing annotations in bulk:
1. Create a ROBOT template for annotations to remove.
    1. create a Google sheet including: Mondo term ID, Annotations to be removed
         Note: the column names for the annotations to remove follow the regular [ROBOT template semantics](http://robot.obolibrary.org/template)        
    1. Publish the spreadsheet on the web, in .tsv format
        1. Click File->Share->Publish to the Web
        1. Publish the specific sheet as TSV
        1. Copy the link to the TSV
1. Create the `.owl` version of the spreadsheet
    1. In Terminal, run :
      `sh run.sh make TMP_TEMPLATE_URL="xxx" temporary_template -B`
      1. where **xxx** is the link to the ROBOT template tsv_ (see example below)
      1. Note: this file will be in the temp folder (~/ontology/tmp/temporary.owl), and will not be seen in GitHub diff.
1. Unmerge the .owl file from the ontology
    1. In Terminal, run:
    `sh run.sh make UNMERGE_FILE=tmp/temporary.owl unmerge -B`
1. Check the GitHub diff: you should see that the annotations from the ROBOT template have been removed (note that the term IDs, though required in the ROBOT template, will not be removed)  

### Updating annotations in bulk:
1. Remove the annotations to be updated as explained above, in **removing annotations in bulk**
1. Create a ROBOT template with the updated annotations.
    1. For annotations replacement, the ROBOT template would essentially be the same as the one used for removing annotations (ie same fields), but with the new annotations.
1. Merge this ROBOT template following the regular process (explained [here](https://mondo.readthedocs.io/en/latest/editors-guide/robot-template/))
    1. Run: `sh run.sh make TEMPLATE_URL="yyy" merge_template -B`
    where **yyy** = the ROBOT template link
1. The end result is essentially an update of existing annotations.

### Examples:
#### Remove 'obsoletion-candidate' tag, and 'date of obsoletion'
This might be done when terms were removed from the obsoletion candidate list.
1. Robot template:

| id | label | Obsoletion candidate subset | obsoletion date
|--|--|--|--|
| **ID**		| | **AI oboInOwl:inSubset**	|**A IAO:0006012**|
|MONDO:0008856	|immunodeficiency 27A	|http://purl.obolibrary.org/obo/mondo#obsoletion_candidate	|2022-05-01|
|MONDO:0020248	|vitreoretinal degeneration	|http://purl.obolibrary.org/obo/mondo#obsoletion_candidate	|2022-05-01
|MONDO:0020094	|obsolete autosomal dominant disease with diffuse palmoplantar keratoderma as a major feature	|http://purl.obolibrary.org/obo/mondo#obsoletion_candidate | 	|
|MONDO:0017671	|obsolete autosomal recessive disease with diffuse palmoplantar keratoderma as a major feature	|http://purl.obolibrary.org/obo/mondo#obsoletion_candidate	| |

1. Create the .owl version of the spreadsheet:
Run: `sh run.sh make TMP_TEMPLATE_URL="https://docs.google.com/spreadsheets/d/e/2PACX-1vSEgalBcvuURhnd2pGGYU4r4cxpkOEMQN1Rzcb2rOem-foKrFc-svrOmqteBdadmHnSly8JEG1n_1mq/pub?gid=1507538904&single=true&output=tsv" temporary_template -B`
1. Unmerge the .owl file from the ontology:
Run: `sh run.sh make UNMERGE_FILE=tmp/temporary.owl unmerge -B`
1. Results:
   1. 'obsoletion candidate' tag is removed for all the terms
   1. 'obsoletion date' will be removed for the terms which has that information in the template, ie, in this example: MONDO:0008856, MONDO:0020248

#### Update 'exclusion code'
We might need to do this when we review the exclusion code usage and/or we create a new exclusion code to replace an existing one.
1. Robot template with annotations to remove:

|termid	|?label	|has obsolescence |reason	|?source
|--|--|--|--|--|
|**ID**	|	|**A IAO:0000231**	|**>A oboInOwl:source**
|MONDO:0000601	|obsolete autoimmune disorder of urogenital tract	|out of scope	|MONDO:excludeGroupingClass
|MONDO:0001424	|obsolete sarcoid meningitis	|out of scope	|MONDO:excludeFinding
|MONDO:0002336	|obsolete inflammatory and toxic neuropathy	|out of scope	|MONDO:excludeConditionsCausedByExternalForce

1. Create the .owl version of the spreadsheet:
Run: `sh run.sh make TMP_TEMPLATE_URL="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ8cszVqBNOeClD6uFif3QRHn0Ud_Cyt_gylyTTFJ-RoJaOwNWS7Qv3c516bJoTBaKT1WLagSQ7CQqS/pub?gid=0&single=true&output=tsv" temporary_template -B`
1. Unmerge the .owl file from the ontology:
Run:`sh run.sh make UNMERGE_FILE=tmp/temporary.owl unmerge -B`
1. GitHub diff: the exclusion code +source are removed for all the terms.
1. Create ROBOT template with the updated annotations:

|termid	|?label	|has obsolescence |reason	|new exclusion code
|--|--|--|--|--|
|**ID**	|	|**A IAO:0000231**	|**>A oboInOwl:source**|
|MONDO:0000601	|obsolete autoimmune disorder of urogenital tract	|out of scope	|MONDO:excludeGroupingMorpho
|MONDO:0001424	|obsolete sarcoid meningitis	|out of scope	|MONDO:excludePhenotype
|MONDO:0002336	|obsolete inflammatory and toxic neuropathy	|out of scope	|MONDO:excludeGrouping

1. Merge the new ROBOT template:
Run: `sh run.sh make TEMPLATE_URL="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ8cszVqBNOeClD6uFif3QRHn0Ud_Cyt_gylyTTFJ-RoJaOwNWS7Qv3c516bJoTBaKT1WLagSQ7CQqS/pub?gid=365804501&single=true&output=tsv" merge_template -B`
1. Results: the Mondo terms have an updated source associated to the "out of scope" exclusion reasons.











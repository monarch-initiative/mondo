# Update external sources

**Note:** this documentation is outdated and will be updated soon.

## Update OMIM

1. run ingest: https://ci.monarchinitiative.org/job/build-omim/ note: right now only a few people can actually run this and it is likely to be replaced by the new ingest being developed by Dazhi soon. For the moment, ping Nico to run this ingest. Before continuing to step 2, make sure that the run has completed by checking that the last run in the [build history](https://ci.monarchinitiative.org/job/build-omim/) is green. 
2. In terminal: `cd src/ontology`
3. In terminal: `sh run.sh make omim_slurp -B`
4. If successful this command will create two files: mondo/src/ontology/tmp/ps_slurp_omim.obo and mondo/src/ontology/tmp/rest_slurp_omim.obo
5. Add all the classes from the slurped files to mondo-edit.obo. (Use a text editor, rathe than Protege). 
6. If ps_slurp_omim.obo is not empty, go back to step 3 and run the slurp again until the ps_slurp_omim.obo is empty

## Update ORDO

1. In Finder/atom, go to src/ontology/sources/orphanet/Makefile
1. Change V=`3.2` to whatever version is the latest. To find the latest version, go to http://www.orphadata.org/, scroll down, search for Ontologies and click on section about ORDO.
1. In terminal: `cd src/ontology`
1. In terminal: `sh run.sh make ordo_slurp -B`
1. If successful this command will create two files: mondo/src/ontology/tmp/ps_slurp_ordo.obo and mondo/src/ontology/tmp/rest_slurp_ordo.obo. Note: ps_slurp_ordo.obo should always be empty
1. Add all the classes from the slurped files to mondo-edit.obo 

## Notes about adding new classes to mondo
1. Add the new classes via the mondo-edit.obo text file (ie Open mondo-edit.obo in Atom and copy and paste the text into the end of the mondo-edit.obo text file.)
1. Before copying and pasting the new terms into the text file, the terms should be reviewed and edited as described below.

### Review new OMIM terms 
1. Check Mondo to ensure the term does not already exist (ie the term was already added from another source).
1. If the term already exists in Mondo, add the OMIM ID as a dbxref, and add MONDO:equivalentTo.
1. Add any synonyms from OMIM (if they don't already exist), or add OMIM as a dbxref to any existing synonyms, as applicable.
1. Terms in the OMIM slurp include RELATED synonyms in the format TERM IN ALL CAPS; ABBREVIATION, for example: `synonym: "MEGACYSTIS-MICROCOLON-INTESTINAL HYPOPERISTALSIS SYNDROME 2; MMIHS2" RELATED  [OMIM:619351]`. 
1. For these cases, we do not want to duplicate the label in the synonym, so delete the duplicate label.
1. In almost all cases, the synonym should be EXACT.
1. Mark the abbreviation with ABBREVIATION 
For example: `synonym: "MMIHS2" RELATED ABBREVIATION [OMIM:619351]`

### Review new Orphanet terms 
1. Check Mondo to ensure the term does not already exist (ie the term was already added from another source like OMIM or NCIT).
1. If the term already exists in Mondo, add the Orphanet ID as a dbxref, and add MONDO:equivalentTo.
1. Add any synonyms from Orphanet (if they don't already exist), or add Orphanet as a dbxref to any existing synonyms, as applicable.
1. Check the capitalization of the synonyms and revise accordingly. All synonyms should lowercase unless they are proper names or abbreviations.
1. Add abbreviation tags to synonyms where applicable.
1. Fix annotations to 'narrow to broad term' or 'broad to narrow term'. The format should be changed as shown in the example below:
- **Original:**
xref: `ICD10:D21.9 {source="Orphanet:595133"} {source="NTBT (ORPHA code's Narrower Term maps to a Broader Term)"}` 
- **Fixed:**
xref: `ICD10:D21.9 {source="Orphanet:595133", source="Orphanet:595133/ntbt"}`

- unique_conditions_df
  - This file has the list of unique conditions from the download file of the 
Total submissions(https://www.ncbi.nlm.nih.gov/clinvar/submitters/505999/) and includes all OAK search results. 
This is an itermediate data set saved to file so that the search would not need to be run again.
This is _not_ the final result data because OAK search is case sensitive and the disease 
names on https://www.ncbi.nlm.nih.gov/clinvar/submitters/505999/ do not match 100% the Mondo disease name and/or synonyms
so another data source (MedGen) was used.

- clinvar_no_mondo.tsv
  - This is the filtered data set from unique_conditions_df where there are no search results.

---
- clinvar_udn_submissions-no_mondo.tsv
  - This is the final result file. This file is the result file of checking the table of Conditions
on https://www.ncbi.nlm.nih.gov/clinvar/submitters/505999/ against the MedGenIDMappings.txt (from MedGenIDMappings.txt.gz 
on https://ftp.ncbi.nlm.nih.gov/pub/medgen/). The MedGenIDMappings.txt file uses the same Condition name 
as on https://www.ncbi.nlm.nih.gov/clinvar/submitters/505999/ and has a column for source and source_id to know 
which Conditions can be found in Mondo.

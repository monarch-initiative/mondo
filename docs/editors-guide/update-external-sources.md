# Update external sources

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




%.tsv: %.csv
	csv2tsv.py $< $@

%.owl: %.tsv
	dosdp-tools --ontology=../ontology/tbn-edit.owl  --template=$*.yaml --outfile=$@ generate --infile=$<

fill:
	fill-col1-ids.pl --skip-dupes *.csv

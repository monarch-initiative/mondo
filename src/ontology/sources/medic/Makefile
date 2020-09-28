all: medic.obo

CTD_diseases.obo.gz:
	wget http://ctdbase.org/reports/CTD_diseases.obo.gz -O $@

medic.obo: CTD_diseases.obo.gz
	gzip -dc $< | perl -npe 's@^alt_id:@xref:@;s@DO:DOID@DOID@' > $@

TODAY ?= $(shell date +%Y-%m-%d)
TGT=../releases/v$(TODAY)

PRODUCTS = medic.obo
OIO = http://www.geneontology.org/formats/oboInOwl#

all:  build stage
build:  $(PRODUCTS)
stage: $(patsubst %, stage-%, $(PRODUCTS))
stage-%: % | $(TGT)
	cp $< $(TGT)

$(TGT):
	mkdir -p $@

CTD_diseases.obo.gz:
	wget http://ctdbase.org/reports/CTD_diseases.obo.gz -O $@

medic.obo: CTD_diseases.obo.gz
	gzip -dc $< | perl -npe 's@^alt_id:@xref:@;s@DO:DOID@DOID@' > $@

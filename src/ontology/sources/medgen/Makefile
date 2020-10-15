OBO=http://purl.obolibrary.org/obo
TODAY ?= $(shell date +%Y-%m-%d)
TGT=../../releases/v$(TODAY)
PRODUCTS = medgen-disease-extract.obo medgen-disease-extract.owl

all:  build stage
build:  $(PRODUCTS)
stage: $(patsubst %, stage-%, $(PRODUCTS))
stage-%: %
	cp $< $(TGT)

$(TGT):
	mkdir -p $@

# ----------------------------------------
# ETL
# ----------------------------------------
fetch:
	wget -r -np ftp://ftp.ncbi.nlm.nih.gov/pub/medgen/ && touch $@

uid2cui.tsv:
	perl ./bin/make_uid2cui.pl > $@

# ----------------------------------------
# Hacky conversion to obo
# ----------------------------------------
# relies on MGCONSO.RRF.gz etc being made by 'fetch' step
medgen.obo: fetch uid2cui.tsv
	perl ./bin/medgen2obo.pl > $@.tmp && mv $@.tmp $@

# we only care about diseases for now
# NOTE: some cancers seem to appear under Neoplastic-Process
x-%.obo: medgen.obo
	owltools $< --extract-subset $* --set-ontology-id $(OBO)/mondo/$@ -o -f obo $@

medgen-disease-extract.obo: x-Disease-or-Syndrome.obo x-Neoplastic-Process.obo
	owltools $^ --merge-support-ontologies -o -f obo $@

medgen-disease-extract.json: medgen-disease-extract.obo
	owltools $< -o -f json $@

medgen-disease-extract.owl: medgen-disease-extract.obo
	owltools $< -o $@


# ----------------------------------------
# Cycles	
# ----------------------------------------

%-cycles.tsv: %.obo
	blip-findall -i $< "subclass_cycle/2" -label -no_pred -use_tabs > $@



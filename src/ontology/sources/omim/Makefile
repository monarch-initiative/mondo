TODAY ?= $(shell date +%Y-%m-%d)
TGT=../releases/v$(TODAY)
PRODUCTS = omim.owl
OMIM_URL=https://github.com/monarch-initiative/omim/releases/latest/download/omim.ttl
OBOGREPL=perl ../../obo-grep.pl

all:  build stage
build:  $(PRODUCTS)
stage: $(patsubst %, stage-%, $(PRODUCTS))
stage-%: % | $(TGT)
	cp $< $(TGT)

$(TGT):
	mkdir -p $@

omim-src.ttl:
	wget $(OMIM_URL) -O $@

omim-src.owl: omim-src.ttl
	owltools $< --set-ontology-id $(OBO)/mondo/$@ -o $@
	
omim-src.obo: omim-src.owl
	robot convert -i $< --check false -f obo -o $@.tmp.obo && grep -v ^owl-axioms $@.tmp.obo | perl ./bin/fix-omim.pl  > $@
	rm $@.tmp.obo

# this gets rid of genes
omim.obo: omim-src.obo
	$(OBOGREPL) --neg -r '(equivalent_to|is_a: SO|property_value: RO:0002524)' omim-src.obo | $(OBOGREPL) -r 'property_value: https://w3id.org/biolink/vocab/category https://w3id.org/biolink/vocab/Disease' - | perl -npe 's@https://omim.org/entry/@OMIM:@g;s@https://www.omim.org/phenotypicSeries/PS@OMIMPS:@g' |  $(OBOGREPL) -r 'id: OMIM' -   > $@.tmp.obo
	owltools $@.tmp.obo --set-ontology-id http://purl.obolibrary.org/obo/omim.owl -o -f obo $@ && rm $@.tmp.obo
.PRECIOUS: omim.obo

omim.owl: omim.obo
	owltools $< --set-ontology-id http://purl.obolibrary.org/obo/omim.owl -o $@

#omim_sssom.tsv: omim.owl
#	robot query -i $< --prefix "ORDO: http://www.orpha.net/ORDO/Orphanet_" -q ../../../sparql/sssom.sparql $@

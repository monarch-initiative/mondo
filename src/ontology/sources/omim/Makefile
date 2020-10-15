TODAY ?= $(shell date +%Y-%m-%d)
TGT=../../releases/v$(TODAY)
PRODUCTS = omim.owl
OMIM_URL=https://data.monarchinitiative.org/experimental/omim.ttl
OBOGREPL=perl ../../obo-grep.pl

all:  build stage
build:  $(PRODUCTS)
stage: $(patsubst %, stage-%, $(PRODUCTS))
stage-%: % | $(TGT)
	cp $< $(TGT)

$(TGT):
	mkdir -p $@

omim-src.ttl:
	wget --no-check-certificate $(OMIM_URL) -O $@

omim-src.owl: omim-src.ttl
	owltools $< --set-ontology-id $(OBO)/mondo/$@ -o $@
	
omim-src.obo: omim-src.owl
	echo "WARNING: OMIM ingest has multiple labels on classes (see https://github.com/monarch-initiative/dipper/issues/969)"
	robot convert -i $< --check false -f obo -o $@.tmp.obo && grep -v ^owl-axioms $@.tmp.obo | perl ./bin/fix-omim.pl  > $@
	rm $@.tmp.obo

# this gets rid of genes
omim.obo: omim-src.obo
	$(OBOGREPL) --neg -r '(equivalent_to|is_a: SO|property_value: RO:0002524)' $< | $(OBOGREPL) -r 'property_value: https://w3id.org/biolink/vocab/category https://w3id.org/biolink/vocab/Disease' - | perl -npe 's@http://omim.org/entry/@OMIM:@g;s@http://www.omim.org/phenotypicSeries/PS@OMIMPS:@g' |  $(OBOGREPL) -r 'id: OMIM' -   > $@.tmp.obo
	owltools $@.tmp.obo --set-ontology-id http://purl.obolibrary.org/obo/omim.owl -o -f obo $@ && rm $@.tmp.obo
.PRECIOUS: omim.obo

omim.owl: omim.obo
	owltools $< --set-ontology-id http://purl.obolibrary.org/obo/omim.owl -o -f obo $@

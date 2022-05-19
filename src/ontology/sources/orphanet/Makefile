# ~~~~~~~~
# ORDO
# ~~~~~~~~

OBO=http://purl.obolibrary.org/obo
TODAY ?= $(shell date +%Y-%m-%d)
TGT=../releases/v$(TODAY)
PRODUCTS = obo_orphanet.owl obo_orphanet.obo
OIO=http://www.geneontology.org/formats/oboInOwl\#

all:  build stage
build:  $(PRODUCTS)
stage: $(patsubst %, stage-%, $(PRODUCTS))
stage-%: % | $(TGT)
	cp $< $(TGT)

$(TGT):
	mkdir -p $@

EFO=http://www.ebi.ac.uk/efo

# In converting to obo format, everything is assumed to have an OBO prefix.
# This perl corrects this.
# Longer term we need to eliminate passing through obo and/or fix the owlapi implementation to respect prefixes
FIX_URI_EXPR = 's@$(OBO)/EFO_@http://www.ebi.ac.uk/efo/EFO_@g; s@$(OBO)/UMLS_@http://linkedlifedata.com/resource/umls/id/@g'

# EFO uses different properties. The following command can be used on owltools
EFO2OBO_OPTS = --rename-entity $(EFO)/definition $(OBO)/IAO_0000115 \
           --rename-entity $(EFO)/reason_for_obsolescence $(RDFS)comment \
           --rename-entity $(EFO)/alternative_term "$(OIO)hasExactSynonym" \
           --rename-entity $(OBO)/ECO_0000218 "$(OIO)source"


V=4.0

# STEP 0: DOWNLOAD
#ordo_orphanet.owl.zip:
#	curl -L -s http://www.orphadata.org/data/ORDO/ordo_orphanet.owl.zip > $@.tmp  && mv $@.tmp $@

#ordo_orphanet.owl: ordo_orphanet.owl.zip
#	unzip  ordo_orphanet.owl.zip -d .
#	touch $@

ordo_orphanet.owl:
	curl -L -s http://www.orphadata.org/data/ORDO/ORDO_en_$(V).owl > $@.tmp && mv $@.tmp $@

obo_orphanet_0.owl: ordo_orphanet.owl unmerge.owl
	robot unmerge -i $< -i unmerge.owl -o $@

# STEP 1: FIX URIs
obo_orphanet_1.owl: obo_orphanet_0.owl
	owltools $< $(EFO2OBO_OPTS) -o $@.tmp && mv $@.tmp $@

# STEP 2: Fix XREFs
obo_orphanet_2.owl: obo_orphanet_1.owl
	perl -npe 's@MeSH:@MESH:@;s@ICD-10:@ICD10:@;' $< >  $@.tmp && mv $@.tmp $@

# STEP 2b: Create is-a from part-of
obo_orphanet_sc.owl: obo_orphanet_2.owl
	robot query --format ttl -c construct-subclass-from-part-of.sparql $@ -i $<

# STEP 2c: Create subsets based on subClass to sub-root level
obo_orphanet_subsets.owl: obo_orphanet_2.owl
	robot query --format ttl -c construct-ordo-subsets.sparql $@ -i $<

# STEP 3: merge 2b and 2c in to 2
obo_orphanet_3.owl: obo_orphanet_2.owl obo_orphanet_sc.owl obo_orphanet_subsets.owl
	owltools $^ --merge-support-ontologies -o $@

# STEP 3a: get genes
obo_orphanet_d2g.owl: obo_orphanet_3.owl
	robot query --format ttl -c construct-d2g.sparql $@ -i $<

# STEP 3b: make an .obo file
obo_orphanet_3.obo: obo_orphanet_3.owl obo_orphanet_d2g.owl
	owltools $^ --merge-support-ontologies --set-ontology-id http://purl.obolibrary.org/obo/orphanet -o -f obo $@.tmp && grep -v ^owl-axioms $@.tmp > $@

# STEP 4: Remove part-ofs (see 2b, we have these as subClassOf now)
# TODO: use robot remove for this
obo_orphanet_4.obo: obo_orphanet_3.obo
	grep -v '^relationship: BFO:0000050' $< > $@


obo_orphanet.obo: obo_orphanet_4.obo
	cp $< $@
obo_orphanet.owl: obo_orphanet.obo
	owltools $< -o $@.tmp && perl -npe 's@http://purl.obolibrary.org/obo/Orphanet_@http://www.orpha.net/ORDO/Orphanet_@g' $@.tmp > $@

#orphanet_sssom.tsv: obo_orphanet.owl
#	robot query -i $< --prefix "ORDO: http://www.orpha.net/ORDO/Orphanet_" -q ../../../sparql/sssom.sparql $@

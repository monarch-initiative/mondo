# ----------------------------------------
# Instructions
# ----------------------------------------
#
# This needs to be simplified!
#
# ```
# make all
# rm mondo-lastbuild.obo
# make mondo-diff.txt
# ./get-new-classes.sh
# [manually edit ../../Changes.md using output of previous command and "git log mondo-edit.obo"]
# ```

# ----------------------------------------
# Standard Constants
# ----------------------------------------
# these can be overwritten on the command line

OBO=http://purl.obolibrary.org/obo
OIO=http://www.geneontology.org/formats/oboInOwl\#
RDFS=http://www.w3.org/2000/01/rdf-schema#
SKOS=http://www.w3.org/2004/02/skos/core\#
EFO=http://www.ebi.ac.uk/efo
ONT=mondo
ONTURI=$(OBO)/$(ONT)
ONTBASE=$(OBO)/$(ONT)


SRC=$(ONT)-edit.obo
#RELEASEDIR=../../target/
CATALOG=catalog-v001.xml
ROBOT= robot --catalog $(CATALOG)
OWLTOOLS= owltools
USECAT= --use-catalog
SPARQLDIR = ../sparql
PATTERNDIR = ../patterns
TMPDIR = tmp

CONSTRUCTS= embedded-definition
INCLUDES_OWL = $(patsubst %,include-%.owl,$(CONSTRUCTS))
ISODATE:=`date +%Y-%m-%d`
TODAY ?= $(shell date +%Y-%m-%d)
OBODATE ?= $(shell date +'%d:%m:%Y %H:%M')

FMTS = obo owl json

obo-filter-axiom-header = grep -v ^owl-axioms:

OWL2OBO = $(ROBOT) convert -i $< -o $@.tmp.obo && grep -v ^owl-axioms: $@.tmp.obo > $@

PV_CC0 = http://purl.org/dc/terms/license https://creativecommons.org/publicdomain/zero/1.0/

# In converting to obo format, everything is assumed to have an OBO prefix.
# This perl corrects this.
# Longer term we need to eliminate passing through obo and/or fix the owlapi implementation to respect prefixes
FIX_URI_EXPR = 's@$(OBO)/EFO_@http://www.ebi.ac.uk/efo/EFO_@g; s@$(OBO)/UMLS_@http://linkedlifedata.com/resource/umls/id/@g'

# EFO uses different properties. The following command can be used on owltools
EFO2OBO_OPTS = --rename-entity $(EFO)/definition $(OBO)/IAO_0000115 \
           --rename-entity $(EFO)/reason_for_obsolescence $(RDFS)comment \
           --rename-entity $(EFO)/alternative_term $(OIO)hasExactSynonym\
           --rename-entity $(OBO)/ECO_0000218 $(OIO)source

# EFO uses different prefixes in xrefs. We replace these with the following perl
# intended to be used within a perl -npe loop.
# In future we should use a more robust translation
EFO2OBO_PERL = 's@NCIt:@NCIT:@; s@MSH:@MESH:@; s@SNOMEDCT:@SCTID:@;'
OBOGREPL=../scripts/obo-grepl.pl
OBOGREP=../scripts/obo-grep.pl
ADDTOTBD=../scripts/add-to-tbd.pl

# ----------------------------------------
# Top-level targets
# ----------------------------------------
.PHONY: .FORCE
all: test all_artefacts mappings
	echo "release finished"

# ----------------------------------------
# Artefacts
# ----------------------------------------
ONTOLOGY_IMPORTS = uberon cl go pato ro hp mf ncbitaxon chebi envo ncit hgnc foodon so ecto omo chr hsapdv nbo maxo mfomd
IMPORT_ROOTS = $(patsubst %, imports/%_import, $(ONTOLOGY_IMPORTS)) imports/equivalencies
IMPORT_FILES = $(foreach n,$(IMPORT_ROOTS), $(n).owl $(n).obo $(n).json)  imports/axioms.owl
IMPORT_FILES_OWL = $(foreach n,$(IMPORT_ROOTS), $(n).owl)  imports/axioms.owl

COMPONENTS = mondo-tags mondo-subsets
COMPONENT_FILES = $(foreach n, $(COMPONENTS), components/$(n).owl)

SUBSETS = mondo-minimal mondo-rare
SUBSET_ROOTS = $(patsubst %, subsets/%, $(SUBSETS))
SUBSET_FILES = $(foreach n,$(SUBSET_ROOTS), $(n).owl $(n).obo $(n).json)

REPORTS = basic-report class-count-by-prefix edges xrefs obsoletes obsoletion-candidates synonyms class-stats root-classes superclass-count
REPORT_ARGS = $(foreach V,$(REPORTS),-s $(SPARQLDIR)/reports/$V.sparql reports/$V.tmp.tsv)
MAIN_REPORT_FILES = $(foreach V, $(REPORTS), reports/$V.tsv)
ADDITIONAL_REPORT_FILES = reports/semantic-xref-pairs.tsv
#ADDITIONAL_REPORT_FILES = reports/release/mondo-obo-report.yaml reports/release/mondo-owl-report.yaml reports/release/semantic-xref-pairs.tsv
REPORT_FILES = $(MAIN_REPORT_FILES) $(ADDITIONAL_REPORT_FILES)


MAIN_PRODUCTS = $(ONT) $(ONT)-base $(ONT)-with-equivalents
MAIN_FILES = $(foreach n,$(MAIN_PRODUCTS), $(n).owl $(n).obo $(n).json)
EQUIVALENTS_FILES=imports/equivalencies
EQUIVALENTS = $(foreach n, $(EQUIVALENTS_FILES), $(n).owl $(n).obo $(n).json)
ARTEFACTS = \
  $(IMPORT_FILES) \
  $(MAIN_FILES) \
  $(EQUIVALENTS) \
  $(REPORT_FILES) \
  $(COMPONENT_FILES) \
  $(SUBSET_FILES)

REPORT_FILES_RELEASE = reports/mondo_release_diff_changed_terms.tsv \
  reports/mondo_release_diff_new_terms.tsv \
  reports/mondo_obsoletioncandidates.tsv

ASSETS = $(MAIN_FILES) $(SUBSET_FILES) $(EQUIVALENTS) \
  ../../README.md \
  $(REPORT_FILES_RELEASE)

list_main_files:
	echo $(MAIN_FILES)

list_artefacts:
	echo $(ARTEFACTS)
	du -sh $(ARTEFACTS)
%-DU:
	@test -f $* && du -sh $* || echo "MISSING" $*


all_artefacts: all_reports $(ARTEFACTS)

all_release_reports: $(REPORT_FILES_RELEASE)

# ----------------------------------------
# Tests
# ----------------------------------------

#all: test all_imports all_reports all_equivalencies all_subsets imports/equivalencies.obo $(ONT).owl $(ONT).obo $(ONT).json pre/$(ONT).owl pre/$(ONT).obo pre/$(ONT).json extid/$(ONT).owl extid/$(ONT).obo extid/$(ONT).json $(ONT)-merged.owl

test: sparql_test_edit roundtrip.obo debug.owl debug_inference_check.owl mondo-edit.owl sparql_test_main_obo test_nomerge
test: reports/robot-report-mondo-tags-reasoned.owl.tsv
test: sparql_test_main_owl

# ----------------------------------------
# Staging releases
# ----------------------------------------

#prepare_release: $(ARTEFACTS)
#	$(MAKE) mappings -B
#	rsync -R $^ ../..

# note: only reports, imports
prepare_release_direct:
	rsync -R $(ARTEFACTS) ../..

all_includes: $(INCLUDES_OWL)

#OSF_UPLOAD = $(HOME)/repos/osf-cli/venv/bin/osf -p 2qk53 upload
#osf_upload: prepare_release osf_upload_direct
#osf_upload_direct:
#	cd ../.. && $(OSF_UPLOAD) -f -r target/ current/ && $(OSF_UPLOAD) -f -r target/ releases/$(ISODATE)

list_assets:
	ls -alt $(ASSETS)
	echo $(GHVERSION)

check_version_set:
	@test $(GHVERSION)

# REMEMBER TO COMMIT/PUSH
# e.g. make deploy_release GHVERSION=v2018-10-26
# this will create the GH repo. Use --no-create if repo already created.
deploy_release: deploy_assets_direct
#deploy_assets_current see https://github.com/OBOFoundry/purl.obolibrary.org/pull/723

# deploys to a versioned released
deploy_assets_direct:
	@test $(GHVERSION)
	ls -alt $(ASSETS)
	gh release create $(GHVERSION) --notes "TBD." --title "$(GHVERSION)" --draft $(ASSETS)

#	../utils/make-release-assets.py -c $(RELEASE_ASSETS_OPTS) --release $(GHVERSION) $(ASSETS)
# deploys to https://github.com/monarch-initiative/mondo/releases/tag/current
#deploy_assets_current:
#	ls -alt $(ASSETS)
#	../utils/make-release-assets.py -c -f --release current $(ASSETS)

# ----------------------------------------
# Main release targets
# ----------------------------------------

ANN = annotate -V $(ONTURI)/releases/`date +%Y-%m-%d`/$@.owl

# the GITHUB_ACTION flag should be set to true to skip computationally intensive actions in the pipeline that are not necessary for QC, see filtered.obo
# Use sparingly

GITHUB_ACTION = false

filtered.obo: $(SRC)
	perl -ne 'print unless (m@^xref: (Orphanet|OMIM|OMIMPS|DOID|EFO|NCIT|SCTID|MESH|UMLS|ICD10CM):@ && !(m@(obsoleteEquivalent|equivalentObsolete|equivalentTo|relatedTo|mondoIsNarrowerThanSource|directSiblingOf|mondoIsBroaderThanSource)@i))' $< | grep -v '^property_value: confidence' | grep -v '^property_value: excluded_subClassOf' | egrep -v '^synonym: .*EXCLUDE' | egrep -v 'relationship: disease_has_basis_in_dysfunction_of (hgnc|HGNC|NCBIGene):' > $@.tmp && mv $@.tmp $@
	if [ $(GITHUB_ACTION) = false ]; then $(ROBOT) query -i $@ --use-graphs false \
		--update ../sparql/update/delete-axiom-annotations.ru \
		--update ../sparql/update/delete-axiom-annotations-by-prefix.ru \
		--update ../sparql/update/inject-cross-species-analog.ru \
		remove --term-file config/remove-annotations-before-release.txt \
		convert -f obo --check false -o $@.obo && mv $@.obo $@; fi
#egrep -v 'MONDO:(subClassOf|superClassOf|relatedTo)' $< > $@

skos.ttl: filtered.obo
	../utils/mk-skos.pl $< > $@

# this appears to be problematic. not all declarations are restored on a save.
#REMOVE_DECLARATIONS = --remove-axioms -t Declaration
REMOVE_DECLARATIONS=

# necessary to remove stray declarations induced by obo2owl;
# we remove declaration axioms for ALL classes;
# all necessary ones are implicitly added back when converting back to OWL
# see: https://github.com/owlcs/owlapi/pull/761
filtered.owl: filtered.obo skos.ttl
	owltools --use-catalog $< $(REMOVE_DECLARATIONS) skos.ttl --merge-support-ontologies -o $@

# perform reasoning on source
# PREVIOUS: SKIP FOR NOW: assume pre-asserted, but run reasoner to check
# note: $(ROBOT) will protect redundant annotated axioms
reasoned.owl: filtered.owl
	$(ROBOT) reason -T true -x true -X true -i $< -r ELK relax reduce -p false -r ELK \
		remove --term MONDO:0700097 $(ANN) -o $@


test: reasoned-plus-equivalents.owl

# merged = reasoned + equivalencies
reasoned-plus-equivalents.owl: reasoned.owl imports/equivalencies.owl
	owltools --use-catalog $^ --merge-support-ontologies -o $@
	#$(ROBOT) reason -i $@ --equivalent-classes-allowed asserted-only -o $(TMPDIR)/$@_test_equivalents.owl



# PRE-RELEASES: MONDO IDs primary
#
# by default we use Elk to perform a reason-relax-reduce chain
# after that we annotate the ontology with the release versionInfo
$(ONT).owl: reasoned.owl
	$(ROBOT) merge -i $< annotate -V $(ONTURI)/releases/`date +%Y-%m-%d`/$(ONT).owl -o $@

# obo is self-contained
$(ONT).obo: reasoned.owl
	$(ROBOT) annotate -i $< -V $(ONTURI)/releases/`date +%Y-%m-%d`/$(ONT).owl -o $@.tmp.owl
	owltools --use-catalog $@.tmp.owl --remove-imports-declarations --remove-dangling -o -f obo --no-check $@.tmp && $(obo-filter-axiom-header) $@.tmp > $@
	rm -f $@.tmp.owl

$(ONT).json: $(ONT).owl
	$(ROBOT) convert --input $< --check false -f json -o $@.tmp.json &&\
		mv $@.tmp.json $@

$(ONT)-with-equivalents.owl: reasoned-plus-equivalents.owl
	$(ROBOT) annotate -i $< -V $(ONTURI)/releases/`date +%Y-%m-%d`/$(ONT).owl -o $@

$(ONT)-with-equivalents.obo: $(ONT)-with-equivalents.owl
	$(OWL2OBO)
$(ONT)-with-equivalents.json: $(ONT)-with-equivalents.owl
	$(ROBOT) convert -i $< -o $@.tmp.json && mv $@.tmp.json $@

#$(ONT)-atomic.owl: $(ONT).owl
#	owltools --use-catalog $< --remove-imports-declarations --set-ontology-id $(OBO)/$(ONT)/$@ -o $@.tmp && mv $@.tmp $@

# Component module.
# we remove imports and merge in additional assertions
# note: typically component is not pre-reasoned, but this is compex for mondo.

OTHER_SRC=imports/axioms.owl components/mondo-subsets.owl

$(ONT)-base.owl: reasoned.owl
	$(ROBOT) remove --input $< --select imports --trim false \
		merge $(patsubst %, -i %, $(OTHER_SRC)) \
		annotate --annotation http://purl.org/dc/elements/1.1/type http://purl.obolibrary.org/obo/IAO_8000001 \
		--ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ \
		--output $@.tmp.owl && mv $@.tmp.owl $@

$(ONT)-base.obo: $(ONT)-base.owl
	$(OWL2OBO)
$(ONT)-base.json: $(ONT)-base.owl
	$(ROBOT) convert -i $< -o $@.tmp.json && mv $@.tmp.json $@


#pre/$(ONT).%: $(ONT).%
#	$(ROBOT) annotate -i $< -V $(ONTURI)/pre/$(ONT).owl -o $@
#pre/$(ONT).json: $(ONT).owl
#	$(ROBOT) annotate -i $< -V $(ONTURI)/pre/$(ONT).owl -o $@

# CURRENT RELEASES: map back to clique leaders
#extid/mondo.owl: mondo.owl
#	owltools --use-catalog $< --reasoner elk --merge-equivalence-sets -s NCIT 20 -s Orphanet 10 -s OMIM 8 -s EFO 6 -s DOID 5 -s MESH 4 -s MONDO 1 --remove-dangling -o $@

#extid/mondo.obo: extid/mondo.owl
#	owltools --use-catalog $< --remove-imports-declarations --remove-dangling -o -f obo --no-check $@.tmp && $(obo-filter-axiom-header) $@.tmp > $@

#$(ONT)-basic.owl: $(ONT).owl
#	owltools --use-catalog $< --remove-imports-declarations --remove-dangling -o $@
#$(ONT)-basic.obo: $(ONT)-basic.owl
#	owltools --use-catalog $<  -o -f obo $(ONT).obo.tmp && mv $(ONT).obo.tmp $@

%.json: %.owl
	$(ROBOT) convert --input $< --check false -f json -o $@.tmp.json &&\
		mv $@.tmp.json $@

# ensure that inference including equivalencies does not result in merging any classes in MONDO.
# if this fails, the resolution is to look for two MONDO classes with equivalence to the same external class
test_nomerge: mondo.owl
	owltools  --log-error --use-catalog $< --reasoner elk --merge-equivalence-sets -P MONDO -s MONDO 100 --remove-dangling -o $@


# ----------------------------------------
# Inference comparison
# ----------------------------------------
filtered-nr.obo: filtered.owl
	$(ROBOT) relax -i $< reduce -p false -r ELK annotate -O $(OBO)/mondo/$@ -o $@.owl && owltools --use-catalog $@.owl --remove-axiom-annotations -o -f obo --no-check $@.tmp && grep -v ^owl-axioms $@.tmp | obo-grep.pl -r MONDO: - > $@

filtered-nr-reasoned.obo: filtered.owl
	$(ROBOT) relax -i $< reduce -p false -r ELK reason -r ELK annotate -O $(OBO)/mondo/$@ -o $@.owl && owltools --use-catalog $@.owl --remove-axiom-annotations -o -f obo --no-check $@.tmp && grep -v ^owl-axioms $@.tmp | obo-grep.pl -r MONDO: - > $@

reports/reasoner-diff.obo: filtered-nr.obo filtered-nr-reasoned.obo
	obo-simple-diff.pl -l $^ > $@

# ----------------------------------------
# CC-0 MINIMAL
# ----------------------------------------

all_subsets: $(SUBSET_FILES)

RARE_SUBSET_PRESERVED_RELATIONS=RO:0004003 RO:0000053

tmp/rare-subset-pre.owl: #$(SRC)
	$(ROBOT) merge -i $(SRC) reason relax materialize $(patsubst %, --term %, $(RARE_SUBSET_PRESERVED_RELATIONS)) -o $@

# This gets us all the rare disease classes:
tmp/rare-seed-classes.txt: tmp/rare-subset-pre.owl
	$(ROBOT) merge -i $< query --query ../sparql/signature/rare-subset.sparql $@
.PRECIOUS: tmp/rare-seed-classes.txt

# This gets us all the entities linked to the rare disease classes
# Make sure you add the relationships you want to add to ../sparql/signature/rare-subset-related-entity.sparql
# AND config/rare_subset_relations.txt
tmp/rare-seed-entities.txt: tmp/rare-subset-pre.owl tmp/rare-seed-classes.txt
	$(ROBOT) merge -i $< filter -T tmp/rare-seed-classes.txt --trim false query --query ../sparql/signature/rare-subset-related-entity.sparql $@
.PRECIOUS: tmp/rare-seed-entities.txt

# This merges thes seed together into one file (including rare disease classes _and_ related entities.)
tmp/rare-seed.txt: tmp/rare-seed-entities.txt tmp/rare-seed-classes.txt config/rare_subset_relations.txt
	cat $^ | sort | uniq > $@
.PRECIOUS: tmp/rare-seed.txt

subsets/mondo-rare.owl: $(ONT)-base.owl imports/hgnc_import.owl  tmp/rare-seed.txt | $(SUBSETDIR)
	$(ROBOT) merge -i $< -i imports/hgnc_import.owl extract --method subset -T tmp/rare-seed.txt --output $@ &&\
	$(ROBOT) annotate --input $@ --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) -o $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(SUBSETDIR)/mondo-rare.owl

TRIM_MINIMAL = --remove-imports-declarations --remove-abox --remove-axiom-annotations --remove-annotation-assertions -l -r -p $(OIO)hasDbXref -p $(SKOS)exactMatch  -p $(SKOS)narrowMatch   -p $(SKOS)relatedMatch  -p $(SKOS)broadMatch
subsets/mondo-minimal.owl: mondo-base.owl imports/equivalencies.owl
	owltools --use-catalog $< $(TRIM_MINIMAL) imports/equivalencies.owl --merge-support-ontologies --set-ontology-id $(OBO)/mondo/$@ -o $@.tmp.owl &&\
	$(ROBOT) annotate -R -i $@.tmp.owl -o $@.tmp2.owl &&\
	owltools $@.tmp2.owl --add-ontology-annotation $(PV_CC0) -o $@

subsets/%.json: subsets/%.owl
	$(ROBOT) convert -i $< -o $@

subsets/%.obo: subsets/%.owl
	$(ROBOT) convert -i $< -o $@.tmp.obo && grep -v ^owl-axioms: $@.tmp.obo > $@ && rm $@.tmp.obo

rare_subset:
	$(MAKE) IMP=false MIR=false COMP=false subsets/mondo-rare.owl

# ----------------------------------------
# DOSDP Modules
# ----------------------------------------
all_mods: modules/disease_by_location.owl

modules/%.tsv: modules/%.csv
	csv2tsv.py $< $@

modules/%.owl: modules/%.tsv
	dosdp-tools  --obo-prefixes --ontology=../ontology/mondo-edit.obo  --template=../patterns/$*.yaml --outfile=$@ generate --infile=$<

# ----------------------------------------
# Import modules
# ----------------------------------------
# Most ontologies are modularly constructed using portions of other ontologies
# These live in the imports/ folder
# These can be regenerated with make all_imports

ONTOLOGY_IMPORTS_OWL = $(patsubst %, imports/%_import.owl, $(ONTOLOGY_IMPORTS))
ONTOLOGY_IMPORTS_OBO = $(patsubst %, imports/%_import.obo, $(ONTOLOGY_IMPORTS))
ONTOLOGY_IMPORTS_OWL_ROOTS = $(patsubst %, imports/%_import.owl-roots.tsv, $(ONTOLOGY_IMPORTS))

# Make this target to regenerate ALL
all_imports: all_imports_owl all_imports_obo  all_imports_owl_roots
all_imports_owl: $(ONTOLOGY_IMPORTS_OWL)
all_imports_owl_roots: $(ONTOLOGY_IMPORTS_OWL_ROOTS)
all_imports_obo: $(ONTOLOGY_IMPORTS_OBO)

# Use ROBOT, driven entirely by terms lists NOT from source ontology
IMP=true

imports/%_import.owl: mirror/%.owl imports/%_terms.txt
	if [ $(IMP) = true ]; then $(ROBOT) extract -i $< -T imports/$*_terms.txt --force true --individuals definitions --method BOT \
		query --update ../sparql/inject-subset-declaration.ru \
		remove -T imports/removeseed.txt \
		remove --select "<http://purl.obolibrary.org/obo/PR_*>" \
		reason --exclude-tautologies structural \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/%_import.owl

# we use owltools for making the obo file until: https://github.com/ontodev/robot/issues/64
imports/%_import.obo: imports/%_import.owl
	if [ $(IMP) = true ]; then $(OWLTOOLS) $(USECAT) $< -o -f obo --no-check $@.tmp && grep -v ^owl-axioms $@.tmp > $@; fi

imports/omo_import.owl: mirror/omo.owl imports/omo_terms.txt
	@if [ $(IMP) = true ]; then $(ROBOT) merge -i $< \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/omo_import.owl

imports/so_import.owl: mirror/so.owl imports/so_terms.txt
	if [ $(IMP) = true ]; then $(ROBOT) extract -i $< -T imports/so_terms.txt --force true --individuals definitions --method BOT \
		query --update ../sparql/inject-subset-declaration.ru \
		remove -T imports/removeseed.txt \
		remove --select object-properties \
		reason --exclude-tautologies structural \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi

.PRECIOUS: imports/omo_import.owl

edit-merged.owl: $(SRC)
	$(ROBOT) merge -c true -i $< -o $@
imports/seed.txt: edit-merged.owl imports/manual_seed.txt
	$(ROBOT) query -f tsv -i $< -s ../sparql/signature/classes.sparql $@.tmp
	cat $@.tmp imports/manual_seed.txt | perl -npe 's@^\<@@;s@>$$@@' - | sort -u > $@

imports/%_terms.txt: imports/seed.txt
	touch $@ && grep -hi $* $< $@ | sort -u  > $@.tmp && mv $@.tmp $@

# ----------------------------------------
# Release
# ----------------------------------------
# copy from staging area (this directory) to top-level
#release: $(ONT).owl $(ONT).obo
#	cp $^ $(RELEASEDIR) && cp imports/* $(RELEASEDIR)/imports && cp subsets/* $(RELEASEDIR)/subsets

mondo-lastbuild.owl:
	curl -L -s $(OBO)/mondo.owl > $@.tmp && mv $@.tmp $@
mondo-lastbuild.obo:
	curl -L -s $(OBO)/mondo.obo > $@.tmp && mv $@.tmp $@
#mondo-diff.md: mondo-lastbuild.owl
#	owljs-diff -o $@ $< mondo.owl
mondo-diff.txt: mondo-lastbuild.obo
	obo-simple-diff.pl $< mondo.obo >  $@.tmp && mv $@.tmp $@

# ----------------------------------------
# Editing
# ----------------------------------------

td:
	echo $(ISODATE)
# NOTE: no longer removes redundant
INF: mondo-edit.obo
	owltools --use-catalog  mondo-edit.obo --assert-inferred-subclass-axioms --always-assert-super-classes --keepRedundant --markIsInferred --merge-axiom-annotations -o -f obo $@.tmp && grep -v ^owl-axioms $@.tmp | perl -npe 's@is_inferred="true"@source="OWLReasoner:Elk-$(ISODATE)"@' | egrep -v '^relationship:.*is_inferred' | obo-grep.pl --neg -r 'id: (UBERON|CL|ENVO|NCBITaxon|HP|PATO|CHEBI):' -  > $@

# normalize obo file
# note we use owltools-compat to ensure standard ordering
NORM: mondo-edit.obo
	owltools --use-catalog  mondo-edit.obo --merge-axiom-annotations -o -f obo $@.norm && $(ROBOT) convert -i $@.norm -o $@.tmp.obo && mv $@.tmp.obo $@

# tests roundtripping
roundtrip.obo: mondo-edit.obo
	owltools --use-catalog  mondo-edit.obo -o -f obo $@.tmp && mv $@.tmp $@



NEWAXTEST: mondo-edit.owl new.owl
#	owltools --use-catalog  $^ --merge-support-ontologies --run-reasoner -r elk -u -m z.owl -o $@
	owltools --use-catalog  $^ --merge-support-ontologies --assert-inferred-subclass-axioms --always-assert-super-classes --markIsInferred --removeRedundant  --merge-axiom-annotations -o -f obo $@.tmp && grep -v ^owl-axioms $@.tmp | egrep -v '^relationship:.*is_inferred' | obo-grep.pl --neg -r 'id: (UBERON|CL|ENVO|NCBITaxon|HP|PATO|CHEBI):' -  > $@

# ----------------------------------------
# Sparql queries: Q/C
# ----------------------------------------

SPARQL_MONDO_QC=$(patsubst %.sparql, %, $(notdir $(wildcard $(SPARQLDIR)/qc/mondo/qc-*.sparql)))
SPARQL_GENERAL_QC=$(patsubst %.sparql, %, $(notdir $(wildcard $(SPARQLDIR)/qc/general/qc-*.sparql)))
SPARQL_EDIT_EXCLUDE=
SPARQL_OBO_EXCLUDE=qc-single-child qc-omimps-should-be-inherited qc-omim-subsumption qc-permitted-properties
SPARQL_OWL_EXCLUDE=qc-permitted-properties
SPARQL_GENERAL_QC_EDIT=$(filter-out $(SPARQL_EDIT_EXCLUDE),$(SPARQL_GENERAL_QC))
SPARQL_GENERAL_QC_OWL=$(filter-out $(SPARQL_OWL_EXCLUDE),$(SPARQL_GENERAL_QC))
SPARQL_GENERAL_QC_OBO=$(filter-out $(SPARQL_OBO_EXCLUDE),$(SPARQL_GENERAL_QC))
SPARQL_MONDO_QC_EDIT=$(filter-out $(SPARQL_EDIT_EXCLUDE),$(SPARQL_MONDO_QC))
SPARQL_MONDO_QC_OWL=$(filter-out $(SPARQL_OWL_EXCLUDE),$(SPARQL_MONDO_QC))
SPARQL_MONDO_QC_OBO=$(filter-out $(SPARQL_OBO_EXCLUDE),$(SPARQL_MONDO_QC))

SPARQL_MONDO_QC_FILES=$(foreach V,$(SPARQL_MONDO_QC),$(SPARQLDIR)/qc/mondo/$V.sparql)
SPARQL_GENERAL_QC_FILES_EDIT=$(foreach V,$(SPARQL_GENERAL_QC_EDIT),$(SPARQLDIR)/qc/general/$V.sparql)
SPARQL_GENERAL_QC_FILES_OBO=$(foreach V,$(SPARQL_GENERAL_QC_OBO),$(SPARQLDIR)/qc/general/$V.sparql)
SPARQL_GENERAL_QC_FILES_OWL=$(foreach V,$(SPARQL_GENERAL_QC_OWL),$(SPARQLDIR)/qc/general/$V.sparql)
SPARQL_MONDO_QC_FILES_EDIT=$(foreach V,$(SPARQL_MONDO_QC_EDIT),$(SPARQLDIR)/qc/mondo/$V.sparql)
SPARQL_MONDO_QC_FILES_OBO=$(foreach V,$(SPARQL_MONDO_QC_OBO),$(SPARQLDIR)/qc/mondo/$V.sparql)
SPARQL_MONDO_QC_FILES_OWL=$(foreach V,$(SPARQL_MONDO_QC_OWL),$(SPARQLDIR)/qc/mondo/$V.sparql)


QSRC = $(SRC)-noimports.owl

$(QSRC): $(SRC)
	owltools --use-catalog $< --remove-imports-declarations -o $@

SRC_TAGS_REASONED=mondo-tags-reasoned.owl

$(SRC_TAGS_REASONED): $(SRC)
	$(ROBOT) merge -i $< -i components/mondo-tags.owl --collapse-import-closure false reason -o $@

# run all violation checks on edit file
sparql_test_edit: $(SRC_TAGS_REASONED)
	mkdir -p reports/edit/ &&\
	$(ROBOT) verify -i $< --queries $(SPARQL_MONDO_QC_FILES_EDIT) $(SPARQL_GENERAL_QC_FILES_EDIT) -O reports/edit/ && touch $@

sparql_test_main_owl: $(ONT).owl
	mkdir -p reports/main_owl/ &&\
	$(ROBOT) verify -i $< --queries $(SPARQL_MONDO_QC_FILES_OWL) $(SPARQL_GENERAL_QC_FILES_OWL) -O reports/main_owl/ && touch $@

sparql_test_main_obo: $(ONT).obo
	mkdir -p reports/main_obo/ &&\
	$(ROBOT) verify -i $< --queries $(SPARQL_MONDO_QC_FILES_OBO) $(SPARQL_GENERAL_QC_FILES_OBO) -O reports/main_obo/ && touch $@

PL2SPARQL = ../plq/pq-mondo
#../sparql/%.sparql:
#	 $(PL2SPARQL) -v  "$*" > $@.tmp && mv $@.tmp $@

reports/pql-%.tsv: mondo-edit.owl
	 $(PL2SPARQL) -f tsv -v -i $< -e -l "$*" > $@.tmp && mv $@.tmp $@

reports/bg-%.tsv:
	 $(PL2SPARQL) -f tsv -l "$*" > $@.tmp && mv $@.tmp $@

reports/$(Q)-pqlx-$(Ont).tsv: mondo-edit.owl
	 $(PL2SPARQL) -f tsv -v -i $< -i mirror/$(Ont).owl -e -l "$(Q)" > $@.tmp && mv $@.tmp $@

reports/pq-%.tsv: mondo-edit.owl
	 $(PL2SPARQL) -f tsv -v -i $< -e  "$*" > $@.tmp && mv $@.tmp $@

reports/equiv-obs-%.tsv:
	pl2sparql -e -A void.ttl -i mondo_edit -i equivs -i mirror/$*.owl -c ../plq/mondo_queries.pro -l equivalent_to_deprecated > $@
reports/equiv-replaced-by-%.tsv:
	pl2sparql -e -A void.ttl -i mondo_edit -i equivs -i mirror/$*.owl -c ../plq/mondo_queries.pro -l equivalent_to_replaced_by > $@

reports/proxy-merge.tsv: mondo.owl
	./mq -i all proxy_merge -f tsv -l > $@.tmp && sort -u $@.tmp > $@
#	pl2sparql -f tsv -A void.ttl -e -i all -c ../plq/proxy_merge.pro proxy_merge > $@.tmp && mv $@.tmp $@

# the main OWL file will have 'pseudo-roots' caused by the fact that external classes
# are referenced; restrict the report to those with labels
%.owl-roots.tsv: %.owl
	$(ROBOT) query -f tsv -i $< -s $(SPARQLDIR)/reports/root-labeled-classes.sparql $@
%.obo-roots.tsv: %.obo
	$(ROBOT) query -f tsv -i $< -s $(SPARQLDIR)/reports/root-classes.sparql $@

prefixes: mondo-edit.obo
	grep ^xref $< | cut -f2 -d : | count-occ.pl

# ----------------------------------------
# Sparql queries: Reports
# ----------------------------------------


all_reports: all_reports_1 fix_reports

all_reports_1: mondo.owl $(ADDITIONAL_REPORT_FILES)
	$(ROBOT) query -f tsv -i $< $(REPORT_ARGS) && touch $@

# Will be retired when we have https://github.com/ontodev/robot/issues/176
fix_reports: $(foreach V, $(REPORTS), fix-report-$V)
fix-report-%:
	../utils/tidy-sparql-output.pl reports/$*.tmp.tsv > reports/$*.tsv


# TODO: remove hacky script once we improve $(ROBOT) output: https://github.com/ontodev/robot/issues/176
reports/query-%-mondo-edit.obo.tsv: $(SRC) $(SPARQLDIR)/reports/%.sparql
	$(ROBOT) query -f tsv -i $< -s $(SPARQLDIR)/reports/$*.sparql $@.tmp && ../utils/tidy-sparql-output.pl $@.tmp > $@

reports/query-%-mondo.owl.tsv: mondo.owl $(SPARQLDIR)/reports/%.sparql
	$(ROBOT) query -f tsv -i $< -s $(SPARQLDIR)/reports/$*.sparql $@.tmp && ../utils/tidy-sparql-output.pl $@.tmp > $@

# TODO: replace with sparql
#reports/semantic-xref-pairs.tsv: d2p.pro mondo-base.obo
#	blip-findall -i mondo-base.obo -i $< -i ../../scratch/mondo-ncit-finding.pro -consult ../utils/xreftbl_maker.pro xrefrow/5 -no_pred > $@

#RR=$(HOME)/repos/rctauber/robot/bin/$(ROBOT) report --fail-on none
RR= $(ROBOT) report --fail-on ERROR --profile profile.txt --print 8

reports/robot-report-%.tsv: %
	$(RR) -i $* -o $@

reports/mondo-edit-report.html: $(SRC_TAGS_REASONED)
	$(ROBOT) report -i $< --profile profile.txt --fail-on ERROR -o $@
.PRECIOUS: reports/mondo-edit-report.html

mondo_edit_report: reports/mondo-edit-report.html

common_map.tsv:
	blip-findall -debug index -goal ix -i imports/equivalencies.obo -i d2p.pro  -r mondoe -c ../utils/all_genetic.pro common_to_mondo/2 -label -no_pred -use_tabs | cut -f1,3,4 > $@

# ----------------------------------------
# Sparql constructs
# ----------------------------------------

# generate includes from sparql CONSTRUCT queries;
# these can then be merged in to the main ontology
#include-%.owl: ../sparql/construct/construct-%.sparql $(SRC)
#	$(ROBOT) merge -i $(SRC) query -c $< $@.tmp.ttl -f ttl && $(ROBOT) annotate -i $@.tmp.ttl -O $(OBO)/mondo/$@ -o $@

imports/external_definitions.owl: ../sparql/construct/construct-embedded-definition.sparql $(SRC)
	$(ROBOT) merge -i $(SRC) query -c $< $@.tmp.ttl -f ttl && $(ROBOT) annotate -i $@.tmp.ttl -O $(OBO)/mondo/$@ -o $@

FIX_URIS_IN_PLACE = perl -pi -ne $(FIX_URI_EXPR)

all_equivalencies: imports/equivalencies.owl  imports/equivalencies.obo imports/equivalencies.json
imports/equivalencies.owl: ../sparql/construct/construct-ecs-from-xrefs.sparql $(SRC)
	$(ROBOT) merge -i $(SRC) query -c $< $@.tmp.ttl -f ttl && $(FIX_URIS_IN_PLACE)  $@.tmp.ttl && $(ROBOT) annotate -i $@.tmp.ttl -a $(PV_CC0) -O $(OBO)/mondo/$@ -o $@
imports/equivalencies.obo: imports/equivalencies.owl
	$(ROBOT) convert -i $< -o $@

clean_imports: $(patsubst %, clean-mirror-%, $(ONTOLOGY_IMPORTS))
clean-mirror-%:
	test -f mirror/$*.owl && rm mirror/$*.owl || echo 'no mirror file'

#imports/equivalencies.owl: $(SRC)
#	../utils/xrefs2axioms.pl $< > $@.tmp && owltools $@.tmp -o $@

# ----------------------------------------
# Merge constructs
# ----------------------------------------
mondo-premerge-%.owl: mondo.owl mirror/%.owl
	owltools --use-catalog $^ --merge-support-ontologies -o $@.tmp && mv $@.tmp $@

mondo-plus-%.owl: mondo-premerge-%.owl
	owltools --use-catalog $< --reasoner elk --merge-equivalence-sets -P MONDO -s MONDO 100 --remove-dangling -o $@.tmp && mv $@.tmp $@

mondo-compat-%: mondo.owl mirror/%.owl
	owltools --use-catalog $^ --add-imports-from-supports --run-reasoner -r elk -u -m $@-debug.owl && touch $@


# ----------------------------------------
# External ontologies
# ----------------------------------------

XD = gard ncit-disease obo_orphanet icd10 doid medgen-disease-extract snomed mesh
XD_OWL = $(patsubst %, mirror/%.owl, $(XD))
mirror/xdisease-all.owl: $(patsubst %, mirror/%.owl, $(XD))
	owltools $^ --merge-support-ontologies -o $@

mirror/xdisease-labels.owl: mirror/xdisease-all.owl
	$(ROBOT) query --format ttl -c ../sparql/construct/construct-labels.sparql $@ -i $<

mirror/labels:  $(patsubst %, mirror/%-labels.owl, $(XD))
mirror/%-labels.owl: mirror/%.owl
	$(ROBOT) query --format ttl -c ../sparql/construct/construct-labels.sparql $@ -i $<

mirror/%-raw.owl: mirror/%.owl
	$(OWLTOOLS) $< --remove-axioms-about -v


# You could trigger this upstream to get the very latest results:
# https://ci.monarchinitiative.org/view/dipper/job/build-omim



trigger-mirror:
	touch $@

# clone remote ontology locally, perfoming some excision of relations and annotations
mirror/%.owl:
	$(OWLTOOLS) $(OBO)/$*.owl --remove-annotation-assertions -l -s -d -r --remove-dangling-annotations --remove-axiom-annotations  -o $@
.PRECIOUS: mirror/%.owl

mirror/ecto.owl:
	$(OWLTOOLS) $(OBO)/ecto.owl --remove-annotation-assertions -l -s -d -r --remove-dangling-annotations --remove-axiom-annotations  -o $@ &&\
	$(ROBOT) remove -i $@ --select "<http://purl.obolibrary.org/obo/ENVO_*>" -o $@
.PRECIOUS: mirror/ecto.owl

mirror/ncbitaxon.owl:
	wget --no-check-certificate http://purl.obolibrary.org/obo/ncbitaxon/subsets/taxslim.owl -O $@
.PRECIOUS: mirror/ncbitaxon.owl

# hp.owl currently contains many stray root classes
mirror/hp.obo:
	wget --no-check-certificate $(OBO)/hp.obo -O $@.tmp && mv $@.tmp $@ && touch $@
.PRECIOUS: mirror/hp.obo
mirror/hp.owl:  mirror/hp.obo
	$(OWLTOOLS) $< -o $@.tmp && mv $@.tmp $@
.PRECIOUS: mirror/hp.owl

CHEBI_URL=https://raw.githubusercontent.com/obophenotype/chebi_obo_slim/main/chebi_slim.owl

mirror/chebi.owl:
	wget --no-check-certificate $(CHEBI_URL) -O $@.tmp.obo && owltools $@.tmp.obo --remove-annotation-assertions -l -s -d --remove-dangling-annotations --remove-axiom-annotations  -o $@ && touch $@
.PRECIOUS: mirror/chebi.owl

mirror/mfoem.owl:
	$(OWLTOOLS) $(OBO)/mfoem.owl --remove-annotation-assertions -l -s -d --make-subset-by-properties -f BFO:0000050 // --remove-dangling-annotations  -o $@
.PRECIOUS: mirror/mfoem.owl

# we have to roundtrip some ontologies through obo for obscure reasons see https://github.com/monarch-initiative/mondo/issues/237
mirror/doid.owl:
	wget --no-check-certificate $(OBO)/doid.owl -O doid1.owl && owltools doid1.owl -o -f obo doid1.obo && owltools doid1.obo -o $@

# TODO: change this when monochrom is on OBO
mirror/chr.owl:
	wget --no-check-certificate https://raw.githubusercontent.com/monarch-initiative/monochrom/master/chr-base.owl -O $@


mirror/neoplasm-core.owl:
	wget --no-check-certificate $(OBO)/ncit/neoplasm-core.owl -O $@ && touch $@

mirror/ncit.owl:
	wget --no-check-certificate $(OBO)/ncit.owl -O $@ && touch $@

# It looks odd to reason relax reduce the base, but its necessary until we have base plus
mirror/cl.owl:
	$(ROBOT) merge -I $(OBO)/cl/cl-base.owl reason relax reduce -o $@ && touch $@

mirror/uberon.owl:
	$(ROBOT) merge -I $(OBO)/uberon/uberon-base.owl reason relax reduce \
		remove --base-iri $(OBO)/UBERON --base-iri $(OBO)/UBPROP_ --axioms external --preserve-structure false --trim false \
		remove --term rdfs:label --select complement --select "annotation-properties" -o $@ && touch $@

mirror/omo.owl:
	wget --no-check-certificate $(OBO)/omo.owl -O $@ && touch $@

mirror/ncit-disease.uris: mirror/ncit.owl
	$(ROBOT) query -i $< -s ../sparql/signature/ncit-subclass-of-disease.sparql $@

mirror/ncit-disease.ids: mirror/ncit-disease.uris
	perl -npe 's@http://purl.obolibrary.org/obo/NCIT_@NCIT:@' $< > $@

# Make a disease subset; ensure axioms are relaxed
mirror/ncit-disease.owl: mirror/ncit.owl mirror/ncit-disease.uris
	$(ROBOT) extract -i $< -T mirror/ncit-disease.uris --method BOT relax -o $@

mirror/ncit-%-xrefs.ttl: mirror/ncit.owl
	$(ROBOT) query -c ../sparql/construct/construct-$*-xrefs-from-ncit.sparql $@ -i $<

mirror/merge-ncit-xrefs.owl: mirror/ncit.owl mirror/ncit-icdo-xrefs.ttl mirror/ncit-umls-xrefs.ttl
	owltools $^ --merge-support-ontologies -o $@

mirror/ncit-disease.obo: mirror/ncit-disease.owl
	owltools $< -o -f obo $@
#	$(ROBOT) convert -i $< -o $@

mirror/rdo.obo:
	wget  --no-check-certificate ftp://ftp.rgd.mcw.edu/pub/ontology/disease/RDO.obo -O $@ && touch $@

mirror/medgen-disease-extract.owl: mirror/medgen-disease-extract.obo
	owltools $< -o $@.tmp && perl -npe $(FIX_URI_EXPR) $@.tmp > $@

mirror/dipper-%.ttl:
	wget --no-check-certificate https://archive.monarchinitiative.org/latest/rdf/$*.ttl -O $@.tmp && perl -npe 's@https://www.genenames.org/data/gene-symbol-report/#!/hgnc_id/HGNC:@http://identifiers.org/hgnc/@g' $@.tmp > $@

mirror/dipper-%.obo: mirror/dipper-%.ttl
	$(ROBOT) convert -i $< -o $@.tmp.obo && grep -v ^owl-axioms $@.tmp.obo > $@


#mirror/hgnc.owl:
#	echo "WARNING: HGNC MIRROR TEMPORARILY SKIPPED (KINDA AN ERROR)!"

mirror/hgnc.owl: mirror/dipper-hgnc.ttl
	$(ROBOT) query -i $< --format ttl --query ../sparql/construct/construct-hgnc.sparql $@.tmp.ttl &&\
	$(ROBOT) annotate -i $@.tmp.ttl --annotation http://purl.org/dc/elements/1.1/type http://purl.obolibrary.org/obo/IAO_8000001 \
		--ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ \
		--output $@.tmp.owl && mv $@.tmp.owl $@ && rm $@.tmp.ttl

#	$(ROBOT) query construct
#	owltools $< --remove-axioms -t EquivalentClasses -o $@
#	owltools $< --remove-dangling -o $@
#	owltools $< --merge-equivalence-sets -s http://identifiers.org/hgnc/ 20 -o $@


mirror/omia.ttl:
	wget --no-check-certificate http://data.monarchinitiative.org/ttl/omia.ttl -O $@ && touch $@
.PRECIOUS: mirror/omia.ttl

mirror/omia-1.owl: mirror/omia.ttl
	owltools $< --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: mirror/omia-1.owl

mirror/omia-2.obo: mirror/omia-1.owl
	owltools $< -o -f obo $@.tmp && grep -v ^owl-axioms $@.tmp | grep -v ^property_value | perl -npe 's@xref: OMIM:@relationship: RO:HOM0000001 OMIM:@' | perl -npe 's@is_a: MESH:@relationship: RO:HOM0000001 MESH:@' | obo-grep.pl --neg -r 'id: http' - | ../utils/fix-omia-names.pl > $@.tmp.obo && $(ROBOT) reduce -i $@.tmp.obo -o $@

mirror/omia.owl: mirror/omia-2.obo imports/equivalencies.owl
	owltools $^ --add-imports-from-supports --reasoner elk --merge-equivalence-sets -s MONDO 20 --remove-imports-declarations  -o $@

mirror/omia.obo: mirror/omia.owl
	owltools --use-catalog $< -o -f obo $@

mirror/efo-src.owl:
	wget --no-check-certificate http://www.ebi.ac.uk/efo/efo.owl -O $@ && touch $@

mirror/efo.owl: mirror/efo-src.owl
	owltools $< $(EFO2OBO_OPTS) -o $@.tmp && perl -npe $(EFO2OBO_PERL) $@.tmp > $@

mirror/efo.obo: mirror/efo.owl
	owltools $< -o -f obo --no-check $@.tmp && perl ../utils/fix-efo.pl $@.tmp > $@

mirror/efo-disease.uris: mirror/efo.owl
	$(ROBOT) query -i $< -s ../sparql/signature/efo-subclass-of-disease.sparql $@

# Make a disease subset; ensure axioms are relaxed
mirror/efo-disease.owl: mirror/efo.owl mirror/efo-disease.uris
	$(ROBOT) extract -i $< -T mirror/efo-disease.uris --method BOT relax -o $@

mirror/efo-disease.obo: mirror/efo-disease.owl
	owltools $< -o -f obo --no-check $@.tmp && perl ../utils/fix-efo.pl $@.tmp > $@

# ----------------------------------------
# Indirect inferences
# ----------------------------------------
imports/indirect.owl: mondo-edit.obo
	$(ROBOT) reason -r elk -i $< query  --format ttl  -c ../sparql/construct/construct-indirect-subclass-of.sparql $@
imports/tag-indirect.owl: mondo-edit.obo
	$(ROBOT) reason -r elk -i $< query  --format ttl  -c ../sparql/construct/construct-tag-indirect-subclass-of.sparql $@


# ----------------------------------------
# Rewritten ext axioms
# ----------------------------------------

compare_all: compare_all_nd compare_all_d
compare_all_nd: $(patsubst %, compare/axioms-%-nd.obo, $(XD))
compare_all_d: $(patsubst %, compare/axioms-%-d.obo, $(XD))

# Generates synonym from labels
compare/lsyns-%.owl: mirror/%.owl
	$(ROBOT) query -i $<  --format ttl -c ../sparql/construct/construct-related-synonym-from-label.sparql $@
.PRECIOUS: compare/lsyns-%.owl

# Merges in the syns generated as above step
compare/%-plus-lsyns.owl: mirror/%.owl compare/lsyns-%.owl
	owltools $^ --merge-support-ontologies -o $@
.PRECIOUS: compare/%-plus-lsyns.owl

# logical merge, no duplicate axioms
compare/axioms-%-nd.owl: compare/%-plus-lsyns.owl mondo-edit.obo
	owltools --use-catalog mondo-edit.obo --copy-axioms -l -m imports/equivalencies.owl -s $< -n --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: compare/axioms-%.owl

# duplicate axioms, for provenance tagging
compare/axioms-%-d.owl: compare/%-plus-lsyns.owl mondo-edit.obo
	owltools --use-catalog mondo-edit.obo --copy-axioms -I -D -m imports/equivalencies.owl -s $< -n --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: compare/axioms-%.owl

# bring in strictly new literals in annotation axioms
compare/ann-axioms-%-new.owl: compare/%-plus-lsyns.owl mondo-edit.obo
	owltools --use-catalog mondo-edit.obo --copy-axioms -x -m imports/equivalencies.owl -s $< -n --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: compare/axioms-%.owl

compare/ann-axioms-ncit-disease-new.owl: mirror/ncit-disease.owl mondo-edit.obo
	owltools --use-catalog mondo-edit.obo --copy-axioms -x -m imports/equivalencies.owl -s $< -n --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: compare/axioms-%.owl

# all axioms
compare/axioms-%-all.owl: compare/%-plus-lsyns.owl mondo-edit.obo
	owltools --use-catalog mondo-edit.obo --copy-axioms -d -m imports/equivalencies.owl -s $< -n --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: compare/axioms-%.owl

# tag axioms that are asserted but could be inferred
compare/entailed.obo: mondo-edit.obo
	owltools --use-catalog $< --remove-axiom-annotations --reasoner elk --silence-elk --tag-entailed-axioms --set-ontology-id $(OBO)/mondo/$@ -o -f obo $@.tmp && perl -npe 's@{source="direct"}@{source="MONDO:Redundant"}@' $@.tmp > $@

compare/entailed-isa.obo: compare/entailed.obo
	obo-filter-tags.pl -t is_a -t id  | obo-grep.pl -r is_a - | grep -v ^import > $@
	obo-filter-tags.pl -t is_a -t id  | $(OBOGREP) -r is_a - | grep -v ^import > $@

compare/unique-isa.tsv: compare/entailed-isa.owl
	 ./mq -i $< report unique_isa > $@

compare/main.obo: mondo-edit.obo
	owltools --use-catalog $< --remove-axiom-annotations  --set-ontology-id $(OBO)/mondo/$@ -o -f obo $@.tmp && perl -npe 's@{source="direct"}@{source="MONDO:Redundant"}@' $@.tmp > $@

#compare/axioms-%.owl:
#	owltools --use-catalog mondo-edit.obo --copy-axioms -l -d -m imports/equivalencies.owl -s mirror/$*.owl -n --set-ontology-id $(OBO)/mondo/$@ -o $@
#.PRECIOUS: compare/axioms-%.owl


compare/axioms-%.obo: compare/axioms-%.owl
	owltools $< -o -f obo --no-check $@
compare/ann-axioms-%.obo: compare/ann-axioms-%.owl
	owltools $< -o -f obo --no-check $@

# construct an OWL file that expresses the fact that every child term must be distinct from its superclas
# C1 SubClassOf P ==> exists C2 : C2 subClassOf P, C1 DisjointWith C2
disjoint_sibs.owl: $(SRC)
	$(ROBOT) query --format ttl -c ../sparql/construct/construct-disjoint-siblings.sparql $@ -i $<

testcombo-%: mondo-edit.obo disjoint_sibs.owl imports/equivalencies.owl mirror/%.owl disjoint_sibs.owl
	owltools --use-catalog  $^ --merge-support-ontologies --run-reasoner -r elk -u -m compare/bad-$*.owl


debug_inference_check.owl: debug.owl explain_unsat.owl
	$(ROBOT) reason -i $< --equivalent-classes-allowed none -o $@

explain_unsat.owl: debug.owl
	$(ROBOT) explain -i $< -M unsatisfiability --unsatisfiable random:10 --explanation mondo_explain_debug.md \
	annotate --ontology-iri "http://purl.obolibrary.org/obo/mondo/mondo_explain_debug.ofn" \
	--output mondo_explain_debug.ofn && cat mondo_explain_debug.md

debug.owl: mondo-edit.obo disjoint_sibs.owl imports/equivalencies.owl
	owltools --no-logging --use-catalog  $^ --merge-support-ontologies --run-reasoner -r elk -u -m $@ | grep -v ^INFERENCE
debug2.owl: mondo-edit.obo disjoint_sibs.owl imports/equivalencies.owl
	owltools --use-catalog  $^ --merge-support-ontologies --reasoner elk --merge-equivalence-sets -s MONDO 100 --run-reasoner -r elk -u -m $@ | grep -v ^INFERENCE

debug-prod.owl: mondo.owl disjoint_sibs.owl imports/equivalencies.owl
	owltools --use-catalog  $^ --merge-support-ontologies --run-reasoner -r elk -u -m $@ | grep -v ^INFERENCE

# ----------------------------------------
# Lexical mapping
# ----------------------------------------

# align against self (*not* external ontologies)
mappings.tsv: mondo.json
	ontobio-lexmap.py $< > $@.tmp && mv $@.tmp $@ && perl -pi -ne 's@http://purl.obolibrary.org/obo/MONDO_@MONDO:@g' $@

%-mappings.tsv: mondo.json mirror/%.json
	ontobio-lexmap.py $^ -u unmapped-$@ > $@.tmp && mv $@.tmp $@

hp-mappings.tsv: mondo.json
	ontobio-lexmap.py hp $< > $@.tmp && mv $@.tmp $@

mesh-mappings.tsv: mondo.json mesh.json
	ontobio-lexmap.py $^ > $@.tmp && mv $@.tmp $@

gard-mappings.tsv: mondo-edit.json gard.json
	ontobio-lexmap.py $^ -u unmapped-$@ > $@.tmp && mv $@.tmp $@

medgen-mappings.tsv: mondo-edit.json mirror/medgen-disease-extract.obo
	ontobio-lexmap.py -v -e $^ -u unmapped-$@ > $@.tmp && mv $@.tmp $@

neoplasm-mappings.tsv: mondo-edit.json neoplasm-core.json
	ontobio-lexmap.py -v -e $^ -u unmapped-$@ > $@.tmp && mv $@.tmp $@
ncit-mappings.tsv: mondo-edit.json mirror/ncit-disease.json
	ontobio-lexmap.py -v -e $^ -u unmapped-$@ > $@.tmp && mv $@.tmp $@

ptable-%.tsv: %-mappings.tsv
	cat $< | p.df  'df[df.right_novel==True]' 'df[["left", "right","pr_subClassOf","pr_superClassOf","pr_equivalentTo","pr_other"]]' -o csv -i tsv | grep -v '^"left' | grep MONDO > $@.tmp && csv2tsv.py $@.tmp $@

%-mappings-best.tsv: %-mappings.tsv
	cat $< | p.df  'df[["left", "left_label", "right", "right_label", "reciprocal_score"]]' -o csv -i tsv | grep -v '^"left' | grep MONDO > $@.tmp && mv $@.tmp $@

%-mappings-filtered.tsv: %-mappings.tsv
	cat $< | p.df  'df[df.reciprocal_score==4]' 'df[df.left_match_type=="label"]' 'df[df.right_match_type=="label"]' 'df[["left", "left_label", "right", "right_label"]]'  -i tsv -o tsv  > $@.tmp && mv $@.tmp $@


unlikely.md: linked-rpt.md
	./unlikely-axiom-report.pl $< | head -200 > $@

modules/equiv-xrefs.obo: mondo-edit.obo
	obo-filter-tags.pl -t id -t xref $<   | egrep '^($$|\[Term|id:|xref:.*equivalentTo)' > $@

mim2gene_medgen:
	wget ftp://ftp.ncbi.nih.gov/gene/DATA/mim2gene_medgen && touch $@

# g2g
mim2gene.txt:
	curl -L -s https://omim.org/static/omim/data/mim2gene.txt  > $@.tmp && mv $@.tmp $@

diseases_to_genes.txt:
	curl -L -s http://compbio.charite.de/jenkins/job/hpo.annotations.monthly/lastSuccessfulBuild/artifact/annotation/diseases_to_genes.txt > $@.tmp && mv $@.tmp $@

omim2medgen.obo: mim2gene_medgen
	grep phenotype $<  | cut -f1,5 | perl -npe 's@^@OMIM:@;s@\t@\tUMLS:@' | grep UMLS:C | tbl2obolinks.pl --rel xref --source NCBI:mim2gene_medline - > $@

reports/mondo-equivs.tsv:
	$(ROBOT) query -i mondo.owl -q ../sparql/reports/sssom-mappings.sparql $@.tmp && ../utils/tidy-sparql-output.pl $@.tmp > $@

# NEW: uses rdf_matcher
# **IMPORTANT*: remember to clear tmp/ dir for fresh start
# mondo_queries requires for prefixes
all_unique.tsv:
	rdfmatch -p MONDO -f sssom  ../plq/mondo_queries.pro  -X tmp -A void.ttl -f tsv -v -i all -i skos.ttl unique_match > $@

all_matches.tsv:
	rdfmatch -T --debug rdf_matcher -i prefixes.ttl -p MONDO -f sssom -X tmp -A void.ttl -w obo_weights -v -i all2 match > $@

matches-to-%.tsv:
	rdfmatch  --debug rdf_matcher -i prefixes.ttl -p MONDO  -X tmp -A void.ttl  -v -i mondo -i $* match > $@

matches-to-nando.tsv:
	rdfmatch -g remove_non_english_literals  --debug rdf_matcher -i prefixes.ttl -p NANDO --match_prefix MONDO  -X tmp -A void.ttl  -v -i mondo -i nando match > $@

lexrules-%.pro:
	test -d tmp-$* || mkdir -p tmp-$*
	rdfmatch --ontA MONDO --ontB $(shell echo $* | tr a-z A-Z) -l -c  ../plq/mondo_queries.pro  -X tmp-$* -A void.ttl -f tsv -v -i mondo_edit -i equivs -i mirror/$*.owl -i skos.ttl learn > $@
.PRECIOUS: lexrules-%.pro

match-dedupe-%.tsv: match-%.tsv
	sssom dedupe -i $< -o $@

match-%.tsv:
	rdfmatch -p MONDO -l -c  ../plq/mondo_queries.pro  -X tmp -A void.ttl -f sssom  -w obo_weights -v -i mondo_edit -i equivs -i mirror/$*.owl -i skos.ttl new_match $< > $@

learnedmatch-%.tsv: lexrules-%.pro
	rdfmatch -p MONDO -l -c  ../plq/mondo_queries.pro  -X tmp-$* -A void.ttl -f tsv -v -i mondo_edit -i equivs -i mirror/$*.owl -i skos.ttl classify $< > $@

all_unique_fresh: clean_tmp all_unique.tsv
clean_tmp:
	rm tmp/*

# ----------------------------------------
# Metaclasses
# ----------------------------------------
disorder-by-%.tsv: mondo-edit.obo
	blip-findall -r uberonp -r cell -r go -i $< "class_cdef(C,cdef('MONDO:0000001',[disease_has_location=A])),subclassRT(A,'$(subst _,:,$*)')" -select C-A -no_pred -use_tabs -label > $@.tmp && sort -u $@.tmp > $@

disorder-by-anatomical-region.tsv: disorder-by-UBERON_0000475.tsv
	cp $< $@
disorder-by-anatomical-system.tsv: disorder-by-UBERON_0000467.tsv
	cp $< $@
disorder-by-cell.tsv: disorder-by-CL_0000000.tsv
	cp $< $@

# ----------------------------------------
# Anns
# ----------------------------------------
phenotype_annotation.tab:
	wget http://compbio.charite.de/jenkins/job/hpo.annotations/lastStableBuild/artifact/misc/phenotype_annotation.tab -O $@ && touch $@

phenotype_annotation_nu.tab:
	wget http://compbio.charite.de/jenkins/job/hpo.annotations.2018/lastSuccessfulBuild/artifact/misc_2018/phenotype.hpoa -O $@ && touch $@

g2p.tsv:
	wget http://compbio.charite.de/jenkins/job/hpo.annotations.monthly/lastStableBuild/artifact/annotation/ALL_SOURCES_ALL_FREQUENCIES_genes_to_phenotype.txt -O $@ && touch $@

d2p.tsv: phenotype_annotation.tab
	../utils/phenotab2tbl.pl $< > $@

# ----------------------------------------
# Hacky
# ----------------------------------------

mondox.obo: mondo-edit.obo
	perl -npe 's@source="MONDO:(equivalentto|subclassof|superclassof|other|relatedto)@semantics="MONDO:$$1@i' $< > $@

check: mondo-edit.obo
	$(HOME)/repos/go-ontology/src/util/check-obo-for-standard-release.pl --disable-xrf-abbs-check $<

%-quickcheck: %.obo
	 ../utils/quick-check.pl $<

mondo-edit.owl: mondo-edit.obo
	../utils/quick-check.pl $< && $(ROBOT) convert -i $< -o $@

d2taxon-wd.tsv:
	pq-wd -f tsv  "has_cause(D,T),doid_id(D,DX),ncbitaxon_id(T,TX)" "x(DX,TX)" > $@.tmp && perl -npe 's@\t@\tNCBITaxon:@' $@.tmp > $@

d2symp-wd.tsv:
	pq-wd -f tsv  "symptoms(D,S),doid_id(D,DX),umls_id(S,SX),enlabel(S,SN)" "x(DX,SX,SN)" > $@.tmp && perl -npe 's@\tC@\tUMLS:C@' $@.tmp > $@

# ----------------------------------------
# Kboom
# ----------------------------------------

# new
weights.tsv:
	pl2sparql -f tsv -e -i mondo-edit.owl  -c ../plq/kboom_weights.pro w > $@

weights-mg.tsv:
	pl2sparql -f tsv -e -i mondo-edit.owl -i mirror/medgen-disease-extract.owl  -c ../plq/kboom_weights.pro w > $@

ptable.tsv: weights.tsv
	../utils/softmax-weights.py $< > $@

#ptable.tsv: mondo-edit.obo
#	../utils/xrefs2ptable.pl $< > $@.tmp && mv $@.tmp $@

seed.owl: mondo-edit.obo ext.obo
	owltools --use-catalog $^ --remove-imports-declarations --merge-support-ontologies -o $@

#seed-ncit.owl: mondo-edit.obo imports/equivalencies-ncit.obo neoplasm-core-nd.obo
#	owltools --use-catalog $^ --remove-imports-declarations --merge-support-ontologies -o $@
seed-ncit.owl: mondo-edit.obo imports/equivalencies.owl mirror/ncit-disease.owl
	owltools --use-catalog $^ --remove-imports-declarations --merge-support-ontologies --remove-disjoints -o $@

ext.obo: ptable.tsv
	perl -ne '($$goo, $$x) = split;print "$$x\t$$x\n"' $< | tbl2obo.pl  > $@

bridge.owl: ptable.tsv seed.owl
	kboom --experimental  --splitSize 50 --max 4 -m linked-rpt.md -j linked-rpt.json -n -o $@ -t $^

bridge-%.owl: ptable-%.tsv seed-%.owl
	kboom --experimental  --splitSize 50 --max 6 -m linked-rpt-$*.md -j linked-rpt-$*.json -n -o $@ -t $^

# ----------------------------------------
# HACK: extraction
# ----------------------------------------
v-%.png:
	tbl2p -p id $* > $*.pro && \
	blip ontol-query -r mondoeq -r mondo -r medic -r snomed_tidy -r icd10 -r neoplasm -r ordop -r disease -consult extract.pro -i $*.pro -query "id(X),q(X,ID)" -to obo > v-$*.obo && \
	owltools v-$*.obo --remove-dangling -o -f obo v-$*-trim.obo && \
	blip ontol-subset -u ontol_config_do -i v-$*-trim.obo -idfile $* -down 5 -to png > $@

../../scratch/mondo-ncit-finding.tsv:
	blip-findall -i imports/equivalencies.obo  -i mondo.obo -r neoplasm "(R='NCIT:R115';R='NCIT:R108'),parent(X,R,Y),equivalent_class(M,X)" -select "x(M,Y)" -no_pred -label -use_tabs  > $@.tmp && sort -u $@.tmp > $@

#../../scratch/mondo-ncit-finding.tsv:


# ----------------------------------------
# TEST
# ----------------------------------------

ncit-eq.obo: ncit-kboom-curated.obo
	perl -npe 's@\{@{source="MONDO:equivalentTo", @' $< > $@

# ----------------------------------------
# AD-HOC CHECKS
# ----------------------------------------
omim-ps-equiv.obo: mondo-edit.obo
	obo-grep.pl  -r 'xref: OMIM:.*equiv' $< | obo-grep.pl  -r 'xref: OMIMPS:.*equiv' - > $@


# ----------------------------------------
# BLAZEGRAPH
# ----------------------------------------
# (experimental)
#
# For query and reporting purposes, it is useful to have a blazegraph
# instance containing mondo plus external ontologies.
#
# The blazegraph instance can run as a docker container

BGVERSION = 2.1.4
BGPORT=8921
bg: bg-run pause bg-load

# folder to stage OWL to be loaded into BG
bg-data:
	mkdir $@

# sync data folder; mondo + external ontologies
bg-sync: mondo.owl  $(XD_OWL)
	rm bg-data/* && cp $^ bg-data

# start up a docker image with blazegraph and local configuration
bg-run: bg-data
	docker run --name blazegraph -d -p $(BGPORT):8080 -v $(PWD)/blazegraph/RWStore.properties:/RWStore.properties -v $(PWD)/bg-data/:/data lyrasis/blazegraph:$(BGVERSION)

pause:
	sleep 1

bg-load: bg-data bg-sync bg-load-direct

bg-load-direct:
	curl -X POST --data-binary @blazegraph/dataloader.txt   --header 'Content-Type:text/plain'   http://localhost:$(BGPORT)/bigdata/dataloader

bg-stop:
	docker kill blazegraph; docker rm blazegraph

bg-clean:
	rm bg-data/*

succeed:
	echo make succeeded

###### NICO MIGRATION: overwriting unsuccessful goals!

../sparql/construct-ecs-from-xrefs.sparql:
	echo "STRONG WARNING STRONG WARNING make $@ is skipped!" && touch $@

d2p.pro:
	echo "STRONG WARNING STRONG WARNING make $@ is skipped!" && touch $@

reports/semantic-xref-pairs.tsv:
	echo "STRONG WARNING STRONG WARNING make $@ is skipped!" && touch $@

mirror/ordo.obo: build-orphanet
	cp sources/orphanet/obo_orphanet.obo $@

mirror/omim.obo: build-omim
	$(ROBOT) convert -i sources/omim/omim.owl -o $@

mirror/medgen.obo:
	$(ROBOT) convert -i sources/$(SOURCE_VERSION)/medgen.owl -o $@

tmp/tbd_%.tbd: $(SRC) mirror/%.obo mirror/hp.obo
	cat mirror/$*.obo | perl $(ADDTOTBD) > $@

tmp/rest_slurp_%.obo: tmp/tbd_%.tbd
	cat $< | perl $(OBOGREP) --neg -r ALREADY - | perl $(OBOGREP) --neg -r is_obsol - | perl $(OBOGREP) -r is_a - | perl $(OBOGREP) --neg -r "no mapping" - > $@
	sed -i -E 's/is_a[:][ ]MONDO[:]0000001[ ][{]source[=]["]OMIM[:][0-9]+["][}][ ][!][ ]disease[ ]or[ ]disorder/is_a: MONDO:0003847/g' $@
.PRECIOUS: tmp/rest_slurp_%.obo


tmp/ps_slurp_%.obo: tmp/tbd_%.tbd
	cat $< | perl $(OBOGREP) --neg -r ALREADY - | perl $(OBOGREP) --neg -r is_obsol - | perl $(OBOGREP) -r "xref: OMIMPS" - > $@
.PRECIOUS: tmp/ps_slurp_%.obo

%_slurp: tmp/ps_slurp_%.obo tmp/rest_slurp_%.obo
	echo "Slurping of $* completed".

slurp: ordo_slurp omim_slurp medgen_slurp

#tmp/slurp-complete.obo:
#	$(ROBOT) merge --input tmp/slurp.obo \
#  unmerge --input mondo-edit.obo -o $@


include mondo.Makefile

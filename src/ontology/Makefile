# ----------------------------------------
# Standard Constants
# ----------------------------------------
# these can be overwritten on the command line

OBO=http://purl.obolibrary.org/obo
OIO=http://www.geneontology.org/formats/oboInOwl\#
ONT=mondo
BASE=$(OBO)/$(ONT)
SRC=$(ONT)-edit.obo
RELEASEDIR=../../target/
ROBOT= robot
OWLTOOLS= owltools
USECAT= --use-catalog
SPARQLDIR = ../sparql

CONSTRUCTS= embedded-definition
INCLUDES_OWL = $(patsubst %,include-%.owl,$(CONSTRUCTS))
ISODATE:=`date +%Y-%m-%d`

obo-filter-axiom-header = grep -v ^owl-axioms:

# ----------------------------------------
# Top-level targets
# ----------------------------------------

all: test all_imports all_reports imports/equivalencies.owl imports/equivalencies.obo $(ONT).owl $(ONT).obo $(ONT).json pre/$(ONT).owl pre/$(ONT).obo pre/$(ONT).json extid/$(ONT).owl extid/$(ONT).obo extid/$(ONT).json $(ONT)-merged.owl
test: sparql_test test_nomerge
prepare_release: all
	cp $(ONT).owl $(ONT).obo $(ONT).json $(RELEASEDIR) &&\
	mkdir -p $(RELEASEDIR)/imports &&\
	cp imports/*_import.{owl,obo} $(RELEASEDIR)/imports &&\
	cp extid/*{owl,obo,json} $(RELEASEDIR)/extid &&\
	(test -f subsets/*owl && cp subsets/*{owl,obo,json} $(RELEASEDIR)/subsets && git add $(RELEASEDIR)/subsets/* || echo "no subsets") &&\
	echo "Release files are now in $(RELEASEDIR) - now you should commit, push and make a release on github"

all_includes: $(INCLUDES_OWL)

OSF_UPLOAD = $(HOME)/repos/osf-cli/venv/bin/osf -p 2qk53 upload
osf_upload:
	cd ../.. && $(OSF_UPLOAD) -f -r target/ current/ && $(OSF_UPLOAD) -f -r target/ releases/$(ISODATE)

# ----------------------------------------
# Main release targets
# ----------------------------------------

ANN = annotate -V $(BASE)/releases/`date +%Y-%m-%d`/$@.owl

filtered.obo: $(SRC)
	perl -ne 'print unless (m@^xref: (Orphanet|OMIM|DOID|EFO|NCIT|SCTID):@ && !(m@equivalentTo@))' $< | grep -v '^property_value: confidence' | grep -v '^property_value: excluded_subClassOf' | grep -v 'relationship: disease_has_basis_in_dysfunction_of NCBIGene:' > $@.tmp && mv $@.tmp $@
#egrep -v 'MONDO:(subClassOf|superClassOf|relatedTo)' $< > $@

# perform reasoning on source
# PREVIOUS: SKIP FOR NOW: assume pre-asserted, but run reasoner to check
# note: robot will protect redundant annotated axioms
reasoned-redundant.owl: filtered.obo
	$(ROBOT) reason -i $< -r ELK relax reduce -r ELK $(ANN) -o $@
#	$(ROBOT) reason -i $< -r ELK relax reduce -r ELK $(ANN) -o $@-validated.owl && cp $< $@
reasoned.owl: reasoned-redundant.owl
	owltools --use-catalog $< --assert-inferred-subclass-axioms --always-assert-super-classes --removeRedundant --markIsInferred --allowEquivalencies --merge-axiom-annotations -o $@

# merged = reasoned + equivalencies
merged.owl: reasoned.owl imports/equivalencies.owl
	owltools --use-catalog $^ --merge-support-ontologies -o $@

disjoint_sibs.owl: $(SRC)
	robot query --format ttl -c ../sparql/construct-disjoint-siblings.sparql $@ -i $<

# PRE-RELEASES: MONDO IDs primary
#
# by default we use Elk to perform a reason-relax-reduce chain
# after that we annotate the ontology with the release versionInfo
$(ONT).owl: merged.owl
	$(ROBOT) annotate -i $< -V $(BASE)/releases/`date +%Y-%m-%d`/$(ONT).owl -o $@

# obo is self-contained
$(ONT).obo: reasoned.owl
	owltools --use-catalog $< --remove-imports-declarations --remove-dangling -o -f obo --no-check $@.tmp && $(obo-filter-axiom-header) $@.tmp > $@
#	owltools --use-catalog $< --merge-imports-closure -o -f obo --no-check $(ONT).obo.tmp && mv $(ONT).obo.tmp $@
$(ONT).json: pre/$(ONT).owl
	owltools --use-catalog $< -o -f json  $(ONT).json.tmp && mv $(ONT).json.tmp $@
#	$(ROBOT) convert -i $< -f json -o $(ONT).json.tmp && mv $(ONT).json.tmp $@

$(ONT)-atomic.owl: $(ONT).owl
	owltools --use-catalog $< --remove-imports-declarations --set-ontology-id $(OBO)/$(ONT)/$@ -o $@.tmp && mv $@.tmp $@

$(ONT)-merged.owl: $(ONT).owl
	owltools --use-catalog $< --merge-imports-closure --set-ontology-id $(OBO)/$(ONT)/$@ -o $@.tmp && mv $@.tmp $@

pre/$(ONT).%: $(ONT).%
	$(ROBOT) annotate -i $< -V $(BASE)/pre/$(ONT).owl -o $@
pre/$(ONT).json: $(ONT).owl
	$(ROBOT) annotate -i $< -V $(BASE)/pre/$(ONT).owl -o $@

# CURRENT RELEASES: map back to clique leaders
extid/mondo.owl: mondo.owl
	owltools --use-catalog $< --reasoner elk --merge-equivalence-sets -s NCIT 20 -s Orphanet 10 -s OMIM 8 -s EFO 6 -s DOID 5 -s MESH 4 -s MONDO 1 --remove-dangling -o $@

extid/mondo.obo: extid/mondo.owl
	owltools --use-catalog $< --remove-imports-declarations --remove-dangling -o -f obo --no-check $@.tmp && $(obo-filter-axiom-header) $@.tmp > $@

#$(ONT)-basic.owl: $(ONT).owl
#	owltools --use-catalog $< --remove-imports-declarations --remove-dangling -o $@
#$(ONT)-basic.obo: $(ONT)-basic.owl
#	owltools --use-catalog $<  -o -f obo $(ONT).obo.tmp && mv $(ONT).obo.tmp $@

%.json: %.owl
	owltools --use-catalog $< -o -f json  $(ONT).json.tmp && mv $(ONT).json.tmp $@
#	$(ROBOT) convert -i $< -f json -o $(ONT).json.tmp && mv $(ONT).json.tmp $@

# ensure that inference including equivalencies does not result in merging any classes in MONDO.
# if this fails, the resolution is to look for two MONDO classes with equivalence to the same external class
test_nomerge: mondo.owl
	owltools --use-catalog $< --reasoner elk --merge-equivalence-sets -P MONDO -s MONDO 100 --remove-dangling -o $@

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

IMPORTS = uberon cl go pato ro hp mf ncbitaxon chebi envo foodon
IMPORTS_OWL = $(patsubst %, imports/%_import.owl,$(IMPORTS)) $(patsubst %, imports/%_import.obo,$(IMPORTS))

# Make this target to regenerate ALL
all_imports: $(IMPORTS_OWL)

# Use ROBOT, driven entirely by terms lists NOT from source ontology
imports/%_import.owl: mirror/%.owl imports/%_terms.txt
	$(ROBOT) extract -i $< -T imports/$*_terms.txt --method BOT -O $(BASE)/$@ -o $@
.PRECIOUS: imports/%_import.owl

# we use owltools for making the obo file until: https://github.com/ontodev/robot/issues/64
imports/%_import.obo: imports/%_import.owl
	$(OWLTOOLS) $(USECAT) $< -o -f obo --no-check $@.tmp && mv $@.tmp $@


imports/%_terms.txt:  $(SRC)
	robot query -f tsv -i $< -s ../sparql/classes.sparql $@.tmp && grep -hi $* $@.tmp imports/$*_terms.txt | perl -npe 's@^\<@@;s@>$$@@' | sort -u > $@

# ----------------------------------------
# Release
# ----------------------------------------
# copy from staging area (this directory) to top-level
release: $(ONT).owl $(ONT).obo
	cp $^ $(RELEASEDIR) && cp imports/* $(RELEASEDIR)/imports

$(ONT)-lastbuild.owl: $(ONT).owl
	wget --no-check-certificate $(OBO)/$(ONT).owl -O $@.tmp && mv $@.tmp $@
$(ONT)-lastbuild.obo: $(ONT).obo
	wget --no-check-certificate $(OBO)/$(ONT).obo -O $@.tmp && mv $@.tmp $@
$(ONT)-diff.md: $(ONT)-lastbuild.owl 
	owljs-diff -o $@ $< $(ONT).owl

# ----------------------------------------
# Editing
# ----------------------------------------

td:
	echo '$(ISODATE)'
# NOTE: no longer removes redundant
INF: mondo-edit.obo
	owltools --use-catalog  mondo-edit.obo --assert-inferred-subclass-axioms --always-assert-super-classes --keepRedundant --markIsInferred --merge-axiom-annotations -o -f obo $@.tmp && grep -v ^owl-axioms $@.tmp | perl -npe 's@is_inferred="true"@source="OWLReasoner:Elk-$(ISODATE)"@' | egrep -v '^relationship:.*is_inferred' | obo-grep.pl --neg -r 'id: (UBERON|CL|ENVO|NCBITaxon|HP|PATO|CHEBI):' -  > $@

NORM: mondo-edit.obo
	owltools --use-catalog  mondo-edit.obo --merge-axiom-annotations -o -f obo $@.tmp && mv $@.tmp $@



NEWAXTEST: mondo-edit.owl new.owl
#	owltools --use-catalog  $^ --merge-support-ontologies --run-reasoner -r elk -u -m z.owl -o $@
	owltools --use-catalog  $^ --merge-support-ontologies --assert-inferred-subclass-axioms --always-assert-super-classes --markIsInferred --removeRedundant  --merge-axiom-annotations -o -f obo $@.tmp && grep -v ^owl-axioms $@.tmp | egrep -v '^relationship:.*is_inferred' | obo-grep.pl --neg -r 'id: (UBERON|CL|ENVO|NCBITaxon|HP|PATO|CHEBI):' -  > $@

# ----------------------------------------
# Sparql queries: Q/C
# ----------------------------------------

# these live in the ../sparql directory, and have suffix -violation.sparql
# adding the name here will make the violation check live
VCHECKS = subclass-cycle equivalent-classes trailing-whitespace owldef-self-reference xref-syntax nolabels

QSRC = $(SRC)-noimports.owl

$(QSRC): $(SRC)
	owltools --use-catalog $< --remove-imports-declarations -o $@

# run all violation checks
VQUERIES = $(foreach V,$(VCHECKS),$(SPARQLDIR)/$V-violation.sparql)
sparql_test: $(QSRC)
	robot verify -i $< --queries $(VQUERIES) -O reports/edit/ && touch $@

PL2SPARQL = ../plq/pq-mondo
../sparql/%.sparql:
	 $(PL2SPARQL) -v  "$*" > $@.tmp && mv $@.tmp $@

reports/pql-%.tsv: mondo-edit.owl
	 $(PL2SPARQL) -f tsv -v -i $< -e -l "$*" > $@.tmp && mv $@.tmp $@

reports/bg-%.tsv: 
	 $(PL2SPARQL) -f tsv -l "$*" > $@.tmp && mv $@.tmp $@

reports/$(Q)-pqlx-$(Ont).tsv: mondo-edit.owl
	 $(PL2SPARQL) -f tsv -v -i $< -i mirror/$(Ont).owl -e -l "$(Q)" > $@.tmp && mv $@.tmp $@

reports/pq-%.tsv: mondo-edit.owl
	 $(PL2SPARQL) -f tsv -v -i $< -e  "$*" > $@.tmp && mv $@.tmp $@

# ----------------------------------------
# Sparql queries: Reports
# ----------------------------------------

REPORTS = basic-report class-count-by-prefix edges xrefs obsoletes synonyms class-stats root-classes
REPORT_ARGS = $(foreach V,$(REPORTS),-s $(SPARQLDIR)/$V.sparql reports/release/$V.tsv)
all_reports: mondo.owl reports/release/mondo-obo-report.yaml reports/release/mondo-owl-report.yaml
	robot query -f tsv -i $< $(REPORT_ARGS)

# TODO: remove hacky script once we improve robot output: https://github.com/ontodev/robot/issues/176
reports/edit/%.tsv: $(SRC) $(SPARQLDIR)/%.sparql
	robot query -f tsv -i $< -s $(SPARQLDIR)/$*.sparql $@.tmp && ../utils/tidy-sparql-output.pl $@.tmp > $@

reports/release/%.tsv: mondo.owl
	robot query -f tsv -i $< -s $(SPARQLDIR)/$*.sparql $@.tmp && ../utils/tidy-sparql-output.pl $@.tmp > $@

# TODO: replace with sparql
reports/release/semantic-xref-pairs.tsv: d2p.pro
	blip-findall -i imports/equivalencies.obo  -i mondo-edit.obo -i $< -i ../../scratch/mondo-ncit-finding.pro -consult ../utils/xreftbl_maker.pro xrefrow/5 -no_pred > $@

reports/edit/report.yaml: $(SRC)
	robot report -i $< report -o $@.tmp && mv $@.tmp $@
reports/release/mondo-obo-report.yaml: mondo.obo
	robot report -i $< report -o $@.tmp && mv $@.tmp $@

reports/release/mondo-owl-report.yaml: mondo.owl
	robot report -i $< report -o $@.tmp && mv $@.tmp $@

# ----------------------------------------
# Sparql constructs
# ----------------------------------------

# generate includes from sparql CONSTRUCT queries;
# these can then be merged in to the main ontology
#include-%.owl: ../sparql/construct-%.sparql $(SRC)
#	robot merge -i $(SRC) query -c $< $@.tmp.ttl -f ttl && robot annotate -i $@.tmp.ttl -O $(OBO)/mondo/$@ -o $@

imports/external_definitions.owl: ../sparql/construct-embedded-definition.sparql $(SRC)
	robot merge -i $(SRC) query -c $< $@.tmp.ttl -f ttl && robot annotate -i $@.tmp.ttl -O $(OBO)/mondo/$@ -o $@

imports/equivalencies.owl: ../sparql/construct-ecs-from-xrefs.sparql $(SRC)
	robot merge -i $(SRC) query -c $< $@.tmp.ttl -f ttl && perl -pi -ne 's@http://purl.obolibrary.org/obo/UMLS_@http://linkedlifedata.com/resource/umls/id/@'  $@.tmp.ttl && robot annotate -i $@.tmp.ttl -O $(OBO)/mondo/$@ -o $@
imports/equivalencies.obo: imports/equivalencies.owl
	robot convert -i $< -o $@

#imports/equivalencies.owl: $(SRC)
#	../utils/xrefs2axioms.pl $< > $@.tmp && owltools $@.tmp -o $@

# ----------------------------------------
# Merge constructs
# ----------------------------------------
mondo-premerge-%.owl: mondo.owl mirror/%.owl
	owltools --use-catalog $^ --merge-support-ontologies -o $@.tmp && mv $@.tmp $@

mondo-plus-%.owl: mondo-premerge-%.owl
	owltools --use-catalog $< --reasoner elk --merge-equivalence-sets -P MONDO -s MONDO 100 --remove-dangling -o $@.tmp && mv $@.tmp $@

# ----------------------------------------
# External ontologies
# ----------------------------------------

XD = gard ncit-disease obo_orphanet icd10 doid medgen-disease-extract snomed mesh
mirror/xdisease-all.owl: $(patsubst %, mirror/%.owl, $(XD))
	owltools $^ --merge-support-ontologies -o $@

mirror/%-raw.owl: mirror/%.owl
	$(OWLTOOLS) $< --remove-axioms-about -v 

trigger-mirror:
	touch $@

# clone remote ontology locally, perfoming some excision of relations and annotations
mirror/%.owl: trigger-mirror
	$(OWLTOOLS) $(OBO)/$*.owl --remove-annotation-assertions -l -s -d -r --remove-dangling-annotations --remove-axiom-annotations  -o $@
.PRECIOUS: mirror/%.owl

mirror/ncbitaxon.owl: 
	wget --no-check-certificate $(OBO)/ncbitaxon.obo -O $@.tmp && mv $@.tmp $@
.PRECIOUS: mirror/%.owl

mirror/chebi.owl: 
	wget --no-check-certificate $(OBO)/chebi.obo -O $@.tmp.obo && owltools $@.tmp.obo --remove-annotation-assertions -l -s -d --remove-dangling-annotations --remove-axiom-annotations  -o $@
.PRECIOUS: mirror/%.owl

mirror/mfoem.owl: 
	$(OWLTOOLS) $(OBO)/mfoem.owl --remove-annotation-assertions -l -s -d --make-subset-by-properties -f BFO:0000050 // --remove-dangling-annotations  -o $@
.PRECIOUS: mirror/%.owl

mirror/neoplasm-core.owl:
	wget --no-check-certificate $(OBO)/ncit/neoplasm-core.owl -O $@

mirror/ncit.owl:
	wget --no-check-certificate $(OBO)/ncit.owl -O $@

mirror/ncit-disease.uris: mirror/ncit.owl
	robot query -i $< -s ../sparql/ncit-subclass-of-disease.sparql $@

mirror/ncit-disease.ids: mirror/ncit-disease.uris
	perl -npe 's@http://purl.obolibrary.org/obo/NCIT_@NCIT:@' $< > $@


mirror/ncit-disease.owl: mirror/ncit.owl mirror/ncit-disease.uris
	robot extract -i $< -T mirror/ncit-disease.uris --method BOT -o $@

mirror/ncit-%-xrefs.ttl: mirror/ncit.owl
	robot query -c ../sparql/construct-$*-xrefs-from-ncit.sparql $@ -i $<

mirror/ncit-disease.obo: mirror/ncit-disease.owl
	owltools $< -o -f obo $@
#	robot convert -i $< -o $@

mirror/rdo.obo:
	wget  --no-check-certificate ftp://ftp.rgd.mcw.edu/pub/ontology/disease/RDO.obo -O $@

mirror/ordo_orphanet.owl.zip:
	wget -nd -P mirror http://www.orphadata.org/data/ORDO/$@

mirror/ordo_orphanet.owl: mirror/ordo_orphanet.owl.zip
	unzip  mirror/ordo_orphanet.owl.zip -d mirror
	touch $@

# ~~~~~~~~
# ORDO
# ~~~~~~~~
EFO=http://www.ebi.ac.uk/efo


# STEP 1: DOWNLOAD
mirror/obo_orphanet_1.owl: mirror/ordo_orphanet.owl
	owltools $< --rename-entity $(EFO)/definition $(OBO)/IAO_0000115 \
           --rename-entity $(EFO)/alternative_term $(OIO)hasExactSynonym\
           --rename-entity $(OBO)/ECO_0000218\
           $(OIO)source -o $@.tmp && mv $@.tmp $@

# STEP 2: Fix XREFs
mirror/obo_orphanet_2.owl: mirror/obo_orphanet_1.owl
	perl -npe 's@MeSH:@MESH:@;s@ICD-10:@ICD10:@;' $< >  $@.tmp && mv $@.tmp $@

# STEP 2b: Create is-a from part-of
mirror/obo_orphanet_sc.owl: mirror/obo_orphanet_2.owl
	robot query --format ttl -c ../sparql/construct-subclass-from-part-of.sparql $@ -i $<

# STEP 2c: Create subsets based on subClass to sub-root level
mirror/obo_orphanet_subsets.owl: mirror/obo_orphanet_2.owl
	robot query --format ttl -c ../sparql/construct-ordo-subsets.sparql $@ -i $<

# STEP 3: merge 2b and 2c in to 2
mirror/obo_orphanet_3.owl: mirror/obo_orphanet_2.owl mirror/obo_orphanet_sc.owl mirror/obo_orphanet_subsets.owl
	owltools $^ --merge-support-ontologies -o $@

# STEP 3b: make an .obo file
mirror/obo_orphanet_3.obo: mirror/obo_orphanet_3.owl
	owltools $< -o -f obo $@.tmp && grep -v ^owl-axioms $@.tmp > $@

# STEP 4: Remove part-ofs (see 2b, we have these as subClassOf now)
mirror/obo_orphanet_4.obo: mirror/obo_orphanet_3.obo
	grep -v '^relationship: BFO:0000050' $< > $@

mirror/obo_orphanet.obo: mirror/obo_orphanet_4.obo
	cp $< $@
mirror/obo_orphanet.owl: mirror/obo_orphanet.obo
	owltools $< -o $@.tmp && perl -npe 's@http://purl.obolibrary.org/obo/Orphanet_@http://www.orpha.net/ORDO/Orphanet_@g' $@.tmp > $@

mirror/omia.ttl: 
	wget --no-check-certificate http://data.monarchinitiative.org/ttl/omia.ttl -O $@ && touch $@
.PRECIOUS: mirror/omia.ttl

mirror/omia-1.owl: mirror/omia.ttl
	owltools $< --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: mirror/omia-1.owl

mirror/omia-2.obo: mirror/omia-1.owl
	owltools $< -o -f obo $@.tmp && grep -v ^owl-axioms $@.tmp | grep -v ^property_value | perl -npe 's@xref: OMIM:@relationship: RO:HOM0000001 OMIM:@' | perl -npe 's@is_a: MESH:@relationship: RO:HOM0000001 MESH:@' | obo-grep.pl --neg -r 'id: http' - | ../utils/fix-omia-names.pl > $@.tmp.obo && robot reduce -i $@.tmp.obo -o $@

mirror/omia.owl: mirror/omia-2.obo imports/equivalencies.owl
	owltools $^ --add-imports-from-supports --reasoner elk --merge-equivalence-sets -s MONDO 20 --remove-imports-declarations  -o $@

mirror/omia.obo: mirror/omia.owl
	owltools --use-catalog $< -o -f obo $@

mirror/efo-src.owl:
	wget --no-check-certificate http://www.ebi.ac.uk/efo/efo.owl -O $@

mirror/efo.owl: mirror/efo-src.owl
	cp $< $@

mirror/efo.obo: mirror/efo-src.owl
	owltools $< -o -f obo --no-check $@.tmp && perl ../utils/fix-efo.pl $@.tmp > $@

# ----------------------------------------
# Indirect inferences
# ----------------------------------------
imports/indirect.owl: mondo-edit.obo
	robot reason -r elk -i $< query  --format ttl  -c ../sparql/construct-indirect-subclass-of.sparql $@
imports/tag-indirect.owl: mondo-edit.obo
	robot reason -r elk -i $< query  --format ttl  -c ../sparql/construct-tag-indirect-subclass-of.sparql $@


# ----------------------------------------
# Rewritten ext axioms
# ----------------------------------------

# Generates synonym from labels
compare/lsyns-%.owl: mirror/%.owl
	robot query -i $<  --format ttl -c ../sparql/construct-related-synonym-from-label.sparql $@
.PRECIOUS: compare/lsyns-%.owl

# Merges in the syns generated as above step
compare/%-plus-lsyns.owl: mirror/%.owl compare/lsyns-%.owl
	owltools $^ --merge-support-ontologies -o $@
.PRECIOUS: compare/%-plus-lsyns.owl

# logical merge, no duplicate axioms
compare/axioms-%-nd.owl: compare/%-plus-lsyns.owl
	owltools --use-catalog mondo-edit.obo --copy-axioms -l -m imports/equivalencies.owl -s $< -n --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: compare/axioms-%.owl

compare/axioms-%-d.owl: compare/%-plus-lsyns.owl
	owltools --use-catalog mondo-edit.obo --copy-axioms -I -D -m imports/equivalencies.owl -s $< -n --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: compare/axioms-%.owl

# bring in strictly new literals in annotation axioms
compare/ann-axioms-%-new.owl: compare/%-plus-lsyns.owl
	owltools --use-catalog mondo-edit.obo --copy-axioms -x -m imports/equivalencies.owl -s $< -n --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: compare/axioms-%.owl

compare/ann-axioms-ncit-disease-new.owl: mirror/ncit-disease.owl
	owltools --use-catalog mondo-edit.obo --copy-axioms -x -m imports/equivalencies.owl -s $< -n --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: compare/axioms-%.owl

# all axioms
compare/axioms-%-all.owl: compare/%-plus-lsyns.owl
	owltools --use-catalog mondo-edit.obo --copy-axioms -d -m imports/equivalencies.owl -s $< -n --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: compare/axioms-%.owl

#compare/axioms-%.owl:
#	owltools --use-catalog mondo-edit.obo --copy-axioms -l -d -m imports/equivalencies.owl -s mirror/$*.owl -n --set-ontology-id $(OBO)/mondo/$@ -o $@
#.PRECIOUS: compare/axioms-%.owl


compare/axioms-%.obo: compare/axioms-%.owl
	owltools $< -o -f obo --no-check $@
compare/ann-axioms-%.obo: compare/ann-axioms-%.owl
	owltools $< -o -f obo --no-check $@

testcombo-%: mondo-edit.obo disjoint_sibs.owl imports/equivalencies.owl mirror/%.owl disjoint_sibs.owl
	owltools --use-catalog  $^ --merge-support-ontologies --run-reasoner -r elk -u -m compare/bad-$*.owl

debug.owl: mondo-edit.obo disjoint_sibs.owl imports/equivalencies.owl
	owltools --use-catalog  $^ --merge-support-ontologies --run-reasoner -r elk -u -m $@

# ----------------------------------------
# Lexical mapping
# ----------------------------------------

# align against self (*not* external ontologies)
mappings.tsv: mondo.json
	ontobio-lexmap.py $< > $@.tmp && mv $@.tmp $@ && perl -pi -ne 's@http://purl.obolibrary.org/obo/MONDO_@MONDO:@g' $@

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
	wget ftp://ftp.ncbi.nih.gov/gene/DATA/mim2gene_medgen

omim2medgen.obo: mim2gene_medgen
	grep phenotype $<  | cut -f1,5 | perl -npe 's@^@OMIM:@;s@\t@\tUMLS:@' | grep UMLS:C | tbl2obolinks.pl --rel xref --source NCBI:mim2gene_medline - > $@

# ----------------------------------------
# Anns
# ----------------------------------------
phenotype_annotation.tab:
	wget http://compbio.charite.de/jenkins/job/hpo.annotations/lastStableBuild/artifact/misc/phenotype_annotation.tab -O $@

d2p.tsv: phenotype_annotation.tab
	../utils/phenotab2tbl.pl $< > $@

# ----------------------------------------
# Hacky
# ----------------------------------------

mondox.obo: mondo-edit.obo
	perl -npe 's@source="MONDO:(equivalentto|subclassof|superclassof|other|relatedto)@semantics="MONDO:$$1@i' $< > $@

check: mondo-edit.obo
	$(HOME)/repos/go-ontology/src/util/check-obo-for-standard-release.pl --disable-xrf-abbs-check $<

mondo-edit.owl: mondo-edit.obo
	robot convert -i $< -o $@

# ----------------------------------------
# Kboom
# ----------------------------------------

ptable.tsv: mondo-edit.obo
	../utils/xrefs2ptable.pl $< > $@.tmp && mv $@.tmp $@

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
# BLAZEGRAPH
# ----------------------------------------

BGVERSION = 2.1.4
bg: bg-run pause bg-load

bg-data:
	mkdir $@

XD_OWL = $(patsubst %, mirror/%.owl, $(XD))
bg-sync: mondo.owl  $(XD_OWL)
	cp $^ bg-data


bg-run: bg-data
	docker run --name blazegraph -d -p 8889:8080 -v $(PWD)/blazegraph/RWStore.properties:/RWStore.properties -v $(PWD)/bg-data/:/data lyrasis/blazegraph:$(BGVERSION)

pause:
	sleep 1

bg-load: bg-data bg-sync bg-load-direct

bg-load-direct:
	curl -X POST --data-binary @blazegraph/dataloader.txt   --header 'Content-Type:text/plain'   http://localhost:8889/bigdata/dataloader

bg-stop:
	docker kill blazegraph; docker rm blazegraph

bg-clean:
	rm bg-data/*

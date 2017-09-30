# ----------------------------------------
# Standard Constants
# ----------------------------------------
# these can be overwritten on the command line

OBO=http://purl.obolibrary.org/obo
ONT=tbd
BASE=$(OBO)/$(ONT)
SRC=$(ONT)-edit.obo
RELEASEDIR=../..
ROBOT= robot
OWLTOOLS= owltools
USECAT= --use-catalog
SPARQLDIR = ../sparql

# ----------------------------------------
# Top-level targets
# ----------------------------------------

all: sparql_test all_imports $(ONT).owl $(ONT).obo
test: sparql_test all
prepare_release: all
	cp $(ONT).owl $(ONT).obo $(RELEASEDIR) &&\
	mkdir -p $(RELEASEDIR)/imports &&\
	cp imports/*{owl,obo} $(RELEASEDIR)/imports &&\
	git add $(RELEASEDIR)/imports/*{obo,owl} &&\
	(test -f subsets/*owl && cp subsets/*{owl,obo} $(RELEASEDIR)/subsets && git add $(RELEASEDIR)/subsets/* || echo "no subsets") &&\
	echo "Release files are now in $(RELEASEDIR) - now you should commit, push and make a release on github"

# ----------------------------------------
# Main release targets
# ----------------------------------------

# by default we use Elk to perform a reason-relax-reduce chain
# after that we annotate the ontology with the release versionInfo
$(ONT).owl: $(SRC)
	$(ROBOT)  reason -i $< -r ELK relax reduce -r ELK annotate -V $(BASE)/releases/`date +%Y-%m-%d`/$(ONT).owl -o $@
$(ONT).obo: $(ONT).owl
	owltools --use-catalog $< --merge-imports-closure -o -f obo --no-check $(ONT).obo.tmp && mv $(ONT).obo.tmp $@
#	$(ROBOT) convert -i $< -f obo -o $(ONT).obo.tmp && mv $(ONT).obo.tmp $@
$(ONT).json: $(ONT).owl
	$(ROBOT) convert -i $< -f json -o $(ONT).json.tmp && mv $(ONT).json.tmp $@

$(ONT)-basic.owl: $(ONT).owl
	owltools --use-catalog $< --remove-imports-declarations --remove-dangling -o $@
$(ONT)-basic.obo: $(ONT)-basic.owl
	owltools --use-catalog $<  -o -f obo $(ONT).obo.tmp && mv $(ONT).obo.tmp $@
%.json: %.owl
	$(ROBOT) convert -i $< -f json -o $(ONT).json.tmp && mv $(ONT).json.tmp $@


# ----------------------------------------
# DOSDP Modules
# ----------------------------------------
all_mods: modules/disease_by_location.owl

modules/%.tsv: modules/%.csv
	csv2tsv.py $< $@

modules/%.owl: modules/%.tsv
	dosdp-tools  --obo-prefixes --ontology=../ontology/tbd-edit.owl  --template=../patterns/$*.yaml --outfile=$@ generate --infile=$<


# ----------------------------------------
# Import modules
# ----------------------------------------
# Most ontologies are modularly constructed using portions of other ontologies
# These live in the imports/ folder
# These can be regenerated with make all_imports

IMPORTS = uberon cl go pato ro bfo mfoem
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

# clone remote ontology locally, perfoming some excision of relations and annotations
mirror/%.owl: 
	$(OWLTOOLS) $(OBO)/$*.owl --remove-annotation-assertions -l -s -d --remove-dangling-annotations  -o $@
.PRECIOUS: mirror/%.owl

mirror/mfoem.owl: 
	$(OWLTOOLS) $(OBO)/mfoem.owl --remove-annotation-assertions -l -s -d --make-subset-by-properties -f BFO:0000050 // --remove-dangling-annotations  -o $@
.PRECIOUS: mirror/%.owl

imports/%_newterms.txt:
	robot query -i tbd-edit.obo -s ../sparql/classes.sparql $@.tmp && grep -hi $* $@.tmp imports/$*_terms.txt | sort -u > $@

# ----------------------------------------
# Release
# ----------------------------------------
# copy from staging area (this directory) to top-level
release: $(ONT).owl $(ONT).obo
	cp $^ $(RELEASEDIR) && cp imports/* $(RELEASEDIR)/imports

# ----------------------------------------
# Editing
# ----------------------------------------

INF: tbd-edit.obo
	owltools --use-catalog  tbd-edit.obo --assert-inferred-subclass-axioms --markIsInferred --removeRedundant  --merge-axiom-annotations -o -f obo $@.tmp && grep -v ^owl-axioms $@.tmp > $@

# ----------------------------------------
# Sparql queries: Q/C
# ----------------------------------------

# these live in the ../sparql directory, and have suffix -violation.sparql
# adding the name here will make the violation check live
VCHECKS = equivalent-classes trailing-whitespace owldef-self-reference xref-syntax nolabels

# run all violation checks
VQUERIES = $(foreach V,$(VCHECKS),$(SPARQLDIR)/$V-violation.sparql)
sparql_test: $(SRC)
	robot verify -i $< --queries $(VQUERIES) -O reports/

# ----------------------------------------
# Sparql queries: Reports
# ----------------------------------------

REPORTS = basic-report class-count-by-prefix edges xrefs obsoletes synonyms
REPORT_ARGS = $(foreach V,$(REPORTS),-s $(SPARQLDIR)/$V.sparql reports/$V.tsv)
all_reports: $(SRC)
	robot query -f tsv -i $< $(REPORT_ARGS)

# ----------------------------------------
# Lexical mapping
# ----------------------------------------

# align against self (*not* external ontologies)
mappings.tsv: tbd.json
	ontobio-lexmap.py $< > $@.tmp && mv $@.tmp $@

hp-mappings.tsv: tbd.json
	ontobio-lexmap.py hp $< > $@.tmp && mv $@.tmp $@


unlikely.md: linked-rpt.md
	./unlikely-axiom-report.pl $< | head -200 > $@

phenotype_annotation.tab:
	wget http://compbio.charite.de/jenkins/job/hpo.annotations/lastStableBuild/artifact/misc/phenotype_annotation.tab -O $@

mim2gene_medgen:
	wget ftp://ftp.ncbi.nih.gov/gene/DATA/mim2gene_medgen

modules/equiv-xrefs.obo: tbd-edit.obo
	obo-filter-tags.pl -t id -t xref $<   | egrep '^($$|\[Term|id:|xref:.*equivalentTo)' > $@

# ----------------------------------------
# Standard Constants
# ----------------------------------------
# these can be overwritten on the command line

OBO=http://purl.obolibrary.org/obo
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
	cp imports/*{owl,obo} $(RELEASEDIR)/imports &&\
	cp pre/*{owl,obo} $(RELEASEDIR)/pre &&\
	cp extid/*{owl,obo,json} $(RELEASEDIR)/extid &&\
	(test -f subsets/*owl && cp subsets/*{owl,obo,json} $(RELEASEDIR)/subsets && git add $(RELEASEDIR)/subsets/* || echo "no subsets") &&\
	echo "Release files are now in $(RELEASEDIR) - now you should commit, push and make a release on github"

all_includes: $(INCLUDES_OWL)

osf_upload:
	cd ../.. && $(HOME)/repos/osf-cli/venv/bin/osf -p 2qk53 upload -f -r target/ current/

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

PL2SPARQL = pl2sparql  -c ../plq/lexical_match_queries.pro -c ../plq/checks.pro -c ../plq/reports.pro
../sparql/%.sparql:
	 $(PL2SPARQL) -v  "$*" > $@.tmp && mv $@.tmp $@

reports/pql-%.tsv: mondo-edit.owl
	 $(PL2SPARQL) -f tsv -v -i $< -e -l "$*" > $@.tmp && mv $@.tmp $@
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
	robot merge -i $(SRC) query -c $< $@.tmp.ttl -f ttl && robot annotate -i $@.tmp.ttl -O $(OBO)/mondo/$@ -o $@
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

mirror/%-raw.owl: mirror/%.owl
	$(OWLTOOLS) $< --remove-axioms-about -v 

# clone remote ontology locally, perfoming some excision of relations and annotations
mirror/%.owl: 
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

mirror/ncit-disease.obo: mirror/ncit-disease.owl
	owltools $< -o -f obo $@
#	robot convert -i $< -o $@

mirror/rdo.obo:
	wget  --no-check-certificate ftp://ftp.rgd.mcw.edu/pub/ontology/disease/RDO.obo -O $@

# ----------------------------------------
# Rewritten ext axioms
# ----------------------------------------

imports/axioms-%-nd.owl:
	owltools --use-catalog mondo-edit.obo --copy-axioms -l -m imports/equivalencies.owl -s mirror/$*.owl -n --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: imports/axioms-%.owl

imports/axioms-%-all.owl:
	owltools --use-catalog mondo-edit.obo --copy-axioms -d -m imports/equivalencies.owl -s mirror/$*.owl -n --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: imports/axioms-%.owl

imports/axioms-%.owl:
	owltools --use-catalog mondo-edit.obo --copy-axioms -l -d -m imports/equivalencies.owl -s mirror/$*.owl -n --set-ontology-id $(OBO)/mondo/$@ -o $@
.PRECIOUS: imports/axioms-%.owl


imports/axioms-%.obo: imports/axioms-%.owl
	owltools $< -o -f obo --no-check $@

testcombo-%: mondo-edit.obo disjoint_sibs.owl imports/equivalencies.owl mirror/%.owl disjoint_sibs.owl
	owltools --use-catalog  $^ --merge-support-ontologies --run-reasoner -r elk -u -m imports/bad-$*.owl

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

phenotype_annotation.tab:
	wget http://compbio.charite.de/jenkins/job/hpo.annotations/lastStableBuild/artifact/misc/phenotype_annotation.tab -O $@

d2p.tsv: phenotype_annotation.tab
	../utils/phenotab2tbl.pl $< > $@


modules/equiv-xrefs.obo: mondo-edit.obo
	obo-filter-tags.pl -t id -t xref $<   | egrep '^($$|\[Term|id:|xref:.*equivalentTo)' > $@

mim2gene_medgen:
	wget ftp://ftp.ncbi.nih.gov/gene/DATA/mim2gene_medgen

omim2medgen.obo: mim2gene_medgen
	grep phenotype $<  | cut -f1,5 | perl -npe 's@^@OMIM:@;s@\t@\tUMLS:@' | grep UMLS:C | tbl2obolinks.pl --rel xref --source NCBI:mim2gene_medline - > $@

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

BGJAR = target/jars/blazegraph-jar.jar

$(BGJAR):
	mkdir -p jars && cd jars && curl -O http://tenet.dl.sourceforge.net/project/bigdata/bigdata/2.1.1/blazegraph.jar
.PRECIOUS: $(BGJAR)

BG = java -XX:+UseG1GC -Xmx12G -cp $(BGJAR) com.bigdata.rdf.store.DataLoader -defaultGraph http://geneontology.org/rdf/ conf/blazegraph.properties
load-blazegraph: mondo-edit.owl
	$(BG) $<

bg-start:
	java -server -Xmx8g -Dbigdata.propertyFile=conf/blazegraph.properties -jar $(BGJAR)

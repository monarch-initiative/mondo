ALL_PATTERNS_1=$(patsubst ../patterns/dosdp-patterns/%.yaml,%,$(wildcard ../patterns/dosdp-patterns/[a-h]*.yaml))
ALL_PATTERNS_2=$(patsubst ../patterns/dosdp-patterns/%.yaml,%,$(wildcard ../patterns/dosdp-patterns/[i-p]*.yaml))
ALL_PATTERNS_3=$(patsubst ../patterns/dosdp-patterns/%.yaml,%,$(wildcard ../patterns/dosdp-patterns/[q-z]*.yaml))
DOSDPT=../dosdp-tools-0.15.1-SNAPSHOT/bin/dosdp-tools

g:
	echo $(ALL_PATTERNS_2)

.PHONY: dirs
dirs:
	mkdir -p tmp/
	mkdir -p components/


.PHONY: matches
	
matches: matches_1 matches_2 matches_3

matches_1:
	$(DOSDPT) query --ontology=$(SRC) --catalog=catalog-v001.xml --reasoner=elk --obo-prefixes=true --batch-patterns="$(ALL_PATTERNS_1)" --template="../patterns/dosdp-patterns" --outfile="../patterns/data/matches/"

matches_2:
	$(DOSDPT) query --ontology=$(SRC) --catalog=catalog-v001.xml --reasoner=elk --obo-prefixes=true --batch-patterns="$(ALL_PATTERNS_2)" --template="../patterns/dosdp-patterns" --outfile="../patterns/data/matches/"
		
matches_3:
	$(DOSDPT) query --ontology=$(SRC) --catalog=catalog-v001.xml --reasoner=elk --obo-prefixes=true --batch-patterns="$(ALL_PATTERNS_3)" --template="../patterns/dosdp-patterns" --outfile="../patterns/data/matches/"
	

pattern_schema_checks:
	simple_pattern_tester.py ../patterns/dosdp-patterns/
	
../patterns/dosdp-pattern.owl: pattern_schema_checks
	$(DOSDPT) prototype --obo-prefixes --template=../patterns/dosdp-patterns --outfile=$@

../patterns/pattern-merged.owl: ../patterns/dosdp-pattern.owl
	$(ROBOT) merge -i ../patterns/dosdp-pattern.owl annotate -V $(ONTBASE)/releases/`date +%Y-%m-%d`/$(ONT)-pattern.owl annotate --ontology-iri $(ONTBASE)/$(ONT)-pattern.owl -o $@

../patterns/imports/seed.txt: ../patterns/dosdp-pattern.owl
	$(ROBOT) query -f csv -i $< --query ../sparql/terms.sparql $@
	
../patterns/imports/seed_sorted.txt: ../patterns/imports/seed.txt
	cat ../patterns/imports/seed.txt | sort | uniq > $@


PATTERN_IMPORTS = ro
PATTERN_IMPORTS_OWL = $(patsubst %, ../patterns/imports/%_import.owl, $(PATTERN_IMPORTS))
../patterns/imports/%_import.owl: mirror/%.owl ../patterns/imports/seed_sorted.txt
	$(ROBOT) extract -i $< -T ../patterns/imports/seed_sorted.txt --force true --method BOT -O mirror/$*.owl annotate --ontology-iri $(OBO)/$(ONT)/patterns/imports/$*_import.owl -o $@

../patterns/pattern-with-imports.owl: ../patterns/pattern-merged.owl $(PATTERN_IMPORTS_OWL)
	$(ROBOT) merge $(addprefix -i , $^) unmerge -i ../patterns/components/pattern-ontology-remove-axioms.owl -o $@

../patterns/pattern.owl: ../patterns/pattern-with-imports.owl
	$(ROBOT) merge -i ../patterns/pattern-with-imports.owl remove --term http://www.w3.org/2002/07/owl#Nothing reason -r Hermit reduce -r Hermit annotate --ontology-iri $(OBO)/$(ONT)/patterns/pattern.owl -o $@

pattern_ontology: ../patterns/pattern.owl
	$(ROBOT) merge -i ../patterns/pattern.owl \
	filter --select "<http://purl.obolibrary.org/obo/mondo/patterns*>" --select "self annotations" --signature true --trim true -o ../patterns/pattern-simple.owl
	
../patterns/dosdp-patterns/README.md: .FORCE
	pip install tabulate
	python ../scripts/patterns_create_overview.py "../patterns/dosdp-patterns" "../patterns/data/matches" $@

pattern_readmes: ../patterns/dosdp-patterns/README.md

.PHONY: pattern_docs
pattern_docs: pattern_ontology pattern_readmes


#################################
##### REPORTING PIPELINE ########

SPARQL_WARNINGS=$(patsubst %.sparql, %, $(notdir $(wildcard $(SPARQLDIR)/*-warning.sparql)))
SPARQL_STATS=$(patsubst %.sparql, %, $(notdir $(wildcard $(SPARQLDIR)/*-stats.sparql)))
SPARQL_TAGS=$(patsubst %.sparql, %, $(notdir $(wildcard $(SPARQLDIR)/*-tags.sparql)))

tmp/mondo-version_edit.owl: $(SRC)
	$(ROBOT) merge -i $< -o $@
	
tmp/mondo-version_mondo-owl.owl: mondo.owl
	$(ROBOT) merge -i $< -o $@

tmp/mondo-version_current.owl:
	$(ROBOT) merge -I $(OBO)/mondo.owl -o $@

tmp/mondo-version_2019.owl:
	$(ROBOT) merge -I http://purl.obolibrary.org/obo/mondo/releases/2019-04-29/mondo.owl -o $@

tmp/mondo-version_2020.owl:
	$(ROBOT) merge -I http://purl.obolibrary.org/obo/mondo/releases/2020-01-27/mondo.owl -o $@

tmp/mondo-version_2018.owl:
	wget "https://osf.io/bqpjm/download?version=5&displayName=mondo-2018-01-06T03%3A29%3A32.300263%2B00%3A00.owl" -O $@
	$(ROBOT) merge -i $@ -o $@.tmp.owl && mv $@.tmp.owl $@
	
tmp/mondo-version_2017.owl:
	wget "https://osf.io/bqpjm/download?version=1&displayName=mondo-2017-10-19T06%3A08%3A40.163682%2B00%3A00.owl" -O $@	
	$(ROBOT) merge -i $@ -o $@.tmp.owl && mv $@.tmp.owl $@

# This combines all into one single command
.PHONY: all_reports_warnings_%
all_reports_warnings_%: tmp/mondo-version_%.owl
	$(ROBOT) query -f tsv --use-graphs true -i $< $(foreach V,$(SPARQL_WARNINGS),-s $(SPARQLDIR)/$V.sparql reports/mondo-qc-$*-$V.tsv)

.PHONY: all_reports_stats_%
all_reports_stats_%: tmp/mondo-version_%.owl
	$(ROBOT) query -f tsv --use-graphs true -i $< $(foreach V,$(SPARQL_STATS),-s $(SPARQLDIR)/$V.sparql reports/mondo-qc-$*-$V.tsv)

reports/mondo-qc-%-robot-report-obo.tsv: tmp/mondo-version_%.owl
	$(ROBOT) report -i $< --fail-on none --print 5 -o $@
.PRECIOUS: reports/mondo-qc-%-robot-report-obo.tsv

QC_BASE_FILES=edit mondo-owl current 2017 2018 2019 2020
QC_REPORTS=$(foreach V,$(QC_BASE_FILES), qc_reports_$V)
QC_REPORTS_RM=$(foreach V,$(QC_BASE_FILES), reports/$V*)

clean_qc:
	rm report/mondo-qc-*

qc_reports_%: all_reports_stats_% reports/mondo-qc-%-robot-report-obo.tsv all_reports_warnings_%
	echo $^

travis_test: mondo.owl sparql_test_main_obo
	$(ROBOT) report -i mondo.owl --fail-on none --print 5 -o reports/obo-report.tsv

run_notebook:
	# https://github.com/jupyter/notebook/issues/2254
	jupyter notebook --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''

reports/mondo_analysis.md: $(QC_REPORTS)
	jupyter nbconvert --execute --to markdown --TemplateExporter.exclude_input=True reports/mondo_analysis.ipynb
	#sed -i 's/<style.*<[/]style>//g' $@
	# This is a hack to get rid of <style> tags that are rendered very ugly by github.
	perl -0777 -i.original -pe 's#<style[^<]*<\/style>##igs' $@
	
reports/mondo_analysis.pdf: $(QC_REPORTS)
	jupyter nbconvert --execute --to pdf --TemplateExporter.exclude_input=True reports/mondo_analysis.ipynb

##############################################################
###### Pipeline for adding a compoment with tagging ##########
# For example: DOSDP conformance

MATCHED_TSVs=$(foreach V,$(notdir $(wildcard ../patterns/data/matches/*.tsv)),../patterns/data/matches/$V)

tmp/mondo-tags-dosdp.tsv: | dirs
	python ../scripts/dosdp-matches-tags.py $(addprefix -d , $(MATCHED_TSVs)) -o $@

tmp/mondo-tags-dosdp.owl: tmp/mondo-tags-dosdp.tsv | dirs
	$(ROBOT) merge -i $(SRC) template --template $< --prefix "MONDO: http://purl.obolibrary.org/obo/MONDO_" --output $@

tmp/mondo-tags-sparql.ttl: $(SRC) | dirs
	$(ROBOT) query -f ttl -i $< --queries $(foreach V,$(SPARQL_TAGS),$(SPARQLDIR)/$V.sparql) --output-dir tmp/
	$(ROBOT) merge $(addprefix -i , $(foreach V,$(SPARQL_TAGS),tmp/$V.ttl)) -o $@

components/mondo-tags.owl: tmp/mondo-tags-dosdp.owl tmp/mondo-tags-sparql.ttl | dirs
	$(ROBOT) merge $(addprefix -i , $^) annotate --ontology-iri $(ONTBASE)/$@ -o $@
	
clean:
	rm -rf mondo-base.* mondo.json mondo.obo mondo.owl mondo-qc.* \
		mondo_current_release* all_reports_1 filtered.* mondo-with-equivalents.* \
		*.tmp *.tmp.obo merged.owl *merged.owl reasoned.obo skos.ttl \
		debug.owl roundtrip.obo test_nomerge sparql_test_* disjoint_sibs.obo \
		reasoned-plus-equivalents.owl reasoned.owl tmp/*

#############################################
##### Mondo analysis ########################
#############################################

# Makefile for mondo analysis

all: sources

## SOURCES
SOURCE_VERSION = $(TODAY)
SOURCE_IDS = doid ncit mondo ordo medgen equivalencies
ALL_SOURCES_JSON = $(patsubst %, sources/$(SOURCE_VERSION)/%.json, $(SOURCE_IDS))
ALL_SOURCES_JSON_GZ = $(patsubst %, sources/$(SOURCE_VERSION)/%.json.gz, $(SOURCE_IDS))
ALL_SOURCES_OWL = $(patsubst %, sources/$(SOURCE_VERSION)/%.owl, $(SOURCE_IDS))


sources: $(ALL_SOURCES_JSON) $(ALL_SOURCES_JSON_GZ) sources/$(SOURCE_VERSION)/all_sources_merged.json

.PHONY: source_release_dir
source_release_dir:
	mkdir -p sources/$(SOURCE_VERSION)

sources/$(SOURCE_VERSION)/%.json.gz: sources/$(SOURCE_VERSION)/%.json | source_release_dir
	gzip -c $< > $@
	
sources/$(SOURCE_VERSION)/%.json: sources/$(SOURCE_VERSION)/%.owl
	robot merge -i $< convert -f json -o $@

sources/$(SOURCE_VERSION)/doid.owl: | source_release_dir
	robot merge -I http://purl.obolibrary.org/obo/doid.owl -o $@

sources/$(SOURCE_VERSION)/medgen.owl: | source_release_dir
	robot merge -i sources/medgen/medgen-disease-extract.owl -o $@

sources/$(SOURCE_VERSION)/ordo.owl: | source_release_dir
	robot merge -i sources/orphanet/ordo_orphanet.owl -o $@

sources/$(SOURCE_VERSION)/ncit.owl: | source_release_dir
	robot merge -I http://purl.obolibrary.org/obo/ncit.owl -o $@

sources/$(SOURCE_VERSION)/mondo.owl: | source_release_dir
	curl -L -s $(OBO)/mondo.owl > $@.tmp && mv $@.tmp $@

sources/$(SOURCE_VERSION)/equivalencies.owl: | source_release_dir
	curl -L -s $(OBO)/mondo/imports/equivalencies.json > $@.tmp && mv $@.tmp $@

sources/$(SOURCE_VERSION)/all_sources_merged.json: $(ALL_SOURCES_OWL)
	robot merge $(addprefix -i , $^) convert -f json -o $@

#sources/CTD_diseases.obo:
#	curl -L -s http://ctdbase.org/reports/CTD_diseases.obo.gz  | gzip -dc | perl -npe 's@alt_id@xref@' > $@.tmp && mv $@.tmp $@

##################################################
################## Old diseases2owl code #########


#### Download and preprocess upstream Mondo sources.
# MONDO_SOURCES = omim medgen medic orphanet
MONDO_SOURCES = omim medgen medic orphanet
all: build_sources

.PHONY: release_dir

build_sources: $(patsubst %, build-%, $(MONDO_SOURCES))

build-%:
	cd sources/$* && make

xxx:
	$(ROBOT) query -f tsv --use-graphs false -i $(SRC) --query $(SPARQLDIR)/excluded-subsumption-is-inferred-violation.sparql reports/excluded-subsumption-is-inferred-violation.tsv

yyy:
	$(ROBOT) query -i $(SRC) --update $(SPARQLDIR)/excluded-subsumption-is-inferred-tags.sparql -o $(SRC)

aa:
	$(ROBOT) query -f tsv --use-graphs false -i $(SRC) --query $(SPARQLDIR)/related-exact-synonym-report.sparql reports/related-exact-synonym-report.tsv

ab:
	$(ROBOT) query -f tsv --use-graphs false -i $(SRC) --query $(SPARQLDIR)/related-exact-synonym-reportz.sparql reports/related-exact-synonym-report.tsv

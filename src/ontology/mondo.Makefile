ALL_PATTERNS=$(patsubst ../patterns/dosdp-patterns/%.yaml,%,$(wildcard ../patterns/dosdp-patterns/[a-z]*.yaml))
DOSDPT=dosdp-tools
TEMPLATES_DIR=../templates
MONDO_STATS_SPARQLDIR = ../sparql/mondo_stats
MONDO_STATS_REPORTS_DIR = reports/mondo_stats

.PHONY: dirs python-install-dependencies update-exclusion-reasons
dirs:
	mkdir -p tmp/
	mkdir -p components/
	mkdir -p mirror/
	mkdir -p reports/


.PHONY: matches

tmp/mondo-edit-merged.owl: $(SRC)
	$(ROBOT) merge -i $< -o $@

matches: tmp/mondo-edit-merged.owl
	$(DOSDPT) query --ontology=$< --catalog=catalog-v001.xml --reasoner=elk --obo-prefixes=true --batch-patterns="$(ALL_PATTERNS)" --template="../patterns/dosdp-patterns" --outfile="../patterns/data/matches/"

matches_annotations: tmp/mondo-edit-merged.owl
	$(DOSDPT) query --ontology=$< --catalog=catalog-v001.xml --reasoner=elk --restrict-axioms-to=annotation --obo-prefixes=true --batch-patterns="$(ALL_PATTERNS)" --template="../patterns/dosdp-patterns" --outfile="../patterns/data/matches_annotations/"

pattern_schema_checks:
	simple_pattern_tester.py ../patterns/dosdp-patterns/

owlaxioms_check:
	! grep "^owl-axioms" mondo-edit.obo

obo_validator:
	fastobo-validator mondo-edit.obo

oak_pronto_parser: mondo.obo
	runoak -i pronto:mondo.obo ontology-metadata > tmp/mondo-metadata.txt

test: pattern_schema_checks
test: owlaxioms_check
test: test_reason_equivalence
test: test_reason_equivalence_hermit
test: obo_validator
test: oak_pronto_parser

test_reason_equivalence_hermit: $(ONT)-base.obo
	$(ROBOT) reason -i $< --equivalent-classes-allowed none -r hermit

test_reason_equivalence: $(SRC)
	$(ROBOT) merge -i $< \
	remove --term FOODON:03315150 --term FOODON:00001257 --term ENVO:01001479 --term ENVO:01001784 --axioms logical \
	reason -e none

../patterns/dosdp-pattern.owl: pattern_schema_checks
	$(DOSDPT) prototype --obo-prefixes=true --template=../patterns/dosdp-patterns --outfile=$@

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
	python ../scripts/patterns_create_overview.py "../patterns/dosdp-patterns" "../patterns/data/matches" $@

pattern_readmes: ../patterns/dosdp-patterns/README.md

MYDIR = .
list: $(MYDIR)/*

../../docs/editors-guide/quality-control-tests.md:
	echo "# Custom SPARQL checks Mondo" > $@ &&\
	echo "" >> $@ &&\
	echo "## Mondo specific checks" >> $@ &&\
	echo "" >> $@ &&\
	for file in $(SPARQLDIR)/qc/mondo/*.sparql ; do \
		echo "### " $$(basename $${file}) >> $@  ; \
		echo "" >> $@ ; \
		echo "\`\`\`" >> $@ ; \
		cat $${file} >> $@ ; \
		echo "" >> $@ ;\
		echo "\`\`\`" >> $@ ; \
		echo "" >> $@ ;\
	done &&\
	echo "## General quality checks" >> $@ &&\
	echo "" >> $@ &&\
	for file in $(SPARQLDIR)/qc/general/*.sparql ; do \
		echo "### " $$(basename $${file}) >> $@  ; \
		echo "" >> $@ ; \
		echo "\`\`\`" >> $@ ; \
		cat $${file} >> $@ ; \
		echo "" >> $@ ;\
		echo "\`\`\`" >> $@ ; \
		echo "" >> $@ ;\
	done

.PHONY: qc_docs
qc_docs: ../../docs/editors-guide/quality-control-tests.md

pattern_mkdocs:
	python ../scripts/patterns_create_docs.py

.PHONY: pattern_docs
pattern_docs: pattern_ontology pattern_readmes pattern_mkdocs qc_docs


#################################
##### REPORTING PIPELINE ########
SPARQL_STATS=$(patsubst %.sparql, %, $(notdir $(wildcard $(SPARQLDIR)/reports/*-stats.sparql)))
SPARQL_TAGS=$(patsubst %.sparql, %, $(notdir $(wildcard $(SPARQLDIR)/tags/*-tags.sparql)))

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
.PHONY: all_reports_sparqlqc_%
all_reports_sparqlqc_%: tmp/mondo-version_%.owl
	$(ROBOT) query -f tsv --use-graphs true -i $< $(foreach V,$(SPARQL_MONDO_QC),-s $(SPARQLDIR)/qc/mondo/$V.sparql reports/mondo-qc-$*-$V.tsv)

.PHONY: all_reports_stats_%
all_reports_stats_%: tmp/mondo-version_%.owl
	$(ROBOT) query -f tsv --use-graphs true -i $< $(foreach V,$(SPARQL_STATS),-s $(SPARQLDIR)/reports/$V.sparql reports/mondo-qc-$*-$V.tsv)

reports/mondo-qc-%-robot-report-obo.tsv: tmp/mondo-version_%.owl
	$(ROBOT) report -i $< --fail-on none --print 5 -o $@
.PRECIOUS: reports/mondo-qc-%-robot-report-obo.tsv

QC_BASE_FILES=edit mondo-owl current 2017 2018 2019 2020
QC_REPORTS=$(foreach V,$(QC_BASE_FILES), qc_reports_$V)
QC_REPORTS_RM=$(foreach V,$(QC_BASE_FILES), reports/$V*)

clean_qc:
	rm report/mondo-qc-*

qc_reports_%: all_reports_stats_% reports/mondo-qc-%-robot-report-obo.tsv all_reports_sparqlqc_%
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
	$(ROBOT) reason -i $< query -f ttl --queries $(foreach V,$(SPARQL_TAGS),$(SPARQLDIR)/tags/$V.sparql) --output-dir tmp/
	$(ROBOT) merge $(addprefix -i , $(foreach V,$(SPARQL_TAGS),tmp/$V.ttl)) -o $@

components/mondo-tags.owl: tmp/mondo-tags-dosdp.owl tmp/mondo-tags-sparql.ttl | dirs
	$(ROBOT) merge $(addprefix -i , $^) annotate --ontology-iri $(ONTBASE)/$@ -o $@

clean:
	rm -rf mondo-base.* mondo.json mondo.obo mondo.owl mondo-qc.* \
		mondo_current_release* all_reports_1 filtered.* mondo-with-equivalents.* \
		*.tmp *.tmp.obo merged.owl *merged.owl reasoned.obo skos.ttl \
		debug.owl roundtrip.obo test_nomerge sparql_test_* disjoint_sibs.obo \
		reasoned-plus-equivalents.owl reasoned.owl tmp/*


reports/new-rare-diseases.txt: $(ONT)-base.owl
	$(ROBOT) query -i $(ONT)-base.owl --query ../sparql/signature/rare-subset.sparql $@

reports/old-rare-diseases.txt: tmp/mondo-lastbase.owl
	$(ROBOT) query -i tmp/mondo-lastbase.owl --query ../sparql/signature/rare-subset.sparql $@

reports/%-rare-diseases.tsv: $(ONT)-base.owl reports/%-rare-diseases.txt
	$(ROBOT) filter --input $(ONT)-base.owl  -T reports/$*-rare-diseases.txt --select "annotations self" \
		export --header "ID|LABEL|SYNONYMS" \
  		--format tsv --export $@

rare-disease-reports: reports/old-rare-diseases.tsv reports/new-rare-diseases.tsv
	python ../scripts/filter_rare_disease_list.py reports/old-rare-diseases.tsv reports/new-rare-diseases.tsv reports/added-rare-disases.tsv reports/removed-rare-diseases.tsv


############################################
# Create Stats based on Mondo Release Tags #
############################################

# Define directories
MONDO_STATS_REPORTS_DIR := reports/mondo_stats
TMP_MONDO_STATS_REPORTS_DIR = $(MONDO_STATS_REPORTS_DIR)/tmp
GEN_STATS_REPORTS_DIR = $(MONDO_STATS_REPORTS_DIR)/mondo-general-stats
RARE_STATS_REPORTS_DIR = $(MONDO_STATS_REPORTS_DIR)/mondo-rare-stats
SYNONYM_STATS_REPORTS_DIR = $(MONDO_STATS_REPORTS_DIR)/mondo-synonym-stats
EMC_STATS_REPORTS_DIR = $(MONDO_STATS_REPORTS_DIR)/emc-stats

# Define the most recent tag for mondo.owl (default is latest tag)
MONDO_TAG := $(shell git for-each-ref --sort=-creatordate --format '%(refname:short)' refs/tags | head -n 1)
MONDO_OWL_GH_TAG := mondo.owl

# Define the path where mondo.owl will be saved
MONDO_OWL_PATH := tmp/$(MONDO_OWL_GH_TAG)

# Define the URL to download mondo.owl from the GitHub release
MONDO_OWL_URL := https://github.com/monarch-initiative/mondo/releases/download/$(MONDO_TAG)/mondo.owl

# Define report queries
GENERAL_STATISTICS_QUERIES = \
    $(SPARQLDIR)/reports/COUNT-all_diseases.sparql \
    $(SPARQLDIR)/reports/COUNT-all_human_diseases.sparql \
    $(SPARQLDIR)/reports/COUNT-all_non-human_diseases.sparql \
    $(SPARQLDIR)/reports/COUNT-human-rare-diseases.sparql \
    $(SPARQLDIR)/reports/COUNT-human-genetic-diseases.sparql \
    $(SPARQLDIR)/reports/COUNT-human_diseases_infectious.sparql \
    $(SPARQLDIR)/reports/COUNT-human-cancer-diseases.sparql \
    $(SPARQLDIR)/reports/COUNT-non-human-genetic-diseases.sparql \
    $(SPARQLDIR)/reports/COUNT-non-human_diseases_infectious.sparql \
    $(SPARQLDIR)/reports/COUNT-non-human_diseases_cancer.sparql \
	$(SPARQLDIR)/reports/COUNT-disease_selected_xrefs.sparql \
	$(SPARQLDIR)/reports/COUNT-selected_xrefs.sparql \
	$(SPARQLDIR)/reports/COUNT-classes-with-definitions.sparql \
	$(SPARQLDIR)/reports/COUNT-xrefs.sparql \
	$(SPARQLDIR)/reports/COUNT-exact-synonyms.sparql \
	$(SPARQLDIR)/reports/COUNT-narrow-synonyms.sparql \
	$(SPARQLDIR)/reports/COUNT-broad-synonyms.sparql \
	$(SPARQLDIR)/reports/COUNT-related-synonyms.sparql

# Statistics for the Mondo Community Web site (these are a subset of the General Statistics)
ONTOLOGY_METRICS_TABLE = reports/mondo_stats/mondo-general-stats/ontology-metrics-table.md
DISEASE_TYPES_METRICS_TABLE = reports/mondo_stats/mondo-general-stats/disease-types-metrics-table.md

ontology-metrics-table: create-directories $(MONDO_OWL_PATH)
	# Creating data for the Ontology metrics table
	@echo "| Metric | Count |" > $(ONTOLOGY_METRICS_TABLE)
	@echo "| :--- | ---: |" >> $(ONTOLOGY_METRICS_TABLE)
	# Creating stats for Total diseases
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-all_diseases.sparql tmp/results.tsv
	@echo "| **Total number of diseases** | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(ONTOLOGY_METRICS_TABLE)
	# Creating stats for Xrefs
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-xrefs.sparql tmp/results.tsv
	@echo "| &nbsp;&nbsp;&nbsp;&nbsp;Database cross references | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(ONTOLOGY_METRICS_TABLE)
	# Creating stats for Definitions
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-classes-with-definitions.sparql tmp/results.tsv
	@echo "| &nbsp;&nbsp;&nbsp;&nbsp;Term definitions | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(ONTOLOGY_METRICS_TABLE)
	# Creating stats for Exact synonyms
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-exact-synonyms.sparql  tmp/results.tsv
	@echo "| &nbsp;&nbsp;&nbsp;&nbsp;Exact synonyms<sup>1</sup> | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(ONTOLOGY_METRICS_TABLE)
	# Creating stats for Narrow synonyms 
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-narrow-synonyms.sparql tmp/results.tsv
	@echo "| &nbsp;&nbsp;&nbsp;&nbsp;Narrow synonyms<sup>2</sup> | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(ONTOLOGY_METRICS_TABLE)
	# Creating stats for Broad synonyms
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-broad-synonyms.sparql tmp/results.tsv
	@echo "| &nbsp;&nbsp;&nbsp;&nbsp;Broad synonyms<sup>3</sup> | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(ONTOLOGY_METRICS_TABLE)
	# Creating stats for Related synonyms
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-related-synonyms.sparql tmp/results.tsv
	@echo "| &nbsp;&nbsp;&nbsp;&nbsp;Related synonyms<sup>4</sup> | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(ONTOLOGY_METRICS_TABLE)
	@echo "\n** Report saved to: $(ONTOLOGY_METRICS_TABLE)\n"

disease-types-metrics-table: create-directories $(MONDO_OWL_PATH)
	# Creating data for the Representation of disease types table
	@echo "| Category | Count (classes) |" > $(DISEASE_TYPES_METRICS_TABLE)
	@echo "| :--- | ---: |" >> $(DISEASE_TYPES_METRICS_TABLE)
	# Creating stats for Total diseases
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-all_diseases.sparql tmp/results.tsv
	@echo "| **Total number of diseases** | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(DISEASE_TYPES_METRICS_TABLE)
	# Creating stats for Human diseases
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-all_human_diseases.sparql tmp/results.tsv
	@echo "|&nbsp;&nbsp;&nbsp;&nbsp; **Human diseases** | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(DISEASE_TYPES_METRICS_TABLE)
	# Creating stats for Human Cancer diseases
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-human-cancer-diseases.sparql tmp/results.tsv
	@echo "|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cancer | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(DISEASE_TYPES_METRICS_TABLE)
	# Creating stats for Human Infectious diseases
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-human_diseases_infectious.sparql tmp/results.tsv
	@echo "|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Infectious | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(DISEASE_TYPES_METRICS_TABLE)
	# Creating stats for Human Mendelian diseases
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-human-genetic-diseases.sparql tmp/results.tsv
	@echo "|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mendelian | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(DISEASE_TYPES_METRICS_TABLE)
	# Creating stats for Human Rare diseases
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-human-rare-diseases.sparql tmp/results.tsv
	@echo "|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Rare | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(DISEASE_TYPES_METRICS_TABLE)
	# Creating stats for Non-Human Animal diseases
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-all_non-human_diseases.sparql tmp/results.tsv
	@echo "|&nbsp;&nbsp;&nbsp;&nbsp; **Non-human diseases** | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(DISEASE_TYPES_METRICS_TABLE)
	# Creating stats for Non-Human Animal Cancer diseases
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-non-human_diseases_cancer.sparql tmp/results.tsv
	@echo "|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cancer | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(DISEASE_TYPES_METRICS_TABLE)
	# Creating stats for Non-Human Infectious diseases
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-non-human_diseases_infectious.sparql tmp/results.tsv
	@echo "|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Infectious | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(DISEASE_TYPES_METRICS_TABLE)
	# Creating stats for Non-Human Animal Mendelian diseases
	@robot query -i $(MONDO_OWL_PATH) --use-graphs true --format tsv --query $(SPARQLDIR)/reports/COUNT-non-human-genetic-diseases.sparql tmp/results.tsv
	@echo "|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mendelian | $$(tail -n +2 tmp/results.tsv | tr -d '\r') |" >> $(DISEASE_TYPES_METRICS_TABLE)
	@echo "\n** Report saved to: $(DISEASE_TYPES_METRICS_TABLE)\n"

all-metrics-tables: ontology-metrics-table disease-types-metrics-table
	@echo "All metrics tables have been generated."

RARE_STATISTICS_QUERIES = \
    $(SPARQLDIR)/reports/COUNT-rare_subsets.sparql

SYNONYM_STATISTICS_QUERIES = \
    $(SPARQLDIR)/reports/COUNT-all_diseases_synonym_stats.sparql

EMC_STATISTICS_QUERIES = \
	$(SPARQLDIR)/reports/COUNT-emc-xrefs.sparql \
	$(SPARQLDIR)/reports/COUNT-emc-total-usage.sparql

# Define output file names
GEN_STATS_OUTPUTS = $(patsubst $(SPARQLDIR)/reports/%.sparql, $(TMP_MONDO_STATS_REPORTS_DIR)/%.tsv, $(GENERAL_STATISTICS_QUERIES))
RARE_STATS_OUTPUTS = $(patsubst $(SPARQLDIR)/reports/%.sparql, $(TMP_MONDO_STATS_REPORTS_DIR)/%.tsv, $(RARE_SATISTICS_QUERIES))
SYNONYM_STATS_OUTPUTS = $(patsubst $(SPARQLDIR)/reports/%.sparql, $(TMP_MONDO_STATS_REPORTS_DIR)/%.tsv, $(SYNONYM_STATISTICS_QUERIES))
EMC_STATS_OUTPUTS = $(patsubst $(SPARQLDIR)/reports/%.sparql, $(TMP_MONDO_STATS_REPORTS_DIR)/%.tsv, $(EMC_STATISTICS_QUERIES))

# Define output file names
GEN_STATS_OUTPUTS = $(patsubst $(SPARQLDIR)/reports/%.sparql, $(TMP_MONDO_STATS_REPORTS_DIR)/%.tsv, $(GENERAL_STATISTICS_QUERIES))
RARE_STATS_OUTPUTS = $(patsubst $(SPARQLDIR)/reports/%.sparql, $(TMP_MONDO_STATS_REPORTS_DIR)/%.tsv, $(RARE_STATISTICS_QUERIES))
SYNONYM_STATS_OUTPUTS = $(patsubst $(SPARQLDIR)/reports/%.sparql, $(TMP_MONDO_STATS_REPORTS_DIR)/%.tsv, $(SYNONYM_STATISTICS_QUERIES))

# Combined report files
COMBINED_REPORT = $(GEN_STATS_REPORTS_DIR)/mondo_general_statistics.tsv
COMBINED_RARE_REPORT = $(RARE_STATS_REPORTS_DIR)/mondo_rare_statistics.tsv
COMBINED_SYNONYM_REPORT = $(SYNONYM_STATS_REPORTS_DIR)/mondo_synonym_statistics.tsv
COMBINED_EMC_REPORT = $(EMC_STATS_REPORTS_DIR)/mondo_emc_statistics.tsv

# General stats target
create-general-mondo-stats-all: move-mondo-owl create-general-mondo-stats combine-general-stats-reports clean-temp-stats

# Rare stats target
create-rare-mondo-stats-all: move-mondo-owl create-rare-mondo-stats combine-rare-stats-reports clean-temp-stats

# Synonym stats target
create-synonym-mondo-stats-all: move-mondo-owl create-synonym-mondo-stats combine-synonym-stats-reports clean-temp-stats

# EMC stats target
create-emc-mondo-stats-all: move-mondo-owl create-emc-mondo-stats finalize-emc-stats-reports clean-temp-stats 

# Create the individual general stats
create-general-mondo-stats: $(GEN_STATS_OUTPUTS)

# Create the individual rare stats
create-rare-mondo-stats: $(RARE_STATS_OUTPUTS)

# Create the individual synonym stats
create-synonym-mondo-stats: $(SYNONYM_STATS_OUTPUTS)

# Create the individual emc stats
create-emc-mondo-stats: $(EMC_STATS_OUTPUTS)

# Reusable rule to create necessary directories
.PHONY: create-directories
create-directories:
	mkdir -p $(MONDO_STATS_REPORTS_DIR) $(GEN_STATS_REPORTS_DIR) $(RARE_STATS_REPORTS_DIR) $(SYNONYM_STATS_REPORTS_DIR) \
		$(EMC_STATS_REPORTS_DIR) $(TMP_MONDO_STATS_REPORTS_DIR)

# Rule to download mondo.owl if it doesn't exist
$(MONDO_OWL_PATH):
	wget $(MONDO_OWL_URL) -O $@
	@echo "Downloaded $(MONDO_OWL) from $(MONDO_OWL_URL) to $(MONDO_OWL_PATH)"

# Move the mondo.owl file to the desired directory
move-mondo-owl: $(MONDO_OWL_PATH)
	mv $(MONDO_OWL_PATH) ./$(MONDO_OWL_GH_TAG)

# Rule for generating .tsv files from the queries (general, rare, synonym stats)
$(TMP_MONDO_STATS_REPORTS_DIR)/%.tsv: $(SPARQLDIR)/reports/%.sparql | create-directories
	@echo "Running query $< ..."
	$(ROBOT) query -i mondo.owl --use-graphs true -f tsv --query $< $@

# Combine the general stats results into one report
combine-general-stats-reports: create-general-mondo-stats
	@echo "Combining results into $(COMBINED_REPORT)..."
	@echo "All Mondo General Statistics created on: $(current_date)" > $(COMBINED_REPORT)
	cat $(TMP_MONDO_STATS_REPORTS_DIR)/*.tsv >> $(COMBINED_REPORT)
	@echo "\n** Combined report saved to: $(COMBINED_REPORT)\n"

# Combine the rare stats results into one report
combine-rare-stats-reports: create-rare-mondo-stats
	@echo "Combining results into $(COMBINED_RARE_REPORT)..."
	@echo "All Mondo Rare Statistics created on: $(current_date)" > $(COMBINED_RARE_REPORT)
	cat $(TMP_MONDO_STATS_REPORTS_DIR)/*.tsv >> $(COMBINED_RARE_REPORT)
	@echo "\n** Combined report saved to: $(COMBINED_RARE_REPORT)\n"

# Combine the synonym stats results into one report
combine-synonym-stats-reports: create-synonym-mondo-stats
	@echo "Combining results into $(COMBINED_SYNONYM_REPORT)..."
	@echo "All Mondo Synonym Statistics created on: $(current_date)" > $(COMBINED_SYNONYM_REPORT)
	cat $(TMP_MONDO_STATS_REPORTS_DIR)/*.tsv >> $(COMBINED_SYNONYM_REPORT)
	@echo "\n** Combined report saved to: $(COMBINED_SYNONYM_REPORT)\n"

# Move the emc stats results files and tag with date created
finalize-emc-stats-reports: create-emc-mondo-stats
	@echo "Finalizing EMC reports with current date header and moving to $(EMC_STATS_REPORTS_DIR)"
	mkdir -p $(EMC_STATS_REPORTS_DIR)
	@for f in $(EMC_STATS_OUTPUTS); do \
		filename=$$(basename $$f); \
		cleanname=$$(echo $$filename | sed 's/^COUNT-//'); \
		outf="$(EMC_STATS_REPORTS_DIR)/$$cleanname"; \
		echo "All Mondo EMC Statistics created on: $(current_date)" > $$outf; \
		cat $$f >> $$outf; \
		echo "** Saved file to: $$outf"; \
	done

# Clean up the temporary .tsv files
clean-temp-stats:
	rm -f $(TMP_MONDO_STATS_REPORTS_DIR)/*.tsv
	@echo "(Cleaned up temporary result files)"

# Clean everything (temporary + reports)
clean-stats:
	rm -f $(TMP_MONDO_STATS_REPORTS_DIR)/*.tsv $(COMBINED_REPORT) $(COMBINED_RARE_REPORT) $(COMBINED_SYNONYM_REPORT)
	@echo "Cleaned all generated files."


###############################
# Create Community Statistics #
###############################

COMMUNITY_STATS_REPORTS_DIR = $(MONDO_STATS_REPORTS_DIR)/mondo-community-stats
COMMUNITY_STATS_REPORT = $(COMMUNITY_STATS_REPORTS_DIR)/gh_issue_status.csv
COMMUNITY_USER_REPORT = $(COMMUNITY_STATS_REPORTS_DIR)/gh_issue_usernames.csv

.PHONY: test-github-issue-stats
test-github-issue-stats:
	make github-issue-stats FROM_DATE=2025-03-15 TO_DATE=2025-03-18

.PHONY: github-issue-stats
github-issue-stats:
	@echo "Today's date: $$(date +%Y-%m-%d)"
	@mkdir -p $(COMMUNITY_STATS_REPORTS_DIR)
	@FROM_DATE="$(FROM_DATE)"; \
	TO_DATE="$(TO_DATE)"; \
	if [ -z "$$FROM_DATE" ] || [ -z "$$TO_DATE" ]; then \
		echo "No dates provided. Auto-detecting from git tags..."; \
		TAG_DATES=$$(git for-each-ref --sort=-creatordate --format='%(creatordate:short)' refs/tags | awk -v today="$$(date +%Y-%m-%d)" '$$1 < today' | head -n 2); \
		TO_DATE=$$(echo "$$TAG_DATES" | head -n 1); \
		FROM_DATE=$$(echo "$$TAG_DATES" | tail -n 1); \
	fi; \
	echo "From date: $$FROM_DATE"; \
	echo "To date: $$TO_DATE"; \
	echo "Report file: $(COMMUNITY_STATS_REPORT)"; \
	echo "Calculating GitHub issue metrics..."; \
	python ../scripts/gh_issues.py \
		--repo=monarch-initiative/mondo \
		--token=$(GITHUB_TOKEN) \
		--from=$$FROM_DATE \
		--to=$$TO_DATE \
		--outpath=$(COMMUNITY_STATS_REPORT) \
		--user-report=$(COMMUNITY_USER_REPORT)



#############################################
# Dump Mondo Terms for Delphi curation tool #
#############################################
.PHONY: clean_dump-mondo-terms
.PHONY: dump-mondo-terms

clean_dump-mondo-terms:
	rm -rf reports/mondo_term_dump.csv

dump-mondo-terms: clean_dump-mondo-terms mondo.owl
	$(ROBOT) query --input mondo.owl  --format csv --query $(SPARQLDIR)/reports/dump-mondo-terms.sparql reports/mondo_term_dump.csv
	@echo "** All Mondo terms extracted. See file: reports/mondo_term_dump.csv"


#############################################
##### One-time scripts ######################
#############################################
# MedGen conflicts (Aug 2023) pipeline
# - https://github.com/monarch-initiative/mondo-ingest/issues/273
.PHONY: address-medgen-conflicts-aug2023
address-medgen-conflicts-aug202x3: address-medgen-conflicts-aug2023-deletes address-medgen-conflicts-aug2023-adds

# - MedGen conflicts: dependencies
tmp/July2023_CUIReports_FromMedGentoMondo.xlsx:
	mkdir -p tmp && wget "https://github.com/monarch-initiative/mondo-ingest/files/12029712/July2023_CUIReports_FromMedGentoMondo.xlsx" -O $@

# - MedGen conflicts: analysis
tmp/mondo-edit.obo.tmp.diff: mondo-edit.obo.tmp
	-diff mondo-edit.obo mondo-edit.obo.tmp > $@

tmp/report-qc-medgen-conflicts-update-diff.tsv: tmp/mondo-edit.obo.tmp.diff
	python ../scripts/medgen_conflicts_removals_diff_analysis.py -i tmp/mondo-edit.obo.tmp.diff -o $@

tmp/report-qc-medgen-conflicts-adds-diff.tsv: $(TEMPLATES_DIR)/ROBOT_addMedGen_fromConflictResolution.tsv $(TEMPLATES_DIR)/ROBOT_addMedGen_fromIngest.tsv
	python ../scripts/medgen_conflicts_add_xrefs_diff_analysis.py -c $(TEMPLATES_DIR)/ROBOT_addMedGen_fromConflictResolution.tsv -i $(TEMPLATES_DIR)/ROBOT_addMedGen_fromIngest.tsv -o $@

# - MedGen conflicts: deletes
.PHONY: address-medgen-conflicts-aug2023-deletes
address-medgen-conflicts-aug2023-deletes: mondo-edit.obo.tmp
	mv mondo-edit.obo.tmp mondo-edit.obo

mondo-edit.obo.tmp: tmp/July2023_CUIReports_FromMedGentoMondo.xlsx mondo-edit.obo
	python ../scripts/medgen_conflicts_removals.py -i tmp/July2023_CUIReports_FromMedGentoMondo.xlsx -I mondo-edit.obo -o $@

# - MedGen conflicts: adds
.PHONY: address-medgen-conflicts-aug2023-adds
address-medgen-conflicts-aug2023-adds: tmp/report-qc-medgen-conflicts-adds-diff.tsv

$(TEMPLATES_DIR)/ROBOT_addMedGen_fromConflictResolution.tsv: tmp/July2023_CUIReports_FromMedGentoMondo.xlsx
	python ../scripts/medgen_conflicts_add_xrefs.py -i tmp/July2023_CUIReports_FromMedGentoMondo.xlsx -o $@

$(TEMPLATES_DIR)/ROBOT_addMedGen_fromIngest.tsv:
	wget "https://github.com/monarch-initiative/medgen/releases/latest/download/medgen-xrefs.robot.template.tsv" -O $@

#############################################
###### Mondo Ingest Source Versions #########
#############################################
reports/source-versions.tsv:
	wget "https://raw.githubusercontent.com/monarch-initiative/mondo-ingest/refs/heads/main/src/ontology/reports/source-versions.tsv" -O $@

######################################################
##### Mondo Ingest Update Pipelines ##################
######################################################

# 1. Rare disease pipeline
# 2. Externally managed content pipeline

MONDO_INGEST_EXTERNAL_LOCATION=https://raw.githubusercontent.com/monarch-initiative/mondo-ingest/main/src/ontology/external

DOWNLOAD_EXTERNAL=true

# All the content for this pipeline is pulled from the mondo-ingest repo

tmp/external/processed-%.robot.owl:
	mkdir -p tmp/external
	if [ $(DOWNLOAD_EXTERNAL) = true ]; then wget "$(MONDO_INGEST_EXTERNAL_LOCATION)/processed-$*.robot.owl" -O $@; fi

# This is the main pipeline to update all rare disease subsets
update-rare-disease-subset:
	$(MAKE) subset-metrics -B && cp $(TMPDIR)/subset-metrics.tsv $(TMPDIR)/subset-metrics-before.tsv
	$(MAKE) update-orphanet-rare -B
	$(MAKE) update-gard -B
	$(MAKE) update-nord -B
	$(MAKE) update-inferred-subset -B
	$(MAKE) update-rare-subset -B
	$(MAKE) subset-metrics -B && cp $(TMPDIR)/subset-metrics.tsv $(TMPDIR)/subset-metrics-after.tsv
	@echo "Subset metrics before..."
	cat $(TMPDIR)/subset-metrics-before.tsv
	@echo "Subset metrics after..."
	cat $(TMPDIR)/subset-metrics-after.tsv

# This is the main pipeline to update all externally managed content(EMC)
update-external-content:
	$(MAKE) subset-metrics -B && cp $(TMPDIR)/subset-metrics.tsv $(TMPDIR)/subset-metrics-before.tsv
	$(MAKE) update-efo-subset -B
	$(MAKE) update-clingen -B
	$(MAKE) update-ordo-subsets -B
	$(MAKE) update-omim-subsets -B
	$(MAKE) update-nando -B
	$(MAKE) update-medgen -B
	$(MAKE) update-malacards -B
	$(MAKE) update-emc-synonym-prov -B
	$(MAKE) subset-metrics -B && cp $(TMPDIR)/subset-metrics.tsv $(TMPDIR)/subset-metrics-after.tsv
	@echo "Subset metrics before..."
	cat $(TMPDIR)/subset-metrics-before.tsv
	@echo "Subset metrics after..."
	cat $(TMPDIR)/subset-metrics-after.tsv

update-emc-synonym-prov:
	$(ROBOT) merge -i $(SRC) --collapse-import-closure false \
		query --update ../sparql/update/insert_emc_synonym_provenance.ru \
		convert -f obo --check false -o $(SRC).obo && mv $(SRC).obo $(SRC)

# This is the main pipeline to update both externally managed content and rare disease subsets
update-external-content-incl-rare:
	$(MAKE) subset-metrics -B && cp $(TMPDIR)/subset-metrics.tsv $(TMPDIR)/subset-metrics-before.tsv
	$(MAKE) update-efo-subset -B
	$(MAKE) update-clingen -B
	$(MAKE) update-ordo-subsets -B
	$(MAKE) update-omim-subsets -B
	$(MAKE) update-nando -B
	$(MAKE) update-medgen -B
	$(MAKE) update-orphanet-rare -B
	$(MAKE) update-gard -B
	$(MAKE) update-nord -B
	$(MAKE) update-inferred-subset -B
	$(MAKE) update-rare-subset -B
	$(MAKE) subset-metrics -B && cp $(TMPDIR)/subset-metrics.tsv $(TMPDIR)/subset-metrics-after.tsv
	@echo "Subset metrics before..."
	cat $(TMPDIR)/subset-metrics-before.tsv
	@echo "Subset metrics after..."
	cat $(TMPDIR)/subset-metrics-after.tsv

######################################################
##### Mondo Rare Disease Pipeline ####################
######################################################

##### Orphanet Rare ################

$(TMPDIR)/orphanet-rare-subset.owl: $(SRC)
	$(ROBOT) merge -i $(SRC) reason \
		query --format ttl --query ../sparql/construct/construct-orphanet-rare-subset.sparql $@

.PHONY: update-orphanet-rare
update-orphanet-rare:
	$(MAKE) $(TMPDIR)/orphanet-rare-subset.owl
	grep -vE '^(subset: orphanet_rare)' $(SRC) > $(TMPDIR)/mondo-edit.tmp || true
	mv $(TMPDIR)/mondo-edit.tmp mondo-edit.obo
	$(ROBOT) merge -i $(SRC) -i $(TMPDIR)/orphanet-rare-subset.owl --collapse-import-closure false convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC) && make NORM && mv NORM $(SRC)

##### GARD #########################

# The complex part here is that we need to dynamically update the MONDO source code, i.e. 
# MONDO:equivalentTo and MONDO:obsoleteEquivalentTo.

.PHONY: update-gard
update-gard:
	$(MAKE) $(TMPDIR)/external/processed-gard.robot.owl
	grep -vE '^(xref: GARD:|subset: gard_rare)' $(SRC) > $(TMPDIR)/mondo-edit.tmp || true
	mv $(TMPDIR)/mondo-edit.tmp mondo-edit.obo
	$(ROBOT) merge -i $(SRC) -i $(TMPDIR)/external/processed-gard.robot.owl --collapse-import-closure false \
		query --update ../sparql/update/insert-gard-obsoletion-status.ru \
		convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC) && make NORM && mv NORM $(SRC) && make deprecated_annotation_merging && make NORM && mv NORM $(SRC)

##### NORD #########################

.PHONY: update-nord
update-nord:
	make $(TMPDIR)/external/processed-nord.robot.owl -B
	grep -vE '^(xref: NORD:|subset: nord_rare)' $(SRC) > $(TMPDIR)/mondo-edit.tmp || true
	mv $(TMPDIR)/mondo-edit.tmp mondo-edit.obo
	$(ROBOT) merge -i $(SRC) -i $(TMPDIR)/external/processed-nord.robot.owl --collapse-import-closure false \
		convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC) && make NORM && mv NORM $(SRC)

##### Inferred #####################

# The inferred subset depends on the other ones, so we need to first remove the old subsets
# Then add the gard, nord and orphanet subsets back in
$(TMPDIR)/inferred-rare-subset.owl: $(SRC)
	$(ROBOT) merge -i $(SRC) \
		reason \
		query --format ttl --query ../sparql/construct/construct-inferred-rare-subset.sparql $@

update-inferred-subset:
	$(MAKE) $(TMPDIR)/inferred-rare-subset.owl
	grep -vE '^(subset: inferred_rare)' $(SRC) > $(TMPDIR)/mondo-edit.tmp || true
	mv $(TMPDIR)/mondo-edit.tmp mondo-edit.obo
	$(ROBOT) merge -i $(SRC) -i $(TMPDIR)/inferred-rare-subset.owl --collapse-import-closure false convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC) && make NORM && mv NORM $(SRC)

##### RARE #########################

tmp/rare-subset.owl: $(SRC)
	$(ROBOT) merge -i $(SRC) \
		query --format ttl --query ../sparql/construct/construct-rare-subset.sparql $@

.PHONY: update-rare-subset
update-rare-subset:
	$(MAKE) $(TMPDIR)/rare-subset.owl
	grep -vE '^(subset: rare)$$' $(SRC) > $(TMPDIR)/mondo-edit.tmp || true
	mv $(TMPDIR)/mondo-edit.tmp mondo-edit.obo
	$(ROBOT) merge -i $(SRC) -i $(TMPDIR)/rare-subset.owl --collapse-import-closure false convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC) && make NORM && mv NORM $(SRC)


######################################################
##### Mondo Externally Managed Content Pipeline ######
######################################################

####################################
##### OMIM #####################
####################################

$(TMPDIR)/keep-susceptibility-gene-assocation-axioms.owl: $(SRC)
	$(MAKE) report-query-omim-susceptibilities
	sed -i 's/"//g' reports/report-omim-susceptibilities.tsv
	$(ROBOT) filter --input $(SRC) \
		-T reports/report-omim-susceptibilities.tsv \
		--trim false \
		filter \
		--term RO:0004003 \
		--axioms SubClassOf \
		--trim false \
		-o $@

$(TMPDIR)/mondo-genes-axioms.owl: $(SRC)
	$(ROBOT) filter --input $(SRC) \
		--term RO:0004003 \
		--axioms SubClassOf \
		--preserve-structure false \
		--trim false \
		--drop-axiom-annotations "oboInOwl:source=~'(OMIM):.*'" \
		-o $@

.PHONY: update-omim-genes
update-omim-genes:
	$(MAKE) $(TMPDIR)/external/processed-mondo-omim-genes.robot.owl \
	$(TMPDIR)/keep-susceptibility-gene-assocation-axioms.owl \
	$(TMPDIR)/mondo-genes-axioms.owl -B
	# We need to be less aggressive here, as some gene relations were not originally sourced
	# from OMIM, and were added, for example, for ClinGen.
	$(ROBOT) remove -i $(SRC) --term RO:0004003 --axioms SubClassOf --preserve-structure false --trim true \
		merge -i $(TMPDIR)/external/processed-mondo-omim-genes.robot.owl \
		-i $(TMPDIR)/mondo-genes-axioms.owl \
		-i $(TMPDIR)/keep-susceptibility-gene-assocation-axioms.owl \
		--collapse-import-closure false \
		query --update ../sparql/update/omim-gene-equivalence.ru \
		query --update ../sparql/update/remove_gene_associations_from_obsolete.ru \
		convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC) && make NORM && mv NORM $(SRC)

.PHONY: update-omim-subsets
update-omim-subsets:
	$(MAKE) $(TMPDIR)/external/processed-mondo-omim-susceptibility-subset.robot.owl -B
	grep -vE '^(subset: omim_susceptibility)' $(SRC) > $(TMPDIR)/mondo-edit.tmp || true
	mv $(TMPDIR)/mondo-edit.tmp $(SRC)
	$(ROBOT) merge -i $(SRC) -i $(TMPDIR)/external/processed-mondo-omim-susceptibility-subset.robot.owl --collapse-import-closure false convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC) && make NORM && mv NORM $(SRC)


####################################
##### Orphanet #####################
####################################

.PHONY: update-ordo-subsets
update-ordo-subsets:
	$(MAKE) $(TMPDIR)/external/processed-ordo-subsets.robot.owl -B
	grep -vE '^(subset: ordo_group_of_disorders)' $(SRC) | grep -vE '^(subset: ordo_disorder)' | grep -vE '^(subset: ordo_subtype_of_a_disorder)' > $(TMPDIR)/mondo-edit.tmp || true
	mv $(TMPDIR)/mondo-edit.tmp $(SRC)
	$(ROBOT) merge -i $(SRC) -i $(TMPDIR)/external/processed-ordo-subsets.robot.owl --collapse-import-closure false convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC) && make NORM && mv NORM $(SRC)
	
####################################
##### MalaCards #####################
####################################

.PHONY: update-malacards
update-malacards:
	$(MAKE) $(TMPDIR)/external/processed-mondo-malacards.robot.owl -B
	grep -vE '^(relationship: curated_content_resource.*MalaCards)' $(SRC) > $(TMPDIR)/mondo-edit.tmp || true
	mv $(TMPDIR)/mondo-edit.tmp $(SRC)
	$(ROBOT) merge -i $(SRC) -i $(TMPDIR)/external/processed-mondo-malacards.robot.owl --collapse-import-closure false -o $(SRC).obo
	mv $(SRC).obo $(SRC) && make NORM && mv NORM $(SRC)

####################################
##### NANDO #########################
####################################

.PHONY: update-nando
update-nando:
	$(MAKE) $(TMPDIR)/external/processed-nando-mappings.robot.owl -B
	grep -vE '^(xref: NANDO:)' $(SRC) > $(TMPDIR)/mondo-edit.tmp || true
	mv $(TMPDIR)/mondo-edit.tmp $(SRC)
	$(ROBOT) merge -i $(SRC) -i $(TMPDIR)/external/processed-nando-mappings.robot.owl --collapse-import-closure false convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC) && make NORM && mv NORM $(SRC)

####################################
##### CLINGEN ######################
####################################

.PHONY: update-clingen
update-clingen:
	$(MAKE) $(TMPDIR)/external/processed-mondo-clingen.robot.owl
	grep -vE '^(relationship: curated_content_resource https://search.clinicalgenome.org|subset: clingen)' $(SRC) > $(TMPDIR)/mondo-edit.tmp
	#CAREFUL, this needs to be uncommented when we import CLINGEN LABELs as EMC
	#sed -i 's#OMO:0002001="https://w3id\.org/information-resource-registry/clingen"##g' "$TMPDIR/mondo-edit.tmp" || true
	# The next line is needed because an empty metadata record is illegal OBO syntax
	#sed -i 's#[{][}]##g' "$TMPDIR/mondo-edit.tmp" || true
	mv $(TMPDIR)/mondo-edit.tmp $(SRC)
	$(ROBOT) merge -i $(SRC) -i $(TMPDIR)/external/processed-mondo-clingen.robot.owl --collapse-import-closure false convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC) && make NORM && mv NORM $(SRC)

####################################
##### EFO ##########################
####################################

.PHONY: update-efo-subset
update-efo-subset:
	$(MAKE) $(TMPDIR)/external/processed-mondo-otar-subset.robot.owl $(TMPDIR)/external/processed-mondo-efo.robot.owl
	grep -vE '^(xref: EFO:|subset: otar)' $(SRC) > tmp/mondo-edit.tmp || true
	mv $(TMPDIR)/mondo-edit.tmp mondo-edit.obo
	$(ROBOT) merge -i $(SRC) -i $(TMPDIR)/external/processed-mondo-otar-subset.robot.owl -i $(TMPDIR)/external/processed-mondo-efo.robot.owl --collapse-import-closure false \
		query --use-graphs false --update ../sparql/update/update-equivalent-obsolete.ru \
		convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC) && make NORM && mv NORM $(SRC)

####################################
##### MedGen #######################
####################################

.PHONY: update-medgen
update-medgen:
	$(MAKE) $(TMPDIR)/external/processed-mondo-medgen.robot.owl
	grep -vE '^(xref: UMLS:|xref: MEDGEN:|subset: medgen)' $(SRC) > $(TMPDIR)/mondo-edit.tmp || true
	mv $(TMPDIR)/mondo-edit.tmp mondo-edit.obo
	$(ROBOT) merge -i $(SRC) -i $(TMPDIR)/external/processed-mondo-medgen.robot.owl --collapse-import-closure false \
		query --use-graphs false --update ../sparql/update/update-equivalent-obsolete.ru \
		convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC) && make NORM && mv NORM $(SRC) 


.PHONY: subset-metrics
subset-metrics:
	$(ROBOT) query -f tsv -i $(SRC) --query $(SPARQLDIR)/reports/count-subsets.sparql $(TMPDIR)/$@.tsv

.PHONY: update-omim-genes
rm-excluded-asserted:
	$(ROBOT) merge -i $(SRC) --collapse-import-closure false \
		query --update ../sparql/update/rm-excluded-subclassof.ru \
		convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC) && make NORM && mv NORM $(SRC)

#############################################
##### Mondo analysis ########################
#############################################

# Makefile for mondo analysis

#all: sources

## SOURCES
## TODO: NOTE THE MONDO SOURCE BUNDLED HERE IS THE LATEST RELEASE, (i.e. does not trigger a release run)
## THIS is to enable fair comparison with the other sources and issues with syncronisation

SOURCE_VERSION = $(TODAY)
# snomed
SOURCE_IDS = doid ncit ordo omim
SOURCE_IDS_INCL_MONDO = $(SOURCE_IDS) mondo equivalencies
ALL_SOURCES_JSON = $(patsubst %, sources/$(SOURCE_VERSION)/%.json, $(SOURCE_IDS_INCL_MONDO))
ALL_SOURCES_JSON_GZ = $(patsubst %, sources/$(SOURCE_VERSION)/%.json.gz, $(SOURCE_IDS_INCL_MONDO))
ALL_SOURCES_OWL_GZ = $(patsubst %, sources/$(SOURCE_VERSION)/%.owl.gz, $(SOURCE_IDS_INCL_MONDO))
ALL_SOURCES_OWL = $(patsubst %, sources/$(SOURCE_VERSION)/%.owl, $(SOURCE_IDS_INCL_MONDO))


sources: $(ALL_SOURCES_JSON) $(ALL_SOURCES_OWL) $(ALL_SOURCES_JSON_GZ) $(ALL_SOURCES_OWL_GZ)

.PHONY: source_release_dir
source_release_dir:
	mkdir -p sources/$(SOURCE_VERSION)

sources/$(SOURCE_VERSION)/%.gz: sources/$(SOURCE_VERSION)/% | source_release_dir
	gzip -c $< > $@

sources/$(SOURCE_VERSION)/%.json: sources/$(SOURCE_VERSION)/%.owl
	robot merge -i $< convert -f json -o $@

## The following goals covers NCIT, DOID, and MONDO
sources/$(SOURCE_VERSION)/%.owl: | source_release_dir
	robot merge -I $(OBO)/$*.owl -o $@

sources/$(SOURCE_VERSION)/omim.owl: build-omim | source_release_dir
	robot merge -i sources/omim/omim.owl -o $@

# build-medgen
sources/$(SOURCE_VERSION)/medgen.owl: | source_release_dir
	echo "WARNING: MEDGEN IS CURRENTLY NOT BEING UPDATED, BECAUSE OF "
	robot merge -i sources/medgen/medgen-disease-extract.owl -o $@

sources/$(SOURCE_VERSION)/ordo.owl: build-orphanet | source_release_dir
	robot merge -i sources/orphanet/ordo_orphanet.owl -o $@

sources/$(SOURCE_VERSION)/equivalencies.owl: | source_release_dir
	curl -L -s $(OBO)/mondo/imports/equivalencies.owl > $@.tmp && mv $@.tmp $@

#sources/CTD_diseases.obo:
#	curl -L -s http://ctdbase.org/reports/CTD_diseases.obo.gz  | gzip -dc | perl -npe 's@alt_id@xref@' > $@.tmp && mv $@.tmp $@

reports/gard-mondo-mapped-obsoletes.tsv: $(ONT).owl
	$(ROBOT) query -i $(ONT).owl -f tsv --query $(SPARQLDIR)/reports/gard-mondo-mapped-obsoletes.sparql $@

##################################################
################## Old diseases2owl code #########


#### Download and preprocess upstream Mondo sources.
# MONDO_SOURCES = omim medgen medic orphanet
#MONDO_SOURCES_WITH_SPECIAL_PREPROCESSING = omim medgen orphanet
#all: build_sources
#	$(ROBOT) query -f tsv --use-graphs false -i $(SRC) --query $(SPARQLDIR)/reports/related-exact-synonym-report.sparql reports/related-exact-synonym-report.tsv
#.PHONY: release_dir

#build_sources: $(patsubst %, build-%, $(MONDO_SOURCES))
.PHONY: build-%
build-%:
	cd sources/$* && make all -B

#### Some useful ROBOT queries:
# $(ROBOT) query -f tsv --use-graphs false -i $(SRC) --query $(SPARQLDIR)/excluded-subsumption-is-inferred-violation.sparql reports/excluded-subsumption-is-inferred-violation.tsv
# $(ROBOT) query -i $(SRC) --update $(SPARQLDIR)/update/excluded-subsumption-is-inferred-tags.sparql -o $(SRC)
# $(ROBOT) query -f tsv --use-graphs false -i $(SRC) --query $(SPARQLDIR)/related-exact-synonym-report.sparql reports/related-exact-synonym-report.tsv
# $(ROBOT) query -f tsv --use-graphs false -i $(SRC) --query $(SPARQLDIR)/related-exact-synonym-reportz.sparql reports/related-exact-synonym-report.tsv

patterns: matches pattern_docs
	make components/mondo-tags.owl

components:
	$(MAKE) patterns

reports/robot_diff.md: mondo.obo mondo-lastbuild.obo
	$(ROBOT) diff --left mondo-lastbuild.obo --right $< -f markdown -o $@

tmp/mondo-lastbase.owl:
	mkdir -p tmp && wget "http://purl.obolibrary.org/obo/mondo/mondo-base.owl" -O $@

reports/mondo_diff.md: mondo-base.owl tmp/mondo-lastbase.owl
	$(ROBOT) diff --left tmp/mondo-lastbase.owl --right $< -f markdown -o $@

tmp/mondo-main-edit.owl:
	wget "https://raw.githubusercontent.com/monarch-initiative/mondo/refs/heads/master/src/ontology/mondo-edit.obo" -O $@

reports/mondo_branch_edit_diff.md: mondo-edit.obo tmp/mondo-main-edit.owl
	$(ROBOT) diff --left tmp/mondo-main-edit.owl --right $< -f markdown -o $@

reports/mondo_unsats.md: mondo-edit.obo
	$(ROBOT) explain -i $< -M unsatisfiability --unsatisfiable random:10 --explanation $@

.PHONY: mondo_branch_diff reports/mondo_branch_edit_diff.md reports/mondo_unsats.md tmp/mondo-main-edit.owl
mondo_branch_diff: reports/mondo_branch_edit_diff.md reports/mondo_unsats.md
	@echo "** Process is complete. See report files at: reports/mondo_branch_edit_diff.md and reports/mondo_unsats.md"

.PHONY: mondo_feature_diff
mondo_feature_diff: reports/robot_diff.md reports/mondo_unsats.md

.PHONY: mondo_feature_diff
related_annos_to_exact:
	$(ROBOT) query --use-graphs false -i $(SRC) --update $(SPARQLDIR)/related-exact-synonym-annotations.ru -o $(SRC)

related_to_exact_where_label:
	$(ROBOT) query --use-graphs false -i $(SRC) --update $(SPARQLDIR)/update/rm-related-where-label.ru -o $(SRC)


rm_related_annos_to_exact:
	$(ROBOT) query --use-graphs false -i $(SRC) --update $(SPARQLDIR)/rm-related-exact-synonym-annotations.ru -o $(SRC)

rm_xref_without_source:
	$(ROBOT) query --use-graphs false -i $(SRC) --update $(SPARQLDIR)/update/rm-xref-without-source.ru -o $(SRC)

rm_confidence_annotation:
	$(ROBOT) query --use-graphs false -i $(SRC) --update $(SPARQLDIR)/update/rm-confidence_annotation.ru -o $(SRC)

add_redundant_subclass_annotations:
	$(ROBOT) query --use-graphs false -i $(SRC) --update $(SPARQLDIR)/update/add-flag-redundant-subclass-axioms.ru -o $(SRC)

remove_redundant_subclass_annotations:
	$(ROBOT) query --use-graphs false -i $(SRC) --update $(SPARQLDIR)/update/rm-redundant-subclass-axioms.ru -o $(SRC)


report-query-%:
	$(ROBOT) query --use-graphs true -i $(SRC) -f tsv --query $(SPARQLDIR)/reports/$*.sparql reports/report-$*.tsv

report-base-query-%: mondo-base.owl
	$(ROBOT) query --use-graphs true -i mondo-base.owl -f tsv --query $(SPARQLDIR)/reports/$*.sparql reports/report-base-$*.tsv

report-reason-query-%:
	$(ROBOT) reason -i $(SRC) query --use-graphs true  -f tsv --query $(SPARQLDIR)/reports/$*.sparql reports/report-reason-$*.tsv

report-reason-materialise-query-%:
	$(ROBOT) reason -i $(SRC) materialize --term RO:0002573 \
		query --use-graphs true  -f tsv --query $(SPARQLDIR)/reports/$*.sparql reports/report-reason-materialise-$*.tsv

#report-owl-query-%:
#	$(ROBOT) query --use-graphs true -I http://purl.obolibrary.org/obo/mondo/mondo-with-equivalents.owl -f tsv --query $(SPARQLDIR)/reports/$*.sparql reports/report-$*.tsv

tmp/mondo-rdfxml.owl:
	$(ROBOT) remove -i $(SRC) --select imports convert -f owl -o $@

report-tbd-query-%: tmp/mondo-rdfxml.owl
	$(ROBOT) query --use-graphs true -i $< -f tsv --tdb true --query $(SPARQLDIR)/reports/$*.sparql reports/report-$*.tsv

update-query-%:
	$(ROBOT) query --use-graphs true -i $(SRC) --update $(SPARQLDIR)/update/$*.ru convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC)
	make NORM
	mv NORM $(SRC)

construct-query-%:
	$(ROBOT) query --use-graphs true -i $(SRC) --query $(SPARQLDIR)/update/$*.ru tmp/construct-$*.ttl

construct-merge-query-%: construct-query-%
	$(ROBOT) merge -i $(SRC) -i tmp/construct-$*.ttl --collapse-import-closure false convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC)
	make NORM
	mv NORM $(SRC)

construct-unmerge-query-%: construct-query-%
	$(ROBOT) unmerge -i $(SRC) -i tmp/construct-$*.ttl convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC)
	make NORM
	mv NORM $(SRC)

TMP_TEMPLATE_URL="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ8cszVqBNOeClD6uFif3QRHn0Ud_Cyt_gylyTTFJ-RoJaOwNWS7Qv3c516bJoTBaKT1WLagSQ7CQqS/pub?gid=0&single=true&output=tsv"
TMP_TEMPLATE_FILE=tmp/temporary.tsv
TMP_TEMPLATE_OWL=tmp/temporary.owl

temporary_template:
	wget "$(TMP_TEMPLATE_URL)" -O $(TMP_TEMPLATE_FILE)
	robot template --template $(TMP_TEMPLATE_FILE) -o $(TMP_TEMPLATE_OWL)

UNMERGE_FILE=$(TMP_TEMPLATE_OWL)
unmerge:
	$(ROBOT) convert -i $(UNMERGE_FILE) -f ofn -o tmp/unmerge.owl
	sed -i '/^Declaration[(]/d' tmp/unmerge.owl
	$(ROBOT) unmerge -i mondo-edit.obo -i tmp/unmerge.owl convert -f obo -o tmp/mondo-edit.obo
	mv tmp/mondo-edit.obo mondo-edit.obo
	make NORM
	mv NORM mondo-edit.obo



# This first merges a the result of a construct query to mondo-edit, than unmerges another
construct-remerge-query-%: construct-query-% construct-query-%-new
	$(ROBOT) merge -i $(SRC) -i tmp/construct-$*-new.ttl --collapse-import-closure false \
		unmerge -i tmp/construct-$*.ttl \
		convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC)
	make NORM
	mv NORM $(SRC)

fix-disorder-names:
	make construct-unmerge-query-construct-disorders-conformsTo-location-label
	make construct-merge-query-construct-disorders-conformsTo-location-newlabel


update-merge-normalise-%: update-query-%
	mv $(SRC).obo $(SRC)
	make NORM
	mv NORM $(SRC)


.PHONY: r2e
r2e:
	make related_annos_to_exact
	make NORM
	mv NORM mondo-edit.obo

GH_ISSUE=none
OBS_REASON=outOfScope

.PRECIOUS: config/obsolete_me.txt
.PRECIOUS: config/filtered_obsolete_me.txt

mass_obsolete:
	perl ../scripts/obo-obsoletify.pl --seeAlso https://github.com/monarch-initiative/mondo/issues/$(GH_ISSUE) --obsoletionReason MONDO:$(OBS_REASON)  -i ../scripts/obsolete_me.txt mondo-edit.obo > OBSOLETE && mv OBSOLETE mondo-edit.obo

tmp/mass_obsolete.sparql: ../sparql/reports/mondo-obsolete-simple.sparql config/filtered_obsolete_me.txt
	@echo "\n** Run mondo-obsolete-simple.sparql **"
	LISTT="$(shell paste -sd" " config/filtered_obsolete_me.txt)"; sed "s/MONDO:0000000/$$LISTT/g" $< > $@

tmp/mondo-rename-effected-classes.ru: ../sparql/reports/mondo-rename-effected-classes.ru config/filtered_obsolete_me.txt
	@echo "\n** Run mondo-rename-effected-classes.ru **"
	LISTT="$(shell paste -sd" " config/filtered_obsolete_me.txt)"; sed "s/MONDO:0000000/$$LISTT/g" $< > $@

tmp/mass_obsolete_warning.sparql: ../sparql/reports/mondo-obsolete-warning.sparql config/filtered_obsolete_me.txt
	@echo "\n** Run mondo-obsolete-warning.sparql **"
	LISTT="$(shell paste -sd" " config/filtered_obsolete_me.txt)"; sed "s/MONDO:0000000/$$LISTT/g" $< > $@

tmp/mass_obsolete.ru: ../sparql/update/mondo-obsolete-simple.ru config/filtered_obsolete_me.txt
	@echo "\n** Run mondo-obsolete-simple.ru **"
	# Create input for query
	LISTT="$(shell paste -sd" " config/filtered_obsolete_me.txt)"; \
	sed -e "s/MONDO:0000000/$$LISTT/g" -e "s|GITHUB_ISSUE_URL|$(GITHUB_ISSUE_URL)|g" $< > $@


config/filtered_obsolete_me.txt: tmp/identify_existing_obsoletes.txt config/obsolete_me.txt
	# Remove ^M from tmp/identify_existing_obsoletes.txt
	sed 's/\r//g' tmp/identify_existing_obsoletes.txt > tmp/filtered_identify_existing_obsoletes.txt

	# Filter out existing obsoletes
	grep -v -w -i -f tmp/filtered_identify_existing_obsoletes.txt config/obsolete_me.txt > $@


tmp/mass_obsolete_me.txt: tmp/mass_obsolete.sparql
	$(ROBOT) query -i $(SRC) --use-graphs true -f tsv --query $< $@
	sed -i 's/[?]//g' $@
	sed -i 's/<http:[/][/]purl[.]obolibrary[.]org[/]obo[/]MONDO_/MONDO:/g' $@
	sed -i 's/>//g' $@

.PHONY: mass_obsolete_warning
mass_obsolete_warning: tmp/mass_obsolete_warning.sparql
	$(ROBOT) verify -i $(SRC) --queries $< --output-dir reports/

tmp/identify_existing_obsoletes.ru: ../sparql/reports/check_obsoletes_from_list.ru config/obsolete_me.txt
	@echo "\n** Identify existing obsoletes in config/obsolete_me.txt **"
	LISTT="$(shell paste -sd" " config/obsolete_me.txt)"; sed "s/MONDO:0000000/$$LISTT/g" $< > $@

tmp/identify_existing_obsoletes.txt: tmp/identify_existing_obsoletes.ru
	@echo "\n** Write existing obsoletes to tmp/identify_existing_obsoletes.txt **"
	$(ROBOT) query --format txt -i $(SRC) --query $< $@

mass_obsolete2: tmp/mass_obsolete.ru tmp/mass_obsolete_me.txt
	@echo "Make sure you have updated config/obsolete_me.txt before running this script.."
	$(MAKE) tmp/mondo-obsolete-labels.obo
	$(MAKE) mass_obsolete_warning
	@echo "** Check above for violations\n"
	$(ROBOT) query -i $(SRC) --use-graphs true --update tmp/mass_obsolete.ru \
		remove --preserve-structure false -T tmp/mass_obsolete_me.txt --axioms logical convert -f obo --check false -o $(SRC).obo
	mv $(SRC).obo $(SRC)
	$(MAKE) NORM
	mv NORM $(SRC)

tmp/mondo-obsolete-labels.obo: tmp/mondo-rename-effected-classes.ru
	@echo "\n** Re-name obsolete class labels **"
	$(ROBOT) merge -i $(SRC) --collapse-import-closure false query --update tmp/mondo-rename-effected-classes.ru  \
		convert -f obo --check false -o $@



MAPPINGSDIR=mappings
METADATADIR=metadata
MAPPING_IDS=mondo
ALL_MAPPINGS=$(patsubst %, $(MAPPINGSDIR)/%.sssom.tsv, $(MAPPING_IDS))

tmp/mirror-ordo.json: mirror/ordo.obo
	robot merge -i mirror/ordo.obo convert -f json -o $@

tmp/mirror-omim.json: mirror/omim.obo
	robot merge -i mirror/omim.obo convert -f json -o $@

tmp/mirror-mondo.json: mondo.owl
	robot merge -i mondo.owl convert -f json -o $@

tmp/mirror-efo.json: #mirror/efo.owl
	robot merge -i mirror/efo.owl convert -f json -o $@

.PHONY: sssom
sssom:
	python3 -m pip install --upgrade pip setuptools && python3 -m pip install --upgrade --force-reinstall sssom==0.4.0

.PHONY: oaklib
oaklib:
	python3 -m pip install --upgrade pip setuptools && python3 -m pip install --upgrade --force-reinstall oaklib

tmp/%.sssom.tsv: tmp/mirror-%.json
	sssom parse tmp/mirror-$*.json --no-strict-clean-prefixes -I obographs-json -m $(METADATADIR)/mondo.sssom.config.yml -C merged -o $@


$(MAPPINGSDIR)/mondo.sssom.tsv: tmp/mondo.sssom.tsv tmp/mondo-ingest.db
	python ../scripts/add_object_label.py run $<
	python ../scripts/split_sssom_by_source.py -s $< -m $(METADATADIR)/mondo.sssom.config.yml -o $(MAPPINGSDIR)/
	sssom dosql -Q "SELECT * FROM df WHERE predicate_id IN (\"skos:exactMatch\", \"skos:broadMatch\")" $< -o $@
	sssom annotate $@ -o $@ --mapping_set_id "http://purl.obolibrary.org/obo/mondo/mappings/mondo.sssom.tsv"
	sssom sort $@ -o $@
	sssom validate $@

#$(MAPPINGSDIR)/%.sssom.tsv: tmp/mirror-%.json
#	sssom convert -i $< -o $@
#	#python ../scripts/split_sssom_by_source.py $@

.PHONY: clean_mappings
.PHONY: mappings mappings_fast

clean_mappings:
	rm -rf $(MAPPINGSDIR)/*.sssom.tsv

mappings: clean_mappings $(ALL_MAPPINGS)

mappings_fast:
	$(MAKE) sssom -B
	$(MAKE) clean_mappings -B
	$(MAKE) mappings IMP=false MIR=false PAT=false -B

###### OMIM Genes #########

tmp/omim.owl:
	$(ROBOT) merge -I "https://github.com/monarch-initiative/omim/releases/latest/download/omim.owl" convert -o $@

tmp/omim-genes.tsv: tmp/omim.owl
	$(ROBOT) query --use-graphs true -i tmp/omim.owl -f tsv --tdb true --query $(SPARQLDIR)/reports/omim-genes.sparql $@
	sed -i 's/[?]//g' $@
	sed -i 's/[<]https[:][/][/]omim[.]org[/]entry[/]/OMIM:/g' $@
	sed -i 's/>//g' $@
	tail -n +2 $@ > output_file && mv output_file $@

# Check for occurrences of OMIM genes in MONDO,
# Then narrow down to only xrefs
tmp/omim-gene-matches.txt: tmp/omim-genes.tsv
	grep -Ff $< mondo-edit.obo | grep '^xref' > $@ || true
	if [ -s $@ ]; then \
		echo "FAIL: OMIM gene entry used in xref (matches found in $@)"; \
		exit 1; \
	fi

test: tmp/omim-gene-matches.txt

##### RELEASE Report ######

reports/mondo_base_current_%.tsv: mondo-base.owl
	$(ROBOT) query --use-graphs true -i mondo-base.owl -f tsv --tdb true --query $(SPARQLDIR)/reports/$*.sparql $@

reports/mondo_base_last_%.tsv: tmp/mondo-lastbase.owl
	$(ROBOT) query --use-graphs true -i tmp/mondo-lastbase.owl -f tsv --tdb true --query $(SPARQLDIR)/reports/$*.sparql $@

tmp/mondo-versioned-base.owl:
	$(ROBOT) convert -I http://purl.obolibrary.org/obo/mondo/releases/$(COMPARE_VERSION)/mondo-base.owl -f owl -o $@

reports/mondo_base_version_%.tsv: tmp/mondo-versioned-base.owl
	$(ROBOT) query --use-graphs true -i tmp/mondo-versioned-base.owl -f tsv --tdb true --query $(SPARQLDIR)/reports/$*.sparql $@

reports/mondo_release_diff.md reports/mondo_release_diff_changed_terms.tsv reports/mondo_release_diff_new_terms.tsv: reports/mondo_base_last_release-report.tsv reports/mondo_base_current_release-report.tsv reports/mondo_obsoletioncandidates.tsv
	python ../scripts/merge_release_diff.py reports/mondo_base_last_release-report.tsv reports/mondo_base_current_release-report.tsv reports/mondo_obsoletioncandidates.tsv reports/mondo_release_diff_changed_terms.tsv reports/mondo_release_diff_new_terms.tsv > reports/mondo_release_diff.md
	sed -i 's/  */ /g' reports/mondo_release_diff.md
	sed -i 's/----*/---/g' reports/mondo_release_diff.md
	sed -i 's/----*/---/g' reports/mondo_release_diff.md

version_diff: reports/mondo_base_version_release-report.tsv reports/mondo_base_current_release-report.tsv reports/mondo_obsoletioncandidates.tsv
	python ../scripts/merge_release_diff.py reports/mondo_base_last_release-report.tsv reports/mondo_base_current_release-report.tsv reports/mondo_obsoletioncandidates.tsv reports/mondo_release_diff_changed_terms_version.tsv reports/mondo_release_diff_new_terms_version.tsv > reports/mondo_release_diff_version.md
	sed -i 's/  */ /g' reports/mondo_release_diff_version.md
	sed -i 's/----*/---/g' reports/mondo_release_diff_version.md
	sed -i 's/----*/---/g' reports/mondo_release_diff_version.md


reports/mondo_obsoletioncandidates.tsv: report-base-query-obsoletioncandidates-withcomment
	cp reports/report-base-obsoletioncandidates-withcomment.tsv $@
	sed -i 's/[?]//g' $@
	sed -i 's/<http:[/][/]purl[.]obolibrary[.]org[/]obo[/]MONDO_/MONDO:/g' $@
	sed -i 's/>//g' $@

release_diff: reports/mondo_release_diff.md
all: reports/mondo_release_diff.md
all: reports/mondo_obsoletioncandidates.tsv

##################
### KGCL Diff ####
##################

KGCL_ONTOLOGY=mondo-base.obo

all: kgcl-diff

.PHONY: kgcl-diff
kgcl-diff: kgcl-diff-release-base

.PHONY: kgcl-diff-release-base
kgcl-diff-release-base: reports/difference_release_base.yaml \
						reports/difference_release_base.tsv \
						reports/difference_release_base.md

tmp/mondo-released.obo: .FORCE
	wget http://purl.obolibrary.org/obo/mondo/mondo-base.obo -O $@

reports/difference_release_base.md: tmp/mondo-released.obo $(KGCL_ONTOLOGY)
	runoak -i simpleobo:tmp/mondo-released.obo diff -X simpleobo:$(KGCL_ONTOLOGY) -o $@ --output-type md

reports/difference_release_base.tsv: tmp/mondo-released.obo $(KGCL_ONTOLOGY)
	runoak -i simpleobo:tmp/mondo-released.obo diff -X simpleobo:$(KGCL_ONTOLOGY) \
	-o $@ --output-type csv --statistics --group-by-property oio:hasOBONamespace

reports/difference_release_base.yaml: tmp/mondo-released.obo $(KGCL_ONTOLOGY)
	runoak -i simpleobo:tmp/mondo-released.obo diff -X simpleobo:$(KGCL_ONTOLOGY) -o $@ --output-type yaml

###########################
## MONDO VIEW GENERATION ##
###########################

# 1. In a ROBOT template, define a top level as you see fit (using, however, MONDO ids)
# 2. Make sure the template file ends up in modules, and is named like modules/harrisons-view.tsv, where harrisons is the id
# 3. Add the id to the MONDOVIEWS variable
# 4. Run `sh run.sh make mondo-views` to generate all views, including your new one.
# This will:
#     a) build the template (modules/mondo-%-view-top.owl)
#     b) query for the children of the leafs in the template
#     c) Remove all other MONDO classes from mondo.owl (other than the leafs and their children)
#     d) Merge this with the template upper level


HARRISON_TEMPLATE_URL=https://docs.google.com/spreadsheets/d/e/2PACX-1vS0748V0s6seWTYetzidiWJbY7r-e_Vc87XcQKl8NmN5BK0LWUios9DTcGqM_1cLj7wWUaueUaBDVx8/pub?gid=0&single=true&output=tsv

modules/harrisons-view.tsv:
	wget "$(HARRISON_TEMPLATE_URL)" -O $@

modules/mondo-%-view-top.owl: modules/%-view.tsv
	$(ROBOT) -vvv merge -i $(SRC) template --template $< --output $@ && \
	$(ROBOT) -vvv annotate --input $@ --ontology-iri $(OBO)/$(ONT)/mondo-$*-view-top.owl -o $@
.PRECIOUS: modules/mondo-%-view-top.owl

tmp/mondo-%-leafs.txt: modules/mondo-%-view-top.owl
	$(ROBOT) query --use-graphs false -i $< -f tsv --query $(SPARQLDIR)/signature/leaf-classes.sparql $@
	tail -n +2 "$@" > $@.tmp && mv $@.tmp $@

tmp/subclasses-of-%-leafs.sparql: tmp/mondo-%-leafs.txt
	echo "prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>" > $@
	echo "SELECT ?c WHERE {" >> $@
	LISTT="$(shell paste -sd" " tmp/mondo-$*-leafs.txt)"; echo "  VALUES ?list { $$LISTT }" >> $@
	echo "  ?c rdfs:subClassOf+ ?list" >> $@
	echo "}" >> $@

tmp/mondo-%-children.txt: $(SRC) tmp/subclasses-of-%-leafs.sparql
	$(ROBOT) query --use-graphs false -i $(SRC) -f tsv --query tmp/subclasses-of-$*-leafs.sparql $@
	tail -n +2 "$@" > $@.tmp && mv $@.tmp $@

tmp/mondo-%-children-and-leafs.txt: tmp/mondo-%-children.txt tmp/mondo-%-leafs.txt
	cat $^ | sort | uniq > $@
	sed -i -E 's/[<>?"]//g' $@

tmp/mondo-%-removed.owl: tmp/mondo-%-children-and-leafs.txt mondo.owl
	$(ROBOT) merge -i mondo.owl remove -T $< --select complement --select classes --select "MONDO:*"  -o $@

modules/mondo-%-view.owl: tmp/mondo-%-removed.owl modules/mondo-%-view-top.owl
	$(ROBOT) merge $(patsubst %, -i %, $^) annotate --ontology-iri $(OBO)/$(ONT)/mondo-$*-view.owl -o $@

MONDOVIEWS=harrisons

mondo-views: $(patsubst %, modules/mondo-%-view.owl, $(MONDOVIEWS))

modules/mondo-%.owl: modules/%.tsv
	$(ROBOT) -vvv merge -i $(SRC) template --template $< --output $@ && \
	$(ROBOT) -vvv annotate --input $@ --ontology-iri $(OBO)/$(ONT)/mondo-$*.owl -o $@
.PRECIOUS: modules/mondo-%.owl

MERGE_TEMPLATE=tmp/merge_template.tsv
#TEMPLATE_URL=https://docs.google.com/spreadsheets/d/e/2PACX-1vTV6ITR7RJMt5jswUHBmEEcfbNAeZWpj4VkDbMY3Bvh_fcmfXEw1CFvbgzOUPDxsj6oT5vsFQRg8FuM/pub?gid=346126899&single=true&output=tsv
TEMPLATE_URL=https://docs.google.com/spreadsheets/d/e/2PACX-1vTsgIbFYWkhMT0EgaBNbyT6fJiNKqVjdqcZxXQLwJ3CpXpSzB24BITZGDNSMyg_3bneIvE3F2l_iHWH/pub?gid=1886610709&single=true&output=tsv

tmp/merge_template.tsv:
	wget "$(TEMPLATE_URL)" -O $@

merge_template: $(MERGE_TEMPLATE)
	$(ROBOT) template --prefix "CHR: http://purl.obolibrary.org/obo/CHR_" --prefix "HGNC: http://identifiers.org/hgnc/" --prefix "sssom: https://w3id.org/sssom/" --merge-before --input $(SRC) \
 --template $(MERGE_TEMPLATE) convert -f obo -o $(SRC)

tmp/remove_classes.txt: $(MERGE_TEMPLATE)
	cut -f1 $< > $@

tmp/heal_hierarchy.ru: tmp/remove_classes.txt
	echo "PREFIX owl: <http://www.w3.org/2002/07/owl#>" > $@
	echo "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>" >> $@
	echo "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>" >> $@
	echo "prefix MONDO: <http://purl.obolibrary.org/obo/MONDO_>" >> $@
	echo "DELETE {" >> $@
	echo "?child rdfs:subClassOf ?subj ." >> $@
	echo "?subj rdfs:subClassOf ?parent ." >> $@
	echo "}" >> $@
	echo "INSERT {" >> $@
	echo "	?child rdfs:subClassOf ?parent ." >> $@
	echo "}" >> $@
	echo "WHERE {" >> $@
	echo "  ?child rdfs:subClassOf ?subj ." >> $@
	echo "  ?subj rdfs:subClassOf ?parent ." >> $@
	echo "  FILTER (?subj in (MONDO:0018652, MONDO:0014424, MONDO:0016788, MONDO:0014425, MONDO:0018651, MONDO:0005503))" >> $@
	echo "}" >> $@

merge_obsolete_template: tmp/heal_hierarchy.ru $(MERGE_TEMPLATE) tmp/remove_classes.txt
	git checkout master -- $(SRC) &&\
	$(ROBOT) query --input $(SRC) --update $< \
	remove -T tmp/remove_classes.txt --preserve-structure false \
	template --merge-before --template $(MERGE_TEMPLATE) convert -f obo -o $(SRC)

ALL_SOURCES_DEPRECATED_PATTERNS = $(patsubst %, tmp/deprecated-%-mappings.robot.tsv, $(SOURCE_IDS))

tmp/deprecated-%-mappings.robot.tsv:
	wget "https://raw.githubusercontent.com/monarch-initiative/mondo-ingest/main/src/ontology/reports/$*_mapped_deprecated_terms.robot.template.tsv" -O $@

update_deprecated_mappings: $(ALL_SOURCES_DEPRECATED_PATTERNS)
	$(ROBOT) template --prefix "CHR: http://purl.obolibrary.org/obo/CHR_" --prefix "sssom: https://w3id.org/sssom/" --merge-before --input $(SRC) \
 		$(patsubst %, --template %, $^) \
 		convert -f obo -o $(SRC)
	$(MAKE) NORM && mv NORM $(SRC)
	$(MAKE) deprecated_annotation_merging
	$(MAKE) NORM && mv NORM $(SRC)

deprecated_annotation_merging:
	sed -i 's/source="MONDO:equivalentObsolete",\ source="MONDO:obsoleteEquivalentObsolete"/source="MONDO:obsoleteEquivalentObsolete"/g' mondo-edit.obo || true
	sed -i 's/source="MONDO:equivalentObsolete",\ source="MONDO:equivalentTo"/source="MONDO:equivalentObsolete"/g' mondo-edit.obo || true
	sed -i 's/\(.*\)source="MONDO:equivalentObsolete"\(.*\)source="MONDO:obsoleteEquivalentObsolete"\(.*\)/\1source="MONDO:obsoleteEquivalentObsolete"\2\3/g' mondo-edit.obo || true
	sed -i '/source="MONDO:equivalentObsolete"/ s/, source="MONDO:equivalentTo"//g' mondo-edit.obo || true
	sed -i 's/source="MONDO:equivalentObsolete",\ source="MONDO:obsoleteEquivalent"/source="MONDO:obsoleteEquivalentObsolete"/g' mondo-edit.obo || true
	sed -i 's/, }/}/g' mondo-edit.obo || true
	sed -i 's/, ,/,/g' mondo-edit.obo || true
	echo "NOTE: There are still some broken cases that need to be manually fixed. Search for `quivalent.*quivalent` (no E) in case sensitive regex mode in Atom or Visual Studio"

#ANNOTATION_PROPERTIES=rdfs:label IAO:0000115 IAO:0000116 IAO:0000111 oboInOwl:hasDbXref rdfs:comment
#OBJECT_PROPERTIES=BFO:0000054 MONDOREL:disease_causes_feature MONDOREL:disease_has_basis_in_accumulation_of MONDOREL:disease_has_basis_in_development_of MONDOREL:disease_has_major_feature MONDOREL:disease_responds_to MONDOREL:disease_shares_features_of MONDOREL:disease_triggers MONDOREL:has_onset MONDOREL:part_of_progression_of_disease MONDOREL:predisposes_towards intersection:of rdfs:subClassOf RO:0002162 RO:0002451 RO:0002573 RO:0004001 RO:0004020 RO:0004021 RO:0004022 RO:0004024 RO:0004025 RO:0004026 RO:0004027 RO:0004028 RO:0004029 RO:0004030 RO:0009501
#--prefix "MONDOREL: http://purl.obolibrary.org/obo/mondo#"

#		remove --base-iri $(OBO)/$(ONT)"/MONDO_" --axioms external --preserve-structure false --trim false \
#	remove $(patsubst %, --term %, $(ANNOTATION_PROPERTIES)) -T modules/mondo-harrisons-children-and-leafs.txt --select complement \


open_%_report:
	open reports/mondo-$*-report.html

mondo_obo:
	robot convert -i mondo-edit.obo -f obo -o mondo-edit.obo

tmp/mondo-ingest.owl:
	curl https://github.com/monarch-initiative/mondo-ingest/releases/latest/download/mondo-ingest.owl -L --output $@


tmp/mondo-ingest.db: tmp/mondo-ingest.owl
	@rm -f .template.db
	@rm -f .template.db.tmp
	RUST_BACKTRACE=full semsql make $@ -P config/prefixes.csv
	@rm -f .template.db
	@rm -f .template.db.tmp

METRIC_SINCE_VERSION=2019-06-29
METRIC_UNTIL_VERSION=2020-06-30

tmp/mondo-%-release.owl:
	wget http://purl.obolibrary.org/obo/mondo/releases/$*/mondo.owl -O $@

tmp/unmerge.owl: tmp/mondo-$(METRIC_SINCE_VERSION)-release.owl tmp/mondo-$(METRIC_UNTIL_VERSION)-release.owl
	$(ROBOT) unmerge -i tmp/mondo-$(METRIC_UNTIL_VERSION)-release.owl -i tmp/mondo-$(METRIC_SINCE_VERSION)-release.owl -o $@

report-metrics-%: tmp/mondo-%.owl
	$(ROBOT) query --use-graphs true -i $< -f tsv --query $(SPARQLDIR)/reports/all-properties.sparql reports/report-$*.tsv

metrics: report-metrics-$(METRIC_SINCE_VERSION)-release report-metrics-$(METRIC_UNTIL_VERSION)-release

tmp/harrisons_seed.txt: mondo.owl
	$(ROBOT) query --use-graphs true -i $< -f csv --query $(SPARQLDIR)/signature/harrisonview-seed.sparql $@

mondo-harrisons-view.owl: mondo.owl tmp/harrisons_seed.txt
	$(ROBOT) remove -i $< -T tmp/harrisons_seed.txt --select complement --select classes --select "MONDO:*" \
	annotate -V $(ONTBASE)/releases/`date +%Y-%m-%d`/$@ annotate --ontology-iri $(ONTBASE)/$@ -o $@


######################################
### Mondo managing major use ids #####
######################################

tmp/efo_protection.txt:
	wget "https://raw.githubusercontent.com/EBISPOT/efo/master/src/ontology/iri_dependencies/mondo_terms.txt" -O tmp/efo_mondo_terms.txt
	wget "https://raw.githubusercontent.com/EBISPOT/otar_profiler/master/templates/disease_p_ta.txt" -O tmp/efo_disease_p_ta.txt
	cat tmp/efo_mondo_terms.txt tmp/efo_disease_p_ta.txt | grep MONDO_ | sort | uniq  > $@

.PHONY: %_risks
%_risks: $(SRC) tmp/%_protection.txt
	$(ROBOT) merge -i $(SRC) filter -T tmp/$*_protection.txt --select annotations \
		verify --queries ../sparql/reports/obsoletion-candidates.sparql --output-dir tmp/

.PHONY: risky_obsoletion_check
risky_obsoletion_check: efo_risks

.PHONY: test_owlaxioms
test_owlaxioms:
	! grep "owl-axioms: " mondo-edit.obo

test: test_owlaxioms

.PHONY: test_obs_reason
test_obs_reason:
	echo "all obsolesence reasons should be typed as xsd:string"
	! grep -E "property_value: IAO:0000231.*xsd:[^s]" mondo-edit.obo
	echo "obsolesence reason does not seem to use the correct property"
	! grep -E "\"terms merged\" xsd:" mondo-edit.obo | grep -v IAO:0000231
	! grep -E "\"out of scope\" xsd:" mondo-edit.obo | grep -v IAO:0000231
	! grep -E "\"terms split\" xsd:" mondo-edit.obo | grep -v IAO:0000231

test: test_obs_reason

######################################
### Mondo slurp python ###############
######################################

SLURP_FROM="https://github.com/monarch-initiative/omim/releases/download/1.0.0/omim.ttl"
tmp/source-%.ttl:
	wget $(SLURP_FROM) -O $@

tmp/mondo-edit.ttl: $(SRC)
	$(ROBOT) convert -i $< -f ttl -o $@

tmp/mondo-edit-%.ttl: tmp/mondo-edit.ttl tmp/source-%.ttl
	python ../scripts/migrate.py $^ $@

migrate-%: tmp/mondo-edit-%.ttl
	$(ROBOT) convert -i $< -f obo -o $@

migrate: migrate-omim

#######################################################
##### British synonyms pipeline #######################
#######################################################

tmp/synonyms.csv: $(SRC)
	$(ROBOT) query -i $< --use-graphs true -f csv --query ../sparql/reports/mondo_synonyms.sparql $@

tmp/labels.csv: $(SRC)
	$(ROBOT) query -i $< --use-graphs true -f csv --query ../sparql/reports/mondo_labels.sparql $@

tmp/british_english_dictionary.csv:
	wget "https://raw.githubusercontent.com/obophenotype/human-phenotype-ontology/master/src/ontology/hpo_british_english_dictionary.csv" -O $@

SYN_TYPES=hasBroadSynonym hasRelatedSynonym hasExactSynonym hasNarrowSynonym
SYN_TYPE_TEMPLATES=$(patsubst %, tmp/be_syns_%.csv, $(SYN_TYPES))

$(SYN_TYPE_TEMPLATES): tmp/labels.csv tmp/synonyms.csv tmp/british_english_dictionary.csv
	python3 ../scripts/compute_british_synonyms.py $^ tmp/

tmp/british_synonyms.owl: $(SYN_TYPE_TEMPLATES) $(SRC)
	$(ROBOT) merge -i $(SRC) template $(patsubst %, --template %, $(SYN_TYPE_TEMPLATES)) --output $@ && \
	$(ROBOT) annotate --input $@ --ontology-iri $(ONTBASE)/components/$*.owl -o $@

#We remove the old ones so that if we change the synonym scope of the AE synonym, its changed as well for this one.
add_british_language_synonyms: $(SRC) tmp/british_synonyms.owl
	echo "WARNING: REMOVING OLD BRITISH SYNONYMS! WE HOPE YOU DIDNT CURATE ANY MANUALLY!"
	grep -v 'OMO:0003005' mondo-edit.obo > TT || true
	mv TT mondo-edit.obo
	$(ROBOT) merge -i $< -i tmp/british_synonyms.owl --collapse-import-closure false -o tmp/mondo-edit.obo && mv tmp/mondo-edit.obo $(SRC)
	make NORM
	mv NORM $(SRC)

# This updates all British English in Mondo to American English.
.PHONY: americanize

americanize: $(SRC) tmp/british_english_dictionary.csv
	python ../scripts/clean-british-english.py $^


.PHONY: update-gard-mappings
update-gard-mappings:
	grep -v '^xref: GARD:' mondo-edit.obo > TT || true
	mv TT mondo-edit.obo
	# make NORM
	# mv NORM $(SRC)


#######################################
### New Pattern merge pipeline ########
#######################################

../patterns/data/default/%.owl: ../patterns/data/default/%.tsv $(SRC)
	dosdp-tools generate --catalog=catalog-v001.xml --obo-prefixes=true --restrict-axioms-to=logical --ontology=$(SRC)  --template=../patterns/dosdp-patterns/$*.yaml --outfile=$@ generate --infile=$<

../patterns/data/default/%_terms.txt: ../patterns/data/default/%.tsv
	cut -f1 $< | tail -n +2 | sed 's!http://purl.obolibrary.org/obo/MONDO_!MONDO:!g' > $@

tmp/remove_%.ru: ../patterns/data/default/%_terms.txt
	echo "prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>" > $@
	echo "prefix MONDO: <http://purl.obolibrary.org/obo/MONDO_>" >> $@
	echo "PREFIX owl: <http://www.w3.org/2002/07/owl#>" >> $@
	echo "DELETE {" >> $@
	echo "?list owl:equivalentClass ?equivalent ." >> $@
	echo "}" >> $@
	echo "WHERE {" >> $@
	LISTT="$(shell paste -sd" " ../patterns/data/default/$*_terms.txt)"; echo "  VALUES ?list { $$LISTT }" >> $@
	echo "  ?list owl:equivalentClass ?equivalent ." >> $@
	echo "  FILTER(isBlank(?equivalent))" >> $@
	echo "}" >> $@

dosdp-merge-%: ../patterns/data/default/%.owl tmp/remove_%.ru
	$(ROBOT) query -i $(SRC) --update tmp/remove_$*.ru \
		merge -i $< --collapse-import-closure false \
		convert -f obo --check false -o tmp/$(SRC)
		mv tmp/$(SRC) $(SRC)
		make NORM
		mv NORM $(SRC)

p1: dosdp-merge-acute

python-install-dependencies:
	python3 -m pip install --upgrade pip
	python3 -m pip install --upgrade -r ../../requirements.txt

update-exclusion-reasons: python-install-dependencies
	python3 ../scripts/exclusion_reasons_enum_updater.py \
	--input-path-exclusion-reasons ../scripts/exclusion_reasons.csv \
	--input-path-mondo-schema ../schema/mondo.yaml

config/exclusion_reasons.tsv:
	wget "https://docs.google.com/spreadsheets/d/e/2PACX-1vTuZlr1P4ZUwdEnet_wN0RShGa8_9MYX-dAFva_xslNuiDrLP_MuIXPu0rzClq-xZQ47QhqzK2p74AA/pub?gid=1644570180&single=true&output=tsv" -O $@

all: config/exclusion_reasons.tsv

# ----------------------------------------
# Babelon Translation Files
# ----------------------------------------

BABELONPY=babelon -q
TRANSLATIONS=mondo-jp
TRANSLATIONS_OWL=$(TRANSLATIONSDIR)/mondo-jp.babelon.owl
TRANSLATIONS_TSV=$(TRANSLATIONSDIR)/mondo-jp-preprocessed.babelon.tsv
TRANSLATIONS_ADAPTER=simpleobo:mondo-simple.obo
TRANSLATIONS_ONTOLOGY=mondo-simple.obo
TRANSLATE_PREDICATES=rdfs:label 

.PHONY: update-mondo-japanese-translation
update-mondo-japanese-translation:
	@echo "DOWNLOADING JAPANESE TRANSLATION IS SKIPPED"
	wget "https://raw.githubusercontent.com/dbcls/mondo-japanese/refs/heads/main/babelon/mondo-jp.babelon.tsv" -O $@

validate-%: $(TRANSLATIONSDIR)/%.babelon.tsv
	@output=$$(tsvalid $(TRANSLATIONSDIR)/$*.babelon.tsv --skip "W1" --skip "E1"); \
	if echo "$$output" | grep -Eq 'E[0-9]+:[ ]'; then \
		echo "Error detected in hp-$*.babelon.tsv: $$output"; \
		exit 1; \
	fi
	babelon convert $(TRANSLATIONSDIR)/$*.babelon.tsv --output-format owl -o tmp/$*-babelon.owl

.PHONY: validate-translations
validate-translations:
	$(MAKE) $(foreach lang, $(TRANSLATIONS), validate-$(lang))


$(TRANSLATIONSDIR)/mondo-jp-preprocessed.babelon.tsv: $(TRANSLATIONS_ONTOLOGY) $(TRANSLATIONSDIR)/mondo-jp.babelon.tsv
	$(BABELONPY) prepare-translation $(TRANSLATIONSDIR)/mondo-jp.babelon.tsv \
		--oak-adapter $(TRANSLATIONS_ADAPTER) \
		--language-code jp \
		$(foreach n,$(TRANSLATE_PREDICATES), --field $(n)) \
		--output-source-changed $(TRANSLATIONSDIR)/mondo-jp-changed.babelon.tsv  \
		--output-not-translated $(TRANSLATIONSDIR)/mondo-jp-not-translated.babelon.tsv \
		--include-not-translated false \
		--update-translation-status true \
		--drop-unknown-columns true \
		-o $@


$(TRANSLATIONSDIR)/%.synonyms.owl: $(TRANSLATIONSDIR)/%.synonyms.tsv
	$(ROBOT) template --template $< \
		annotate \
			--ontology-iri $(ONTBASE)/translations/$*.synonyms.owl \
			-V $(ONTBASE)/releases/$(VERSION)/translations/$*.synonyms.owl \
			--annotation owl:versionInfo $(VERSION) \
		convert -f owl --output $@
.PRECIOUS: $(TRANSLATIONSDIR)/%.synonyms.owl

$(TRANSLATIONSDIR)/%.babelon.owl: $(TRANSLATIONSDIR)/%-preprocessed.babelon.tsv
	$(BABELONPY) convert $< --output-format owl -o $@.tmp
	$(ROBOT) merge -i $@.tmp \
		annotate \
			--ontology-iri $(ONTBASE)/translations/$*.babelon.owl \
			-V $(ONTBASE)/releases/$(VERSION)/translations/$*.babelon.owl \
			--annotation owl:versionInfo $(VERSION) \
		convert -f owl --output $@
	@rm $@.tmp
.PRECIOUS: $(TRANSLATIONSDIR)/%.babelon.owl

$(TRANSLATIONSDIR)/$(ONT)-all.babelon.tsv: $(TRANSLATIONS_TSV)
	$(BABELONPY) merge $^ -o $@

$(TRANSLATIONSDIR)/%.babelon.json: $(TRANSLATIONSDIR)/%.babelon.tsv
	$(BABELONPY) convert $< --output-format json -o $@


$(ONT)-international.owl: $(ONT).owl $(TRANSLATIONS_OWL)
	$(ROBOT) merge $(patsubst %, -i %, $^) \
		$(SHARED_ROBOT_COMMANDS) annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
		--output $@.tmp.owl && mv $@.tmp.owl $@


##################################
##### Scheduled GH Actions #######
##################################

$(TMPDIR)/subclass-confirmed.robot.tsv:
	wget "https://raw.githubusercontent.com/monarch-initiative/mondo-ingest/main/src/ontology/reports/sync-subClassOf.confirmed.tsv" -O $@

$(TMPDIR)/synonyms-confirmed.robot.tsv:
	wget "https://raw.githubusercontent.com/monarch-initiative/mondo-ingest/refs/heads/main/src/ontology/reports/sync-synonym/sync-synonyms.confirmed.robot.tsv" -O $@

$(TMPDIR)/new-exact-matches-%.tsv:
	wget "https://raw.githubusercontent.com/monarch-initiative/mondo-ingest/main/src/ontology/lexmatch/unmapped_$*_lex_exact.tsv" -O $@

$(TMPDIR)/%.robot.owl: $(TMPDIR)/%.robot.tsv
	$(ROBOT) --prefix "sssom: https://w3id.org/sssom/" template --template $< -o $@

$(TMPDIR)/new-exact-matches-%.owl: $(TMPDIR)/new-exact-matches-%.tsv
	$(ROBOT) --prefix "sssom: https://w3id.org/sssom/" template --template $< -o $@

update-%-mappings: $(TMPDIR)/new-exact-matches-%.owl
	$(ROBOT) merge -i $(SRC) -i $< --collapse-import-closure false \
		convert -f obo --check false -o tmp/$(SRC)
		mv tmp/$(SRC) $(SRC)
		make NORM
		mv NORM $(SRC)

# We want to preserve all axioms with relationships as they are here
# As we only care about subclass relations between names.
$(TMPDIR)/subclass-anonymous-axioms.owl: $(SRC)
	$(ROBOT) filter --input $(SRC) \
		--select "object-properties" \
		--axioms SubClassOf \
		--preserve-structure false \
		--trim false \
		-o $@

# Here we select all subclass relations between named classes
# and drop the evidence we want.
# Hopefully the union of named and anonymous subclass relations will be _all_ subclass relations
$(TMPDIR)/subclass-named-axioms.owl: $(SRC)
	$(ROBOT) filter --input $(SRC) \
		--axioms SubClassOf \
		--preserve-structure false \
		--trim false \
		remove --select "object-properties" \
		--drop-axiom-annotations "oboInOwl:source=~'($(SUBCLASS_SOURCES_REGEX)):.*'" \
		-o $@

# This command updates mondo-edit with all the confirmed subclass evidence from the mondo-ingest repo
.PHONY: update-subclass-sync
update-subclass-sync: 
	$(MAKE) $(TMPDIR)/subclass-confirmed.robot.owl $(TMPDIR)/subclass-named-axioms.owl $(TMPDIR)/subclass-anonymous-axioms.owl
	$(ROBOT) remove --input $(SRC) \
		--axioms SubClassOf \
		--preserve-structure false \
		merge -i $(TMPDIR)/subclass-confirmed.robot.owl -i $(TMPDIR)/subclass-named-axioms.owl -i $(TMPDIR)/subclass-anonymous-axioms.owl --collapse-import-closure false \
		convert -f obo --check false -o tmp/$(SRC)
		mv tmp/$(SRC) $(SRC)
		make NORM
		mv NORM $(SRC)


# All the synchronized sources
SYNCED_SOURCES := DOID ICD10CM ICD10WHO icd11.foundation NCIT OMIM OMIMPS Orphanet
SUBCLASS_SYNCED_SOURCES := DOID ICD10CM ICD10WHO icd11.foundation NCIT OMIM Orphanet

# Join the sources with '|' to form a regex for use in commands
SOURCES_REGEX := $(shell IFS='|'; echo "$(SYNCED_SOURCES)" | sed 's/ /|/g')
SUBCLASS_SOURCES_REGEX := $(shell IFS='|'; echo "$(SUBCLASS_SYNCED_SOURCES)" | sed 's/ /|/g')

# This target extracts all synonyms from mondo edit and then drops all axiom
# annotations related to the sources that are in the list of curated sources
tmp/synonyms-axioms.owl: $(SRC)
	$(ROBOT) filter --input $(SRC) \
		--term oboInOwl:hasExactSynonym \
		--term oboInOwl:hasNarrowSynonym \
		--term oboInOwl:hasBroadSynonym \
		--term oboInOwl:hasRelatedSynonym \
		--axioms annotation --preserve-structure false --trim false \
		--drop-axiom-annotations "oboInOwl:hasDbXref=~'($(SOURCES_REGEX)):.*'" \
		-o $@

# This command updates mondo-edit with all the confirmed synonyms evidence from the mondo-ingest repo
.PHONY: update-synonyms-sync
update-synonyms-sync: $(TMPDIR)/synonyms-confirmed.robot.owl tmp/synonyms-axioms.owl
	$(ROBOT) \
		remove --input $(SRC) \
			--term oboInOwl:hasExactSynonym \
			--term oboInOwl:hasNarrowSynonym \
			--term oboInOwl:hasBroadSynonym \
			--term oboInOwl:hasRelatedSynonym \
			--axioms annotation --trim true \
		merge \
			-i $(TMPDIR)/synonyms-confirmed.robot.owl \
			-i tmp/synonyms-axioms.owl \
			--collapse-import-closure false \
		convert -f obo --check false -o tmp/$(SRC)
	mv tmp/$(SRC) $(SRC)
	make NORM
	mv NORM $(SRC)


.PHONY: help
help:
	@echo "$$data"
	echo "Making sure all english in Mondo in American:"
	echo "sh run.sh make americanize"
	echo "Update british english synonyms"
	echo "sh run.sh make add_british_language_synonyms"

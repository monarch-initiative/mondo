ALL_PATTERNS=$(patsubst ../patterns/dosdp-patterns/%.yaml,%,$(wildcard ../patterns/dosdp-patterns/*.yaml))
DOSDPT=../dosdp-tools-0.15.1-SNAPSHOT/bin/dosdp-tools


.PHONY: dirs
dirs:
	mkdir -p tmp/
	mkdir -p components/


.PHONY: matches
matches:
	$(DOSDPT) query --ontology=../ontology/mondo-edit.obo --reasoner=elk --obo-prefixes=true --batch-patterns="$(ALL_PATTERNS)" --template="../patterns/dosdp-patterns" --outfile="../patterns/data/matches/"

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
	
tmp/mondo-version_edit-owl.owl: mondo.owl
	$(ROBOT) merge -i $< -o $@

tmp/mondo-version_current.owl:
	$(ROBOT) merge -I $(OBO)/mondo.owl -o $@

tmp/mondo-version_2019.owl:
	$(ROBOT) merge -I http://purl.obolibrary.org/obo/mondo/releases/2019-04-29/mondo.owl -o $@

tmp/mondo-version_2020.owl:
	$(ROBOT) merge -I http://purl.obolibrary.org/obo/mondo/releases/2020-01-27/mondo.owl -o $@

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

QC_BASE_FILES=edit edit-owl mondo-owl current 2019 2020
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

reports/mondo_analysis.md: #$(QC_REPORTS)
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

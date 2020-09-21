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

current-release-%:
	$(ROBOT) merge -I $(OBO)/$* -o $@

# This combines all into one single command
all_reports_warnings_%: %
	$(ROBOT) query -f tsv -i $< $(foreach V,$(SPARQL_WARNINGS),-s $(SPARQLDIR)/$V.sparql reports/$*-$V.tsv)

all_reports_stats_%: %
	$(ROBOT) query -f tsv -i $< $(foreach V,$(SPARQL_STATS),-s $(SPARQLDIR)/$V.sparql reports/$*-$V.tsv)

reports/robot-report-%.tsv: %
	$(ROBOT) report -i $< --fail-on none --print 5 -o $@

QC_BASE_FILES=mondo-edit.obo mondo.owl current-release-mondo.owl
QC_REPORTS=$(foreach V,$(QC_BASE_FILES), qc_reports_$V)

qc_reports_%: all_reports_warnings_% all_reports_stats_% reports/robot-report-%.tsv
	echo $^

travis_test: mondo.owl sparql_test_main_owl
	$(ROBOT) report -i mondo.owl --fail-on none --print 5 -o reports/obo-report.tsv

run_notebook:
	# https://github.com/jupyter/notebook/issues/2254
	jupyter notebook --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''

reports/mondo_analysis.md: $(QC_REPORTS)
	jupyter nbconvert --execute --to markdown --TemplateExporter.exclude_input=True reports/mondo_analysis.ipynb
	#sed -i 's/<style.*<[/]style>//g' $@
	# This is a hack to get rid of <style> tags that are rendered very ugly by github.
	perl -0777 -i.original -pe 's#<style[^<]*<\/style>##igs' $@

##############################################################
###### Pipeline for adding a compoment with tagging ##########
# For example: DOSDP conformance

MATCHED_TSVs=$(foreach V,$(notdir $(wildcard ../patterns/data/matches/*.tsv)),../patterns/data/matches/$V)

tmp/mondo-tags-dosdp.tsv:
	python ../scripts/dosdp-matches-tags.py $(addprefix -d , $(MATCHED_TSVs)) -o $@

tmp/mondo-tags-dosdp.owl: tmp/mondo-tags-dosdp.tsv | dirs
	$(ROBOT) merge -i $(SRC) template --template $< --prefix "MONDO: http://purl.obolibrary.org/obo/MONDO_" --output $@ && \
	$(ROBOT) annotate --input $@ --ontology-iri $(ONTBASE)/components/$*.owl -o $@

components/mondo-tags.owl: tmp/mondo-tags-dosdp.owl | dirs
	$(ROBOT) merge $(addprefix -i , $^) -o $@

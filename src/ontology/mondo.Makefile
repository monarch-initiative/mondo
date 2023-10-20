ALL_PATTERNS=$(patsubst ../patterns/dosdp-patterns/%.yaml,%,$(wildcard ../patterns/dosdp-patterns/[a-z]*.yaml))
DOSDPT=dosdp-tools

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

test: pattern_schema_checks
test: owlaxioms_check
test: test_reason_equivalence
test: test_reason_equivalence_hermit
test: obo_validator

test_reason_equivalence_hermit: $(ONT).obo
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
	pip install tabulate
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
	pip install tabulate
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

#############################################
##### Mondo subset auto-tagger ##############
#############################################

RARE_SUBSETS=nord orphanet inferred gard

tmp/orphanet-rare-subset.ttl: $(SRC)
	$(ROBOT) merge -i $(SRC) reason \
		query --format ttl --query ../sparql/construct/construct-orphanet-rare-subset.sparql $@


subsets/gard-subset.template.tsv:
	wget "https://github.com/monarch-initiative/gard/releases/latest/download/mondo-gard-exact.robot.template.tsv" -O $@

# The complex part here is that we need to dynamically update the MONDO source code, i.e. 
# MONDO:equivalentTo and MONDO:obsoleteEquivalentTo.
tmp/gard-rare-subset.ttl: $(SRC) subsets/gard-subset.template.tsv
	$(ROBOT) template --template subsets/gard-subset.template.tsv convert -f ttl -o $@
	$(ROBOT) remove -i $< --select imports merge -i $@ query -f ttl --query ../sparql/construct/construct-equivalent-obsolete-gard.sparql $@.source
	$(ROBOT) merge -i $@ -i $@.source -o $@

tmp/nord-rare-subset.ttl: $(SRC)
	$(ROBOT) template --template subsets/nord-subset.template.tsv convert -f ttl -o $@

# The inferred subset depends on the other ones, so we need to first remove the old subsets
# Then add the gard, nord and orphanet subsets back in
tmp/inferred-rare-subset.ttl: $(SRC) tmp/nord-rare-subset.ttl tmp/gard-rare-subset.ttl tmp/orphanet-rare-subset.ttl
	$(ROBOT) merge -i $(SRC) \
		unmerge -i components/mondo-subsets.owl \
		merge $(patsubst %, -i %, $^) \
		reason \
		query --format ttl --query ../sparql/construct/construct-inferred-rare-subset.sparql $@

components/mondo-subsets.owl: tmp/inferred-rare-subset.ttl tmp/orphanet-rare-subset.ttl tmp/nord-rare-subset.ttl tmp/gard-rare-subset.ttl
	$(ROBOT) merge $(patsubst %, -i %, $^) \
		query --update ../sparql/construct/construct-rare-subset.sparql \
		annotate --ontology-iri $(ONTBASE)/$@ -o $@

# As of 3 August, does not do anything.
components/mondo-characteristic-rare.owl: components/mondo-subsets.owl
	$(ROBOT) merge -i $(SRC) reason \
		query --format ttl --query ../sparql/construct/construct-rare-subset.sparql \
		annotate --ontology-iri $(ONTBASE)/$@ -o $@

reports/new-rare-diseases.txt: #$(ONT)-base.owl
	$(ROBOT) query -i $(ONT)-base.owl --query ../sparql/signature/rare-subset.sparql $@

reports/old-rare-diseases.txt: tmp/mondo-lastbase.owl
	$(ROBOT) query -i tmp/mondo-lastbase.owl --query ../sparql/signature/rare-subset.sparql $@

reports/%-rare-diseases.tsv: $(ONT)-base.owl reports/%-rare-diseases.txt
	$(ROBOT) filter --input $(ONT)-base.owl  -T reports/$*-rare-diseases.txt --select "annotations self" \
		export --header "ID|LABEL|SYNONYMS" \
  		--format tsv --export $@

rare-disease-reports: reports/old-rare-diseases.tsv reports/new-rare-diseases.tsv
	python ../scripts/filter_rare_disease_list.py reports/old-rare-diseases.tsv reports/new-rare-diseases.tsv reports/added-rare-disases.tsv reports/removed-rare-diseases.tsv

	


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
SOURCE_IDS = doid ncit ordo omim gard
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
	$(MAKE) components/mondo-subsets.owl

reports/robot_diff.md: mondo.obo mondo-lastbuild.obo
	$(ROBOT) diff --left mondo-lastbuild.obo --right $< -f markdown -o $@

tmp/mondo-lastbase.owl:
	mkdir -p tmp && wget "http://purl.obolibrary.org/obo/mondo/mondo-base.owl" -O $@

reports/mondo_diff.md: mondo-base.owl tmp/mondo-lastbase.owl
	$(ROBOT) diff --left tmp/mondo-lastbase.owl --right $< -f markdown -o $@

reports/mondo_unsats.md: mondo.obo
	$(ROBOT) explain -i $< --reasoner ELK -M unsatisfiability --unsatisfiable all --explanation $@ \
		annotate --ontology-iri "http://purl.obolibrary.org/obo/$@" -o $@.owl

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

report-query-%:
	$(ROBOT) query --use-graphs true -i $(SRC) -f tsv --query $(SPARQLDIR)/reports/$*.sparql reports/report-$*.tsv

report-base-query-%: mondo-base.owl
	$(ROBOT) query --use-graphs true -i mondo-base.owl -f tsv --query $(SPARQLDIR)/reports/$*.sparql reports/report-base-$*.tsv

report-reason-query-%:
	$(ROBOT) reason -i $(SRC) query --use-graphs true  -f tsv --query $(SPARQLDIR)/reports/$*.sparql reports/report-reason-$*.tsv

report-reason-materialise-query-%:
	$(ROBOT) reason -i $(SRC) materialize --term RO:0002573 \
		query --use-graphs true  -f tsv --query $(SPARQLDIR)/reports/$*.sparql reports/report-reason-materialise-$*.tsv


report-owl-query-%:
	$(ROBOT) query --use-graphs true -I http://purl.obolibrary.org/obo/mondo/mondo-with-equivalents.owl -f tsv --query $(SPARQLDIR)/reports/$*.sparql reports/report-$*.tsv

tmp/mondo-rdfxml.owl:
	$(ROBOT) remove -i $(SRC) --select imports convert -f owl -o $@

report-tbd-query-%: tmp/mondo-rdfxml.owl
	$(ROBOT) query --use-graphs true -i $< -f tsv --tdb true --query $(SPARQLDIR)/reports/$*.sparql reports/report-$*.tsv

update-query-%:
	$(ROBOT) query --use-graphs true -i $(SRC) --update $(SPARQLDIR)/update/$*.ru convert -f obo --check false -o $(SRC).obo

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

tmp/mass_obsolete.ru: ../sparql/update/mondo-obsolete-simple.ru tmp/identify_existing_obsoletes.txt config/obsolete_me.txt
	@echo "\n** Run mondo-obsolete-simple.ru **"
	# Remove ^M from tmp/identify_existing_obsoletes.txt
	sed 's/\r//g' tmp/identify_existing_obsoletes.txt > tmp/filtered_identify_existing_obsoletes.txt

	# Filter out existing obsoletes
	grep -v -w -i -f tmp/filtered_identify_existing_obsoletes.txt config/obsolete_me.txt > config/filtered_obsolete_me.txt

	# Create input for query
	LISTT="$(shell paste -sd" " config/filtered_obsolete_me.txt)"; sed "s/MONDO:0000000/$$LISTT/g" $< > $@

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

mass_obsolete2: identify_existing_obsoletes tmp/mass_obsolete.ru tmp/mass_obsolete_me.txt
	@echo "Make sure you have updated config/obsolete_me.txt before running this script.."
	$(MAKE) tmp/mondo-obsolete-labels.obo
	$(MAKE) mass_obsolete_warning
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
	python3 -m pip install --upgrade pip setuptools && python3 -m pip install --upgrade --force-reinstall sssom==0.3.17

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

#$(MAPPINGSDIR)/%.sssom.tsv: tmp/mirror-%.json
#	sssom convert -i $< -o $@
#	#python ../scripts/split_sssom_by_source.py $@

mappings: $(ALL_MAPPINGS)

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
	$(ROBOT) template --prefix "CHR: http://purl.obolibrary.org/obo/CHR_" --prefix "sssom: https://w3id.org/sssom/" --merge-before --input $(SRC) \
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

deprecated_annotation_merging:
	sed -i 's/source="MONDO:equivalentObsolete",\ source="MONDO:obsoleteEquivalentObsolete"/source="MONDO:obsoleteEquivalentObsolete"/g' mondo-edit.obo || true
	sed -i 's/source="MONDO:equivalentObsolete",\ source="MONDO:equivalentTo"/source="MONDO:equivalentObsolete"/g' mondo-edit.obo || true
	sed -i 's/\(.*\)source="MONDO:equivalentObsolete"\(.*\)source="MONDO:obsoleteEquivalentObsolete"\(.*\)/\1source="MONDO:obsoleteEquivalentObsolete"\2\3/g' mondo-edit.obo || true
	sed -i 's/, }/}/g' mondo-edit.obo || true
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

##################################
##### Scheduled GH Actions #######
##################################
$(TMPDIR)/new-exact-matches-%.tsv:
	wget "https://raw.githubusercontent.com/monarch-initiative/mondo-ingest/main/src/ontology/lexmatch/unmapped_$*_lex_exact.tsv" -O $@

$(TMPDIR)/new-exact-matches-%.owl: $(TMPDIR)/new-exact-matches-%.tsv
	$(ROBOT) --prefix "sssom: https://w3id.org/sssom/" template --template $< -o $@

update-%-mappings: $(TMPDIR)/new-exact-matches-%.owl
	$(ROBOT) merge -i $(SRC) -i $< --collapse-import-closure false \
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

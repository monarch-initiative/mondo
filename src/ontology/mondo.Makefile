ALL_PATTERNS=$(patsubst ../patterns/dosdp-patterns/%.yaml,%,$(wildcard ../patterns/dosdp-patterns/[a-z]*.yaml))
DOSDPT=dosdp-tools
PAT=true

.PHONY: dirs
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

test: pattern_schema_checks
test: owlaxioms_check
test: test_reason_equivalence

test_reason_equivalence: $(SRC)
	$(ROBOT) merge -i $< \
	remove --term FOODON:03315150 --term FOODON:00001257 --term ENVO:01001479 --term ENVO:01001784 --axioms logical \
	reason -e none

# ----------------------------------------
# Patterns (experimental)
# ----------------------------------------

# Test patterns for schema compliance:
merge_definitions: 
	$(ROBOT) merge -i $(SRC) -i ../patterns/definitions.owl --collapse-import-closure false convert -f obo -o tmp/mondoeditmerged.obo &&\
	mv  tmp/mondoeditmerged.obo $(SRC) 


.PHONY: patterns
patterns: all_imports $(PATTERNDIR)/pattern.owl $(PATTERNDIR)/definitions.owl

.PHONY: pattern_clean
pattern_clean:
	echo "Not implemented"

.PHONY: pattern_schema_checks
pattern_schema_checks:
	if [ $(PAT) = true ]; then $(PATTERN_TESTER) $(PATTERNDIR)/dosdp-patterns/; fi

#This command is a workaround for the absence of -N and -i in wget of alpine (the one ODK depend on now). It downloads all patterns specified in external.txt
.PHONY: update_patterns
update_patterns: .FORCE
	if [ $(PAT) = true ]; then rm -f $(PATTERNDIR)/dosdp-patterns/*.yaml.1 || true; fi
	if [ $(PAT) = true ] && [ -s $(PATTERNDIR)/dosdp-patterns/external.txt ]; then wget -i $(PATTERNDIR)/dosdp-patterns/external.txt --backups=1 -P $(PATTERNDIR)/dosdp-patterns; fi
	if [ $(PAT) = true ]; then rm -f $(PATTERNDIR)/dosdp-patterns/*.yaml.1 || true; fi


$(PATTERNDIR)/pattern.owl: pattern_schema_checks
	if [ $(PAT) = true ]; then $(DOSDPT) prototype --obo-prefixes true --template=$(PATTERNDIR)/dosdp-patterns --outfile=$@; fi

individual_patterns_default := $(patsubst %.tsv, $(PATTERNDIR)/data/default/%.ofn, $(notdir $(wildcard $(PATTERNDIR)/data/default/*.tsv)))
pattern_term_lists_default := $(patsubst %.tsv, $(PATTERNDIR)/data/default/%.txt, $(notdir $(wildcard $(PATTERNDIR)/data/default/*.tsv)))





# Generating the individual pattern modules and merging them into definitions.owl
$(PATTERNDIR)/definitions.owl: dosdp_patterns_default  
	if [ $(PAT) = true ] && [ "${individual_patterns_names_default}" ]   && [ $(PAT) = true ]; then $(ROBOT) merge $(addprefix -i , $(individual_patterns_default))   annotate --ontology-iri $(ONTBASE)/patterns/definitions.owl  --version-iri $(ONTBASE)/releases/$(TODAY)/patterns/definitions.owl -o definitions.ofn && mv definitions.ofn $@; fi

individual_patterns_names_default := $(strip $(patsubst %.tsv,%, $(notdir $(wildcard $(PATTERNDIR)/data/default/*.tsv))))
dosdp_patterns_default: $(SRC) .FORCE
	if [ $(PAT) = true ] && [ "${individual_patterns_names_default}" ]; then $(DOSDPT) generate --catalog=catalog-v001.xml --infile=$(PATTERNDIR)/data/default/ --template=$(PATTERNDIR)/dosdp-patterns --batch-patterns="$(individual_patterns_names_default)" --ontology=$< --obo-prefixes=true --restrict-axioms-to=logical --outfile=$(PATTERNDIR)/data/default; fi


# Generating the seed file from all the TSVs. If Pattern generation is deactivated, we still extract a seed from definitions.owl
$(PATTERNDIR)/all_pattern_terms.txt: $(pattern_term_lists_default)   $(PATTERNDIR)/pattern_owl_seed.txt
	if [ $(PAT) = true ]; then cat $^ | sort | uniq > $@; else $(ROBOT) query --use-graphs true -f csv -i ../patterns/definitions.owl --query ../sparql/terms.sparql $@; fi

$(PATTERNDIR)/pattern_owl_seed.txt: $(PATTERNDIR)/pattern.owl
	if [ $(PAT) = true ]; then $(ROBOT) query --use-graphs true -f csv -i $< --query ../sparql/terms.sparql $@; fi

$(PATTERNDIR)/data/default/%.txt: $(PATTERNDIR)/dosdp-patterns/%.yaml $(PATTERNDIR)/data/default/%.tsv .FORCE
	if [ $(PAT) = true ]; then $(DOSDPT) terms --infile=$(word 2, $^) --template=$< --obo-prefixes=true --outfile=$@; fi

.PHONY: prepare_patterns
prepare_patterns:
	if [ $(PAT) = true ]; then touch $(PATTERNDIR)/data $(pattern_term_lists_default)  ; fi
	if [ $(PAT) = true ]; then touch $(PATTERNDIR)/data $(individual_patterns_default)  ; fi




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
##### Mondo analysis ########################
#############################################

# Makefile for mondo analysis

#all: sources

## SOURCES
## TODO: NOTE THE MONDO SOURCE BUNDLED HERE IS THE LATEST RELEASE, (i.e. does not trigger a release run)
## THIS is to enable fair comparison with the other sources and issues with syncronisation

SOURCE_VERSION = $(TODAY)
# snomed
SOURCE_IDS = doid ncit ordo medgen omim
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

patterns: matches matches_annotations pattern_docs
	make components/mondo-tags.owl
	
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

report-query-%:
	$(ROBOT) query --use-graphs true -i $(SRC) -f tsv --query $(SPARQLDIR)/reports/$*.sparql reports/report-$*.tsv

report-reason-query-%:
	$(ROBOT) reason -i $(SRC) query --use-graphs true  -f tsv --query $(SPARQLDIR)/reports/$*.sparql reports/report-reason-$*.tsv

report-owl-query-%:
	$(ROBOT) query --use-graphs true -I http://purl.obolibrary.org/obo/mondo/mondo-with-equivalents.owl -f tsv --query $(SPARQLDIR)/reports/$*.sparql reports/report-$*.tsv


update-query-%:
	$(ROBOT) query --use-graphs true -i $(SRC) --update $(SPARQLDIR)/update/$*.ru convert -f obo --check false -o $(SRC).obo

.PHONY: r2e
r2e:
	make related_annos_to_exact
	make NORM
	mv NORM mondo-edit.obo

GH_ISSUE=none
OBS_REASON=outOfScope

mass_obsolete:
	perl ../scripts/obo-obsoletify.pl --seeAlso https://github.com/monarch-initiative/mondo/issues/$(GH_ISSUE) --obsoletionReason MONDO:$(OBS_REASON)  -i ../scripts/obsolete_me.txt mondo-edit.obo > OBSOLETE && mv OBSOLETE mondo-edit.obo

MAPPINGSDIR=mappings
MAPPING_IDS=ordo omim mondo
ALL_MAPPINGS=$(patsubst %, mappings/%.sssom.tsv, $(MAPPING_IDS))

tmp/mirror-ordo.json: mirror/ordo.obo
	robot merge -i $< convert -f json -o $@

tmp/mirror-omim.json: mirror/omim.obo
	robot merge -i $< convert -f json -o $@

tmp/mirror-mondo.json: mondo.obo
	robot merge -i $< convert -f json -o $@

$(MAPPINGSDIR)/%.sssom.tsv: tmp/mirror-%.json
	sssom convert -i $< -o $@
	#python ../scripts/split_sssom_by_source.py $@

mappings: $(ALL_MAPPINGS)


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
TEMPLATE_URL=https://docs.google.com/spreadsheets/d/e/2PACX-1vTV6ITR7RJMt5jswUHBmEEcfbNAeZWpj4VkDbMY3Bvh_fcmfXEw1CFvbgzOUPDxsj6oT5vsFQRg8FuM/pub?gid=346126899&single=true&output=tsv

tmp/merge_template.tsv:
	wget "$(TEMPLATE_URL)" -O $@

merge_template: $(MERGE_TEMPLATE)
	$(ROBOT) template --prefix "CHR: http://purl.obolibrary.org/obo/CHR_" --merge-before --input $(SRC) \
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
	echo "  FILTER (?subj in (MONDO:0015938, MONDO:0020272, MONDO:0010301, MONDO:0015318, MONDO:0015320, MONDO:0015321, MONDO:0015322, MONDO:0015543, MONDO:0016148, MONDO:0016329, MONDO:0017133, MONDO:0017274, MONDO:0019687, MONDO:0020012, MONDO:0020277, MONDO:0100027))" >> $@
	echo "}" >> $@

merge_obsolete_template: tmp/heal_hierarchy.ru $(MERGE_TEMPLATE) tmp/remove_classes.txt
	git checkout master -- $(SRC) &&\
	$(ROBOT) query --input $(SRC) --update $< \
	remove -T tmp/remove_classes.txt --preserve-structure false \
	template --merge-before --template $(MERGE_TEMPLATE) convert -f obo -o $(SRC)


#ANNOTATION_PROPERTIES=rdfs:label IAO:0000115 IAO:0000116 IAO:0000111 oboInOwl:hasDbXref rdfs:comment 
#OBJECT_PROPERTIES=BFO:0000054 MONDOREL:disease_causes_feature MONDOREL:disease_has_basis_in_accumulation_of MONDOREL:disease_has_basis_in_development_of MONDOREL:disease_has_major_feature MONDOREL:disease_responds_to MONDOREL:disease_shares_features_of MONDOREL:disease_triggers MONDOREL:has_onset MONDOREL:part_of_progression_of_disease MONDOREL:predisposes_towards intersection:of rdfs:subClassOf RO:0002162 RO:0002451 RO:0002573 RO:0004001 RO:0004020 RO:0004021 RO:0004022 RO:0004024 RO:0004025 RO:0004026 RO:0004027 RO:0004028 RO:0004029 RO:0004030 RO:0009501 
#--prefix "MONDOREL: http://purl.obolibrary.org/obo/mondo#" 

#		remove --base-iri $(OBO)/$(ONT)"/MONDO_" --axioms external --preserve-structure false --trim false \
#	remove $(patsubst %, --term %, $(ANNOTATION_PROPERTIES)) -T modules/mondo-harrisons-children-and-leafs.txt --select complement \

reports/mondo-edit-report.html: $(SRC_TAGS_REASONED)
	$(ROBOT) report -i $< --profile profile.txt --fail-on none -o $@
.PRECIOUS: reports/mondo-edit-report.html

.PHONY: mondo_%_report
mondo_edit_report: reports/mondo-edit-report.html
test: mondo_edit_report

open_%_report: 
	open reports/mondo-$*-report.html

mondo_obo:
	robot convert -i mondo-edit.obo -f obo -o mondo-edit.obo

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

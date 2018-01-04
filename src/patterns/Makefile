## THIS IS A BIOMAKE MAKEFILE ##

SRCM := ../ontology/mondo-merged.owl

#PATTERNS = hereditary acquired location_top location rare genetic dependence
PATTERNS = \
autosomal_dominant autosomal_recessive x_linked y_linked \
chronic acute \
location location_top \
disease_by_dysfunctional_structure \
basis_in_disruption_of_process \
inborn_metabolic \
allergy allergic_form_of_disease autoimmune_inflammation inflammatory_disease_by_site infectious_disease_by_agent \
rare genetic acquired rare_genetic congenital hereditary \
syndromic isolated \
malignant benign cancer carcinoma carcinoma_in_situ sarcoma neoplasm neoplasm_by_origin

all: all_mondo_ld merged-ld.owl  all_disease  all_ordo all_ncit all_icd all_snomed

all_disease_ld: $(patsubst %,ld-disease-%.tsv,$(PATTERNS))
all_disease: $(patsubst %,lx-disease-%.tsv,$(PATTERNS))
all_ordo: $(patsubst %,lx-ordo-%.tsv,$(PATTERNS))
all_ncit: $(patsubst %,lx-ncit-%.tsv,$(PATTERNS))
all_icd: $(patsubst %,lx-icd10-%.tsv,$(PATTERNS))
all_snomed: $(patsubst %,lx-snomed_disorder-%.tsv,$(PATTERNS))
all_mondo_lx_tsv: $(patsubst %,lx-mondo-%.tsv,$(PATTERNS))
all_mondo_lx: $(patsubst %,lx-mondo-%.owl,$(PATTERNS))
all_mondo_ld: $(patsubst %,ld-mondo-%.owl,$(PATTERNS))
all_mondo_ld_csv: $(patsubst %,%.csv,$(PATTERNS))

all_yaml: $(patsubst %,%.yaml,$(PATTERNS))

lx-mondo-$(P).tsv:
	blip-findall -r mondo_edit -u odputil -debug load -i disease_patterns.pro  -goal "load_onts($(P))" "new_tuple_from_lex($(P),C,V)" -select C-V -no_pred -use_tabs -label > $@.tmp && mv $@.tmp $@
lx-all-mondo-$(P).tsv:
	blip-findall -r mondo_edit -u odputil -debug load -i disease_patterns.pro  -goal "load_onts($(P))" "tuple_from_lex($(P),C,V)" -select C-V -no_pred -use_tabs -label > $@.tmp && mv $@.tmp $@

# lexical
lx-$(Ont)-$(P).tsv:
	blip-findall -r $(Ont) -goal "load_onts($(P))" -consult helper.pro -u odputil -i disease_patterns.pro "tuple_from_lex($(P),C,V),(disease_id(C);C='iri'),\+genus(C,_)" -select C-V -no_pred -use_tabs -label > $@.tmp && mv $@.tmp $@


%.yaml:
	blip-findall -u odputil -i disease_patterns.pro "write_yaml($*)" > $@.tmp && grep -v ^write_yaml $@.tmp > $@

#$(Ont)-$(P)-ld.tsv: $(P).yaml $(Ont).owl
#	dosdp-tools --prefixes=prefixes.yaml --ontology=$(Ont).owl --reasoner=elk --obo-prefixes=true --template=$< --outfile=$@.tmp query && ./util/fix-tsvs.pl $@.tmp > $@

#ld-$(Ont)-$(P).csv: 
#	blip-findall -r $(Ont) -r uberonp  -u odputil -i disease_patterns.pro -goal "load_onts($(P))" "write_tuple($(P))" -select C-V -no_pred -use_tabs -label > $@.tmp && mv $@.tmp $@

ld-mondo-%.tsv: %.yaml
	dosdp-tools  --ontology=$(SRCM) --reasoner=elk --obo-prefixes=true --template=$< --outfile=$@.tmp query && ./fix-tsvs.pl $@.tmp > $@

%.csv: ld-mondo-%.tsv
	cp $< $@

#ld-%.tsv: ld-%.csv
#	csv2tsv.py $< $@


%-logical.owl: %.owl
	owltools $< --remove-annotation-assertions -o $@
%-logical.obo: %.owl
	owltools $< --remove-annotation-assertions $(SRCM) --add-imports-from-supports   -o -f obo $@.tmp && grep -v ^imports: $@.tmp > $@

# GENERIC
%.obo: %.owl
	owltools $< --merge-imports-closure --add-obo-shorthand-to-properties -o -f obo --no-check $@

lx-$(Ont)-$(P).owl: lx-$(Ont)-$(P).tsv 
	apply-pattern.py -n $(OBO)/$(Ont)/$(P).owl  -P curie_map.yaml -b http://purl.obolibrary.org/obo/ -i $< -p $(P).yaml  > $@.tmp && mv $@.tmp $@

ld-$(Ont)-$(P).owl: ld-$(Ont)-$(P).tsv 
	apply-pattern.py -n $(OBO)/$(Ont)/$(P).owl -P curie_map.yaml -b http://purl.obolibrary.org/obo/ -i $< -p $(P).yaml  > $@.tmp && mv $@.tmp $@


merged-ld.owl: $(patsubst %,ld-mondo-%.owl,$(PATTERNS))
	owltools --create-ontology $(OBO)/mondo/dp.owl $^ --merge-support-ontologies -o $@

merged-%.obo: merged-%.owl
	owltools $< -o -f obo $@

fooz:
	lsaz ddddd
	echo hi

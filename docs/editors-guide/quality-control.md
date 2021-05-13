# Mondo Quality Control


test: sparql_test_edit roundtrip.obo debug.owl mondo-edit.owl sparql_test_main_obo test_nomerge
test: reports/robot-report-mondo-edit.obo.tsv reports/robot-report-mondo.owl.tsv
test: reports/robot-report-mondo.obo.tsvpattern_schema_checks:
test: pattern_schema_checks

../sparql/def-lacks-xref-violation.sparql			../sparql/omimps-should-be-inherited-violation.sparql		../sparql/same-label-violation.sparql
../sparql/definition-containing-underscore-violation.sparql	../sparql/owldef-self-reference-violation.sparql		../sparql/subclass-cycle-violation.sparql
../sparql/equivalent-classes-violation.sparql			../sparql/owldef-violation.sparql				../sparql/trailing-whitespace-violation.sparql
../sparql/excluded-subsumption-is-inferred-violation.sparql	../sparql/predispose-subClassOf-violation.sparql		../sparql/two-label-violation.sparql
../sparql/no-superclass-violation.sparql			../sparql/proxy-merge-violation.sparql				../sparql/undeclared-subset-violation.sparql
../sparql/nolabels-violation.sparql				../sparql/redundant-subClassOf-violation.sparql			../sparql/undeclared-synonym-type-violation.sparql
../sparql/obsolete-violation.sparql				../sparql/related-exact-synonym-violation.sparql		../sparql/xref-syntax-violation.sparql

```
sparql_test_edit: $(QSRC)
	robot verify -i $< --queries $(foreach V,$(EDIT_CHECKS),$(SPARQLDIR)/$V-violation.sparql) -O reports/edit/ && touch $@
```

```
sparql_test_main_obo: $(ONT).obo
	robot verify -i $< --queries $(foreach V,$(MAIN_OBO_CHECKS),$(SPARQLDIR)/$V-violation.sparql) -O reports/edit/ && touch $@
```

```
roundtrip.obo: mondo-edit.obo
	owltools --use-catalog  mondo-edit.obo -o -f obo $@.tmp && mv $@.tmp $@
```


```
debug.owl: mondo-edit.obo disjoint_sibs.owl imports/equivalencies.owl
	owltools --no-logging --use-catalog  $^ --merge-support-ontologies --run-reasoner -r elk -u -m $@ | grep -v ^INFERENCE
```

```
mondo-edit.owl: mondo-edit.obo
	../utils/quick-check.pl $< && robot convert -i $< -o $@
```


```
# ensure that inference including equivalencies does not result in merging any classes in MONDO.
# if this fails, the resolution is to look for two MONDO classes with equivalence to the same external class
test_nomerge: mondo.owl
	owltools  --log-error --use-catalog $< --reasoner elk --merge-equivalence-sets -P MONDO -s MONDO 100 --remove-dangling -o $@
```

```
RR= robot report --fail-on ERROR --profile profile.txt --print 8
reports/edit/report.tsv: $(SRC)
	$(RR) -i $<  -o $@.tmp && mv $@.tmp $@ || mv $@.tmp $@
reports/release/mondo-obo-report.tsv: mondo.obo
	$(RR) -i $<  -o $@.tmp && mv $@.tmp $@ || mv $@.tmp $@

reports/release/mondo-owl-report.tsv: mondo.owl
	$(RR) -i $<  -o $@.tmp && mv $@.tmp $@ || mv $@.tmp $@

reports/robot-report-%.tsv: %
	$(RR) -i $* -o $@.tmp && mv $@.tmp $@ || mv $@.tmp $@
```

```
pattern_schema_checks:
	simple_pattern_tester.py ../patterns/dosdp-patterns/
```

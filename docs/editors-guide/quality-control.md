# Mondo Quality Control

The tests run as part of the Mondo pipeline are defined in our [GitHub Action workflow](https://github.com/monarch-initiative/mondo/blob/master/.github/workflows/main.yaml). The workflows runs the phony `test` target in our [Makefile](https://github.com/monarch-initiative/mondo/blob/master/src/ontology/Makefile) and [Makefile extension (mondo.Makefile)](https://github.com/monarch-initiative/mondo/blob/master/src/ontology/Makefile). The exact set of tests may fluctuate over time (so this documentation, last updated on the 13. May 2021 may be a bit out of date), but this is what is roughly being done: 

1. Roundtripping to ensure OBO format compatible
1. OBO quick check and conversion to OWL
1. Reasoning with equivalence class axioms
1. Proxy merge checking to ensure no external class is referenced by more than one MONDO class
1. ROBOT reports
1. Custom SPARQL checks
1. DOSDP pattern checks

## Checks

### Roundtripping to ensure mondo-edit is OBO-format compatible
```
roundtrip.obo: mondo-edit.obo
	owltools --use-catalog  mondo-edit.obo -o -f obo $@.tmp && mv $@.tmp $@
```

### Reasoning with equivalence class axioms
```
debug.owl: mondo-edit.obo disjoint_sibs.owl imports/equivalencies.owl
	owltools --no-logging --use-catalog  $^ --merge-support-ontologies --run-reasoner -r elk -u -m $@ | grep -v ^INFERENCE
```
### OBO quick check and conversion to OWL

```
mondo-edit.owl: mondo-edit.obo
	../utils/quick-check.pl $< && robot convert -i $< -o $@
```

### Proxy merge checking

```
# ensure that inference includeing equivalencies does not result in merging any classes in MONDO.
# if this fails, the resolution is to look for two MONDO classes with equivalence to the same external class
test_nomerge: mondo.owl
	owltools  --log-error --use-catalog $< --reasoner elk --merge-equivalence-sets -P MONDO -s MONDO 100 --remove-dangling -o $@
```
### ROBOT report

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

### Custom SPARQL Checks

A lot of our fine grained checks are implemented as SPARQL query checks. A SPARQL query basically defines an anti-pattern, i.e. a scenario which we want to avoid. If it returns results, this is an indication something has gone wrong. We test both the edit file and mondo.obo (the OBO release of Mondo) in our continuous integration checks. A complete breakdown of the tests can be found [here](quality-control-tests.md).

#### Testing mondo-edit.obo

```
sparql_test_edit: $(QSRC)
	robot verify -i $< --queries $(SPARQL_MONDO_QC_FILES) $(SPARQL_GENERAL_QC_FILES) -O reports/edit/ && touch $@
```

#### Testing mondo.obo

```
sparql_test_main_obo: $(ONT).obo
	robot verify -i $< --queries $(SPARQL_MONDO_QC_FILES) $(SPARQL_GENERAL_QC_FILES) -O reports/main_obo/ && touch $@
```

### DOSDP Schema checks

We use the pattern schema checker (https://github.com/INCATools/dead_simple_owl_design_patterns).

```
pattern_schema_checks:
	simple_pattern_tester.py ../patterns/dosdp-patterns/
```

We use http://purl.obolibrary.org/obo/mondo#excluded_from_qc_check annotation to tag cases that would otherwise fail. Automated tagging occurs in this make pipeline: `components/mondo-tags.owl`.

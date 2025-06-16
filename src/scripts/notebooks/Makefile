PATH_MONDO_INGEST=/Users/matentzn/ws/mondo-ingest
PATH_SSSOM=/Users/matentzn/ws/SSSOM

tmp/mondo-match-rules.yaml:
	mkdir -p tmp
	cp $(PATH_MONDO_INGEST)/src/ontology/config/mondo-match-rules.yaml $@

sssom_pydantic.py:
	cp $(PATH_SSSOM)/project/pydantic/sssom_schema.py $@

tmp/ncit.db:
	mkdir -p tmp
	cp $(PATH_MONDO_INGEST)/src/ontology/components/ncit.db $@

tmp/mondo_paper.owl:
	wget "http://purl.obolibrary.org/obo/mondo.owl" -O $@

tmp/prefixes.csv:
	mkdir -p tmp
	cp ../../ontology/config/prefixes.csv $@

tmp/mondo_paper.db: tmp/mondo_paper.owl #tmp/prefixes.csv
	@rm -f .template.db
	@rm -f .template.db.tmp
	RUST_BACKTRACE=full semsql make $@ -P tmp/prefixes.csv
	@rm -f .template.db
	@rm -f .template.db.tmp	

tmp/mondo.db:
	mkdir -p tmp
	cp $(PATH_MONDO_INGEST)/src/ontology/tmp/mondo.db $@

tmp/mondo.sssom.tsv:
	mkdir -p tmp
	cp $(PATH_MONDO_INGEST)/src/ontology/tmp/mondo.sssom.tsv $@

tmp/ncit.sssom.tsv:
	mkdir -p tmp
	echo "$@ has been manually curated for test purposes"

tmp/mondo-negative-matches.sssom.tsv:
	wget "https://docs.google.com/spreadsheets/d/e/2PACX-1vRe1zUNaOxcfAq6z6_ynvB-D4CwZVeayOnYCAdk2DMftm9VjzgLQpzNfQAsiPnHJXw7AU5mZujGFqIl/pub?gid=0&single=true&output=tsv" -O $@

tmp/lexical-matches-%.tsv: tmp/mondo.db tmp/%.db tmp/mondo-match-rules.yaml
	mkdir -p tmp
	@if [ -z "$(SOURCE_ID_SPACE)" ]; then \
        echo "Error: SOURCE_ID_SPACE is not set"; \
        exit 1; \
    fi
	runoak --stacktrace -i sqlite:tmp/mondo.db -a tmp/$*.db lexmatch  i^MONDO: @ i^$(SOURCE_ID_SPACE): -R tmp/mondo-match-rules.yaml -o $@

update-ncit:
	$(MAKE) tmp/ncit.db
	$(MAKE) tmp/mondo.db
	$(MAKE)	tmp/mondo.sssom.tsv
	$(MAKE)	tmp/ncit.sssom.tsv
	$(MAKE)	tmp/mondo-negative-matches.sssom.tsv
	$(MAKE) tmp/lexical-matches-ncit.tsv SOURCE_ID_SPACE=NCIT

## How to generate reports

Reports are generally created like this:

```
sh run.sh make report-query-%
```

For example, the following command...

```
sh run.sh make report-query-obsoletion-candidates
```

will run this:

```
robot --catalog catalog-v001.xml query --use-graphs true -i mondo-edit.obo -f tsv --query ../sparql/reports/obsoletion-candidates.sparql reports/report-obsoletion-candidates.tsv
```

Which will generate a TSV report here: `reports/report-obsoletion-candidates.tsv`.

The only requirement for a report is, that a suitable SPARQL query can be found in `../sparql/reports/`, for example, `../sparql/reports/obsoletion-candidates.sparql`. 

If you want to create your very own report, you can 
1. tweak an existing command, for example using Ubergraph (https://api.triplydb.com/s/YfJCi9mrR)
2. Save the query as a `.sparql` query in `../sparql/reports/`, for example, `../sparql/reports/my-query.sparql`. 
3. Run `sh run.sh make report-query-my-query` to generate the report as above.

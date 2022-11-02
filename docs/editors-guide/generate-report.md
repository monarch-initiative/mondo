## How to create a new SPARQL report

1. Go to https://yasgui.triply.cc/#
2. Find a blueprint from src/sparql/reports directory
3. Copy and paste into yasqui and edit as needed
4. Run query and ensure it works
make sure you are using the end point: `https://ubergraph.apps.renci.org/sparql`
5. In [Atom](https://atom.io/) (text editor), go to src/sparql/reports directory
6. Right click on any file name and duplicate
7. Rename file appropriately
8. Paste contents of query into file
9. In Terminal run `sh run.sh make report-query-disease-labeled-terms`
10. The report will be in the src/sparql/reports folder

### Tips

- Tip 1: If you want to look a the report quickly, type in Terminal `atom reports/report-disease-labeled-terms.tsv`. This will open it in Atom.
- Tip 2: In Terminal, `open reports` - this will open the file in Finder.

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

Note:
If you want to run a query using the "inferred" version of the ontology (e.g. harrisonview-termlist requires to check whether any parents (asserted and inferred) have the 'harrisonview' tag), use the following command:
`sh run.sh make report-reason-query-`

If you want to create your very own report, you can:

1. tweak an existing command, for example using Ubergraph (https://api.triplydb.com/s/YfJCi9mrR)
2. Save the query as a `.sparql` query in `../sparql/reports/`, for example, `../sparql/reports/my-query.sparql`.
3. Run `sh run.sh make report-query-my-query` to generate the report as above.

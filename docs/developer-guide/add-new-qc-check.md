# Add new QC check to Mondo

1. Write a new SPARQL query for a QC check (for example, see [this request for a new QC check](https://github.com/monarch-initiative/mondo/issues/5440) and [the new query that Nico created](https://github.com/INCATools/ontology-development-kit/issues/703))
1. Add the text file to the folder mondo/src/sparql/qc/mondo
1. The file must be saved as starting with `qc-` and ending with `.sparql`, for example `qc-check-for-two-replaced-by-annotations.sparql`

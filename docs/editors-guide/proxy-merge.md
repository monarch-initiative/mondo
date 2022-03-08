# GitHub Access
- The GitHub repo is here: [https://github.com/monarch-initiative/mondo](https://github.com/monarch-initiative/mondo).
- The ontology structure is standard - e.g. src/ontology/ for source files for ontology
- Edit file is **mondo-edit.obo**

We use obo format to enable meaningful diffs in pull requests. Complex axioms that cannot be expressed in obo are edited in a sub-module and imported (imports/axioms.owl).

(the use of obo in combination with axiom annotation imposes some constraints that result in mild oddities, outlined later)

# GitHub workflow

**ALL CHANGES ARE DONE AS PULL REQUESTS.** No changes are to be committed to master. Make all changes on branches, and make Pull Requests.

Guidelines that are specific to editing Mondo are available [here](https://mondo.readthedocs.io/en/latest/editors-guide/editing-workflow/). These guidelines were adopted from the [Gene Ontology](http://go-ontology.readthedocs.io/en/latest/DailyWorkflow.html).



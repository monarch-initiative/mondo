# GitHub Access
Repo is here: https://github.com/monarch-initiative/mondo-build 
Ontology structure is standard - e.g. src/ontology/ for source files for ontology

Edit file is **mondo-edit.obo**

We use obo format to enable meaningful diffs in PRs. Complex axioms that cannot be expressed in obo are edited in a sub-module and imported (imports/axioms.owl).

(the use of obo in combination with axiom annotation imposes some constraints that result in mild oddities, outlined later)

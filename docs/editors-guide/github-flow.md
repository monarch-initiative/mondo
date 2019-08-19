# GitHub Flow

See [GO workflow](http://go-ontology.readthedocs.io/en/latest/DailyWorkflow.html). 
Guidelines that are specific to editing Mondo are available [here](https://mondo.readthedocs.io/en/latest/editors-guide/editing-workflow/).

**ALL CHANGES ARE DONE AS PULL REQUESTS**

TODO: Document
* What to do in the case of a conflict e.g [https://github.com/AgileVentures/MetPlus_PETS/wiki/Developing-a-feature-(or-bug,-chore)](https://github.com/AgileVentures/MetPlus_PETS/wiki/Developing-a-feature-(or-bug,-chore)) 
* Checking your diffs

## Github Workflow

No changes are to be committed to master. **Make all changes on branches, and make Pull Requests**. See: 

* [Editing and Pull Request workflow](https://mondo.readthedocs.io/en/latest/editors-guide/editing-workflow/)

## Excluded subclassOf

Rather than removing a subClassOf that comes from a trusted source (like ordo), we usually turn it into an excluded_subClassOf annotation.
For an example, see MONDO_0020528 'ACTH-dependent Cushing syndrome'

![Excluded subclassOf example](images/github-workflow-excluded-subclassof.png)


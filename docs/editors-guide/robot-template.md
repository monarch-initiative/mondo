# Preparing and merging a ROBOT template into Mondo

_Updated 2025-06-10_

## Preparing and merging a ROBOT template into Mondo:

<iframe width="1239" height="697" src="https://www.youtube.com/embed/x-w7NHinJMQ" title="" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

0:00:00 - 0:01:37 Intro and resources

0:01:38 - 0:23:59 preparing ROBOT template (simple example)

0:24:00 - 0:34:10 merging ROBOT template

0:34:11 - 0:42:00 preparing ROBOT template (extended example)

0:48:44 - 0:51:34 examples of error

0:56:42 - 1:05:22 preparing ROBOT template (examples for axioms)

1. Create Google sheet with ROBOT template. See example Mondo ROBOT templates [here](https://github.com/monarch-initiative/mondo/tree/master/src/templates). See more details about ROBOT templates [here](https://oboacademy.github.io/obook/lesson/templates-for-obo/#robot-template-vs-dosdp-template).
1. Click File->Share->Publish to the Web
1. Publish the specific sheet as TSV
1. Copy the link to the TSV
1. In the Terminal, navigate to the folder where the Mondo ontology is (usually in Documents/GitHub/mondo/src/ontology)
1. Run `git checkout master — mondo-edit.obo`  to revert mondo-edit.obo to the state it is on the master branch. This is only important if you have run the template command before.
1. Run `sh run.sh make TEMPLATE_URL="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ_G0rImuYa8o72cgQ97bH7xIq_V4TF6YfHkQaQY7HJUElcolO2RSh4bE7d50HTlSL1Vq7LoRJSkKBD/pub?gid=875350397&single=true&output=tsv" merge_template -B`  (the `TEMPLATE_URL`  should be your template link you have copied)
1. **Note** - If you just want to module a tsv you have edited locally, place it somewhere into the `src` directory and run:
`sh run.sh make merge_template MERGE_TEMPLATE="modules/name_of_your_template.tsv"`
3. If all went well, `mondo-edit.obo` will be updated with the template.
4. Branch + pull request
5. As always, carefully review the diff before committing.

## Recompile the template:

1. Check out the current mondo-edit from master: `git checkout master -- mondo-edit.obo`
1. In terminal: sh run.sh merge_template -B

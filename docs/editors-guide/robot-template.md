# Merging a ROBOT template into Mondo

_Updated 2021-08-05_

## Merging a ROBOT template into Mondo:

1. Create Google sheet with ROBOT template
1. Click File->Share->Publish to the Web
1. Publish the specific sheet as TSV
1. Copy the link to the TSV
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

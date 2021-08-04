# Merging a ROBOT template into Mondo

_Created 2021-07-20_

## Merging a ROBOT template into Mondo:
1. To merge a template, run the following command. This contains an example template: `sh run.sh make merge_template TEMPLATE_URL="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ_B9QERClTE_sgASKEgIpG428Hxud0T-glA6-7KGt4aDXW47V2A5RNjcnGHlqKrGgM8guuwcCkcFW0/pub?gid=577155275&single=true&output=tsv"`
`
2. If you just want to module a tsv you have edited locally, place it somewhere into the `src` directory and run:
`sh run.sh make merge_template MERGE_TEMPLATE="modules/name_of_your_template.tsv"`
3. As always, carefully review the diff before committing.
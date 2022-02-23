## Risky Obsoletions Check

### Overview

The pipeline outlined below will check if external databases or ontologies (such as ClinGen or EFO) are using our Mondo terms in their projects. If so, we should reconsider if we want to obsolete these terms. If we do, we need to notify them that the terms are candidates for obsoletion.

### Workflow
1. In terminal, run this command: `sh run.sh make risky_obsoletion_check`
1. This will output a list of terms that are in use by an external user. Note, you will see Error 1 at the end if there are terms being used by external sources.
1. Review the list of terms (it can be copied and pasted into a text file or spreadsheet)
1. If we want to continue with obsoleting terms that are used by external sources, add obsoletion tags to the terms via the [ROBOT template](https://docs.google.com/spreadsheets/d/1tt1Wk70j9XiHLV1vKQyNiHhaazh286pobpJk1ecSCCg/edit#gid=505727337). (See instructions [here](https://mondo.readthedocs.io/en/latest/editors-guide/robot-template/) to merge the ROBOT template.
1. Inform our users of the obsoletion candidates
  1. Post on [EFO's GitHub tracker](https://github.com/EBISPOT/efo/issues)
  1. Share with ClinGen via email
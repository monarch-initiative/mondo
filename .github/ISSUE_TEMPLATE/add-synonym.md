name: Add synonym
description: Request a new synonym to be added an existing Mondo term.
title: Request for new synonym [ADD NAME HERE]
labels: [ synonym ]
assignees: nicolevasilevsky

body:
  - type: markdown
    attributes:
      value: |
        Use this form to request a new ontology term be added to Mondo. See additional guidance here: https://mondo.readthedocs.io/en/latest/editors-guide/c-make-good-term-request/.
  - type: input
    id: term
    attributes:
      label: Mondo term
      description: Mondo term to which a synonym should be added.
      placeholder: ex. spindle cell rhabdomyosarcoma
    validations:
      required: true
  - type: input
    id: synonyms
    attributes:
      label: Synonyms
      description: Alternative term(s) or acroynymm for the term. Separate multiple synonyms by a comma.
      placeholder:  ex. SCRMS, SC rhabdomyosarcoma
    validations:
      required: false
  - type: dropdown
    id: synonym_type
    attributes:
      label: Synonym type
      description: Please indicate if the synonym is exact, broad, narrow or related. See [here for more explanation of synonym scope](https://mondo.readthedocs.io/en/latest/editors-guide/f-entities/#synonym-scope).
      options:
        - exact
        - broad
        - narrow
        - related
    validations:
      required: false

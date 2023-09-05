pattern_name: late

pattern_iri: http://purl.obolibrary.org/obo/mondo/patterns/late.yaml

description: 'An instance of a disease that has an onset of signs or symptoms of disease
  is after the age of 60 years (late onset).

  Examples: ['hereditary late onset Parkinson disease'](http://purl.obolibrary.org/obo/MONDO_0018466),
  ['''late-onset familial alzheimer disease'''](http://purl.obolibrary.org/obo/MONDO_0100088)'

contributors:
- https://orcid.org/0000-0002-6601-2165
- https://orcid.org/0000-0001-5208-3432

classes:
  late: HP:0003584
  disease: MONDO:0000001

relations:
  has modifier: RO:0002573

annotationProperties:
  exact_synonym: oio:hasExactSynonym
  related_synonym: oio:hasRelatedSynonym

vars:
  disease: '''disease'''

name:
  text: late %s
  vars:
  - disease

annotations:
- annotationProperty: exact_synonym
  text: late %s
  vars:
  - disease

def:
  text: An instance of %s that has a late onset.
  vars:
  - disease

equivalentTo:
  text: '%s and ''has modifier'' some ''late'''
  vars:
  - disease

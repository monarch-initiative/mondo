weight(-0.5, [object_source='DOID',  object_match_field='oio:hasDbXref']).
weight(0.5, [object_source='DOID',  object_match_field='rdfs:label']).
weight(-0.5, [object_source='DOID',  object_match_field='oio:hasExactSynonym']).
weight(-0.5, [object_source='OMIM',  object_match_field='rdfs:label']).
weight(-0.5, [object_source='Orphanet']).
weight(-0.5, [object_source='GARD']).
weight(-20, [object_source='NCBITaxon']).
weight(-20, [object_source='FBbt']).

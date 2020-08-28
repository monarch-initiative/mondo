ogs(X) :-
        entity_partition(X,ordo_group_of_disorders).

ogsu(X) :-
        ogs(X),
        \+ ((entity_xref_idspace(X,Z,S),
             S\='Orphanet',
             atom_concat('UMLS:CN',_,Z))).



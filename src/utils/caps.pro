repl(X,Y,S,S2):-
        entity_label_or_synonym(X,S),
        id_idspace(X,'MONDO'),
        downcase_atom(S,S2),
        entity_label_or_synonym(Y,S2).

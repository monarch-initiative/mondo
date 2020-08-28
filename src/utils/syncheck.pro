
r(C,D,CN,DN,CS,DS) :-
        entity_label_scope(C,CN,CS),
        downcase_atom(CN,X),
        subclassT(C,D),
        entity_label_scope(D,DN,DS),
        downcase_atom(DN,X).

        

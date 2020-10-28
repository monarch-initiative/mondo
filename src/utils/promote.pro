:- use_module(bio(index_util)).

ix :- materialize_index(subclassRT(+,+)).

p(C,G,S) :-
        subclass(C,G),
        \+ genus(C,_),
        parent(C,disease_has_basis_in_dysfunction_of,S),
        \+ ((parent(C,disease_has_basis_in_dysfunction_of,S2),
             S2\=S)),
        \+ ((subclassRT(Z,G),
             Z\=C,
             parent(Z,_,S))).


p2(C,G,S) :-
        subclassT(C,G),
        \+ genus(C,_),
        entity_xref(G,GX),
        id_idspace(GX,'OMIMPS'),
        parent(C,disease_has_basis_in_dysfunction_of,S),
        \+ ((parent(C,disease_has_basis_in_dysfunction_of,S2),
             S2\=S)),
        \+ ((subclassRT(Z,G),
             Z\=C,
             parent(Z,_,S))).


xrefrow(C,CN,S,XsA,M) :-
        class(C,CN),
        id_idspace(C,'MONDO'),
        setof(X,m(C,X,S,M),Xs),
        concat_atom(Xs,',',XsA).


equivalent_class_symm(C,X,S) :- 
        equivalent_class_symm(C,X),
        id_idspace(X,S).
        
m(C,X,S,equivalent) :-
        equivalent_class_symm(C,X,S).
m(C,X,S,M) :-
        entity_xref_idspace(C,X,S),
        \+ equivalent_class_symm(C,X,S),
        \+ ((equivalent_class_symm(C,X2,S),
             X2\=X)),
        \+ ((equivalent_class_symm(C2,X,S),
             C2\=C)),
        (   one_to_one_xref(C,X,S)
        ->  M=one_to_one
        ;   M=inexact).

m(C,X,S,R) :-
        parent(C,R,X),
        id_idspace(X,S).

m(C,X,S,has_phenotype) :-
        equivalent_class_symm(C,D),
        d2p(D,X),
        id_idspace(X,S).
m(C,X,S,has_finding) :-
        d2finding(C,_,X,_),
        id_idspace(X,S).

% COHD
cohd2x(D,DN,X,S,R) :-
        equivalent_class_symm(M,D,'COHD'),
        class(D,DN),
        id_idspace(M,'MONDO'),
        (   parent(M,R,X)
        ;   R=equivalent,
            X=M),
        id_idspace(X,S).




:- use_module(bio(index_util)).

rel(A,B,subClassOf) :- subclassT(A,B),!.
rel(A,B,superClassOf) :- subclassT(B,A),!.
rel(_,_,siblingOf).

ix :- materialize_index(dsyn(+,-,+)).
                       
dsyn(E2,S2,X) :-
        entity_label_or_exact_synonym(E2,S2),
        downcase_atom(S2,X).

        

x(E1,Sc1,E2,R,S1) :-
        entity_synonym_scope(E1,S1,Sc1),
        downcase_atom(S1,X),
        dsyn(E2,S2,X),
        E2\=E1,
        downcase_atom(S2,X),
        rel(E1,E2,R).


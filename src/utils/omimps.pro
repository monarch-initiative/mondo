:- use_module(bio(bioprolog_util)).
:- use_module(bio(metadata_nlp)).
:- use_module(bio(index_util)).

chx(C,PS,N1,N2,Diff1,Diff2) :-
        class(PS),
        id_idspace(PS,'OMIMPS'),
        entity_xref(C,PS),
        chx1(C,PS,N1,N2,Diff1,Diff2).
chx1(C,PS,N1,N2,Diff1,Diff2) :-
        debug(omimps,'D: ~w ~w',[C,PS]),
        solutions(X,subclass(X,PS),Set1),
        solutions(X,mgroup(X,C),Set2),
        sdiff(Set1,Set2,Diff1,Diff2,N1,N2).

mgroup(X,C) :-
        subclassRT(D,C),
        equivalent_class_symm(D,X),
        id_idspace(X,'OMIM').

sdiff(S1,S2,D1,D2,N1,N2) :-
        sdiff1(S1,S2,D1,N1),
        sdiff1(S2,S1,D2,N2).
   
sdiff1(S1,S2,D,N) :-
        ord_subtract(S1,S2,D_pre),
        maplist(ann,D_pre,D),
        length(S1,Len1),
        length(D,LenD),
        N is LenD / (Len1+LenD+1).

ann(X,X2) :-
        \+ entity_xref(_,X),
        !,
        atom_concat('@@@',X,X2).
ann(X,X).



ix :-
        materialize_index(entity_nlabel_scope_stemmed(+,+,-,-)).

nu(C,PS,N1,N2,Diff1,Diff2) :-
        class(PS),
        id_idspace(PS,'OMIMPS'),
        \+ entity_xref(_,PS),
        entity_nlabel_scope_stemmed(PS,T,_,_),
        entity_nlabel_scope_stemmed(C,T,_,_),
        id_idspace(C,'MONDO'),
        chx1(C,PS,N1,N2,Diff1,Diff2).


        
        

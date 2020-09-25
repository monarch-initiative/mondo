:- use_module(bio(metadata_nlp)).

gapfill(B,BX):-
        eqv(A,AX,S),
        id_idspace(A,'MONDO'),
        subclassT(A,B),
        entity_xref_idspace(B,BX,S),
        \+ eqv(B,BX,S),
        subclassT(B,C),
        eqv(C,CX,S),
        subclassT(AX,BX),
        subclassT(BX,CX).

eqv(A,AX,S) :-
        equivalent_class_symm(A,AX),
        id_idspace(AX,S).

x(A,AX) :-
        entity_xref_idspace(A,AX,S),
        id_idspace(A,'MONDO'),
        \+ \+ class(AX),
        \+ eqv(A,_,S),
        \+ eqv(_,AX,S),
        \+ \+ nmatch(A,AX).

nmatch(A,AX) :-
        class(A,AN),
        term_nlabel_stemmed(AN,N,St),
        class(AX,AXN),
        term_nlabel_stemmed(AXN,N,St).

x_u(A,AX) :-
        x(A,AX),
        \+ ((x(Z,AX),
             Z\=A)).




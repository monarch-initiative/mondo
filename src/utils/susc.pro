os(X) :-
        osr(R),
        subclass(X,R).
os(X,M,Z,MZ) :-
        osr(R),
        subclass(X,R),
        entity_xref(M,X),
        id_idspace(M,'MONDO'),
        restriction(X,_,Z),
        entity_xref(MZ,Z),
        id_idspace(MZ,'MONDO').

w :-
        os(X,M,_Z,MZ),
        class(M,MN),
        class(MZ,MZN),
        format('[Term]~n'),
        format('id: ~w ! ~w~n',[M,MN]),
        format('is_a: MONDO:0020573 {source="~w"} ! hereditary predisposition to disease~n',[X]),
        format('relationship: predisposes_towards ~w ! ~w~n',[MZ,MZN]),
        nl,
        fail.

dual(X,Y) :-
        S='MONDO:0042489',
        subclassT(X,S),subclassT(X,Y),subclass(Y,'MONDO:0000001'),
        Y\='MONDO:0003847',Y\='MONDO:0003847',Y\='MONDO:0021200',Y\='MONDO:0042489'.



osr('OMIM:000000').

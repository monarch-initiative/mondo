
ec(C,X,S) :-
        equivalent_class_symm(C,X),
        id_idspace(X,S).

% find prototypical classes, e.g. FOO and FOO type 1
% where one OMIM class is inferred to be subclass of another
proto(C,X1) :-
        proto(C,X1,_,_).

proto(C,X1,D,X2) :-
        ec(C,X1,'OMIM'),
        subclass(D,C),
        ec(D,X2,'OMIM').

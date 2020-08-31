x(X):-
        class(X),
        entity_xref_idspace(X,_,'DC'),
        \+ ((entity_xref_idspace(X,_,S),S\='DC')),
        forall(subclass(Y,X),
               has_p(Y)).

x(X,R):-
        class(X),
        entity_xref_idspace(X,_,'DC'),
        \+ ((entity_xref_idspace(X,_,S),S\='DC')),
        subclass(Y,X),has_p(Y,R,X),
        forall(subclass(Y2,X),
               has_p(Y2,R,X)).

has_p(Y,X):- has_p(Y,_,X).
has_p(Y,Z,X):- subclass(Y,Z),Z\=X,\+class(Z,'disease'),\+class(Z,'genetic disease'), \+class(Z,'genetic disorder').


d2g(D,R,G) :-
        subclassT(G,'Orphanet:410298'),
        parent(G,R,D),
        subclassT(D,'Orphanet:377788').

        
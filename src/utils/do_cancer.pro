mixup(X,Y,N1,N2) :-
        entity_label_or_synonym(X,N1),
        benign(N1),
        ancdec(X,Y),
        entity_label_or_synonym(Y,N2),
        malignant(N2).

benign(N) :-
        sub_atom(N,_,_,_,benign).
malignant(N) :-
        sub_atom(N,_,_,_,malignant).
malignant(N) :-
        sub_atom(N,_,_,_,cancer).

ancdec(X,Y) :- subclassRT(X,Y).
ancdec(X,Y) :- subclassRT(Y,X).

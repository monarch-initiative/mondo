:- use_module(bio(index_util)).
:- use_module(bio(metadata_nlp)).

ix :-
        materialize_index(cn(+,+)).

cn(X,XN) :-
        class(X,XN1),
        term_nlabel_stemmed(XN1,XN,false).

m(X,Y) :-
        cn(X,N),
        cn(Y,N),
        X@<Y,
        \+ is_omim_equiv(X),
        \+ is_omim_equiv(Y),
        \+ entity_partition(X,clingen),
        \+ entity_partition(Y,clingen),
        \+ def_xref(Y,'DOID'),
        \+ ((genus(X,_),genus(Y,_))),
        \+ ((equivalent_class_symm(X,Z),
             equivalent_class_symm(Y,Z))).

is_omim_equiv(C) :-
        equivalent_class_symm(C,X),
        id_idspace(X,'OMIM').

badm(X,Y) :-
        cn(X,N),
        cn(Y,N),
        X@<Y,
        \+ \+ ((equivalent_class_symm(X,Z),
                equivalent_class_symm(Y,Z))).
badm(X,Y) :-
        cn(X,N),
        cn(Y,N),
        X@<Y,
        genus(X,_),
        genus(Y,_).
badm(X,Y) :-
        cn(X,N),
        cn(Y,N),
        X\=Y,
        entity_partition(X,clingen).

        

zzzm(X2,Y2) :-
        x(X,Y),
        (   e(Y,Z),
            atom_concat('DOID:',_,Z)
        ->  [Y2,X2] = [X,Y]
        ;   [X2,Y2] = [X,Y]).

w :-
        format('owltools mondo-edit.obo \\~n',[]),
        fail.

w :-
        m(X,Y),
        %class(X,XN),
        %class(Y,YN),
        sformat(S, '--obsolete-replace ~w ~w \\~n',[X,Y]),
        write(S),
        fail.

w :-
        write(' -o -f obo z~n~n'),
        fail.






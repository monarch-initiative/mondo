:- ['mondo_queries.pro'].

:- srule(references_obsolete,[referencing_object,deprecated_object]).
references_obsolete(R,C) :-
        dep(C),
        (   subClassOf(R,C)
        ;   owl_some(R,_,C)).


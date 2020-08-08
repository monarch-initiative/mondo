:- ['mondo_queries.pro'].
:- use_module(library(sparqlprog/ontologies/owl),[subClassOf_axiom/3]).

subClassOf_src(C,D,S,NS) :-
        subClassOf_axiom(C,D,A),
        rdf(A,oio:source,S),
        curie_ns(S,NS).

% an isa supported only be ordo
ordo_only_isa(C,D,S) :-
        subClassOf_src(C,D,S,"Orphanet"),
        \+ ((subClassOf_src(C,D,_,X),
             X\="Orphanet")).

ordo_only_class(C) :-
        xref_prefix(C,_,"Orphanet"),
        \+ ((xref_prefix(C,_,X),
             X\="Orphanet")).

% same, but where parent is also ordo-only
ordo_only_isa_ordo(C,D,S) :-
        ordo_only_isa(C,D,S),
        ordo_only_class(C),
        ordo_only_class(D).
        



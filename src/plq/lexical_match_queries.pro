:- ['mondo_queries.pro'].
:- use_module(library(tabling)).
:- use_module(library(sparqlprog/emulate_builtins)).

:- srule(same_label,[c1,c2],
         'c1 and c2 share the same label and neither are deprecated').
same_label(A,B) :-
        rdf(A,rdfs:label,N),
        rdf(B,rdfs:label,N),
        \+ dep(A),
        \+ dep(B),
        A\=B.

same_label_asym(A,B) :-
        same_label(A,B),
        A@<B.

:- srule(same_label_ci,[c1,c2],
         'As same_label/2, case-insenstive').
same_label_ci(A,B) :-
        lcase_label(A,N),
        lcase_label(B,N).

% C has lower-case label N
lcase_label(C,N) :-
        rdf(C,rdfs:label,N1),
        lcase(N1,N).

% A and B have the same label and are in different graphs
xgraph_same_label(A,B) :-
        rdf(A,rdfs:label,N,G1),
        rdf(B,rdfs:label,N,G2),
        G1\=G2,
        A\=B.

:- srule(label_matches_exact_syn,[c1,c2]).
label_matches_exact_syn(A,B) :-
        rdf(A,rdfs:label,N),
        has_exact_synonym(B,N),
        \+ dep(A),
        \+ dep(B),
        A\=B.

%% shared_xref(?A:iri, ?B:iri, ?X:literal) is nondet
% true if both A and B have X as xref. X is a literal
shared_xref(A,B,X) :-
        has_dbxref(A,X),
        has_dbxref(B,X).

label_matches_exact_syn_shx(A,B,X) :-
        label_matches_exact_syn(A,B),
        shared_xref(A,B,X).

label_matches_exact_syn_shxl(A,B,Xs) :-
        label_matches_exact_syn(A,B),
        solutions(X,shared_xref(A,B,X),Xs).


untrusted("DOID").
unmergeable(A,B) :-
        equiv_from_xref(A,_AX,S),
        %\+ untrusted(S),
        equiv_from_xref(B,_BX,S).

:- srule(exact_syn_match_mergeable,[c1,c2,syn]).
exact_syn_match_mergeable(A,B,Syn) :-
        has_exact_synonym(A,Syn),        
        has_exact_synonym(B,Syn),
        A@<B,
        \+ unmergeable(A,B).

:- srule(candidate_xref_equiv,[cls,extCls,axiomSrc],
         'xref exists between cls and extCls, no equiv axioms').
candidate_xref_equiv(C,X,S) :-
        xref_prefix(C,Xc,P),
        xref_src(C,Xc,S),
        \+ equiv_from_xref(C,_,P),
        \+ equiv_from_xref(_,Xc,P),
        debug(q,'Expanding: ~q',[Xc]),
        curie_uri(Xc,X).

:- srule(candidate_xref_equiv,[cls,extCls,axiomSrc],
         'xref exists between cls and extCls, no equiv axioms, and is 1-to-1').
candidate_xref_equiv_uniq(C,X,S) :-
        % candidate
        xref_prefix(C,Xc,P),
        xref_src(C,Xc,S),
        % as yet unclaimed
        \+ xref_has_semantics(C,Xc),
        % uniq
        \+ ((xref_prefix(C,Z,P),
             Z\=Xc)),
        \+ ((xref_prefix(Z,Xc,P),
             Z\=C)),
        % nb: these not strictly necessary?
        \+ equiv_from_xref(C,_,P),
        \+ equiv_from_xref(_,Xc,P),
        \+ ((xref_prefix(C,X2,P),
             X2\=X2)),
        \+ ((xref_prefix(C2,Xc,P),
             C2\=C)),
        curie_uri(Xc,X).

:- srule(candidate_xref_equiv_match,[cls,extCls,axiomSrc],
         'As candidate_xref_equiv/3, include lexical match').
candidate_xref_equiv_uniq_match(C,X,S) :-
        candidate_xref_equiv_uniq(C,X,S),
        has_label_or_syn_dn(C,N),
        has_label_or_syn_dn(X,N).

has_label_or_syn_dn(C,N) :-
        has_label_or_syn(C,N1),
        lcase(N1,N).
has_label_or_syn(C,N) :-    label(C,N).
has_label_or_syn(C,N) :-    has_exact_synonym(C,N).
has_label_or_syn(C,N) :-    has_related_synonym(C,N).

        

xref_has_semantics(C,X) :-
        xref_src(C,X,S),
        str_starts(S,"MONDO").

m1(C,X,S) :-
        candidate_xref_equiv_uniq(C,X,S),
        lcase_label(C,N),
        lcase_label(X,N).

:- rdf_meta namepred(r).
namepred(rdfs:label).
namepred(oio:hasExactSynonym).
namepred(oio:hasRelatedSynonym).
namepred(oio:hasNarrowSynonym).
namepred(oio:hasBroadSynonym).


%% mutate(?Transform, +Pred, +Value:atom, ?MutatedValue:atom)
mutate(stem,_,V,V2) :-
        custom_porter_stem(V,V2).
mutate(downcase,_,V,V2) :-
        downcase_atom(V,V2).

custom_porter_stem(T,S) :-
        atom_concat(X,eous,T),
        atom_concat(X,eus,T2),
        !,
        porter_stem(T2,S).
custom_porter_stem(T,S) :-
        porter_stem(T,S).

:- table class_mutated_name/5.
class_mutated_name(C,T,P,V,V2) :-
        namepred(P),
        rdf(C,P,Lit),
        ensure_atom(Lit,V),
        mutate(T,P,V,V2).

match_all(Label,P,C) :-
        % loaded externally
        disease_label(Label),
        label_match_ext(Label,P,C).
                    
label_match(Label,P,C) :-
        mutate(T, label, Label, N),
        class_mutated_name(C, T, P, _, N).


label_match_ext(Label,P,C) :-
        label_match(Label,P,C),
        \+ already_have(C),
        \+ ((label_match(Label,_,C2),
             already_have(C2))).

:- table already_have/1.
already_have(C) :-
        uri_prefix(C,Prefix),
        already_have_prefix(Prefix).
already_have(C) :-
        has_dbxref(_,X),
        curie_uri(X,C).

already_have_prefix('MONDO').
already_have_prefix('HP').

uri_prefix(IRI,Prefix) :-
        rdf_global_id(Prefix:_,IRI).



        
        

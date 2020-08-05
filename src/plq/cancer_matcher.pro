:- ['mondo_queries.pro'].
:- ['vocab_obo.pro'].

:- use_module(library(index_util)).
:- use_module(library(rdf_matcher)).
:- use_module(library(tabling)).


normalize(V,V2,0) :-    replace_term(V,'ö',o,V2).
normalize(V,V2,0) :-    replace_term(V,'ö',oe,V2).
normalize(V,V2,0) :-    replace_term(V,'-',' ',V2).
normalize(V,V2,0) :-    replace_term(V,'\'s','',V2).
normalize(V,V2,1) :-    replace_term(V,disorder,disease,V2).
normalize(V,V2,1) :-    relational_adj_ra(Adj,Noun,_),atom_concat(Adj,' ',Adj1),atom_concat(Noun,' ',Noun1),replace_term(V,Noun1,Adj1,V2).
normalize(V,V2,0) :-    replace_term(V,tumors,tumor,V2).
normalize(V,V2,0) :-    replace_term(V,tumour,tumor,V2).
normalize(V,V2,1) :-    replace_term(V,tumor,neoplasm,V2).
normalize(V,V2,0) :-    concat_atom([A,B],' of ',V),concat_atom([B,A],' ',V2).
normalize(V,V,0).
normalize(V,V2,5) :- concat_atom([A,B],'/',V), (V2=A;V2=B).
normalize(V,V2,3) :- concat_atom([A,B],' - ',V), (V2=A;V2=B).
normalize(V,V2,5) :- concat_atom([V2,_|_],', ',V).

:- table recursive_normalize/3.
recursive_normalize(V,V2,P) :- normalize(V,V2,P).
recursive_normalize(V,V2,P) :- normalize(V,Z,P1), Z\=V, recursive_normalize(Z,V2,P2), P is P1+P2, P > 0.

replace_term(V,Src,Tgt,V2) :-
        concat_atom(L,Src,V),
        L=[_,_|_],
        concat_atom(L,Tgt,V2).

term_best_match(V, C, S, P) :-
        debug(matcher,'Matching: ~w',[V]),
        setof(C-S,term_match_score(V, C, S, P),Pairs),
        member(C-S,Pairs),
        \+ ((member(_-S2,Pairs),S2>S)).

:- table term_match_score/3.
term_match_score(V, C, S, P) :-
        mutate(_, label, V, V2),
        call_unique(recursive_normalize(V2,V3,Penalty)),
        debug(matcher,'  Normalized: ~w -> ~w',[V,V3]),
        term_match_score1(V3, C, S1),
        uri_prefix(C, P),
        S is S1-Penalty.


term_match_score1(V, C, S) :-
        tr_annot(C,P,V,_,_,_),
        prop_score(P,S).
term_match_score1(V, C, S) :-
        atom_concat(V,' cancer',V2),
        tr_annot(C,P,V2,_,_,_),
        prop_score(P,S).
term_match_score1(V, C, S) :-
        atom_concat(V,' (disease)',V2),
        tr_annot(C,P,V2,_,_,_),
        prop_score(P,S).
term_match_score1(V, C, S) :-
        atom_concat(V,' cancer (disease)',V2),
        tr_annot(C,P,V2,_,_,_),
        prop_score(P,S).
term_match_score1(V, C, S) :-
        atom_concat(V,' neoplasm',V2),
        tr_annot(C,P,V2,_,_,_),
        prop_score(P,S).
term_match_score1(V, C, S) :-
        atom_concat(V,', nos',V2),
        tr_annot(C,P,V2,_,_,_),
        prop_score(P,S).
term_match_score1(V, C, S) :-
        atom_concat('all ',V2, V),
        tr_annot(C,P,V2,_,_,_),
        prop_score(P,S).
term_match_score1(V, C, S) :-
        atom_concat(V,' malignant neoplasm',V2),
        tr_annot(C,P,V2,_,_,_),
        prop_score(P,S).
term_match_score1(V, C, S) :-
        atom_concat('unknown ',V2,V),
        tr_annot(C,P,V2,_,_,_),
        prop_score(P,S).
term_match_score1(V, C, S) :-
        atom_concat('primary ',V2,V),
        tr_annot(C,P,V2,_,_,_),
        prop_score(P,S).
term_match_score1(_,null,-99).

prop_score(label,10).
prop_score(exact,8).
prop_score(related,4).
prop_score(broad,1).
prop_score(narrow,1).


all_matches(V,C,S,P) :-
        t(V),
        term_best_match(V,C,S,P).
all_matches(V,null,-99,null) :-
        t(V),
        \+ term_match_score(V,_,_,_).

/*

  

*/
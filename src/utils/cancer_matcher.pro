:- [mondo_queries].

term_best_match(V, C, S) :-
        term_match_score(V, C, S),
        \+ ((term_match_score(V, C2, S2),
            C2\=C,
            S2>S2)).

:- table term_match_score/3.
term_match_score(V, C, S) :-
        mutate(_, label, V, V2),
        term_match_score1(V2, C, S).
term_match_score1(V, C, S) :-
        tr_annot(C,P,V,_,_,_),
        prop_score(P,S).
term_match_score1(V, C, S) :-
        atom_concat(V,' cancer',V2),
        tr_annot(C,P,V2,_,_,_),
        prop_score(P,S).
term_match_score1(V, C, S) :-
        atom_concat(V,' neoplasm',V2),
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
term_match_score1(_,null,-99).



all_matches(V,C,S) :-
        t(V),
        term_match_score(V,C,S).


%% subset S1 is subsumed by subset S2 (for some class pair)
ssrel(S1,S2):-
        ssrel(S1,S2,_,_).
ssrel(S1,S2,C1,C2):-
        subclass(C1,C2),
        inf_subset(C1,S1),
        inf_subset(C2,S2).

inf_subset1(C,S):-
        entity_partition(C,S),
        ordo(S),
        !.
inf_subset(C,S):- inf_subset1(C,S).

inf_subset(C,S):-
        subclass(C,D),
        inf_subset1(D,S),
        !.
inf_subset(C,S):-
        subclass(C,D),
        inf_subset(D,S),
        !.

ordo(S) :-
        atom_concat('ordo_',_,S),
        S\=ordo_inheritance_inconsistent.

is_subtype(S):-
        sub_atom(S,_,_,_,subtype).

bad(C1,C2,S1,S2):-
        ssrel(S1,S2,C1,C2),
        S1=ordo_group_of_disorders,
        is_subtype(S2).

        
level(warn,ordo_disease,ordo_disease).
level(warn,ordo_etiological_subtype,ordo_etiological_subtype).
level(error, ordo_group_of_disorders, ordo_disease).


        
/*

perl -npe 's@subset: (\S+).*@subset: $1@' mondo-edit.obo > mondo-ss.obo

*/

sibling(C1,C2,A) :- subclass(C1,A),subclass(C2,A), C1@<C2.

ix :-
        materialize_index(pattern(+,+)).

cls_split(C,Base,Num) :-
        entity_label_or_synonym(C,N),
        split_number(N,Base,Num).

        
pattern(A,Base) :-
        cls_split(C1,Base,_Num1),
        sibling(C1,C2,A),
        cls_split(C2,Base,_Num2).

pattern_wp(A,Base) :-
        pattern(A,Base),
        entity_label_or_synonym(A,AN1),
        downcase_atom(AN1,Base).

missing_parent(A,Base) :-
        pattern(A,Base),
        \+ pattern_wp(_,Base).

missing_child(C,Base) :-
        pattern_wp(A,Base),
        subclass(C,A),
        \+ cls_split(C,Base,_).

split_number(N,Base,Num) :-
        atom_concat(Base1,Num,N),
        atom_chars(Num,[C|_]),
        char_type(C,digit),
        downcase_atom(Base1, Base).


        
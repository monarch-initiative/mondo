replace_name(C, CN, NewName):-
        entity_xref(P,PX),
        id_idspace(PX,'OMIMPS'),
        class(P,PN),
        downcase_atom(PN,PNd),
        subclassT(C,P),
        class(C,CN),
        downcase_atom(CN,CNd),
        entity_synonym(C,CN2),
        downcase_atom(CN2,CN2d),
        atom_concat(PNd,Suffix,CN2d),
        ok_suffix(Suffix),
        atom_concat(_,Suffix,CN),
        CN2d \= CNd,
        atom_concat(PN,Suffix,NewName).

ok_suffix(Suffix) :-
        atom_concat(' ',S2,Suffix),
        concat_atom(Parts,' ',S2),
        (   Parts=[type,Rest],
            !
        ;   Parts=[Rest]),
        atom_chars(Rest,[C|_]),
        C@>='0',
        C@=<'9'.

        
        
        
        

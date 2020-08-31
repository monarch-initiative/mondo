d(X,AN2) :-
        class(X,N),
        \+entity_xref(_,X),
        atom_concat('disorder of ',AN,N),
        trim(AN,AN2).

trim(N,N2) :-
        atom_concat(N2,' (disorder)',N), !.
trim(N,N).


x :-
        d(X,AN),
        \+ id_idspace(X,'MONDO'),
        entity_label_or_exact_synonym(A,AN),
        class(A,AN2),
        class(X,XN),
        
        findall(EN,(subclass(E,X),entity_xref(EM,E),class(EM,EN)),Examples),
        concat_atom(Examples,', ',ExamplesA),
        format('[Term]\n'),
        format('id: MONDO:design_pattern\n'),
        format('name: ~w disease\n',[AN2]),
        format('synonym: "~w disease" EXACT [MONDO:design_pattern]\n',[AN]),
        format('synonym: "disorder of ~w" EXACT [MONDO:design_pattern]\n',[AN]),
        format('synonym: "disorder of ~w" EXACT [MONDO:design_pattern]\n',[AN2]),
        forall((subclass(X,XP),entity_xref(MXP,XP),class(MXP,MXPN)),
               format('is_a: ~w ! ~w\n',[MXP,MXPN])),
        format('intersection_of: MONDO:0000001 ! disease or disorder\n',[]),
        format('intersection_of: disease_has_location ~w ! ~w\n',[A,AN2]),
        (   ExamplesA=''
        ->  true
        ;   format('comment: Examples: ~w\n',[ExamplesA])),
        format('xref: ~w {source="MONDO:equivalentTo"} ! ~w\n',[X,XN]),
        nl,
        fail.

        
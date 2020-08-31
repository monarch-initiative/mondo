fill(C,A,TN,TX,TXN) :-
        cancer(C,A),
        \+ neoplasm(_,A),
        entity_label_or_exact_synonym(A,AN),
        concat_atom([AN,neoplasm],' ',TN),
        entity_xref_idspace(C,CX,'NCIT'),
        subclass(CX,TX),
        class(TX,TXN),
        \+ eqv(_,TX),
        nmatch(TX,TN).


w :-
        maxid(Num),
        nb_setval(maxid,Num),
        forall_distinct(fill(C,A,TN,TX,TXN),
                        w(C,A,TN,TX,TXN)).

w(_C,A,TN,TX,TXN) :-
        nb_getval(maxid,Num),
        Num2 is Num+1,
        nb_setval(maxid,Num2),
        class(A,AN),
        format('[Term]~n'),
        format('id: MONDO:~|~`0t~d~7+~n',[Num2]),
        format('name: ~w~n',[TN]),
        format('xref: ~w {source="MONDO:equivalentTo"} ! ~w~n',[TX,TXN]),
        format('intersection_of: MONDO:0005070 ! neoplasm (disease)~n',[]),
        format('intersection_of: disease_has_location ~w ! ~w~n',[A,AN]),
        nl.

maxid(N) :-
        aggregate(max(X),midnum(X),N).

midnum(X) :-
        class(C),
        atom_concat('MONDO:',NA,C),
        atom_number(NA,X).
        

        

nmatch(C,N) :-
        downcase_atom(N,N2),
        entity_label_or_synonym(C,CN),
        downcase_atom(CN,N2),
        !.


% INCOMPLETE; due to perl obo parsing bug...
eqv(C,X) :-
        entity_xref(C,X),
        reification(annotation('source','MONDO:equivalentTo'),metadata_db:entity_xref(C,X)),
        !.

eqv_nd(C,X) :-
        reification(annotation('source','MONDO:equivalentTo'),metadata_db:entity_xref(C,X)).


cancer(D,A) :-
        genus(D,'MONDO:0004992'),
        differentium(D,disease_has_location,A),
        class_cdef(D,cdef(_,[_])).


neoplasm(D,A) :-
        genus(D,'MONDO:0005070'),
        differentium(D,disease_has_location,A).

        

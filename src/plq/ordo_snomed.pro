:- ['mondo_queries.pro'].

:- rdf_register_prefix('SCTID','http://purl.obolibrary.org/obo/SCTID_').

mondo_ordo(M,C) :-
        owl_equivalent_class_asserted_symm(C,M),
        uri_prefix(C,'Orphanet').
mondo_ordo(M,C,S) :-
        mondo_ordo(M,C),
        (   in_subset(C,S)
        ->  true
        ;   S='no_subset').

bad_ordo_equiv(M,C) :-
        mondo_ordo(M,C),
        rdfs_subclass_of(C,'Orphanet':'C010').


mondo_snomed(M,X) :-
        owl_equivalent_class_asserted_symm(X,M),
        uri_prefix(X,'SCTID').

ordo_snomed(C,X) :-
        mondo_ordo(M,C),
        mondo_snomed(M,X).

ordo_no_snomed(C) :-
        mondo_ordo(M,C),
        \+ mondo_snomed(M,_).


ix :-
        materialize_index(subclassT(+,+)),
        materialize_index(genetic(+)),
        materialize_index(genetic_lineage(+)).
        

genetic(D) :-
        parent(D,_,X),
        atom_concat('http://identifiers.org/hgnc/',_,X).

genetic(D) :- equivalent_class_symm(D,X), id_idspace(X,'OMIM').
genetic(D) :- equivalent_class_symm(D,X), id_idspace(X,'DECIPHER').
genetic(D) :- equivalent_class_symm(D,X), \+ \+ d2p(X,_).

genetic('MONDO:0021198'). % rare genetic
genetic('MONDO:0021200'). % rare (not necessarily genetic, but we overload)
genetic('MONDO:0003847').  % IGD


genetic_lineage(D) :-
        genetic(D1), subclassRT(D1,D).
genetic_lineage(D) :-
        genetic(D1), subclassT(D,D1).


common_to_mondo(X,M) :-
        equivalent_class_symm(M,X),
        id_idspace(M,'MONDO'),
        \+ genetic_lineage(M).

/*

  blip-findall -debug index -goal ix -i imports/equivalencies.obo  -r mondoe -c ../utils/all_genetic.pro common_to_mondo/2 -label -no_pred -use_tabs  > z
%  ::: Welcome to blip (Version unknown) :::
% ../utils/all_genetic.pro compiled into blipkit 0.00 sec, 6 clauses
% /Users/cjm/repos/mondo-build/src/ontology/mondo-edit.qlf loaded into ontol_db 0.52 sec, 749,770 clauses
% imports/equivalencies.qlf loaded into ontol_db 0.10 sec, 145,038 clauses
% indexing blipkit:subclassT(+,+)
% rewriting subclassT(_G2260,_G2261)

*/
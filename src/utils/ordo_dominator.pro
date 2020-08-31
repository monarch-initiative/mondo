
% Orphanet:C016
d2mode(D,Mode,ORDO) :-
        moi(Root,_N,Mode,OrdoMode),
        parent(ORDO, 'Orphanet:C016', OrdoMode),
        equivalent_class_symm(ORDO,D),
        \+ \+ subclassT(D,Root).


w :-
        d2mode(D,Mode,ORDO),
        class(D,DN),
        class(Mode,MN),
        format('[Term]~n'),
        format('id: ~w ! ~w~n',[D,DN]),
        format('relationship: has_modifier ~w {source="~w"} ! ~w~n',[Mode,ORDO,MN]),
        nl,
        fail.


%moi('MONDO:0000425', 'X-linked', 'HP:0001417').
%moi('MONDO:0000425', 'X-linked', 'HP:0001417').
moi('MONDO:0006025', 'autosomal recessive', 'HP:0000007', 'Orphanet:409930').
moi('MONDO:0000426', 'autosomal dominant', 'HP:0000006', 'Orphanet:409929').

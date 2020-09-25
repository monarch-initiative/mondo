moi('MONDO:0006025', 'autosomal recessive', 'HP:0000007').
moi('MONDO:0000426', 'autosomal dominant', 'HP:0000006').
moi('MONDO:0000425', 'X-linked', 'HP:0001417').

d2mode(D,Mode,OMIM) :-
        moi(Root,_N,Mode),
        d2p(OMIM, Mode),
        equivalent_class_symm(OMIM,D),
        \+ \+ subclassT(D,Root).

w :-
        d2mode(D,Mode,OMIM),
        class(D,DN),
        class(Mode,MN),
        format('[Term]~n'),
        format('id: ~w ! ~w~n',[D,DN]),
        format('relationship: has_modifier ~w {source="HPOA", source="~w"} ! ~w~n',[Mode,OMIM,MN]),
        nl,
        fail.


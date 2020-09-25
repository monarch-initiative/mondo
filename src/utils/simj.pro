:- use_module(bio(index_util)).

/*

  finds matches based on simj of descendants
  
*/

match(X,C,Score) :-
        match(X,C,Score,_).

match(X,C,Score,NumI) :-
        setof(D,subclassT(D,X),XDs),
        length(XDs,NumXDs),
        NumXDs < 500,
        match_idspace(X,S),
        class(C),
        \+ \+ ((member(D,XDs),xdescendant_of_in(D,C,S))),
        debug(simj,'Testing ~w',[C]),
        setof(D,xdescendant_of_in(D,C,S),CDs),
        ord_intersection(CDs,XDs,SetI),
        SetI=[_,_|_],
        ord_union(CDs,XDs,SetU),
        length(SetI,NumI),
        length(SetU,NumU),
        Score is NumI/NumU.

xmatch(S,X,C,Score,N,IsX,IsEq,HasMatch) :-
        class(X),
        id_idspace(X,S),
        match(X,C,Score,N),
        check(entity_xref(C,X),IsX),
        \+ ((Score < 0.5, IsX=false)),
        check(xref_equiv(C,X),IsEq),
        check(xref_equiv(_,X),HasMatch).

check(G,true) :- G,!.
check(_,false).
        

xdescendant_of_in(DX,C,S) :-
        subclassRT(D,C),
        entity_xref_idspace(D,DX,S),
        xref_equiv(D,DX).

%incomplete
%xref_equiv(D,DX) :-
%        reification(annotation('source', 'MONDO:equivalentTo'), metadata_db:entity_xref(D,DX)).

xref_equiv(D,DX) :- equivalent_class(D,DX).
xref_equiv(D,DX) :- equivalent_class(DX,D).

match_idspace(X,'OMIM') :-  id_idspace(X,'OMIMPS'), !.
match_idspace(X,S) :-  id_idspace(X,S).

ix1 :-
        materialize_index(subclassT(+,+)),
        materialize_index(subclassRT(+,+)),
        materialize_index(xref_equiv(+,+)).

ix :-
        ix1,
        materialize_index(xdescendant_of_in(+,+,+)).


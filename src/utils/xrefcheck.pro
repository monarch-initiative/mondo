
/*

  perl -npe 's@source="MONDO:(equiv|sub|sup|other|rel)@semantics="MONDO:$1@i'
  
  reification(annotation('source', 'DOID:0060319'), metadata_db:entity_xref('MONDO:0000745', 'UMLS:C0600228')).
*/


xrel(C,X,R) :-
        reification(annotation('source',XR), metadata_db:entity_xref(C,X)),
        downcase_atom(XR,XR2),
        xr_rel(XR2,R).

xr_rel(N,equivalent) :- sub_atom(N,_,_,_,'equivalent'),!.
xr_rel(N,subclass) :- sub_atom(N,_,_,_,'subclass'),!.
xr_rel(N,superclass) :- sub_atom(N,_,_,_,'superclass'),!.

merge(C1,C2,X) :-
        xrel(C1,X,equivalent),
        xrel(C2,X,equivalent),
        C1@<C2.
xmerge(X1,X2,C) :-
        xrel(C,X1,equivalent),
        xrel(C,X2,equivalent),        
        X1@<X2,
        id_idspace(X1,S),
        id_idspace(X2,S).


missing(X,C) :-
        xrel(C,X,R),
        R\=equivalent,
        \+ xrel(_,X,equivalent).

grouper(P) :-
        xrel(P,X,superclass),
        id_idspace(X,S),
        findall(Y,(xrel(P,Y,superclass),id_idspace(Y,S)),Ys),
        length(Ys,N),
        N > 10,
        \+ ((xrel(P,Y,R),id_idspace(Y,S),R\=superclass)).

% TODO
grouper(P,X,N) :-
        xrel(C,X,subclass),
        subclass(C,P),
        xrel(P,X,equivalent),
        debug(grouper,'candidate ~w < ~w ~w',[C,P,X]),
        findall(C2,(subclass(C2,P),xrel(C2,X,subclass)),Ys),
        debug(grouper,' Ys ~w',[Ys]),
        length(Ys,N),
        N > 10,
        \+ ((subclass(C2,P),xrel(C2,X,R),R\=subclass)).

rare(C,G) :-
        class_cdef(C,cdef(G,[has_modifier='MONDO:0021136'])).


rare_gci(C,G,Z,D) :-
        rare(C,G),
        subclassRT(C,Z),
        subclass(Z,D),
        parent(D,has_modifier,M),
        inherited(M),
        \+ subclassRT(G,D).


inherited('MONDO:0021152').
inherited('MONDO:0021150').

/*

  finds ordo hidden GCIs, where we have a "rare X" being a descendant of a "rare genetic X"
  
  */


slim(M,P,PX) :-
        (   C=M
        ;   entity_xref(C,M),
            id_idspace(C,'MONDO')),
        subclassRT(C,P),
        entity_xref(P,PX),
        entity_partition(PX,'TopNodes_DOcancerslim').

slim_nr(M,P,PX) :-
        slim(M,P,PX),
        \+ ((slim(M,P2,_),
             subclassT(P2,P))).

/*

  blip-findall -c ../utils/topnode.pro -i z.pro -r mondo -r disease "m(M),slim_nr(M,P,PX)" -select "x(M,P,PX)" -label -use_tabs -no_pred | sort -u

  */
        
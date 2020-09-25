
neoplasm_location(C,G,L) :-
        class_cdef(C,cdef(G,[disease_has_location=L])),
        subclassRT(G,X),
        n(X).


viol(D,A1,A2,L1,L2) :-
        neoplasm_location(A1,G,L1),
        subclassT(D,A1),
        subclassT(D,A2),
        neoplasm_location(A2,G,L2),
        %writeln(checking(L1,L2,G)),
        L1\=L2.

xviol(D,A1,A2,L1,L2) :-
        subclassT(D,N),
        n(N),
        subclassT(D,A1),
        neoplasm_location(A1,G,L1),
        subclassT(D,A2),
        neoplasm_location(A1,G,L2),
        \+ parentRT(L1,L2),
        \+ parentRT(L2,L1).

ix :-        
        materialize_index(neoplasm_location(+,+,-)).

xix :-        
        materialize_index(subclassT(+,+)),
        materialize_index(neoplasm_location(+,+,-)).

        


n('MONDO:0005070'). % neoplasm (disease)

/*

blip-findall -u index_util -debug index -goal ix -r uberons  -r mondo -i mondo-base.obo -i ../utils/neoplasm_loc.pro viol/5
*/

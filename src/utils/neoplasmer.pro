:- use_module(bio(index_util)).


ix :-
        materialize_index(cn(+,+)),
        materialize_index(ngenus(+)),
        materialize_index(xsubclassRT(+,+)),
        materialize_index(anat(+)).

% class name normalized
cn(C,N) :- entity_label_or_synonym(C,N1),downcase_atom(N1,N).
cn(C,N) :- inst_sv(C,has_relational_adjective,N,_).

% G is a genus
ngenus(G) :- n(N),genus(_,G),subclassRT(G,N),\+ \+ class_cdef(_,cdef(G,[disease_has_location=_])), \+ differentium(G,disease_has_location,_).
% generalize:
%ngenus(G) :- genus(_,G),\+ \+ class_cdef(_,cdef(G,[disease_has_location=_])), \+ differentium(G,disease_has_location,_).

% A is a structure
anat(A) :- ngenus(G),genus(C,G),differentium(C,disease_has_location,A1),anrel(A1,A).

% new class expression, not yet enumerated
nu(G,A) :- ngenus(G),anat(A),\+ class_cdef(_,cdef(G,[_=A])).

%! nu_match(?Genus,?Anat,?NameInExtOnt,?Xrefs:list) is nondet
% 
% new class expression matching an ontology class
nu_match(G,A,N,Xs) :-
        nu(G,A),
        genlabel(G,A,N),
        setof(X,cn(X,N),Xs).

% choose those that match >1
% but also do not match label of anything existing in mondo
nu_match2(G,A,N,X1,X2) :-
        nu_match(G,A,N,Xs),
        Xs=[_,_],
        member(X1,Xs),
        id_idspace(X1,S1),
        member(X2,Xs),
        id_idspace(X2,S2),
        S1 @> S2,
        \+ entity_xref(_,X1),
        \+ entity_xref(_,X2).

alldiff(Xs) :-
        forall(member(X,Xs), \+ entity_xref(_,X)),
        forall(member(X,Xs),
               \+ ((member(Y,Xs),
                    Y\=X,
                    id_idspace(X,SX),
                    id_idspace(Y,SY),
                    SX\=SY))).



anrel1(A,X) :- xsubclassRT(A,X).
anrel1(A,X) :- xsubclassRT(X,A).
anrel(A,X) :- anrel1(A,X).
anrel(A,X) :- anrel1(A,X1), parent(X,part_of,X1).

genlabel(G,A,N) :-
        l(G,GN),
        l(A,AN),
        concat_atom([GN,of,AN],' ',N).
genlabel(G,A,N) :-
        l(G,GN),
        l(A,AN),
        concat_atom([AN,GN],' ',N).

genlabel(G,A,N) :-
        l(G,cancer),
        l(A,AN),
        concat_atom([malignant,AN,neoplasm],' ',N).
genlabel(G,A,N) :-
        l(G,carcinoma),
        l(A,AN),
        concat_atom([malignant,AN,epithelial,neoplasm],' ',N).


xsubclassRT(A,B) :-
        class(A),
        (   id_idspace(A,'MONDO')
        ;   id_idspace(A,'UBERON')),
        subclassRT(A,B).

                      

l(X,N) :-
        entity_label_or_exact_synonym(X,N).




n('MONDO:0005070'). % ! neoplasm (disease)

/*

  blip-findall -goal ix -r uberon -debug index -i mondo-edit.obo -consult ../utils/neoplasmer.pro -r snomed_disorder -i mirror/ncit-disease.obo -i mirror/mesh.obo nu_match2/5 >z

*/

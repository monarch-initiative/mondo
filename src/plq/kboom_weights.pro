
:- ['mondo_queries.pro'].

%:- use_module(library(tabling)).
:- use_module(library(index_util)).

%:- table mondo_to_x_via_shared/5.

ix :-
        materialize_index(mondo_equiv_xref(1,1)),
        materialize_index(mondo_equiv_xref(1,1,1)),
        materialize_index(mondo_to_x_via_shared(1,1,1,-,-,1)).


/*

pl2sparql -d index -g ix  -f tsv -e -i mondo-edit.owl -i mirror/gard.owl -c ../plq/kboom_weights.pro -l "mondo_to_x_via_shared_uniq(C,X,'GARD',Z,_)"
  
*/

equiv_rule(C,X,OntX,shared_xref(Rel,SharedX,OntSharedX)) :-
        mondo_to_x_via_shared(C,X,OntX,SharedX,Rel,OntSharedX).


ok((=),_).
ok((-),"UMLS").

        
mondo_to_x_via_shared(C,X,PX,Z,Rel,SharedP) :-
        mondo_xref_semantics(C,Z,Rel),
        has_dbxref(X,Z),
        uri_prefix(X,PX),
        curie_prefix(Z,SharedP),
        ok(Rel,SharedP).





mondo_to_x_via_shared_uniq(C,X,PX,Z,Rel,P) :-
        mondo_to_x_via_shared(C,X,PX,Z,Rel,P),
        \+ mondo_equiv_xref(C,_,PX),
        \+ mondo_equiv_class_via_xref(_,X),
        \+ ((mondo_to_x_via_shared(C,X2,PX,_,_,P),X2\=X)),
        \+ ((mondo_to_x_via_shared(C2,X,PX,_,_,P),C2\=C)).


w(eq,C,X,2.5,'mondo2gard-shared-omim') :-
        mondo_to_x_via_shared(C,X,'GARD',_,(=),'OMIM').




w(eq,C,X,2.5,'mondo2umls-via-ncit') :-
        xref_prefix_srcont(C,X,'UMLS','NCIT').

% parses srings like OROD:123/e
w(Pred,C,X,2.0,'mondo2umls-via-ordo') :-
        xref_prefix(C,X,'UMLS'),
        xref_src(C,X,S),
        str_before(S,":","ORDO"),
        ordo2rel(OrdoRel,Pred),
        str_after(S,"/",OrdoRel).

w(eq,U,X,Weight,'umls2x') :-
        xref_prefix(U,X,Prefix),
        uri_prefix(U,'UMLS'),
        umls_xref_prefix_weight(Prefix,Weight).


umls_xref_prefix_weight("MEDGEN",5).
umls_xref_prefix_weight("SCTID",3).




ordo2rel("e",eq).
ordo2rel("btnt",superClassOf).
ordo2rel("ntbt",subClassOf).



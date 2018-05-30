:- ['mondo_queries.pro'].

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



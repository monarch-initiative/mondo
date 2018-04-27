:- ['mondo_queries.pro'].

w(eq,C,X,2.5,'umls-via-ncit') :-
        xref_prefix_srcont(C,X,'UMLS','NCIT').

w(Pred,C,X,2.0,'umls-via-ordo') :-
        xref_prefix(C,X,'UMLS'),
        xref_src(C,X,S),
        str_before(S,":","ORDO"),
        ordo2rel(OrdoRel,Pred),
        str_after(S,"/",OrdoRel).




ordo2rel("e",eq).
ordo2rel("btnt",superClassOf).
ordo2rel("ntbt",subClassOf).



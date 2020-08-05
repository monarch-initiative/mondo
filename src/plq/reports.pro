:- ['mondo_queries.pro'].

class_xrefs(C,CN,Omim,Ordo,Gard,Ncit,Doid,Mesh,Umls,Snomed) :-
        class(C),
        label(C,CN),
        \+dep(C),
        x(C,'OMIM',Omim),
        x(C,'Orphanet',Ordo),
        x(C,'GARD',Gard),
        x(C,'NCIT',Ncit),
        x(C,'DOID',Doid),
        x(C,'MESH',Mesh),
        x(C,'UMLS',Umls),
        x(C,'SCTID',Snomed).

x(C,Prefix,R) :-
        solutions(X,xref_prefix(C,X,Prefix),Xs),
        group_concat(Xs,",",R).


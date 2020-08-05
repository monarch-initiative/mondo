:- ['mondo_queries.pro'].

:- use_module(library(index_util)).
:- use_module(library(rdf_matcher)).

w(eq,C,X,2.0,ncit_xref) :-
        xref_prefix(C,X,'NCIT'),
        uri_prefix(C,'ONCOTREE').

w(eq,C,X,1.2,ncit_xref) :-
        xref_prefix(C,X,'UMLS'),
        uri_prefix(C,'ONCOTREE').

w(Rel,C,X,W,label) :-
        tr_annot(C,P,Name,_,_,_),
        uri_prefix(C,'MONDO'),
        tr_annot(X,label,Name,_,_,_),
        uri_prefix(X,'ONCOTREE'),
        pscore(Rel,P,W).

pscore(eq,label,0.8).
pscore(eq,exact,0.7).
pscore(superClassOf,label,0.3).
pscore(superClassOf,exact,0.3).

        






/*

pl2sparql -d index -g ix  -f tsv -e -i mondo-edit.owl -i mirror/medgen-disease-extract.owl  -c ../plq/kboom_weights_umls.pro w
  
*/
        
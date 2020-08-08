:- ['mondo_queries.pro'].

:- use_module(library(index_util)).
:- use_module(library(rdf_matcher)).

%:- table mondo_to_x_via_shared/5.

ix :-
        materialize_index(tr_annot(1,1,1,-,-,-)),
        materialize_index(mondo_equiv_xref(1,1,1)).

pscore(label,3).
pscore(exact,2).

prefixscore("MEDGEN",1.5).
prefixscore("SCTID",1.5).
prefixscore("NCIT",1).
prefixscore("MESH",0.5).

w(eq,C,X,W,umls_label) :-
        tr_annot(C,P,Name,_,_,_),
        uri_prefix(C,'MONDO'),
        tr_annot(X,label,Name,_,_,_),
        uri_prefix(X,'UMLS'),
        pscore(P,W).
w(eq,C,X,W,umls_xref) :-
        mondo_equiv_xref(C,SharedX),
        uri_prefix(C,'MONDO'),
        has_dbxref(X,SharedX),
        curie_prefix(SharedX,Prefix),
        prefixscore(Prefix,W),
        uri_prefix(X,'UMLS').





/*

pl2sparql -d index -g ix  -f tsv -e -i mondo-edit.owl -i mirror/medgen-disease-extract.owl  -c ../plq/kboom_weights_umls.pro w
  
*/
        
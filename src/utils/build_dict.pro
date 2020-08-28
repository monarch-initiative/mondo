
/*

tbl2p -p w /usr/share/dict/words > words.pro

   blip-findall -no_pred -r ordo -i imports/ncbitaxon_import.obo -r uberonp  -r MP -r CL -r HP -r GO -r disease -r ncitd  -i words.pro  -consult ../utils/build_dict.pro norm_form_weight/4   > WORDS

$ wc WORDS 
 2944737 11778948 89974464 WORDS

  sort -u WORDS > WORDS.s

  ../utils/process-word-scores.pl WORDS.s > DICT 

  ../utils/apply-dict.pl -s DICT mondo-edit.obo > z
  
*/


has_alpha(N) :-
        atom_chars(N,Cs),
        member(C,Cs),
        C @>= 'a',
        C @=< 'z',
        !.

norm_form_weight(N,W,S,C) :-
        form_weight(W,S,C),
        downcase_atom(W,N),
        has_alpha(N).



form_weight(W,S,C) :-
        entity_label(C,N),
        id_idspace(C,Ont),
        \+ entity_obsolete(C,_),
        trusted_label(Ont,S),
        tokenize_atom(N,Toks),
        member(W,Toks).

form_weight(W,S,C) :-
        entity_label_or_synonym(C,N),
        id_idspace(C,Ont),
        \+ entity_obsolete(C,_),
        trusted(Ont,S),
        tokenize_atom(N,Toks),
        member(W,Toks).

form_weight(W,S,C) :-
        entity_label_or_synonym(C,N),
        id_idspace(C,Ont),
        \+ entity_obsolete(C,_),
        leading_ucase(Ont,S1),
        tokenize_atom(N,[Tok1|Toks]),
        (   tok1_score(Tok1,W,S)
        ;   member(W,Toks),
            S=S1).

form_weight(W,S,C) :-
        entity_label_or_synonym(C,N),
        id_idspace(C,Ont),
        \+ entity_obsolete(C,_),
        mixed(Ont,S1),
        tokenize_atom(N,Toks),
        member(Tok1,Toks),
        tok1_score(Tok1,W,S2),
        S is S1*S2.

form_weight(W,8,dict) :-
        w(W).


% initial word provides no evidence for whether leading caps is OK
tok1_score(Tok1,Tok1,0).
% initial word may be evidence against all-caps
tok1_score(Tok1,W,-2) :-
        upcase_atom(Tok1,W),
        W\=Tok1.
% evidence for all-caps 
tok1_score(Tok1,W,1) :-
        upcase_atom(Tok1,W),
        W=Tok1.



trusted_label('DOID', 4).

trusted('UBERON', 5).
trusted('CL', 4).
trusted('GO', 5).
trusted('NCBITaxon', 5).
trusted('MP', 1).  % mistakes: Blood, Lung, ...

leading_ucase('HP', 5).
leading_ucase('Orphanet', 4).
leading_ucase('MESH', 1).

mixed('NCIT', 0.5).             % sometimes has all-caps

exclude(bold,'NCBITaxon').

:- [mondo_queries].

:- rdf_register_prefix(def,'http://purl.obolibrary.org/obo/IAO_0000115').

:- table learn_from_triple/4.
learn_from_triple(S,P,O, Item) :-
        ensure_atom(O, Term),
        uri_prefix(S,Prefix1),
        downcase_atom(Prefix1,Prefix),
        prefix_property_style_weight(Prefix, P, Style, Weight),
        learn_from(Style, Weight, Prefix, Term, Item).

learn_from(Style, Weight, Prefix, Term, Item) :-
        re_split_atom("([\\.:;]\\s*|\\s+)", Term, Tokens),
        include([X]>>(\+atom_concat(' ',_,X)),Tokens,Tokens2),
        tokens_to_pairs(Tokens2, start, Pairs),
        member(Word-Last,Pairs),
        token_category(Word,Type),
        prev_category_expected_info(Last,Type,Style,Class),
        Item=data(Class,Prefix,Weight).

% categorize a token lexically, one of: initialism, capitalized, lowercase, unknown
token_category(Token,initialism) :-  re_match("^[A-Z].*[A-Z]",Token),!.
token_category(Token,capitalized) :-  re_match("^[A-Z]",Token),!.
token_category(Token,lowercase) :-  re_match("^[a-z]+$",Token),!.
token_category(_,unknown).

% given a pair of (previous_token, token_category), plus
% the context, categorize whether this provides evidence for or against
prev_category_style_info(start,capitalized,sentence,not(initialism)).
prev_category_style_info(stop,capitalized,sentence,not(initialism)).
prev_category_style_info(_,capitalized,all_capitalized,not(initialism)).
prev_category_style_info(_,capitalized,lowercase,capitalized).

prev_category_style_info(_,initialism,sentence,initialism).
prev_category_style_info(_,initialism,lowercase,initialism).
prev_category_style_info(_,initialism,all_capitalized,initialism).

prev_category_style_info(_,lowercase,_,lowercase).

:- rdf_meta prefix_property_style_weight(?,r,?,?).

prefix_property_style_weight(mesh, def:'', sentence, 1) :- !.
prefix_property_style_weight(_, def:'', sentence, 6) :- !.

prefix_property_style_weight(mondo, rdfs:label, lowercase, 7) :- !.
prefix_property_style_weight(mp, rdfs:label, lowercase, 8) :- !.
prefix_property_style_weight(uberon, _, lowercase, 8) :- !.
prefix_property_style_weight(hp, _, sentence, 8) :- !.
prefix_property_style_weight(ncit, _, all_capitalized, 8) :- !.
prefix_property_style_weight(omim, _, uppercase, 8) :- !.


        


tokens_to_pairs([], _, []).
tokens_to_pairs([Token|Tokens], _, Pairs) :-
        atom_concat('.',_,Token),
        !,
        tokens_to_pairs(Tokens, stop, Pairs).
tokens_to_pairs([Token|Tokens], LastToken, [Token-LastToken|Pairs]) :-
        tokens_to_pairs(Tokens, Token, Pairs).

re_split_atom(P,In,Tokens) :-
        re_split(P, In, StrTokens),
        maplist([S,A]>>atom_string(A,S),StrTokens,Tokens).
        
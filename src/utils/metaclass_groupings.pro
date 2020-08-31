g(region,'MONDO:0024505',disease_has_location,'UBERON:0000475').
g(system,'MONDO:0021199',disease_has_location,'UBERON:0000467').
g(cp,'MONDO:0021195',disease_disrupts,'GO:0009987').
g(mf,'MONDO:0021196',disease_disrupts,'GO:0003674').
g(cc,'MONDO:0021197',disease_has_basis_in_dysfunction_of,'GO:0005575').
g(supramc,'MONDO:0044974',disease_has_location,'GO:0099080').
g(cell,'MONDO:0044979',disease_has_location,'CL:0000000').



class_group(G,C,MetaC) :-
        class_group(G,C,MetaC,_).

class_group(G,C,MetaC,A) :-
        g(G,MetaC,_Rel,AGrp),
        class_cdef(C,cdef('MONDO:0000001',[_=A])),
        subclassT(A,AGrp),
        \+ subclassT(C,MetaC).


class_group_nr(G,C,P) :- class_group(G,C,P),\+((class_group(G,C,Z),subclassT(Z,P))).


/*

  blip-findall -r uberonp -r go -r cell -r mondoe -c ../utils/metaclass_groupings.pro class_group_nr/3 -no_pred -label -use_tabs  | sort -u > z
  
  cut -f3-7 z | tbl2obolinks.pl --rel is_a --source MONDO:metaclass 


  */

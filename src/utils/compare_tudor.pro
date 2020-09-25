mx(Ordo,Doid) :-
        x(M,_,'DOID',Doid,one_to_one),
        x(M,_,'Orphanet',Ordo,one_to_one).

check(Ordo,Doid,S,M,Agree,Alts) :-
        m(Ordo,Doid,S,M),
        (   mx(Ordo,Doid)
        ->  Agree=yes,
            Alts=''
        ;   Agree=no,
            findall(Alt,alt(Ordo,Doid,Alt),Pairs),
            sformat(Alts,'~w',[Pairs])).

alt(Ordo,_Doid,alt_doid=Doid2) :-
        mx(Ordo,Doid2).
alt(_Ordo,Doid,alt_ordo=Ordo2) :-
        mx(Ordo2,Doid).


        
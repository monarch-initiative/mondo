:- ['mondo_queries.pro'].



ordo_d2g(D,Rel,G) :-
        genetic_basis_relation(Rel),
        rdf(Rel,rdfs:seeAlso,RelX),
        subclass_of_some(GX,RelX,DX),
        owl_equivalent_class(DX,D),
        mondo(D),
        %has_dbxref(GX,G),
        xref_prefix(GX,G,"HGNC").


genetic_basis_relation(R) :-
        rdf(R,rdfs:subPropertyOf,'http://purl.obolibrary.org/obo/RO_0004000').

/*


  */

        
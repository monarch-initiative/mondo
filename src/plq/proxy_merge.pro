proxy_merge(X1,X1N,X2,X2N,M) :-
        owl_equivalent_class_asserted(M,X1),
        owl_equivalent_class_asserted(M,X2),
        X1@<X2,
        rdf(X1,rdfs:label,X1N,G),
        rdf(X2,rdfs:label,X2N,G).


/*

pl2sparql -A void.ttl -e -i all -c ../plq/proxy_merge.pro proxy_merge  
  */

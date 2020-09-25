#/usr/bin/perl
s@http://www.geneontology.org/formats/oboInOwlsource="NTBT.*@source="MONDO:subClassOf"}@;
s@http://www.geneontology.org/formats/oboInOwlsource="BTNT.*@source="MONDO:superClassOf"}@;
s@http://www.geneontology.org/formats/oboInOwlsource="E.*@source="MONDO:equivalentTo"}@;
s@http://www.geneontology.org/formats/oboInOwlsource="E.*@source="MONDO:equivalentTo"}@;

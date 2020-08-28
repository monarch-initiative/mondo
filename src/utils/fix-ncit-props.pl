#!/usr/bin/perl
while(<>) {
    s/SCTID_/SCTID:/;
    s/OMIM:PS/OMIMPS:/;
    s/EFO:0000784/disease_has_location/;
    
    s/NCIT:R100/disease_has_location/;
    s/NCIT:R101/disease_has_location/;
    s/NCIT:R103/disease_arises_from_structure/;
    s/NCIT:R104/disease_arises_from_structure/;
    s/NCIT:R115/disease_has_feature/;
    s/property_value:.*UMLS_CUI.*\"(\S+)\".*/xref: UMLS:$1/;
    s/property_value: NCIT:P207 "(\S+)" xsd:string/xref: UMLS:$1/;
    print;
}

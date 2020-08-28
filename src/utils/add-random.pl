#!/usr/bin/perl
while(<>) {
    if (m@intersection_of: disease_has_basis_in_dysfunction_of http://identifiers.org/hgnc/@) {
        $random = rand();
        print "intersection_of: FOO:$random\n";
    }
    print;
}

#!/usr/bin/perl
while(<>) {
    my ($c,$cn, $g,$gn, $f) = split(/\t/);
    print "[Term]\n";
    print "id: $c ! $cn\n";
    print "intersection_of: $g ! $gn\n";
    print "intersection_of: disease_has_basis_in_dysfunction_of $f\n";
    print "\n";
    
}

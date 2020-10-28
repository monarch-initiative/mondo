#!/usr/bin/perl

my $re = qr@relationship: disease_has_basis_in_dysfunction_of http://identifiers.org/hgnc/@;

while(<>) {
    if ($_ =~ $re) {
        @x = ($_);
        $next = <>;
        if ($next =~ $re) {
            while (<>) {
                if ($_ !~ $re) {
                    print $_;
                    last;
                }
            }
        }
        else {
            print;
            print $next;
        }
            
    }
    else {
        print;
    }
}

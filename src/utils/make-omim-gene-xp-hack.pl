#!/usr/bin/perl -w
use strict;

my $id;
my $name;
my $yes = 0;
my $genus;
my $filler;
while(<>) {
    chomp;
    if (m@^id: (\S+)@) {
        $id = $1;
        $yes = 0;
        $genus = undef;
        $filler = undef;
    }
    if (m@^name: (.*)@) {
        $name = $1;
    }
    if (m@^def:.*(gene|mutation).*DOID@) {
        $yes = 1;
        #print STDERR "Candidate: $id $name\n";
    }
    if (m@^is_a: (.*)@) {
        my $pstr = $1;
        my @parts = split(/ ! /, $pstr);
        my $p = $parts[0];
        $p =~ s@ \{.*@@;
        my $pn = $parts[1];
        if ($yes) {
            if (index(lc($name), lc($pn)) != -1) {
                print STDERR "  GENUS: $p! $pn // $yes // N=$name\n";
                $genus = "$p ! $pn";
            }
        }
    }
    if (m@^relationship: (disease_has_basis_in_dysfunction_of NCBIGene:\S+)@) {
        my $p = $1;
        if ($yes && $genus) {
            print "[Term]\n";
            print "id: $id ! $name\n";
            print "intersection_of: $genus\n";
            print "intersection_of: $p\n";
            print "\n";
        }
        $filler = $p;
    }
    if (m@^intersection_of@) {
        if ($yes && $genus && $filler) {
            die "$id $name // $genus";
        }
    }
}

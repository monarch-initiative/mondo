#!/usr/local/bin/perl
while(<>) {
    chomp;
    my ($c,$cn,$d,$dn,$s) = split(/\t/, $_);
    print "[Term]\n";
    print "id: $c ! $cn\n";
    print "is_a: $d {source=\"$s\"} ! $dn\n";
    print "\n";
}

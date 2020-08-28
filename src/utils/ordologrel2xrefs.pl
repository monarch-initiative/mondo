#!/usr/bin/perl

# blip-findall -r ordox logrel/3 -no_pred | ../utils/ordologrel2xrefs.pl  > z
# obo-map-ids.pl --use-xref-inverse --ignore-tag xref mondo.obo z > zz

while(<>) {
    chomp;
    my ($o,$x,$r) = split(/\t/);
    print "[Term]\n";
    print "id: $o\n";
    $o =~ s@.*:@@;
    print "xref: $x {source=\"ORDO:$o/$r\"}\n";
    print "\n";
    
}

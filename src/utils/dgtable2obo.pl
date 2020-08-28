#!/usr/bin/perl
while(<>) {
    chomp;
    my ($x,$xn,$r,$rn,$y,$yn) = split(/\t/);
    print "[Term]\n";
    print "id: $x ! $xn\n";
    print "relationship: $r $y {source=\"$x\"} ! $rn $yn\n";
    print "\n";
    $rnm{$r} = $rn;
}
foreach my $r (keys %rnm) {
    print "[Typedef]\n";
    print "id: $r\n";
    print "name: $rnm{$r}\n\n";
}

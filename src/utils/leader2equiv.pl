#!/usr/bin/perl

while(<>) {
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    if (m@^name: (\S+)@) {
        $n = $1;
    }
    if (m@xref: (\S+) .*MONDO:Leader@) {
        $x = $1;
        die $id unless $n;
        print "[Term]\n";
        print "id: $id ! $n\n";
        print "equivalent_to: $x\n\n";
    }

}

#!/usr/bin/perl

while(<>) {
    if (m@CONFIDENCE=(\S+)@) {
        print STDERR $_;
        $conf = $1;
        if ($conf eq 'Infinity') {
            $conf = 1000;
        }
    }
    if (m@MONDO_(\d+) (.*) EquivalentTo (\S+) (.*) Pr= (\S+)@) {
        next if $conf < 0.05;
        my ($mid, $ml, $xid, $xl, $pr) = ($1,$2,$3,$4,$5);
        if ($pr == 0) {
            die $_;
        }
        print STDERR "$_\n";
        $xid =~ s@_@:@;
        $prmodel = 1/(1+2**(-$conf));

        $ppr = $prmodel + ((1-$prmodel) * $pr);
        
        print "[Term]\n";
        print "id: MONDO:$mid ! $ml\n";
        printf 'xref: %s {source="MONDO:kboom-pr-%.02f/%.02f/%.02f"} ! %s', $xid, $ppr, $pr, $conf, $xl;
        print "\n\n";
    }
}

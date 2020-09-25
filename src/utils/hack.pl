#!/usr/bin/perl
while(<>) {
    chomp;
    if (m@(\S+),(\S+)@) {
        $x{$2} = $1;
    }
    if (m@CONFIDENCE=(\S+)@) {
        $confidence = $1;
    }
    if (m@ \* (\S+)_(\S+)@) {
        $id = "$1:$2";
        $xid = $x{$id};
        if ($xid) {
            print "[Term]\n";
            print "id: $xid\n";
            print "property_value: confidence $confidence xsd:double\n\n";
        }
    }
}

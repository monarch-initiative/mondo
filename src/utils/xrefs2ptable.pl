#!/usr/bin/perl

while(<>) {
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    if (m@^xref: (\S+).*source="MONDO:(\w+)"@) {
        $x = $1;
        $r = $2;
        
        my $vals;
        if ($r eq 'superClassOf') {
            $vals = [0.1, 0.7, 0.1];
        }
        elsif ($r eq 'subClassOf') {
            $vals = [0.7, 0.1, 0.1];
        }
        elsif ($r eq 'equivalentTo') {
            $vals = [0.04, 0.04, 0.9];
        }
        if ($vals) {
            push(@$vals, 1-($vals->[0] + $vals->[1] + $vals->[2]));
        }
        unshift(@$vals, ($id, $x));
        if (@$vals == 6) {
            print join("\t", @$vals)."\n";
        }
    }
}

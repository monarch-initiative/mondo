#!/usr/bin/perl

$n=1;
open(F,">idmap.csv");
print F "iri,equivalent_class\n";
while(<>) {
    if (m@^id: (\S+)@) {
        $id = $1;
        $x = sprintf("MONDO:%07d", $n);
        $_ = sprintf("id: $x\n", $n);
        print F "$x,$id\n";
        $n++;
    }
    print $_;
}
close(F);

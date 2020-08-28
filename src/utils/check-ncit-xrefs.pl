#!/usr/bin/perl

my %idh = ();
while(<>) {
    chomp;
    s@\s+$@@;
    if (m@^\[@) {
        last;
    }
    $idh{$_} = 1;
}
my @ids = keys %idh;
#print STDERR "IDS: @ids\n";
#printf STDERR "IDS: %d\n", scalar(@ids);
while(<>) {
    chomp;
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    elsif (m@^name: (.*)@) {
        $n = $1;
    }
    elsif (m@xref: (NCIT:\S+)@) {
        $x = $1;
        if (!$idh{$x}) {
            print STDERR "$id\t$n\t'$x'\t$_\n";

            if (m@MONDO:equivalentTo@) {
                s@MONDO:equivalentTo@MONDO:otherHierarchy@;
            }
            else {
                s@\{@\{source="MONDO:otherHierarchy", @;
            }
        }
        else {
            #print STDERR "OK\t$id\$n\t$_\n";
        }
    }
    print "$_\n";
}


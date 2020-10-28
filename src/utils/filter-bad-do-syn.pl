#!/usr/bin/perl

# ./mq report synclash > z
# grep PRIM z | egrep '\tDOID:\d+' > zz

my $tsv = shift @ARGV;
open(F,$tsv);
while(<F>) {
    chomp;
    s@\s+$@@;
    my @vals = split(/\t/,$_);
    my $x = $vals[-1];
    if ($vals[-1] =~ m@^DOID:\d+$@) {
        $bad{$vals[-3]} = $vals[0];
    }
}
close(F);
printf STDERR "BAD: %s\n", scalar(keys %bad);
while (<>) {
    chomp;
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    if (m@^synonym: "(.*)" EXACT \[DOID:\d+\]@) {
        $s = $1;
        if ($bad{$id} eq $s) {
            s@ EXACT @ EXACT EXCLUDE @;
        }
            
    }
    print "$_\n";
}

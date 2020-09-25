#!/usr/bin/perl
my $n;
my $ch = 0;
while(<>) {
    chomp;
    if (m@^synonym: "(.*)" EXACT@) {
        $n = $1;
    }
    elsif (m@^synonym: "(.*)" RELATED \[(.*)\]@) {
        my ($s,$x) = ($1,$2);
        if ($n) {
            if ($n eq $s && ($x =~ m@^OMIM:@ || $x =~ m@^MESH@ || $x =~ m@GARD@) ) {
                $ch++;
                next;
            }
        }
    }
    else {
        $n = undef;
    }
    print "$_\n";
}
print STDERR "CHANGES: $ch\n";

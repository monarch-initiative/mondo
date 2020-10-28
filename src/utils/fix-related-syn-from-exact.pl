#!/usr/bin/perl
my $n;
my $ch = 0;
while(<>) {
    chomp;
    if (m@^synonym: "(.*)" EXACT@) {
        $n = $1;
    }
    elsif (m@^synonym: "(.*)" RELATED \[\]@) {
        if ($n) {
            #print STDERR "CHK: '$1' eq '$n'\n";
            if ($n eq $1) {
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

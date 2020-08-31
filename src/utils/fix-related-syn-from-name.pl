#!/usr/bin/perl
my $n;
my $ch = 0;
while(<>) {
    chomp;
    if (m@^name: (.*)@) {
        $n = $1;
    }
    if (m@^synonym: "(.*)" (\S+) (.*)@) {
        my ($syn,$sc,$rest) = ($1,$2,$3);
        if (lc($syn) eq lc($n)) {
            if ($sc ne 'EXACT') {
                #s@ (RELATED|BROAD|NARROW) @ EXACT @;
                $_ = 'synonym: "'.$n.'" EXACT '.$rest;
                $ch++;
            }
        }
    }
    print "$_\n";
}
print STDERR "CHANGES: $ch\n";

#!/usr/bin/perl
while(<>) {
    chomp;
    if (m@def: "(.*)" (.*)@) {
        ($def,$x) = ($1,$2);
        while ($def =~ m@[A-Z][A-Z]@) {
            $def =~ s@([A-Z][A-Z]+)@lc($1)@e;
        }
        $_ = "def: \"$def\" $x";
    }
    print;
    print "\n";
}

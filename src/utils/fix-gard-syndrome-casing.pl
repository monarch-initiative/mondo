#!/usr/bin/perl
while(<>) {
    if (m@^name: (.*) syndrome@) {
        @ns = split(' ', $1);
        @ns = map { s@(.)@uc($1)@e; $_ } @ns;
        $_ = "name: ".join('-', @ns)." syndrome\nis_a: MONDO:0002254 ! syndromic disease\n";
    }
    print;
}

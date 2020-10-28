#!/usr/bin/perl

while(<>) {
    print;
    chomp;
    if (m@^synonym: "(.*); ([A-Z]+[0-9]*)"\s+\S+\s+\[(\S+)\]@) {
        $s = lc($1);
        print "synonym: \"$s\" EXACT [$3]\n";
        print "synonym: \"$2\" EXACT ABBREVIATION [$3]\n";
    }
}

#!/usr/bin/perl
while(<>) {
    chomp;
    if (m@^name: (.*)'s (disease|syndrome)(.*)@) {
        $n = "$1 $2$3";
        $s = "$1's $2$3";
        print "name: $n\n";
        print "synonym: \"$s\" EXACT [MONDO:LexicalVariant, doi:10.1093/jama/9780195176339.003.0016]\n";
        next;
    }
    print "$_\n";
}

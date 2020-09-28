#!/usr/bin/perl
while(<>) {
    s@ EXACT @ RELATED @;
    if (m@synonym: "(.*), formerly" \S+@i) {
        print "synonym: \"$1\" RELATED []\n";
    }
    s@OMIM:PS@OMIMPS:@g;
    # See https://github.com/monarch-initiative/dipper/issues/600
    if (m@is_a: OMIMPS:(\d+),PS(\d+)@) {
        $_ = "is_a: OMIMPS:$1\nis_a: OMIMPS:$2\n";;
    }
    print $_;
    
}

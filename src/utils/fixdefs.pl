#!/usr/bin/perl
while(<>) {
    
    if (m@^id:@) {
        $n = 0;
        $nc = 0;
    }
    if (m@^def:@) {
        if ($n) {
            print STDERR "SKIP: $_";
            next;
        }
        $n++;
    }
    if (m@^comment:@) {
        if ($nc) {
            print STDERR "SKIP: $_";
            next;
        }
        $nc++;
    }
    print;
}

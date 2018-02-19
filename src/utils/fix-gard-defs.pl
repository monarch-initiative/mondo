#!/usr/bin/perl
while(<>) {
    if (m@^def:@) {
        s@\[\d+\]@@g;
    }
    s@^def: " @def: "@;
    s@ " \[@" \[@;
    print;
}

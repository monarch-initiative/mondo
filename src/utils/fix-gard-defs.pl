#!/usr/bin/perl
while(<>) {
    if (m@^def:@) {
        s@\[\d+\]@@g;
    }
    print;
}

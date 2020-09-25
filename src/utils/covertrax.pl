#!/usr/bin/perl
while(<>) {
    s@\[(SCTID|SNOMED\w+):\d+\]@[]@;
    s@\, (SCTID|SNOMED\w+):\d+@@;
    s@(SCTID|SNOMED\w+):\d+, @@;
    print;
}

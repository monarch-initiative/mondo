#!/usr/bin/perl

while(<>) {
    chomp;
    my ($s,$lid,$x1,$x2,$pid) = split(/\t/,$_);
    $s =~ s@ORPHA@Orphanet@;
    print "$s:$lid\t$pid\n";
}

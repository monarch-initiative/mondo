#!/usr/bin/perl
while(<>) {
    chomp;
    my ($db,$local,$n,$q,$hp) = split(/\t/);
    $db =~ s@ORPHA@Orphanet@;
    print "$db:$local\t$hp\n";
}

#!/usr/bin/perl

our $PATH = "ftp.ncbi.nlm.nih.gov/pub/medgen";

open(F,"gzip -dc $PATH/medgen_pubmed_lnk.txt.gz|") || die;
while(<F>) {
    chomp;
    my ($uid, $cui) = split(/\|/, $_);
    next if $done{$uid};
    print "$uid\t$cui\n";
    $done{$uid} = 1;
}
close(F);

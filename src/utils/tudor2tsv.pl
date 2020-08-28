#!/usr/bin/perl
while(<>) {
    next if m@^orphanet_id@;
    chomp;
    my @vs = split(/\t/,$_);
    $doid = $vs[3];
    $doid =~ s@_@:@l;
    print "Orphanet:$vs[0]\t$doid\t$vs[7]\t$vs[8]\n";
}

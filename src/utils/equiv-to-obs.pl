#!/usr/bin/perl
my $f = shift @ARGV;

my %omap = ();
open(F,$f);
while(<F>) {
    chomp;
    my ($obs_id) = split(/\t/, $_);
    $omap{$obs_id}++;
}
close(F);

while(<>) {
    if (m@^xref: (\S+) .*MONDO:equivalentTo@) {
        my $id = $1;
        if ($omap{$id}) {
            s@MONDO:equivalentTo@MONDO:obsolete@;
        }
    }
    print $_;
}

#!/usr/bin/perl

# first file is NEW-PROTO-OMIM.obo 
my $f = shift @ARGV;
open(F,$f);
while (<F>) {
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    if (m@^xref: (OMIM:\S+)@) {
        $x = $1;
        $m{$x} = $id;
        $rm{$id} = $x;
    }
}
close(F);

# next is MONDO
$in = 0;
while(<>) {
    chomp;
    if (m@^xref: (OMIM:\S+).*equivalentTo@) {
        $x = $1;
        if ($m{$x}) {
            $in = $x;
            s@MONDO:equivalentTo@MONDO:superClassOf@;
        }
        else {
            $in = 0;
        }
    }
    if (m@\[(OMIM:\S+)\]@) {
        $x = $1;
        if ($m{$x}) {
            next;
        }
    }
    if (m@\{source="OMIM:\S+"\}@) {
        $x = $1;
        if ($m{$x}) {
            next;
        }
    }
    if (m@mim2gene_med@) {
        if ($in) {
            my $nu_mondo_id = $m{$in};
            push(@{$lineh{$nu_mondo_id}}, $_);
            next;
        }
    }
    print "$_\n";
}

open(F, ">EXTRA.obo");
foreach my $k (keys %lineh) {
    print F "[Term]\n";
    print F "id: $k\n";
    foreach (@{$lineh{$k}}) {
        print F "$_\n";
    }
    print F "\n";
}
close(F);

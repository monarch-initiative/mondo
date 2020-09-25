#!/usr/bin/perl -w

use strict;
my %tag_h=();
my $negate = 0;
my $replace = 0;
my $check = 0;
my $expand_relations = 0;
my $no_src;
my $preserve_def_xref = 0;
my $combine_def_xref = 0;
my $is_use_all;
my $map_all = 0;
my $is_reuse_already = 0;
while (scalar(@ARGV) && $ARGV[0] =~ /^\-/) {
    my $opt = shift @ARGV;
    if ($opt eq '-h' || $opt eq '--help') {
        print usage();
        exit 0;
    }
    if ($opt eq '--neg') {
        $negate = 1;
    }
    if ($opt eq '-r' || $opt eq '--replace') {
        $replace = 1;
    }
    if ($opt eq '--expand-relations') {
        $expand_relations = 1;
    }
    if ($opt eq '-c' || $opt eq '--check') {
        $check = 1;
    }
    if ($opt eq '-n' || $opt eq '--no-src') {
        $no_src = 1;
    }
    if ($opt eq '-cx' || $opt eq '--combined-def-xref') {
        $combine_def_xref = 1;
    }
    if ($opt eq '-px' || $opt eq '--preserve-def-xref') {
        $preserve_def_xref = 1;
    }
    if ($opt eq '-a' || $opt eq '--use-all') {
        $is_use_all = 1;
    }
    if ($opt eq '-x' || $opt eq '--map-all') {
        $map_all = 1;
    }
    if ($opt eq '-ra' || $opt eq '--reuse-already') {
        $is_reuse_already = 1;
    }
    if ($opt eq '-t' || $opt eq '--tag') {
        $tag_h{shift @ARGV} = 1;
    }
}
if (!%tag_h) {
    $tag_h{'xref'} = 1;
}
my $id;
my %nh = ();
my %xrefh=();
my $uid = 0;
my $stanza_type;
my $proto_id = shift @ARGV;
my @fs = (
    "mondo-edit.obo",
    );

my %taken = ();
my $is_in = 0;
my @lines = ();
my $proto_omim_id;
my %gene = ();

while (my $f = shift @fs) {
    print STDERR "READING $f\n";
    open(F,$f) || die($f);
    while (<F>) {
        s/\s+$//;
        s/OMIM:PS/OMIMPS:/;
        if (/^\[(\S+)\]/) {
            $stanza_type = lc($1);
        }

        if (m@id:\s*MONDO:(\d+)@) {
            $taken{$1} = 1;
        }
        if (/^id:\s+(\S+)/) {
            $id = $1;
            if ($id =~ /MONDO:(\d+)/ && $1 >= $uid && $1 < 100000) {
                $uid = $1+1;
            }
            $xrefh{$id} = $id; # make xref reflexive
            if ($id eq $proto_id) {
                $is_in = 1;
                $proto_omim_id = undef;
            }
            else {
                $is_in = 0;
            }
        }
        elsif (/^name:\s*(.*)/) {
            $nh{$id} = $1;
        }
        elsif (/^xref:\s*(\S+)/) {
            my $x = $1;
            if (m@equiv@i || $id =~ m@^HP:@) {
                $xrefh{$x} = $id;
                #print STDERR "$1 ==> $xrefh{$1}\n";
            }
        }
        elsif (/^def:.*(Wikipedia:[\w\(\)\-]+)/) {
            $xrefh{$1} = $id;
        }
        elsif (/^synonym:.*(Wikipedia:[\w\(\)\-]+)/) {
            $xrefh{$1} = $id;
        }

        if (m@relationship: disease_has_basis_in_dysfunction_of (http://identifiers.org/hgnc/\d+) .* \! (\S+)@) {
            $gene{$id} = "$1 ! $2";
        }

        if ($is_in) {
            if (/^xref: (OMIM:\d+).*equivalent/) {
                $proto_omim_id = $1;
            }
            push(@lines, $_);
        }
    }
    close(F);
}

if (!@lines) {
    die "no match for $proto_id";
}
if (!$proto_omim_id) {
    die "no OMIM match for $proto_id";
}

print "\n[Term]\n";
$uid = nextid();
my $this_id = sprintf("MONDO:%07d",$uid);
print "id: $this_id\n";
print "name: $nh{$proto_id} 1\n";
print "is_a: $proto_id {source=\"MONDO:prototype\"} ! $nh{$proto_id}\n";
print "intersection_of: $proto_id ! $nh{$proto_id}\n";
print "intersection_of: disease_has_basis_in_dysfunction_of http://identifiers.org/hgnc/24039/$gene{$proto_id}\n";

foreach (@lines) {
    if ((m@(OMIM:\d+)@ && $1 eq $proto_omim_id) || m@hgnc@) {
        next if m@xref: OMIM@ && $_ !~ m@equivalent@;
        s@MONDO:equivalentTo@MONDO:subClassOf@g unless m@xref: OMIM@;
        s@EXACT@RELATED@;
        if (m@xref: UMLS@) {
            s@source="NCBI:mim2gene_medline"@source="NCBI:mim2gene_medline", source="MONDO:equivalentTo"@;
        }
        print "$_\n";
    }
}
print "\n\n";

exit 0;

sub scriptname {
    my @p = split(/\//,$0);
    pop @p;
}

sub nextid {
    my @used = sort(keys %taken);
    #printf STDERR "TAKEN: %d %s\n", scalar(@used), $used[0];
    for (my $i=0; $i<@used; $i++) {
        die if $i > 100000;
        my $diff = $used[$i+1] - $used[$i];
        if ($diff > 1) {
            my $nextid = $used[$i] + 1;
            #print STDERR "FILLING: $used[$i] - $used[$i+1] = $diff // next = $nextid\n";
            $taken{sprintf("%07d", $nextid)} = 1;
            return $nextid;
        }
    }
}

sub usage {
    my $sn = scriptname();

    <<EOM;
$sn [-c] [-r] [-t tag]* [REFERENCED FILE...] SOURCE

for all ID references in SOURCE in a specified tag, adds the label after a "!"

using the -c option runs this in CHECK mode

using the -r option replaces existing comments

Example:

$sn -c -t id -t intersection_of human-phenotype-ontology.obo quality.obo fma.obo human-phenotype-ontology_xp.obo

EOM
}


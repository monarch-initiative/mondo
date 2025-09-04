#!/usr/bin/perl -w

use strict;
use FileHandle;
my $outdir = "terms";
my $cmd;
while ($ARGV[0] =~ /^\-/) {
    my $opt = shift @ARGV;
    if ($opt eq '-h' || $opt eq '--help') {
        print usage();
        exit 0;
    }
    if ($opt eq '-d' || $opt eq '--outdir') {
        $outdir = shift @ARGV;
    }
}
`mkdir -p $outdir`;
my $id;
my $stanza = "";
my @alt_ids = ();
my $fn = shift @ARGV;
my @ids = @ARGV;
my %idmap = map {$_ => 1} @ids;
my $num_ids = scalar(@ids);

my $n = 0;
print "Reading $fn\n";
open(F, $fn) || die "no such file $fn";
while(<F>) {
    if (m@^\[@) {
        $n++;
        if ($id) {
            # check if id is in %idmap
            if ($idmap{$id}) {
                w($id, $stanza);
            }
        }
        $stanza = "";
        $id = "";
    }
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    if (m@^alt_id: (\S+)@) {
        push(@alt_ids, $1);
    }
    $stanza .= $_;
}
close(F);
#print "n: $n\n";
sub get_path {
    my ($id) = @_;
    my $fn = "$id";
    $fn =~ s@:@_@;
    return "$outdir/$fn.obo"
    
}

sub w {
    my ($id, $stanza) = @_;
    my $path = get_path($id);
    print "Checking out $id to $path\n";
    open(W, ">$path") || die($path);
    print W $stanza;
    close(W)
}

sub scriptname {
    my @p = split(/\//,$0);
    pop @p;
}


sub usage {
    my $sn = scriptname();

    <<EOM;
$sn  OBO-FILE [ -d TERM-DIR ] TERM1 TERM2 ...

Checks out obo files into TERM-DIR from the OBO-FILE

Example:

$sn src/ontology/foo-edit.obo FOO:0000087 FOO:0000081

This will extract the FOO:0000087 and FOO:0000081 terms from the foo-edit.obo file
and write them to the terms directory, as files:

terms/FOO_0000087.obo
terms/FOO_0000081.obo

EOM
}


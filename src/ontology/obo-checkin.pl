#!/usr/bin/perl -w

use strict;
use FileHandle;
my $outdir = "terms";
my $cmd;
my $dry_run = 0;
my $preserve_files = 0;
while ($ARGV[0] =~ /^\-/) {
    my $opt = shift @ARGV;
    if ($opt eq '-h' || $opt eq '--help') {
        print usage();
        exit 0;
    }
    if ($opt eq '-d' || $opt eq '--outdir') {
        $outdir = shift @ARGV;
    }
    if ($opt eq '-n' || $opt eq '--dry-run') {
        $dry_run = 1;
    }
    if ($opt eq '-p' || $opt eq '--preserve-files') {
        $preserve_files = 1;
    }
}
`mkdir -p $outdir`;
my $id;
my $stanza = "";
my @alt_ids = ();
my $fn = shift @ARGV;
# ensure ids are sorted
my @ids = sort @ARGV;

my %new_stanza_map = ();

foreach my $id (@ids) {
    my $path = get_path($id);
    # check if $id is a path to a file that exists
    if ($id =~ m@[\./]@ && -e $id) {
        open(F, $id) || die "no such file $id";
        my @lines = <F>;
        close(F);
        my $uber_stanza = join("", @lines);
        my @stanzas_in_block = split(/\n\n/, $uber_stanza);
        foreach my $stanza (@stanzas_in_block) {
            # trim whitespace
            $stanza =~ s/\s+$//;
            if (!length($stanza)) {
                next;
            }
            # check if stanza has id (note that stanza is multi-line)
            if ($stanza =~ /id:\s+(\S+)/) {
                my $stanza_id = $1;
                $new_stanza_map{$stanza_id} = "$stanza\n\n";
            }
            else {
                die "no id found in $stanza";
            }
        }
    }
    else {
        open(F, $path) || die "no such file $path";
        my $stanza = "";
        while(<F>) {
            chomp;
            $stanza .= "$_\n";
        }
        close(F);
        if ($stanza =~ /id: (\S+)/) {
            # check id matches
            if ($1 ne $id) {
                die "id mismatch $1 ne $id";
            }
        }
        else {
            die "no id found in $path";
        }
        $new_stanza_map{$id} = $stanza;
    }
}

open(W, ">$fn.tmp") || die "cannot write tp $fn.tmp";

my %stanza_map = ();
my %stanza_type_map = (); # To track stanza type (Term or Typedef)
$/ = "\n\n";
open(F, $fn) || die "cannot open $fn";
while(<F>) {
    if ($_ =~ /id: (\S+)/) {
        my $id = $1;
        $stanza_map{$id} = $_;
        
        # Determine stanza type
        if ($_ =~ /\[(\w+)\]/) {
            $stanza_type_map{$id} = $1;
        }
        else {
            # Default to Term if type not specified
            $stanza_type_map{$id} = "Term";
        }
    }
    else {
        print W $_;
    }
}
close(F);

# combine old and new stanzas
foreach my $id (sort keys %new_stanza_map) {
    $stanza_map{$id} = $new_stanza_map{$id};
    
    # Update stanza type for new stanzas
    if ($new_stanza_map{$id} =~ /\[(\w+)\]/) {
        my $s = $1;
        $stanza_type_map{$id} = $s;
    }
    else {
        # Default to Term if type not specified
        $stanza_type_map{$id} = "Term";
    }
}

# Sort ids by stanza type (Term first, then Typedef) and then alphabetically within each type
my @sorted_ids = sort {
    # First compare stanza types (Term comes before Typedef)
    my $type_compare = ($stanza_type_map{$a} eq "Typedef") <=> ($stanza_type_map{$b} eq "Typedef");
    
    # If same type, sort alphabetically by ID
    return $type_compare || $a cmp $b;
} keys %stanza_map;

foreach my $id (@sorted_ids) {
    my $s = $stanza_map{$id};
    # normalize line endings to strip trailing whitespace
    $s =~ s@[\r\n]+$@\n\n@;
    print W $s;
}
close(W);

if ($dry_run) {
    print "dry run, no changes made\n";
}
else {
    `mv $fn.tmp $fn`;
    # clear out @ids from $outdir
    foreach my $id (@ids) {
        my $path = get_path($id);
        if (!$preserve_files) {
            unlink $path;
        }
    }
}

# get the path for an id
# the ID should be either:
# - an ontology curie, e.g. GO:0000001, in which case the path is terms/GO_0000001.obo
# - an OWL local name, e.g. GO_0000001, in which case the path is terms/GO_0000001.obo
# - a file name, e.g. terms/my_terms.obo, in which case the path is terms/my_terms.obo
sub get_path {
    my ($id) = @_;
    my $fn = "$id";
    $fn =~ s@:@_@;
    # if the id has : or / in it and is a path to a file that exists, return it
    if ($fn =~ m@[\./]@ && -e $fn) {
        return $fn;
    }
    return "$outdir/$fn.obo"
    
}

sub w {
    my ($id, $stanza) = @_;
    my $path = get_path($id);
    open(F, ">$path") || die($path);
    print F $stanza;
    close(F)
}

sub scriptname {
    my @p = split(/\//,$0);
    pop @p;
}


sub usage {
    my $sn = scriptname();

    <<EOM;
$sn  OBO-FILE [ -d TERM-DIR ] TERM1 TERM2 ...

Checks in obo files from TERM-DIR into the OBO-FILE

Example:

$sn src/ontology/foo-edit.obo FOO:0000087 FOO:0000081

This will check in the FOO:0000087 and FOO:0000081 terms from the terms directory
into the foo-edit.obo file.

EOM
}


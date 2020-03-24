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
my $f1 = shift @ARGV;
my @fs = ($f1);
if (!$f1) {
    @fs = (
        "mirror/hp.obo",
        "mondo-edit.obo",
        );
}

my %taken = ();
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
    }
    close(F);
}


my $xref;
my $name;
my $src;
my $srcqual = '';
my $in_header = 1;
my $this_id;
my $obs = 0;
print STDERR "READING NEXT @ARGV\n";
while(<>) {
    chomp;

    if (m@^name:.*\(disorder\)@) {
        s@ \(disorder\)@@;
    }
    s/relationship: (constitutional|regional|systemic)_part/relationship: part/;
    s/ attached_to / attaches_to /;
    s/ branch_of / branching_part_of /;

    s@\.  @. @g;

    s/SCTID_/SCTID:/;
    s/OMIM:PS/OMIMPS:/;
    s/EFO:0000784/disease_has_location/;

    s@http://linkedlifedata.com/resource/umls/id/@UMLS:@;
    s/NCI:/NCIT:/;
    s/SNOMEDCT_US_(\w+):/SCTID:/;
    s/UMLS_CUI/UMLS/;
    s/NCIT:R100/disease_has_location/;
    s/NCIT:R101/disease_has_location/;
    s/NCIT:R103/disease_arises_from_structure/;
    s/NCIT:R104/disease_arises_from_structure/;
    s/NCIT:R105/disease_has_feature/;  ## TBD has abn cell
    s/NCIT:R115/disease_has_feature/;
    s/NCIT:R108/disease_has_feature/;
    s/NCIT:R110/has_modifier/;   ## grade
    s/property_value:.*UMLS_CUI.*\"(\S+)\".*/xref: UMLS:$1/;
    s/property_value: NCIT:P207 "(\S+)" xsd:string/xref: UMLS:$1/;
    s/property_value: NCIT:P207 "(\S+)" xsd:string/xref: UMLS:$1/;
    s/property_value: NCIT:P334 "(\S+)" xsd:string/xref: ICDO:$1/;
    s@\[SCTID:\d+]@[linkedlife]@;
    s@"SCTID:\d+"@"linkedlife"@;

    s@\[SNOMEDCT_US:\d+\]@[]@;
    
    # GARD
    s@def: " @def: "@;
    
    s/(.*)/lc($1)/e if m@^name:@;

    s@relationship: part_of@is_a:@;
    s@property_value: hasSynonym "(.*)" xsd:string@synonym: "$1" EXACT []@;

    s@property_value: skos:definition "(.*)" xsd:string@def: "$1" [$xref]@;

    s@property_value: related:synonym "(.*)" xsd:string@synonym: "$1" RELATED []@;

    s@property_value: .*abbreviation "(.*)" xsd:string@synonym: "$1" RELATED ABBREVIATION []@;

    s@BFO:0000050@part_of@;

    s@property_value: defining:criteria "cyto-architecture" xsd:string@subset: defined_by_cytoarchitecture@;

    s@property_value: alternative:term "(.*)" xsd:string@synonym: "$1" RELATED [$xref]@;
    
    s@xref: (\S+)@xref: $1 \{source="$xref"}@;


    s@Orphanet:409930@HP:0000007@;
    s@Orphanet:409929@HP:0000006@;
    s@Orphanet:409932@HP:0001419@;
    s@Orphanet:C016@has_modifier@;
    ####s@RO:0004003@has_material_basis_in_germline_mutation_in@;
    s@RO:0004003@disease_has_basis_in_dysfunction_of@;

    
    next if (m@property_value: identifier@);
    next if (m@alt_id: (DHBA|HBA|MBA|PBA|DHBA)@);
    next if (m@synonym: ""@);
    next if (m@property_value: @);

    if (m@alt_id: OMIM@) {
        s@alt_id: OMIM:(\d+)@xref: OMIM:$1 \{source="$xref"}@;
        s@MESH:@MEDIC:@;
    }
    
    if (/^\[/) {
        $in_header = 0;
    }

    if (/^id:/) {
        $obs = 0;
    }
    if (m@obsolete@) {
        $obs = 1;
    }
    
    # fix syns
    if (/^(synonym: \".*\")\s+(\[.*)/) {
        $_ = "$1 RELATED $2";
    }
    
    if (/^id:\s*(\S+)/) {
        $xref = $1;

        # NEW!!! fill gaps
        $uid = nextid();
        $this_id = sprintf("MONDO:%07d",$uid);
        $_ = "id: $this_id";
        #$uid++;
        print "$_\n";

        if ($xrefh{$xref}) {
            print "! ALREADY HAVE THIS: id: $xrefh{$xref} ! $nh{$xrefh{$xref}}\n";

            if ($is_reuse_already) {
                delete $taken{sprintf("%07d",$uid)};
                $uid--;
            }

        }
        if ($is_use_all) {
            $xrefh{$xref} = $_; 
            #die "$id --> $uid";
        }
        ($src) = $xref =~/(\S+):/;
        if ($src && !$no_src) {
            $src =~ s/^NEW_//;
            $srcqual = "{source=\"$xref\"} ";
        }
    }
    elsif (/^namespace:/) {
    }
    elsif (/^name:\s*(.*)/) {
        $name = $1;
        print "$_\n";
    }
    elsif (/^(relationship|intersection_of):\s*(\S+)\s+(\S+)/ && $3 !~ /\!/) {
        next if $2 eq 'end';
        if ($xrefh{$3}) {
            print "$1: $2 $xrefh{$3} $srcqual! $nh{$xrefh{$3}}\n";
        }
        elsif ($map_all || $3 =~ m@(UBERON|CL|GO|http://identifiers.org/hgnc)@) {
            s@ \! @ $srcqual\! @g;
            print "$_\n";
        }
        else {
            print "! no mapping ($3) -- $_\n";
        }
    }
    elsif (/^(disjoint_from|is_a|intersection_of):\s*(\S+)/) {
        if ($xrefh{$2}) {
            print "$1: $xrefh{$2} $srcqual! $nh{$xrefh{$2}}\n";
        }
        else {
            print "! no mapping ($2) -- $_\n";
        }
    }
    elsif (/^(synonym:.*" )(.*)\[\]\s*$/) {
        my $x1 = $1;
        my $x2 = $2;
        if ($xref =~ m@^NCIT@) {
            $x1 = lc($x1);
        }
        print "$x1$x2 [$xref]\n";
    }
    elsif (/^(def:\s+\".*\")\s+\[\]\s*$/) {
        print "$1 [$xref]\n";
    }
    elsif (/^(def:\s+\".*\")\s+\[(.*)\]\s*$/ && $combine_def_xref) {
        print "$1 [$xref, $2]\n";
    }
    elsif (/^(def:\s+\".*\")\s+\[.*\]\s*$/ && !$preserve_def_xref) {
        print "$1 [$xref]\n";
    }
    elsif (/^\s*$/) {
        my $EQ = "equivalentTo";
        if ($obs) {
            $EQ = "obsoleteEquivalent";
        }
        print "xref: $xref \{source=\"MONDO:$EQ\"\} ! $name\n"
            unless $xref =~ /^MONDO:/;
        print "\n";
    }
    else {
        print "$_\n" unless $in_header;
    }
}
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
Example:

cat foo.obo | $sn  | obo-grep.pl --neg -r ALREADY -

EOM
}


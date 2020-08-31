#!/usr/bin/perl
use strict;

while(<>) {
    next if m@^level@;
    chomp;
    my @vals = split(/\t/,$_);
    my $nci = $vals[9];
    my $umls = $vals[10];
    my $n = 6;
    while (!$vals[$n] && $n) {
        $n--;
    }
    my $v = $vals[$n];
    my ($id,$name,$x) = getid($v, $n);
    my $p;
    my $pname;
    if ($n) {
        ($p, $pname) = getid($vals[$n-1], $n-1);
    }
    print "[Term]\n";
    print "id: $id\n";
    print "name: $name\n";
    if ($p) {
        print "is_a: $p ! $pname\n";
    }
    if ($nci) {
        print "xref: NCIT:$nci\n";
    }
    if ($umls) {
        print "xref: UMLS:$umls\n";
    }
    print "\n";
    
}
exit 0;

sub getid {
    my $v = shift;
    my $level = shift;
    if ($v =~ m@(.*) \((\S+)\)@) {
        my ($id, $n) = ($2, $1);

        my @toks = split(/([\s\-\/])/, $n);
        #print STDERR "TOKS=@toks\n";
        @toks = map {normalize_case($_)} @toks;
        $n = join('', @toks);
        if (!$level) {
            $n = "$n neoplasm";
        }
        my $x = $id;
        $id =~ s@_@@g;
        return ("ONCOTREE:$id", $n, $x);
    }
    die $v;
}

sub normalize_case {
    my $w = shift;
    if ($w =~ m@^[A-Z][a-z]+@) {
        $w = lc($w);
    }
    return $w;
}

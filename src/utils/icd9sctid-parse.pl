#!/usr/bin/perl
#
# https://www.nlm.nih.gov/research/umls/mapping_projects/icd9cm_to_snomedct.html
# ../utils/icd9sctid-parse.pl ICD9CM_SNOMEDCT_map_201712/ICD9CM*txt
#
my $n=0;
while(<>) {
    next if m@^ICD@;
    my @x = split(/\t/, $_);
    my $rel = 'relatedTo';
    if ($x[9]) {
        $rel = 'equivalentTo';
    }
    $n++;
    print "[Term]\n";
    print "id: SCTID:$x[7] ! $x[8]\n";
    print "xref: ICD9:$x[0] {source=\"MONDO:$rel\", source=\"i2s\"} ! $x[1]\n";
    print "\n";
}
print STDERR "N=$n\n";

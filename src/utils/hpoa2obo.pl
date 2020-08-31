#!/usr/bin/perl
while(<>) {
    chomp;
    my ($db, $id, $n, $q, $t, $src, $ev, $z, $freq, $z2, $aspect) = split(/\t/, $_);
    my $rel;
    if ($aspect eq 'I') {
        $rel = 'has_modifier';
    }
    elsif ($aspect eq 'O') {
        # obligate only
        if ($freq =~ m@HP:0040280@) {
            $rel = 'disease_has_feature';
        }
        
    }
    $db =~ s@ORPHA@Orphanet@;
    if ($rel) {
        my $tn;
        if ($t =~ m@(HP:\d+)-(.*)@) {
            ($t, $tn) = ($1, $2);
        }
        print "[Term]\n";
        print "id: $db:$id\n";
        print "name: $n\n";
        print "relationship: $rel $t {source=\"$src-HPOA\"} ! $tn\n\n";
    }    
}
print "\n";
print "[Typedef]\n";
print "id: has_modifier\n";
print "name: has modifier\n";
print "xref: RO:0002573\n";


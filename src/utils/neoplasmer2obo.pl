#!/usr/bin/perl

$id = '21270';


%done=();
while(<>) {
    chomp;
    my ($g,$gn,$a,$an,$dn,$dn2,@xs) = split(/\t/,$_);
    $uid = "$g-$a";
    next if $done{$uid};
    $done{$uid} = 1;

    my $curr_id;
    foreach (@xs) {
        if (m@^(MONDO:\d+)@) {
            $curr_id = $_;
        }
    }
    
    print "[Term]\n";
    if ($curr_id) {
        print "id: $curr_id\n";
    }
    else {
        $id++;
        printf "id: MONDO:%07d\n", $id;
    }
    print "name: $dn\n";
    while (@xs) {
        my $x = shift @xs;
        my $xn = shift @xs;

        if ($x =~ m@MONDO@) {
            print "!!! CURRENT: $xn\n";
            next;
        }
        print "xref: $x {source=\"MONDO:equivalentTo\"} ! $xn\n";
    }
    print "intersection_of: $g ! $gn\n";
    print "intersection_of: disease_has_location $a ! $an\n";
    print "\n";
}

#!/usr/bin/perl

# use this then replacedef.pl

while(<>) {
    chomp;
    if (m@^id: (\S+)@) {
        $id = $1;
        $xp = ();
    }
    if (m@^name: (.*)@) {
        $n = $1;
    }
    if (m@^intersection_of: (\S+) \! (.*)@) {
        ($genus, $genus_label) = ($1,$2);
    }
    if (m@^intersection_of: (\S+) (\S+) \! (.*)@) {
        ($r,$x,$xn) = ($1,$2,$3);
        if ($genus_label eq 'carcinoma') {
            outdef("A carcinoma that arises from epithelial cells of the $3");
        }
        if ($genus_label eq 'adenocarcinoma') {
            outdef("A carcinoma that arises from glandular epithelial cells of the $3");
        }
        if ($genus_label eq 'cancer') {
            outdef("A malignant neoplasm involving the $3");
        }
        if ($genus_label eq 'disease') {
            if ($r eq 'disease_has_location') {
                outdef("A disease involving the $3");
            }
            if ($r eq 'disease_has_major_feature') {
                outdef("A disease in which $3 is a major feature.");
            }
        }
        #if ($x eq 'disease') {
        #    outdef("A disease involving the $3");
        #}
        push(@{$genus{$id}}, [$genus, $genus_label]);
        push(@{$xp{$id}}, [$r,$x,$xn]);
    }
    if ($_ = "\n") {
        @xps = @{$xp{$id} || []};
        if (@xps) {
            @gs = $genus{$id};
            $g = shift @gs;
            if (@xps == 1) {
                $genus_label =~ s@ \(disease\)@@;
                printf STDERR "FOOOOO %s\n",  $xps[0]->[1];
                if (rare(@{$xps[0]})) {
                    $genus_label =~ s@ \(disease\)@@;
                    outdef("A rare form of $genus_label");
                }
                elsif ($xps[0]->[1] eq 'HP:0001417') {
                    outdef("A $genus_label that has a X-linked model of inheritance");
                }
                elsif ($xps[0]->[1] eq 'HP:0000006') {
                    outdef("A $genus_label that has an autosomal dominant of inheritance");

                }
                elsif ($xps[0]->[1] eq 'HP:0000006') {
                    outdef("A $genus_label that has an autosomal recessive of inheritance");

                }
            }
        }
        
    }
    
}
exit 0;

sub outdef {
    return if $done{$id};
    $done{$id} = 1;
    print "[Term]\n";
    print "id: $id ! $n\n";
    print "def: \"$_[0].\" [MONDO:DesignPattern]\n\n";
}

sub rare {
    print STDERR "CHECKING: @_\n";
    return grep { $_[1] eq "PATO:0000381"} @_;
}

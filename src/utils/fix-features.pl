#!/usr/bin/perl
open(F, ">candidate-d2p.tsv");
while(<>) {
    if (m@^id: (\S+)@) {
        $id = $1;
        $inf = 0;
    }
    if (m@^name: (.*)\n@) {
        $n = $1;
    }
    if (m@MONDO:patterns/infectious_disease_by_agent@) {
        $inf = 1;
    }
    if (m@realized_in_response_to_stimulus NCBITaxon@) {
        $inf = 1;
    }
    if ($inf && m@^relationship: disease_has_feature (HP:\d+) \! (.*)\n@) {
        print F "$id\t$n\t$1\t$2\n";
        next;
    }
    print $_;
    
}
close(F);

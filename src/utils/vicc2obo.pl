#!/usr/bin/perl
use strict;

while(<>) {
    if (m@{"type":{"termId":"(\S+)_(\S+):(.*)"},"id":@) {
        my ($pre, $local, $n) = ($1,$2,$3);
        if ($pre eq 'www.owl-ontologies.com_NPOntology.owl#DOID') {
            $pre = 'DOID';
        }
        $pre =~ s@SNOMEDCT@SCTID@;
        $pre =~ s@MEDDRA@MedDRA@;
        my $id = "$pre:$local";
        print "[Term]\n";
        print "id: $id\n";
        print "name: $n\n";
        print "\n";
    }    
}
exit 0;


#!/usr/bin/perl
use strict;
my $id;
my %has_exact_map = ();
my @triples = ();
while (<>) {
    if (m@^id:@) {
        $id = undef;
        if (m@^id: MONDO:(\d+)@) {
            $id = "http://purl.obolibrary.org/obo/MONDO_$1"
        }
    }
    # A triple <A> skos:broader <B> asserts that <B>, the object of the triple, is a broader concept than <A>, the subject of the triple
    if (m@^xref: (\S+):(\S+) (.*)@) {
        my ($prefix, $x, $anns) = ($1,$2,$3);
        my $rel = 'closeMatch';
        
        if ($anns =~ m@equivalentTo@) {
            $rel = 'exactMatch';
        }
        elsif ($anns =~ m@equivalentObsolete@) {
            next;
        }
        elsif ($anns =~ m@obsoleteEquivalent@) {
            $rel = 'exactMatch';
        }
        elsif ($anns =~ m@relatedTo@) {
            $rel = 'relatedMatch';
        }
        elsif ($anns =~ m@includedEntryInOMIM@) {
            $rel = 'relatedMatch';
        }
        elsif ($anns =~ m@mondoIsNarrowerThanSource@) {
            $rel = 'broadMatch';
        }
        elsif ($anns =~ m@directSiblingOf@) {
            $rel = 'closeMatch';
        }
        elsif ($anns =~ m@mondoIsBroaderThanSource@) {
            $rel = 'narrowMatch';
        }
        $rel = "http://www.w3.org/2004/02/skos/core#".$rel;
        my $uri;
        if ($prefix eq 'UMLS') {
            $uri = 'http://linkedlifedata.com/resource/umls/id/';
        }
        elsif ($prefix eq 'MESH') {
            $uri = 'http://identifiers.org/mesh/';
        }
        elsif ($prefix eq 'SCTID') {
            $uri = 'http://identifiers.org/snomedct/';
        }
        elsif ($prefix eq 'NCIT') {
            $uri = 'http://purl.obolibrary.org/obo/NCIT_';
        }
        elsif ($prefix eq 'DOID') {
            $uri = 'http://purl.obolibrary.org/obo/DOID_';
        }
        elsif ($prefix eq 'Orphanet') {
            $uri = 'http://www.orpha.net/ORDO/Orphanet_';
        }
        elsif ($prefix eq 'MEDGEN') {
            $uri = 'http://identifiers.org/medgen/';
        }
        elsif ($prefix eq 'OMIMPS') {
            $uri = 'https://omim.org/phenotypicSeries/PS';
        }
        elsif ($prefix eq 'OMIM') {
            $uri = 'https://omim.org/entry/';
        }
        elsif ($prefix eq 'MedDRA') {
            $uri = 'http://identifiers.org/meddra/';
        }
        elsif ($prefix eq 'ICD10WHO') {
            $uri = 'https://icd.who.int/browse10/2019/en#/';
        }
        elsif ($prefix eq 'ICD10CM') {
            $uri = 'http://purl.bioontology.org/ontology/ICD10CM/';
        }
        elsif ($prefix eq 'icd11.foundation') {
            $uri = 'http://purl.obolibrary.org/obo/mondo/sources/icd11foundation/';
        }
        elsif ($prefix eq 'EFO') {
            $uri = 'http://www.ebi.ac.uk/efo/EFO_';
        }

        if ($uri) {
            my $tgt = "$uri$x";
            $has_exact_map{$tgt} = 1 if $rel =~ m@exactMatch@;
            push(@triples, [$id, $rel, $tgt]);
        }
    }
    
}

foreach (@triples) {
    my ($s,$rel,$o) = @$_;
    if ($rel =~ m@exactMatch@ || !$has_exact_map{$o}) {
        print "<$s> <$rel> <$o> .\n";
    }
    else {
        #print STDERR "MASKING: $s $rel $o\n";
    }
}

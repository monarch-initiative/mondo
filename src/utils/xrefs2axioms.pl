#!/usr/bin/perl -w
use strict;

print "\@prefix owl:   <http://www.w3.org/2002/07/owl#> .\n";
print "\@prefix MONDO:   <http://purl.obolibrary.org/obo/MONDO_> .\n";
print "\@prefix DOID:   <http://purl.obolibrary.org/obo/DOID_> .\n";
print "\@prefix DC:   <http://purl.obolibrary.org/obo/DC_> .\n";
print "\@prefix OMIM:   <http://purl.obolibrary.org/obo/OMIM_> .\n";
print "\@prefix MESH:   <http://purl.obolibrary.org/obo/MESH_> .\n";
print "\@prefix OGMS:   <http://purl.obolibrary.org/obo/OGMS_> .\n";
print "\@prefix NCIT:   <http://purl.obolibrary.org/obo/NCIT_> .\n";
print "\@prefix UMLS:   <http://purl.obolibrary.org/obo/UMLS_> .\n";
print "\@prefix EFO:   <http://www.ebi.ac.uk/efo/EFO_> .\n";
print "\@prefix Orphanet:   <http://purl.obolibrary.org/obo/http://www.orpha.net/ORDO/Orphanet_> .\n";

print "## Axioms generated from xrefs\n";
print "<http://purl.obolibrary.org/obo/mondo/imports/equivalencies.owl> a owl:Ontology .\n";

my $id;
while(<>) {
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    if (m@^xref: (\S+).*source="MONDO:equivalentTo@) {
        my $x = $1;

        print "$id owl:equivalentTo $x .\n";
    }
}

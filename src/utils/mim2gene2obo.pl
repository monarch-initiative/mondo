#!/usr/bin/perl
$_ = <>;

while(<>) {
    ($m,$g,$t) = split(/\t/,$_);
    if ($t ne 'phenotype') {
        next;
    }
    if ($g ne '-') {
        print "[Term]\n";
        print "id: OMIM:$m\n";
        print "relationship: disease_has_basis_in_dysfunction_of NCBIGene:$g {source=\"mim2gene_medgen\"}\n\n";
    }
}

print "\n[Typedef]\n";
print "id: disease_has_basis_in_dysfunction_of\n";
print "name: disease has basis in dysfunction of\n";
print "xref: RO:0004020\n";

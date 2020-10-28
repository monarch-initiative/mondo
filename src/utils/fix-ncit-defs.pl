#!/usr/bin/perl
while(<>) {
    chomp;
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    s@\[\] {http://purl.obolibrary.org/obo/NCIT_P378="NCI"}@[$id]@;
    print "$_\n";
}

#!/usr/bin/perl

while(<>) {
    
    s@xref: OMIM:@relationship: RO:HOM0000001 OMIM:@;
    s@is_a: DOID:@relationship: RO:HOM0000001 DOID:@;
    
    if (m@^id: (\S+)@) {
        $id = $1;
        $is_generic = $id =~ m@^OMIA:\d+$@;
    }
    
    if (m@^name: (.*)@ && $is_generic) {
        $_ = "name: $1 (in other animals)\nis_a: MESH:D000820 ! animal disease\n";
    }
    print;

    if (m@^ontology:@) {
        print "\n[Term]\n";
        print "id: MESH:D000820\n";
        print "name: animal disease\n";
    }
}

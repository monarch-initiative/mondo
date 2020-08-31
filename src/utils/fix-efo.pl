#/usr/bin/perl 
while (<>) {
    if (m@property_value: http://www.ebi.ac.uk/efo/definition (".*") xsd:string (.*)@) {
        ($def,$x) = ($1,$2);
        $xref = "";
        if ($x =~ m@createdBy="(.*)"@) {
            $xref = $1;
        }
        $_ = "def: $def [$xref]\n";
    }
    elsif (m@property_value: http://www.ebi.ac.uk/efo/definition (".*") xsd:string@) {
        ($def) = ($1);
        $_ = "def: $def []\n";
    }
    if (m@property_value: alternative:term (".*") xsd:string (.*)@) {
        ($def,$x) = ($1,$2);
        $xref = "";
        if ($x =~ m@createdBy="(.*)"@) {
            $xref = $1;
        }
        $_ = "synonym: $def RELATED [$xref]\n";
    }
    s@property_value: http://www.ebi.ac.uk/efo/.*_definition_citation (\S+) xsd:string@xref: $1@;
    s@NCIt:@NCIT:@;
    s@MSH:@MESH:@;
    s@SNOMEDCT@SCTID@;
    s@ORDO:Orphanet_@Orphanet@;
    print;
}

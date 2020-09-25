#!/usr/bin/perl

# make filtered.obo
# obo-map-ids.pl --use-xref-inverse filtered.obo mirror/neoplasm-core.obo > neoplasm-core-m.obo
# replacedef.pl mondo-edit.obo NEW.obo [..]

#also: ../utils/replacedef.pl mondo-edit.obo ../patterns/merged-ld.obo

my $N=0;
my $id = undef;
my $ont = shift @ARGV;
while(<>) {
    chomp;
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    s@\[\] {http://purl.obolibrary.org/obo/NCIT_P378="NCI"}@[$id]@;
    if (m@(^def:.*)@) {
        $def{$id} = $1;
    }
    if (m@^equivalent_to: (\S+)@) {
        #print STDERR "EREAD=$id = $1\n";
        $equiv{$id} = $1;
    }
}
open(F, $ont);
while(<F>) {
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    if (m@def:@) {
        $hasdef{$id} = 1;
    }
}
close(F);
open(F, $ont);
while(<F>) {
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    if (m@^name: (.*)@) {
        $n = $1;
    }
    if (m@def:.*DOID:@) {
        $_ = replacedef($_);
    }
    print;
    
    if (m@^name:@) {
        if (!$hasdef{$id}) {
            $_ = replacedef("NONE");
            if (m@^def:@) {
                print $_;
            }
        }
    }
}

print STDERR "\nREPLACED: $N\n";
exit 0;

sub getdef {
    my $s = shift;
    if ($s=~ m@def: "(.*)" \[@) {
        return $1;
    }
}

sub replacedef {
    $_ = shift @_;
    $e = $equiv{$id};
    $d = $def{$e};
    if (!$d) {
        $d = $def{$id};
    }
    if ($d) {
        $old = getdef($_);
        $new = getdef($d);
        if (lc($old) ne lc($new)) {
            print STDERR "$id ! $n\n";
            print STDERR "REPLACING $_ => $d // $new\n\n";
            $_ = "$d\n";
            $N++;
        }
        
    }
    return $_;
}

#!/usr/bin/perl

while(<>) {
    if (m@^id: (\S+)@) {
        $id = $1;
        $s = 0;
        @xrefs = ();
    }
    if (m@^name: (.*)@) {
        $name = $1;
    }
    if (m@^xref: (\S+).*equivalentTo@) {
        push(@xrefs, $1);
    }
    if (m@^(name|synonym):.*susceptibility to@) {
        $s=1;
        if (m@^name: (.*)@) {
            $ms = $1;
            $mx = 'name';
        }
        elsif (m@^synonym: "(.*)".*\[(.*)\]@) {
            $ms = $1;
            $mx = $2;
        }
    }
    if (m@^is_obsolete: true@) {
        $s=0;
    }

    if (m@^$@) {
        if ($s) {
            $s=0;
            print "$id\t$name\t$mx\t@xrefs\t$ms\n";
        }
    }
}

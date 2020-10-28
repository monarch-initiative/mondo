#!/usr/bin/perl
while(<>) {
    chomp;
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    elsif (m@^name: (.*)@) {
        $n = $1;
    }
    elsif (m@^is_a: (.*) {source="Orphanet:\d+"} ! (.*)@) {
        print "$id\t$n\t$1\t$2\n";
    }
}

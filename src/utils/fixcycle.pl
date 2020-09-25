#!/usr/bin/perl
while(<>) {
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    if (m@^name: (.*)@) {
        $name = $1;
    }
    if (m@is_a: (\S+)@) {
        if ($id eq $1) {
            print STDERR "CYCLE: $id $name $1\n";
            next;
        }
    }
    print;
}

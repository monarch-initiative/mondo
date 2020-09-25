#!/usr/bin/perl
while(<>) {
    if (m@^id: (\S+)@) {
        $id = $1;
    }
    if (m@^def:(.*) \[\] \{@) {
        $_ = "def: $1 [$id]\n";
    }
    print;
}

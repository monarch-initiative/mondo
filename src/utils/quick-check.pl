#!/usr/bin/perl
while(<>) {
    chomp;
    if (m@^\[(\S+)\]@) {
        $type = lc($1);
    }
    if (m@^id: (.*)@) {
        if ($type eq 'term') {
            if ($1 !~ m@^MONDO:\d{7}$@) {
                bad("$_");
            }
        }
    }
    if (m@^xref: (\S+)@) {
        if ($1 =~ m@^(\S+):(\S+)$@) {
            # ok
        }
        else {
            bad($_);
        }
    }
}
if ($bad) {
    print STDERR "ERRORS FOUND: $bad\n";
}
exit $bad;

sub bad {
    print STDERR "@_\n";
    $bad++;
}

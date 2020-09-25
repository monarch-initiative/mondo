#!/usr/bin/perl
while(<>) {
    chomp;
    my @vs = split(/\t/,$_);
    if (@vs == 4) {
        $m{$vs[2]} = [$vs[0],$vs[1]];
        next;
    }
    else {
        if (m@^id: (\S+)@) {
            $id = $1;
            $x = $m{$id};
        }
        if (m@^name:@) {
            if ($x) {
                $_ .= " (disease)";
                print "xref: $x->[0] {source=\"ontobio\"} ! $x->[1]\n";
            }
        }
    }
    print "$_\n";
}

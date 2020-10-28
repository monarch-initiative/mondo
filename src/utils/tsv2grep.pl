#!/usr/bin/perl
while(<>) {
    chomp;
    my ($x,$xn,$y) = split(/\t/, $_);
    run("obo-grep.pl --noheader -r 'id: ($x|$y)' mondo-edit.obo");
    print "../utils/obs.sh $x $y   # FWD\n";
    print "../utils/obs.sh $y $x   # REV\n";
    print "--obsolete-replace $x $y   # FWD\n";
    print "--obsolete-replace $y $x   # REV\n";
}
exit 0;

sub run {
    $c = shift @_;
    print `$c`;
}

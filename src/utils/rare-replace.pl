#!/usr/bin/perl -w
use strict;

open(F,shift @ARGV);
my %m=();
while(<F>) {
    chomp;
    my ($id,$x) = split(' ',$_);
    $m{$id} = $x;
}
close(F);
while(<>) {
    chomp;
    if (m@^is_a: (\S+) (.*)@) {
        my ($is_a,$rest) = ($1,$2);
        if ($m{$is_a}) {
            $rest =~ s@, source="linked\w+"@@;
            print "is_a: $m{$is_a} $rest\n";
            print "relationship: has_modifier MONDO:0021136 {source=\"$is_a\"} ! rare\n";
            next;
        }
    }
    if (m@^intersection_of: (\S+) (.*)@) {
        my ($is_a,$rest) = ($1,$2);
        if ($m{$is_a}) {
            print "intersection_of: $m{$is_a} $rest\n";
            next;
        }
    }
    print "$_\n";
}

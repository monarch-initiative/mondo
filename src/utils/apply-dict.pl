#!/usr/bin/perl
use strict;

my $tr_syns = 1;
my $tr_names = 1;
my $quiet = 0;
while ($ARGV[0] =~ m@^-@) {
    my $opt = shift;
    if ($opt eq '-s') {
        $tr_names = 0;
    }
    elsif ($opt eq '-n') {
        $tr_syns = 0;
    }
    elsif ($opt eq '-q') {
        $quiet = 1;
    }
}

my %wmap = ();
open(F,shift @ARGV);
while(<F>) {
    chomp;
    my ($w, $min, $max, $s, $a) = split(/\t/, $_);
    $wmap{lc($w)} = [$w, $min, $max, $s, $a];
}
close(F);

my @ambigs = ();
my $n_changes = 0;
my $n=0;
while(<>) {
    chomp;
    if ($tr_syns) {
        if (m@synonym: \"(.*)\" (.*)@) {
            my ($s, $rest) = ($1,$2);
            my $s2 = fix_syn($s);
            if ($s2 ne $s) {
                $_ = "synonym: \"$s2\" $rest";
                #print STDERR "S: $s -> $s2\n";
                $n_changes++;
            }
        }
    }
    if ($tr_names) {
        if (m@name: (.*)@) {
            my $s = $1;
            my $s2 = fix_syn($s);
            if ($s2 ne $s) {
                $_ = "name: $s2";
                #print STDERR "N: $s -> $s2\n";
                $n_changes++;
            }
        }
    }
    print "$_\n";
}

if (!$quiet) {
    print STDERR "CHANGES: $n_changes\n";
    printf STDERR "AMBIGS: %d\n", scalar(@ambigs);
}
exit 0;

sub fix_syn {
    my ($s) = @_;
    my @toks = split(/(\W)/, $s);
    my @toks2 = map {fix_word($_, $s)} @toks;
    my $s2 = join('', @toks2);
    return $s2;
}

sub fix_word {
    my ($w,$term) = @_;
    my $info = $wmap{lc($w)};
    if ($info) {
        if ($info->[-1] eq 'IS_AMBIGUOUS') {
            push(@ambigs, "$w // $term");
            #print STDERR "?? $w\n";
        }
        else {
            return $info->[0];
        }
    }
    return $w;
}

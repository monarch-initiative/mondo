#!/usr/bin/perl

use strict;

my %rmap = ();
my %rmap_ci = ();
my $f = shift @ARGV;
open(F,$f) || die $f;
while(<F>) {
    chomp;
    s@\r@@;
    my ($uri, $orig, $is_fine, $repl) = split(/\t/,$_);
    if  ($is_fine eq 'n') {
        $rmap{$orig} = $repl;
        $rmap_ci{lc($orig)} = $repl;
    }
}
close(F);

while(<>) {
    chomp;
    if (m@^name: (.*)@) {
        my $nu = chk($1, 'name');
        if ($nu) {
            $_ = "name: $nu";
        }
    }
    if (m@^synonym: "(.*)"@) {
        my $nu = chk($1, 'synonym');
        if ($nu) {
            s@\s+"(.*)"\s+@ "$nu" @x;
        }
    }
    print "$_\n";;
}
exit 0;

sub chk {
    my ($s, $info) = @_;
    my $nu = $rmap{$s};
    if ($nu) {
        print STDERR "1 $info: $s -> $nu\n";
        return $nu;
    }
    my $nu = $rmap_ci{lc($s)};
    if ($nu && $nu ne $s) {
        print STDERR "2 $info: $s -> $nu\n";
        return $nu;
    }
}

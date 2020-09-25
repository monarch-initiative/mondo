#!/usr/bin/perl

while(<>) {
    if (m@(\S+)\t(\S+)\t(\S+)\t(\S+)@) {
        $m{$1} = $2;
    }
}

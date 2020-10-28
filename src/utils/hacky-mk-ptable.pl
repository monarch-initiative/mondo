#!/usr/bin/perl
while(<>) {
    my ($x,$xn,$y,$yn,$m,$mn,$info) = split(/\t/,$_);
    if ($info =~ m@(related|broad|narrow)@) {
        @p = (0.05,0.05,0.5,0.4);
    }
    else {
        @p = (0.05,0.05,0.8,0.1);
    }
    print join("\t",($x,$y,@p))."\n";
}

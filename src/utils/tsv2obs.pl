#!/usr/bin/perl
print "owltools mondo-edit.obo \\\n";
while(<>) {
    chomp;
    if (m@(\S+) \! .*\t(\S+) \!@) {
        print "  --obsolete-replace $1 $2 \\\n";
    }
}
print " -o -f obo z.tmp && grep -v ^owl-axioms z.tmp > z\n";

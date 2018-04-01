#!/usr/bin/perl
use strict;

# THIS IS TEMPORARY
# will be retired when this implemented: https://github.com/ontodev/robot/issues/176

my $h = <>;
$h =~ s@\?@@g;
print $h;
while(<>) {
    chomp;
    my @vs = map { fixcell($_) } split(/\t/,$_);
    $_ = join("\t", @vs)."\n";
    print;
}
exit 0;

sub fixcell {
    $_ = shift;
    if (m@^<(.*)>$@) {
        return fixuri($1);
    }
    if (m@^"(.*)"\^\^<@) {
        return $1;
    }
    return $_;
}

sub fixuri {
    $_ = shift;
    s@^http://www.w3.org/2000/01/rdf-schema#(\w+)@rdfs:$1@;
    s@^http://www.geneontology.org/formats/oboInOwl#(\w+)@oboInOwl:$1@;
    s@^http://purl.obolibrary.org/obo/(\w+)_@$1:@;
    return $_;
}

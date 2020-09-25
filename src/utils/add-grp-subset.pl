#!/usr/bin/perl
while(<>) {
    print;
    if (m@^name: .* as a major feature@) {
        print "subset: obsoletion_candidate\n";
        print "property_value: seeAlso https://github.com/monarch-initiative/mondo/projects/6 xsd:anyURI\n";
    }
}

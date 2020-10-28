#!/usr/bin/perl
while(<>) {
    print;
    if (m@^name: rare @) {
        print "subset: obsoletion_candidate\n";
        print "property_value: seeAlso https://github.com/monarch-initiative/mondo/issues/254 xsd:anyURI\n";
    }
}

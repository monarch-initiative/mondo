#!/usr/bin/perl
while(<>) {
    s@^relationship: seeAlso (\S+) \{@property_value: seeAlso $1 xsd:anyURI \{@;
    print;
}

#!/usr/bin/perl
while(<>) {
    if (m@^id: MONDO:(\S+)@) {
        $id = $1;
    }
    if (m@name: (.*); (\S+)\n@) {
        print "name: $1\n";
        print "synonym: \"$1; $2\" EXACT [MONDOLEX:$id]\n";
        print "synonym: \"$2\" EXACT ABBREVIATION [MONDOLEX:$id]\n";
    }
    else {
        print;
    }
}

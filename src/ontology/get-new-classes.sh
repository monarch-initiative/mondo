#!/bin/sh
# this is temporary!
# will be replaced when https://github.com/ontodev/robot/issues/432
echo \#\# New Classes
echo
grep ^\+id: mondo-diff.txt | perl -npe 's@...: MONDO:(\d+) . @ * [MONDO:$1](http://purl.obolibrary.org/obo/MONDO_$1) @'
echo
echo \#\# Obsoletions
echo
grep '\--> obsolete' mondo-diff.txt | perl -npe 's@id: MONDO:(\d+) . @ * [MONDO:$1](http://purl.obolibrary.org/obo/MONDO_$1) @'
echo
echo \#\# Renaming
echo
grep '\-->' mondo-diff.txt | perl -npe 's@id: MONDO:(\d+) . @ * [MONDO:$1](http://purl.obolibrary.org/obo/MONDO_$1) @'
echo

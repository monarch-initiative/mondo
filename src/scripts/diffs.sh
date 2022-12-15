#!/usr/bin/env bash

set -e

MONDO0906=http://purl.obolibrary.org/obo/mondo/releases/2022-09-06/mondo.owl
MONDO1003=http://purl.obolibrary.org/obo/mondo/releases/2022-10-03/mondo.owl
MONDO1011=http://purl.obolibrary.org/obo/mondo/releases/2022-10-11/mondo.owl
MONDO1101=http://purl.obolibrary.org/obo/mondo/releases/2022-11-01/mondo.owl

#robot diff --left-iri $MONDO0906 --right-iri $MONDO1003 --output diff_0906_1003.txt
#robot diff --left-iri $MONDO1003 --right-iri $MONDO1011 --output diff_1003_1011.txt
#robot diff --left-iri $MONDO1011 --right-iri $MONDO1101 --output diff_1011_1101.txt
#robot diff --left-iri $MONDO0906 --right-iri $MONDO1101 --output diff_0906_1011.txt

echo "September 9 to October 3"
echo "Removed:" && grep -E '^[-].*OMIM:\d.*' diff_0906_1003.txt | wc -l
echo "Added:" && grep -E '^[+].*OMIM:\d.*' diff_0906_1003.txt | wc -l
echo ""

echo "October 3 to October 11"
echo "Removed:" && grep -E '^[-].*OMIM:\d.*' diff_1003_1011.txt | wc -l
echo "Added:" && grep -E '^[+].*OMIM:\d.*' diff_1003_1011.txt | wc -l
grep -E '^[-].*OMIM:\d.*' diff_1003_1011.txt > diff_1003_1011_omim.txt
echo ""

echo "October 11 to November 1"
echo "Removed:" && grep -E '^[-].*OMIM:\d.*' diff_1011_1101.txt | wc -l
echo "Added:" && grep -E '^[+].*OMIM:\d.*' diff_1011_1101.txt | wc -l
grep -E '^[-].*OMIM:\d.*' diff_1011_1101.txt > diff_1011_1101_omim.txt
echo ""

echo "September 6 to November 1"
echo "Removed:" && grep -E '^[-].*OMIM:\d.*' diff_0906_1011.txt | wc -l
echo "Added:" && grep -E '^[+].*OMIM:\d.*' diff_0906_1011.txt | wc -l
echo ""

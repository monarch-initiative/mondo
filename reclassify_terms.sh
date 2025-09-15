#!/bin/bash

# Script to reclassify human disease direct subclasses

echo "Reclassifying remaining terms..."

# MONDO:0019303: premature aging syndrome → MONDO:1060155: genetic and chromosomal disease
echo "Processing premature aging syndrome..."
LINE_NUM=$(grep -n "id: MONDO:0019303" src/ontology/mondo-edit.obo | cut -d: -f1)
if [ ! -z "$LINE_NUM" ]; then
    SEARCH_START=$((LINE_NUM - 5))
    SEARCH_END=$((LINE_NUM + 50))
    IS_A_LINE=$(sed -n "${SEARCH_START},${SEARCH_END}p" src/ontology/mondo-edit.obo | grep -n "is_a: MONDO:0700096" | head -1)
    if [ ! -z "$IS_A_LINE" ]; then
        IS_A_LINE_NUM=$((SEARCH_START + $(echo $IS_A_LINE | cut -d: -f1) - 1))
        echo "Found is_a at line $IS_A_LINE_NUM"
    fi
fi

echo "Script completed"
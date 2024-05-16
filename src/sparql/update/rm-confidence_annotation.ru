PREFIX mondo: <http://purl.obolibrary.org/obo/mondo#>


# Remove the mondo:confidence annotation from all MONDO classes
DELETE {
    ?class mondo:confidence ?confidence .
}
WHERE {
    ?class mondo:confidence ?confidence .
    FILTER (isIRI(?class) && STRSTARTS(str(?class), "http://purl.obolibrary.org/obo/MONDO_"))
}
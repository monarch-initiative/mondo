from xml.etree.ElementTree import iterparse
from rdflib import URIRef, Literal
from rdflib.namespace import RDF, RDFS, OWL

RDF_ABOUT  = "{" + str(RDF) + "}about"
RDFS_LABEL = "{" + str(RDFS) + "}label"

about_stack: list[str | None] = []
seen: set[str] = set()

for event, el in iterparse("tmp/mondo-ingest.owl", events=("start", "end")):
    if event == "start":
        about_stack.append(el.attrib.get(RDF_ABOUT))
        continue

    if el.tag == RDFS_LABEL:
        # direct parent subject
        subj = about_stack[-2] if len(about_stack) >= 2 else None
        if subj and subj not in seen:
            txt = (el.text or "").strip()
            if txt:
                seen.add(subj)

                s = URIRef(subj).n3()
                print(f"{s} {RDF.type.n3()} {OWL.Class.n3()} .")
                print(f"{s} {RDFS.label.n3()} {Literal(txt).n3()} .")

    about_stack.pop()
    el.clear()


import $ivy.`org.phenoscape::scowl:1.3.4`
import org.phenoscape.scowl._
import $file.util, util._

//print(ont)
//val ontology = load("test.omn")
val ontology = loadOnt("../ontology/mondo-edit.obo")
val reasoner = getReasoner(ontology)
val NEOPLASM = Class("http://purl.obolibrary.org/obo/MONDO_0005070")
val CANCER = Class("http://purl.obolibrary.org/obo/MONDO_0004992")
val BENIGN_NEOPLASM = Class("http://purl.obolibrary.org/obo/MONDO_0005165")

println(ontology)

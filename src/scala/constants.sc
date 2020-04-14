import $ivy.`org.phenoscape::scowl:1.3.4`
import org.phenoscape.scowl._

val Disease = Class("http://purl.obolibrary.org/obo/MONDO_0000001")

object OboVocab2 {

  val Disease = Class("http://purl.obolibrary.org/obo/MONDO_0000001")
  val part_of = ObjectProperty("http://purl.obolibrary.org/obo/BFO_0000050")

}
println(OboVocab2.part_of)

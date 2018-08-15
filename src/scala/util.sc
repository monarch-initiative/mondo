import $ivy.`org.phenoscape::scowl:1.3`
import $ivy.`org.semanticweb.elk:elk-owlapi:0.4.3`

import org.phenoscape.scowl._
import org.semanticweb.owlapi.apibinding.OWLManager
import org.semanticweb.owlapi.model._
import java.io._
import org.semanticweb.owlapi.reasoner._
import org.semanticweb.elk.owlapi._

def loadOnt(path : String): OWLOntology = {
  val manager = OWLManager.createOWLOntologyManager()
  val file = new File(path)
  var iri = IRI.create(file)
  manager.loadOntologyFromOntologyDocument(iri)
}

def getReasoner(ontology : OWLOntology): OWLReasoner = {
  new ElkReasonerFactory().reasonerFactory.createReasoner(ontology)
}

// axioms can be mapped to categories
object AxiomCategory extends Enumeration {
  val AxiomPresentDirect, AxiomPresentIndirect, AxiomAbsentCompatible, AxiomAbsentIncompatible, Unknown = Value
}

object OwlUtil {

  def loadOnt(path : String): OWLOntology = {
    val manager = OWLManager.createOWLOntologyManager()
    val file = new File(path)
    var iri = IRI.create(file)
    manager.loadOntologyFromOntologyDocument(iri)
  }
  
  def loadOnts(paths: String*): OWLOntology = {
    val onts = paths.map(loadOnt)
    merge(onts)
  }
  
  def merge(onts: Seq[OWLOntology]): OWLOntology = {
    val manager = OWLManager.createOWLOntologyManager()
    val ontology = manager.createOntology()
    for (ont <- onts) {
      manager.addAxioms( ontology, ont.getAxioms(true) )
    }
    ontology
  }

  def hasPrefix(c : OWLClass, prefix: String) : Boolean = {
    c.getIRI().toString().startsWith(prefix)
  }

  def getClassesByPrefix(ont : OWLOntology, prefix : String ) : Set[OWLClass] = {
    ont.getClassesInSignature(true).asScala.toSet.filter( (c) => hasPrefix(c, prefix) )
  }
  
}

// assigns axioms to categories.
// the assumption is the axiom has been mapped to another ontology.
// E.g. we may want to take an ORDO axiom, and to test if it is coherent with MONDO, redundant with a particular more
// specific MONDO axiom, etc
object AxiomChecker {

  // tests an axiom (currently on SubClassOf) for the AxiomCategory it belongs to
  def checkAxiom(axiom : OWLSubClassOfAxiom, reasoner : OWLReasoner): AxiomCategory.Value = {
    val ont = reasoner.getRootOntology()
    val m = ont.getOWLOntologyManager()
    val df = m.getOWLDataFactory()
    val c = axiom.getSubClass()
    val p = axiom.getSuperClass()
    if (p.isAnonymous()) {
      AxiomCategory.Unknown
    }
    else if (reasoner.getSuperClasses(c, false).containsEntity(p.asOWLClass())) {
      if (reasoner.getSuperClasses(c, true).containsEntity(p.asOWLClass())) {
        AxiomCategory.AxiomPresentDirect
      }
      else {
        AxiomCategory.AxiomPresentIndirect        
      }
    }
    else {
      m.addAxiom(ont, axiom)
      reasoner.flush()
      val unsats = reasoner.getUnsatisfiableClasses().getEntitiesMinus(df.getOWLNothing())
      m.removeAxiom(ont, axiom)
      reasoner.flush()
      if (unsats.size() > 0) {
        AxiomCategory.AxiomAbsentIncompatible
      }
      else {
        AxiomCategory.AxiomAbsentCompatible
      }
    }
  }

}

// rewires  axioms (currently only SubClassOf)
// according to equivalence axioms.
// E.g. given a base ontology like NCIT and equivalence axioms mapping to MONDO
// we can rewrite to equivalent expressions with MONDO IDs
case class AxiomMapper(val src: Set[OWLClass]) {

  // rewires an axiom (currently only SubClassOf)
  // e.g. gives SubClassOf(NCIT:1 NCIT:2) will return SubClassOf(MONDO:x MONDO:y)
  // assuming NCIT{1,2}->MONDO{x,y}
  
  def mapAxiom(axiom : OWLSubClassOfAxiom, reasoner : OWLReasoner): Option[OWLSubClassOfAxiom] = {
    val cx = mapExpression( axiom.getSubClass(), reasoner )
    val px = mapExpression( axiom.getSuperClass(), reasoner )
    if (cx.isDefined && px.isDefined) {
      Some(cx.get SubClassOf px.get)
    }
    else {
      None
    }
  }

  // rewires an OWL class expression (currently only named classes)
  def mapExpression(x : OWLClassExpression, reasoner : OWLReasoner): Option[OWLClassExpression] = {
    if (x.isAnonymous()) {
      return None
    }
    val eqs = reasoner.getEquivalentClasses(x.asOWLClass()).getEntities().asScala
    val feqs = eqs.filter( x => src.contains(x) && !x.isAnonymous() )
    if (feqs.size == 0) {
      None
    }
    else {
      // TODO: define behavior where maps to >1
      Some(feqs.toSeq(0).asOWLClass())
    }
  }
}

// tests all axioms in an ontology (currently just SubClassOf)
// writes results per-axiom; TODO: define a case class
def compareAxioms(reasoner : OWLReasoner, ont : OWLOntology) = {
  val srcOnt = reasoner.getRootOntology()
  val ch = AxiomChecker
  val mcs = OwlUtil.getClassesByPrefix(srcOnt, "http://purl.obolibrary.org/obo/MONDO_")
  val m = AxiomMapper( mcs )
  for {
    ( ax : OWLSubClassOfAxiom) <- ont.getAxioms(AxiomType.SUBCLASS_OF).asScala
  } yield {
    val ax2 = m.mapAxiom(ax, reasoner)
    if (ax2.isDefined) {
      println(ax2)
      println(ch.checkAxiom(ax2.get, reasoner))
    }
    
  }  
}

def t1 = {
  compareAxioms(reasoner, doid)
}

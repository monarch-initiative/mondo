import os
os.environ['PATH']
stream = os.popen('owltools --help')
output = stream.read()
output


    <IPython.core.display.Javascript object>


# Mondo analysis

from ontobio.ontol_factory import OntologyFactory
mondo_file="/Users/matentzn/ws/mondo/src/ontology/mondo-qc.obo"
ofa = OntologyFactory()
ont = ofa.create(mondo_file)
ont.get_roots()[:3]

mondo="http://purl.obolibrary.org/obo/mondo.owl"
g = Graph()
g.parse("../mondo-qc.owl", format="xml")

## Robot report analysis




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0021108</td>
      <td>owl:equivalentClass</td>
      <td>ffad2d8d-2c04-4db5-a3f9-b5fbffb8f04dgenid312399</td>
      <td>mondo-edit.obo</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <th>1</th>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0021108</td>
      <td>owl:equivalentClass</td>
      <td>ffad2d8d-2c04-4db5-a3f9-b5fbffb8f04dgenid312403</td>
      <td>mondo-edit.obo</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <th>2</th>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0045024</td>
      <td>owl:equivalentClass</td>
      <td>ffad2d8d-2c04-4db5-a3f9-b5fbffb8f04dgenid339152</td>
      <td>mondo-edit.obo</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <th>3</th>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0045024</td>
      <td>owl:equivalentClass</td>
      <td>ffad2d8d-2c04-4db5-a3f9-b5fbffb8f04dgenid339156</td>
      <td>mondo-edit.obo</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <th>4</th>
      <td>missing_ontology_description</td>
      <td>mondo.owl</td>
      <td>dc11:description</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>271584</th>
      <td>lowercase_definition</td>
      <td>MONDO:0025085</td>
      <td>IAO:0000115</td>
      <td>inflammation of the liver in animals due to vi...</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <th>271585</th>
      <td>lowercase_definition</td>
      <td>MONDO:0025100</td>
      <td>IAO:0000115</td>
      <td>inflammation of the udder in cows.</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <th>271586</th>
      <td>lowercase_definition</td>
      <td>MONDO:0044255</td>
      <td>IAO:0000115</td>
      <td>&lt;Subhead&gt; Genetic Heterogeneity of Variation i...</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <th>271587</th>
      <td>lowercase_definition</td>
      <td>MONDO:0044266</td>
      <td>IAO:0000115</td>
      <td>{2,3:Berg and Bearn (1966, 1966)} discovered a...</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <th>271588</th>
      <td>lowercase_definition</td>
      <td>MONDO:0044621</td>
      <td>IAO:0000115</td>
      <td>16p12.1p12.3 triplication syndrome is a rare c...</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
  </tbody>
</table>
<p>271589 rows × 6 columns</p>
</div>



## Overview of errors

This breaks down the errors in the generic ROBOT report. _Note that the whole report is filtered to only show results pertaining to MONDO classes themselves_. All tables are cut off at {{ NUMBER_ERRORS_SHOWN }} rows.




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th></th>
      <th>Value</th>
    </tr>
    <tr>
      <th>Ontology</th>
      <th>Level</th>
      <th>Rule Name</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="6" valign="top">mondo-edit.obo</th>
      <th>ERROR</th>
      <th>multiple_equivalent_classes</th>
      <td>4</td>
    </tr>
    <tr>
      <th rowspan="2" valign="top">INFO</th>
      <th>lowercase_definition</th>
      <td>300</td>
    </tr>
    <tr>
      <th>missing_superclass</th>
      <td>0</td>
    </tr>
    <tr>
      <th rowspan="3" valign="top">WARN</th>
      <th>duplicate_exact_synonym</th>
      <td>1657</td>
    </tr>
    <tr>
      <th>duplicate_scoped_synonym</th>
      <td>1595</td>
    </tr>
    <tr>
      <th>missing_definition</th>
      <td>0</td>
    </tr>
    <tr>
      <th rowspan="7" valign="top">mondo.owl</th>
      <th rowspan="2" valign="top">ERROR</th>
      <th>deprecated_class_reference</th>
      <td>1</td>
    </tr>
    <tr>
      <th>multiple_equivalent_classes</th>
      <td>37553</td>
    </tr>
    <tr>
      <th>INFO</th>
      <th>lowercase_definition</th>
      <td>300</td>
    </tr>
    <tr>
      <th rowspan="4" valign="top">WARN</th>
      <th>duplicate_exact_synonym</th>
      <td>1657</td>
    </tr>
    <tr>
      <th>duplicate_scoped_synonym</th>
      <td>1595</td>
    </tr>
    <tr>
      <th>equivalent_pair</th>
      <td>37576</td>
    </tr>
    <tr>
      <th>missing_definition</th>
      <td>0</td>
    </tr>
    <tr>
      <th rowspan="8" valign="top">mondo_current_release.owl</th>
      <th rowspan="3" valign="top">ERROR</th>
      <th>deprecated_class_reference</th>
      <td>60</td>
    </tr>
    <tr>
      <th>duplicate_definition</th>
      <td>2</td>
    </tr>
    <tr>
      <th>multiple_equivalent_classes</th>
      <td>37565</td>
    </tr>
    <tr>
      <th>INFO</th>
      <th>lowercase_definition</th>
      <td>300</td>
    </tr>
    <tr>
      <th rowspan="4" valign="top">WARN</th>
      <th>duplicate_exact_synonym</th>
      <td>1659</td>
    </tr>
    <tr>
      <th>duplicate_scoped_synonym</th>
      <td>1597</td>
    </tr>
    <tr>
      <th>equivalent_pair</th>
      <td>37604</td>
    </tr>
    <tr>
      <th>missing_definition</th>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>




### mondo-edit.obo



#### multiple_equivalent_classes



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0021108</td>
      <td>owl:equivalentClass</td>
      <td>ffad2d8d-2c04-4db5-a3f9-b5fbffb8f04dgenid312399</td>
      <td>mondo-edit.obo</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0021108</td>
      <td>owl:equivalentClass</td>
      <td>ffad2d8d-2c04-4db5-a3f9-b5fbffb8f04dgenid312403</td>
      <td>mondo-edit.obo</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0045024</td>
      <td>owl:equivalentClass</td>
      <td>ffad2d8d-2c04-4db5-a3f9-b5fbffb8f04dgenid339152</td>
      <td>mondo-edit.obo</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0045024</td>
      <td>owl:equivalentClass</td>
      <td>ffad2d8d-2c04-4db5-a3f9-b5fbffb8f04dgenid339156</td>
      <td>mondo-edit.obo</td>
      <td>ERROR</td>
    </tr>
  </tbody>
</table>



#### duplicate_exact_synonym



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0003401</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor of the CNS</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0016739</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor of the CNS</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0003404</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0005744</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010420</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLP</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010627</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLP</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0017304</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLOA</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0021019</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLOA</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010209</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine oxidase deficiency</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0018106</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine oxidase deficiency</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010209</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine dehydrogenase deficiency</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0018106</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine dehydrogenase deficiency</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0007764</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>Worth syndrome</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0011878</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>Worth syndrome</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0005004</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>Wolffian duct neoplasm</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>



#### missing_definition



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000005</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000009</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000014</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000023</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000030</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000032</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000045</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000049</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000050</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000060</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000065</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000066</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000070</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000075</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000079</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>



#### duplicate_scoped_synonym



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000155</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of sequestering of triglyceride</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000155</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of sequestering of triglyceride</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000242</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>dermatophytosis of beard</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000242</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>dermatophytosis of beard</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000270</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>disorder of lower respiratory tract</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000270</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>disorder of lower respiratory tract</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000330</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>endemic typhus Fever</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000330</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>endemic typhus Fever</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000351</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of methionine catabolic process</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000351</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of methionine catabolic process</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000414</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>pediatric electroclinical syndrome</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000414</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>pediatric electroclinical syndrome</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000421</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of L-serine biosynthetic process</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000421</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of L-serine biosynthetic process</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000424</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of cobalamin metabolic process</td>
      <td>mondo-edit.obo</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>



#### lowercase_definition



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0000712</td>
      <td>IAO:0000115</td>
      <td>frontotemporal dementia plus amyotrophic lateral sclerosis.</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001554</td>
      <td>IAO:0000115</td>
      <td>secondary glaucoma caused by either excessive size or spheric shape of the lens.</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001709</td>
      <td>IAO:0000115</td>
      <td>sarcoidosis with a complication of hypercalcemia.</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001875</td>
      <td>IAO:0000115</td>
      <td>inflammation of the lateral epicondyle.</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0002121</td>
      <td>IAO:0000115</td>
      <td>neuritis of a single nerve.</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0004135</td>
      <td>IAO:0000115</td>
      <td>thyroiditis associated with painless enlargement of the thyroid gland. It occurs more frequently in females and is characterized by alterations between hyperthyroidism and hypothyroidism and the eventual return to normal thyroid gland function.</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005196</td>
      <td>IAO:0000115</td>
      <td>presence of structurally anomalous spermatozoa in the semen; malformations include the physical bending of the sperm to produce kinks or bends</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005448</td>
      <td>IAO:0000115</td>
      <td>liver injury resulting from hepatitis C infection</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005483</td>
      <td>IAO:0000115</td>
      <td>hair loss as a result of chemotherapy treatment</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005490</td>
      <td>IAO:0000115</td>
      <td>stroke caused by the blockage of blood flow in one of the large arteries feeding the brain</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005584</td>
      <td>IAO:0000115</td>
      <td>serious heritable structural anomalies of the left side of the heart, including hypoplastic left heart syndrome, aortic valve stenosis, coarctation of the aorta, mitral valve anomalies and bicuspid aortic valve, that are present from birth</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005588</td>
      <td>IAO:0000115</td>
      <td>inflammation and ulceration of the oral mucosa as a result of chemotherapy treatment</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005589</td>
      <td>IAO:0000115</td>
      <td>pancreatits that is the result of treatment with thiopurine immunosuppressants such as azathioprine or mercaptopurine</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005768</td>
      <td>IAO:0000115</td>
      <td>tuberculosis that involves any region of the gastrointestinal tract, mostly in the distal ileum and the cecum. In most cases, mycobacterium tuberculosis is the pathogen. Clinical features include abdominal pain; fever; and palpable mass in the ileocecal area.</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005789</td>
      <td>IAO:0000115</td>
      <td>inflammation of the liver in humans caused by hepatitis delta virus, a defective rna virus that can only infect hepatitis B patients. For its viral coating, hepatitis delta virus requires the hepatitis B surface antigens produced by these patients. Hepatitis D can occur either concomitantly with (coinfection) or subsequent to (superinfection) hepatitis B infection. Similar to hepatitis B, it is primarily transmitted by parenteral exposure, such as transfusion of contaminated blood or blood products, but can also be transmitted via sexual or intimate personal contact.</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
  </tbody>
</table>



#### missing_superclass



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000065</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000070</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000162</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000224</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000252</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000261</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000263</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000266</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000405</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000421</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000488</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000541</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000543</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000545</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000551</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>mondo-edit.obo</td>
      <td>INFO</td>
    </tr>
  </tbody>
</table>



### mondo_current_release.owl



#### duplicate_definition



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>duplicate_definition</td>
      <td>MONDO:0001744</td>
      <td>IAO:0000115</td>
      <td>The sudden increase of intraocular pressure, resulting in pain and an abrupt decrease in visual acuity.</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>duplicate_definition</td>
      <td>MONDO:0001868</td>
      <td>IAO:0000115</td>
      <td>The sudden increase of intraocular pressure, resulting in pain and an abrupt decrease in visual acuity.</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
  </tbody>
</table>



#### multiple_equivalent_classes



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C2991</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>OGMS:0000031</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:64572001</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.ebi.ac.uk/efo/EFO_0000408</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.orpha.net/ORDO/Orphanet_377788</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000004</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C26691</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000004</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:386584007</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000009</td>
      <td>owl:equivalentClass</td>
      <td>40b46731-0b24-4fde-9acc-ecd3c750fc75genid61</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000009</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:231200</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000044</td>
      <td>owl:equivalentClass</td>
      <td>40b46731-0b24-4fde-9acc-ecd3c750fc75genid119</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000044</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:193100</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000044</td>
      <td>owl:equivalentClass</td>
      <td>http://www.orpha.net/ORDO/Orphanet_437</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000050</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:262400</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000050</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:2109003</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000050</td>
      <td>owl:equivalentClass</td>
      <td>http://www.orpha.net/ORDO/Orphanet_631</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
  </tbody>
</table>



#### deprecated_class_reference



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000275</td>
      <td>owl:equivalentClass</td>
      <td>DOID:0050177</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000746</td>
      <td>owl:equivalentClass</td>
      <td>COHD:4288544</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000746</td>
      <td>owl:equivalentClass</td>
      <td>DOID:0060320</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000746</td>
      <td>owl:equivalentClass</td>
      <td>HP:0000023</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000746</td>
      <td>owl:equivalentClass</td>
      <td>ICD9:550.90</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000746</td>
      <td>owl:equivalentClass</td>
      <td>MESH:D006552</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>http://linkedlifedata.com/resource/umls/id/C0019322</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>COHD:4245842</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>DOID:0060321</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>ICD9:553.1</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>MESH:D006554</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000911</td>
      <td>owl:equivalentClass</td>
      <td>http://linkedlifedata.com/resource/umls/id/C3151039</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000911</td>
      <td>owl:equivalentClass</td>
      <td>DOID:0110452</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000911</td>
      <td>owl:equivalentClass</td>
      <td>MESH:C566052</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0001445</td>
      <td>owl:equivalentClass</td>
      <td>http://linkedlifedata.com/resource/umls/id/C0005697</td>
      <td>mondo_current_release.owl</td>
      <td>ERROR</td>
    </tr>
  </tbody>
</table>



#### duplicate_exact_synonym



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0003401</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor of the CNS</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0016739</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor of the CNS</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0003404</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0005744</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010420</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLP</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010627</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLP</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0017304</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLOA</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0021019</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLOA</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010209</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine oxidase deficiency</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0018106</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine oxidase deficiency</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010209</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine dehydrogenase deficiency</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0018106</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine dehydrogenase deficiency</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0007764</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>Worth syndrome</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0011878</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>Worth syndrome</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0005004</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>Wolffian duct neoplasm</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>



#### equivalent_pair



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C2991</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>OGMS:0000031</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:64572001</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.ebi.ac.uk/efo/EFO_0000408</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.orpha.net/ORDO/Orphanet_377788</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000004</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C26691</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000004</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:386584007</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000005</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:203655</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000009</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:231200</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000015</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:363009005</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000022</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C118172</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000023</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:615438</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000030</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:600513</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000032</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:121210</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000044</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:193100</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>



#### missing_definition



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000005</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000009</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000014</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000023</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000030</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000032</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000045</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000049</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000050</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000060</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000065</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000066</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000070</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000075</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000079</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>



#### duplicate_scoped_synonym



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000155</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of sequestering of triglyceride</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000155</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of sequestering of triglyceride</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000242</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>dermatophytosis of beard</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000242</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>dermatophytosis of beard</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000270</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>disorder of lower respiratory tract</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000270</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>disorder of lower respiratory tract</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000330</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>endemic typhus Fever</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000330</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>endemic typhus Fever</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000351</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of methionine catabolic process</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000351</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of methionine catabolic process</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000414</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>pediatric electroclinical syndrome</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000414</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>pediatric electroclinical syndrome</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000421</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of L-serine biosynthetic process</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000421</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of L-serine biosynthetic process</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000424</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of cobalamin metabolic process</td>
      <td>mondo_current_release.owl</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>



#### lowercase_definition



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0000712</td>
      <td>IAO:0000115</td>
      <td>frontotemporal dementia plus amyotrophic lateral sclerosis.</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001554</td>
      <td>IAO:0000115</td>
      <td>secondary glaucoma caused by either excessive size or spheric shape of the lens.</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001709</td>
      <td>IAO:0000115</td>
      <td>sarcoidosis with a complication of hypercalcemia.</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001875</td>
      <td>IAO:0000115</td>
      <td>inflammation of the lateral epicondyle.</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0002121</td>
      <td>IAO:0000115</td>
      <td>neuritis of a single nerve.</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0004135</td>
      <td>IAO:0000115</td>
      <td>thyroiditis associated with painless enlargement of the thyroid gland. It occurs more frequently in females and is characterized by alterations between hyperthyroidism and hypothyroidism and the eventual return to normal thyroid gland function.</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005196</td>
      <td>IAO:0000115</td>
      <td>presence of structurally anomalous spermatozoa in the semen; malformations include the physical bending of the sperm to produce kinks or bends</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005448</td>
      <td>IAO:0000115</td>
      <td>liver injury resulting from hepatitis C infection</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005483</td>
      <td>IAO:0000115</td>
      <td>hair loss as a result of chemotherapy treatment</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005490</td>
      <td>IAO:0000115</td>
      <td>stroke caused by the blockage of blood flow in one of the large arteries feeding the brain</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005584</td>
      <td>IAO:0000115</td>
      <td>serious heritable structural anomalies of the left side of the heart, including hypoplastic left heart syndrome, aortic valve stenosis, coarctation of the aorta, mitral valve anomalies and bicuspid aortic valve, that are present from birth</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005588</td>
      <td>IAO:0000115</td>
      <td>inflammation and ulceration of the oral mucosa as a result of chemotherapy treatment</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005589</td>
      <td>IAO:0000115</td>
      <td>pancreatits that is the result of treatment with thiopurine immunosuppressants such as azathioprine or mercaptopurine</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005768</td>
      <td>IAO:0000115</td>
      <td>tuberculosis that involves any region of the gastrointestinal tract, mostly in the distal ileum and the cecum. In most cases, mycobacterium tuberculosis is the pathogen. Clinical features include abdominal pain; fever; and palpable mass in the ileocecal area.</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005789</td>
      <td>IAO:0000115</td>
      <td>inflammation of the liver in humans caused by hepatitis delta virus, a defective rna virus that can only infect hepatitis B patients. For its viral coating, hepatitis delta virus requires the hepatitis B surface antigens produced by these patients. Hepatitis D can occur either concomitantly with (coinfection) or subsequent to (superinfection) hepatitis B infection. Similar to hepatitis B, it is primarily transmitted by parenteral exposure, such as transfusion of contaminated blood or blood products, but can also be transmitted via sexual or intimate personal contact.</td>
      <td>mondo_current_release.owl</td>
      <td>INFO</td>
    </tr>
  </tbody>
</table>



### mondo.owl



#### multiple_equivalent_classes



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C2991</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>OGMS:0000031</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:64572001</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.ebi.ac.uk/efo/EFO_0000408</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.orpha.net/ORDO/Orphanet_377788</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000004</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C26691</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000004</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:386584007</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000009</td>
      <td>owl:equivalentClass</td>
      <td>292e5240-a6da-42ef-b41c-ba55ed367d34genid61</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000009</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:231200</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000044</td>
      <td>owl:equivalentClass</td>
      <td>292e5240-a6da-42ef-b41c-ba55ed367d34genid119</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000044</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:193100</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000044</td>
      <td>owl:equivalentClass</td>
      <td>http://www.orpha.net/ORDO/Orphanet_437</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000050</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:262400</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000050</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:2109003</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000050</td>
      <td>owl:equivalentClass</td>
      <td>http://www.orpha.net/ORDO/Orphanet_631</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
  </tbody>
</table>



#### deprecated_class_reference



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0012148</td>
      <td>owl:equivalentClass</td>
      <td>http://linkedlifedata.com/resource/umls/id/C1837154</td>
      <td>mondo.owl</td>
      <td>ERROR</td>
    </tr>
  </tbody>
</table>



#### duplicate_exact_synonym



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0003401</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor of the CNS</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0016739</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor of the CNS</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0003404</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0005744</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010420</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLP</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010627</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLP</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0017304</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLOA</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0021019</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLOA</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010209</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine oxidase deficiency</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0018106</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine oxidase deficiency</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010209</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine dehydrogenase deficiency</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0018106</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine dehydrogenase deficiency</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0007764</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>Worth syndrome</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0011878</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>Worth syndrome</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0005004</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>Wolffian duct neoplasm</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>



#### equivalent_pair



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C2991</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>OGMS:0000031</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:64572001</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.ebi.ac.uk/efo/EFO_0000408</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.orpha.net/ORDO/Orphanet_377788</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000004</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C26691</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000004</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:386584007</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000005</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:203655</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000009</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:231200</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000015</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:363009005</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000022</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C118172</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000023</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:615438</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000030</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:600513</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000032</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:121210</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000044</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:193100</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>



#### missing_definition



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000005</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000009</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000014</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000023</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000030</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000032</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000045</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000049</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000050</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000060</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000065</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000066</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000070</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000075</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000079</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>



#### duplicate_scoped_synonym



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000155</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of sequestering of triglyceride</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000155</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of sequestering of triglyceride</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000242</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>dermatophytosis of beard</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000242</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>dermatophytosis of beard</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000270</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>disorder of lower respiratory tract</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000270</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>disorder of lower respiratory tract</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000330</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>endemic typhus Fever</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000330</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>endemic typhus Fever</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000351</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of methionine catabolic process</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000351</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of methionine catabolic process</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000414</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>pediatric electroclinical syndrome</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000414</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>pediatric electroclinical syndrome</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000421</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of L-serine biosynthetic process</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000421</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of L-serine biosynthetic process</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000424</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of cobalamin metabolic process</td>
      <td>mondo.owl</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>



#### lowercase_definition



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Ontology</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0000712</td>
      <td>IAO:0000115</td>
      <td>frontotemporal dementia plus amyotrophic lateral sclerosis.</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001554</td>
      <td>IAO:0000115</td>
      <td>secondary glaucoma caused by either excessive size or spheric shape of the lens.</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001709</td>
      <td>IAO:0000115</td>
      <td>sarcoidosis with a complication of hypercalcemia.</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001875</td>
      <td>IAO:0000115</td>
      <td>inflammation of the lateral epicondyle.</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0002121</td>
      <td>IAO:0000115</td>
      <td>neuritis of a single nerve.</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0004135</td>
      <td>IAO:0000115</td>
      <td>thyroiditis associated with painless enlargement of the thyroid gland. It occurs more frequently in females and is characterized by alterations between hyperthyroidism and hypothyroidism and the eventual return to normal thyroid gland function.</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005196</td>
      <td>IAO:0000115</td>
      <td>presence of structurally anomalous spermatozoa in the semen; malformations include the physical bending of the sperm to produce kinks or bends</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005448</td>
      <td>IAO:0000115</td>
      <td>liver injury resulting from hepatitis C infection</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005483</td>
      <td>IAO:0000115</td>
      <td>hair loss as a result of chemotherapy treatment</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005490</td>
      <td>IAO:0000115</td>
      <td>stroke caused by the blockage of blood flow in one of the large arteries feeding the brain</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005584</td>
      <td>IAO:0000115</td>
      <td>serious heritable structural anomalies of the left side of the heart, including hypoplastic left heart syndrome, aortic valve stenosis, coarctation of the aorta, mitral valve anomalies and bicuspid aortic valve, that are present from birth</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005588</td>
      <td>IAO:0000115</td>
      <td>inflammation and ulceration of the oral mucosa as a result of chemotherapy treatment</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005589</td>
      <td>IAO:0000115</td>
      <td>pancreatits that is the result of treatment with thiopurine immunosuppressants such as azathioprine or mercaptopurine</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005768</td>
      <td>IAO:0000115</td>
      <td>tuberculosis that involves any region of the gastrointestinal tract, mostly in the distal ileum and the cecum. In most cases, mycobacterium tuberculosis is the pathogen. Clinical features include abdominal pain; fever; and palpable mass in the ileocecal area.</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005789</td>
      <td>IAO:0000115</td>
      <td>inflammation of the liver in humans caused by hepatitis delta virus, a defective rna virus that can only infect hepatitis B patients. For its viral coating, hepatitis delta virus requires the hepatitis B surface antigens produced by these patients. Hepatitis D can occur either concomitantly with (coinfection) or subsequent to (superinfection) hepatitis B infection. Similar to hepatitis B, it is primarily transmitted by parenteral exposure, such as transfusion of contaminated blood or blood products, but can also be transmitted via sexual or intimate personal contact.</td>
      <td>mondo.owl</td>
      <td>INFO</td>
    </tr>
  </tbody>
</table>


## Other Quality Control checks


<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>d2</th>
      <th>d2_label</th>
      <th>ontology</th>
      <th>term_Count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>MONDO:0008648</td>
      <td>ventricular tachycardia, familial</td>
      <td>mondo.owl</td>
      <td>4</td>
    </tr>
    <tr>
      <td>MONDO:0008648</td>
      <td>ventricular tachycardia, familial</td>
      <td>mondo_current_release.owl</td>
      <td>4</td>
    </tr>
    <tr>
      <td>MONDO:0009861</td>
      <td>phenylketonuria</td>
      <td>mondo-edit.obo</td>
      <td>1</td>
    </tr>
  </tbody>
</table>



### Check: no-subclass-between-genetic-disease-warning



#### mondo_current_release.owl (Errors: 68)



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>term</th>
      <th>term_label</th>
      <th>d2</th>
      <th>d2_label</th>
      <th>ontology</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>MONDO:0012762</td>
      <td>catecholaminergic polymorphic ventricular tachycardia 2</td>
      <td>MONDO:0008648</td>
      <td>ventricular tachycardia, familial</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007982</td>
      <td>metaphyseal chondrodysplasia, Jansen type</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0013966</td>
      <td>catecholaminergic polymorphic ventricular tachycardia 4</td>
      <td>MONDO:0008648</td>
      <td>ventricular tachycardia, familial</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014107</td>
      <td>hypogonadotropic hypogonadism 21 with or without anosmia</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014105</td>
      <td>hypogonadotropic hypogonadism 19 with or without anosmia</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0013926</td>
      <td>hypogonadotropic hypogonadism 14 with or without anosmia</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014106</td>
      <td>hypogonadotropic hypogonadism 20 with or without anosmia</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014103</td>
      <td>hypogonadotropic hypogonadism 18 with or without anosmia</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014102</td>
      <td>hypogonadotropic hypogonadism 17 with or without anosmia</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014461</td>
      <td>hypogonadotropic hypogonadism 22 with or without anosmia</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014107</td>
      <td>hypogonadotropic hypogonadism 21 with or without anosmia</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014105</td>
      <td>hypogonadotropic hypogonadism 19 with or without anosmia</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0013926</td>
      <td>hypogonadotropic hypogonadism 14 with or without anosmia</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014106</td>
      <td>hypogonadotropic hypogonadism 20 with or without anosmia</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014103</td>
      <td>hypogonadotropic hypogonadism 18 with or without anosmia</td>
      <td>mondo_current_release.owl</td>
    </tr>
  </tbody>
</table>



#### mondo-edit.obo (Errors: 13)



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>term</th>
      <th>term_label</th>
      <th>d2</th>
      <th>d2_label</th>
      <th>ontology</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>MONDO:0012160</td>
      <td>spondylometaphyseal dysplasia-cone-rod dystrophy syndrome</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0009597</td>
      <td>metaphyseal chondrodysplasia, Spahr type</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0009711</td>
      <td>congenital fiber-type disproportion myopathy</td>
      <td>MONDO:0100084</td>
      <td>actinopathy</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0008477</td>
      <td>spondylometaphyseal dysplasia, Kozlowski type</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0009711</td>
      <td>congenital fiber-type disproportion myopathy</td>
      <td>MONDO:0100084</td>
      <td>actinopathy</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0009711</td>
      <td>congenital fiber-type disproportion myopathy</td>
      <td>MONDO:0100084</td>
      <td>actinopathy</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0009593</td>
      <td>spondylometaphyseal dysplasia, Sedaghatian type</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0007983</td>
      <td>Schmid metaphyseal chondrodysplasia</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0044304</td>
      <td>hyperphenylalaninemia due to DNAJC12 deficiency</td>
      <td>MONDO:0009861</td>
      <td>phenylketonuria</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0010486</td>
      <td>palmoplantar keratoderma, mutilating, with periorificial keratotic plaques, X-linked</td>
      <td>MONDO:0019014</td>
      <td>mutilating palmoplantar keratoderma with periorificial keratotic plaques</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0011211</td>
      <td>axial spondylometaphyseal dysplasia</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0009652</td>
      <td>mucolipidosis type III gamma</td>
      <td>MONDO:0018931</td>
      <td>mucolipidosis type III</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0007982</td>
      <td>metaphyseal chondrodysplasia, Jansen type</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>mondo-edit.obo</td>
    </tr>
  </tbody>
</table>



#### mondo.owl (Errors: 68)



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>term</th>
      <th>term_label</th>
      <th>d2</th>
      <th>d2_label</th>
      <th>ontology</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014107</td>
      <td>hypogonadotropic hypogonadism 21 with or without anosmia</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014105</td>
      <td>hypogonadotropic hypogonadism 19 with or without anosmia</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0013926</td>
      <td>hypogonadotropic hypogonadism 14 with or without anosmia</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014106</td>
      <td>hypogonadotropic hypogonadism 20 with or without anosmia</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014103</td>
      <td>hypogonadotropic hypogonadism 18 with or without anosmia</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014102</td>
      <td>hypogonadotropic hypogonadism 17 with or without anosmia</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007794</td>
      <td>hypogonadotropic hypogonadism 7 with or without anosmia</td>
      <td>MONDO:0014461</td>
      <td>hypogonadotropic hypogonadism 22 with or without anosmia</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0014418</td>
      <td>myopathy, centronuclear, 5</td>
      <td>MONDO:0100175</td>
      <td>TTN-related myopathy</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0013966</td>
      <td>catecholaminergic polymorphic ventricular tachycardia 4</td>
      <td>MONDO:0008648</td>
      <td>ventricular tachycardia, familial</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007982</td>
      <td>metaphyseal chondrodysplasia, Jansen type</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0008477</td>
      <td>spondylometaphyseal dysplasia, Kozlowski type</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0009652</td>
      <td>mucolipidosis type III gamma</td>
      <td>MONDO:0018931</td>
      <td>mucolipidosis type III</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0012160</td>
      <td>spondylometaphyseal dysplasia-cone-rod dystrophy syndrome</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0011211</td>
      <td>axial spondylometaphyseal dysplasia</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0010737</td>
      <td>spondyloepiphyseal dysplasia tarda, X-linked</td>
      <td>MONDO:0010248</td>
      <td>X-linked spondyloepimetaphyseal dysplasia</td>
      <td>mondo.owl</td>
    </tr>
  </tbody>
</table>


    WARNING!  excluded-subsumption-is-inferred-warning  is empty and has been skipped.
    WARNING!  excluded-subsumption-is-inferred-warning  is empty and has been skipped.
    WARNING!  excluded-subsumption-is-inferred-warning  is empty and has been skipped.



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>ontology</th>
    </tr>
  </thead>
  <tbody>
  </tbody>
</table>



### Check: excluded-subsumption-is-inferred-warning



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>total</th>
      <th>ontology</th>
      <th>term_Count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>mondo-edit.obo</td>
      <td>1385</td>
    </tr>
    <tr>
      <td>1</td>
      <td>mondo.owl</td>
      <td>1558</td>
    </tr>
    <tr>
      <td>1</td>
      <td>mondo_current_release.owl</td>
      <td>1559</td>
    </tr>
  </tbody>
</table>



### Check: single-child-warning



#### mondo.owl (Errors: 1558)



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>term</th>
      <th>total</th>
      <th>ontology</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>MONDO:0021202</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007481</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0021468</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0021203</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0021469</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0006282</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0020264</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0044346</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0003656</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0019635</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0006285</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0020267</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0001258</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0021467</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0001259</td>
      <td>1</td>
      <td>mondo.owl</td>
    </tr>
  </tbody>
</table>



#### mondo_current_release.owl (Errors: 1559)



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>term</th>
      <th>total</th>
      <th>ontology</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>MONDO:0021202</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0007481</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0021468</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0021203</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0021469</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0006282</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0020264</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0044346</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0003656</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0019635</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0006285</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0020267</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0001258</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0021467</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0001259</td>
      <td>1</td>
      <td>mondo_current_release.owl</td>
    </tr>
  </tbody>
</table>



#### mondo-edit.obo (Errors: 1385)



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>term</th>
      <th>total</th>
      <th>ontology</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>MONDO:0021202</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0007481</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0002326</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0021468</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0003960</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0011140</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0021203</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0021469</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0002894</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0006282</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0020264</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0044346</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0001697</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0003656</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0001564</td>
      <td>1</td>
      <td>mondo-edit.obo</td>
    </tr>
  </tbody>
</table>



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>related</th>
      <th>ontology</th>
      <th>term_Count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>AD6</td>
      <td>mondo-edit.obo</td>
      <td>1</td>
    </tr>
    <tr>
      <td>AD6</td>
      <td>mondo.owl</td>
      <td>1</td>
    </tr>
    <tr>
      <td>AD6</td>
      <td>mondo_current_release.owl</td>
      <td>1</td>
    </tr>
  </tbody>
</table>



### Check: related-exact-synonym-warning



#### mondo_current_release.owl (Errors: 200)



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>term</th>
      <th>term_label</th>
      <th>related</th>
      <th>ontology</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>MONDO:0021010</td>
      <td>skin lymphangiosarcoma</td>
      <td>lymphangiosarcoma of Stewart and Treves</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0000270</td>
      <td>lower respiratory tract disease</td>
      <td>disorder of lower respiratory tract</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0008738</td>
      <td>aganglionosis, total intestinal</td>
      <td>total intestinal aganglionosis</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0021534</td>
      <td>rectal neuroendocrine tumor G1</td>
      <td>rectum carcinoid tumor</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0015564</td>
      <td>Castleman disease</td>
      <td>angiofollicular lymph node hyperplasia</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0005289</td>
      <td>paranasal sinus neoplasm (disease)</td>
      <td>tumor of paranasal sinus</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0006266</td>
      <td>Leydig cell tumor</td>
      <td>interstitial cell neoplasm</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0024467</td>
      <td>apocrine sweat gland disease</td>
      <td>disorder of apocrine sweat gland</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0002540</td>
      <td>childhood oligodendroglioma</td>
      <td>pediatric oligodendroglioma</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0002485</td>
      <td>breast neuroendocrine neoplasm</td>
      <td>breast neuroendocrine tumor</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0005066</td>
      <td>metabolic disease</td>
      <td>disorder of metabolic process</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0003649</td>
      <td>esophageal neuroendocrine tumor</td>
      <td>neuroendocrine neoplasm of esophagus</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0002967</td>
      <td>dermatophytosis of scalp or beard</td>
      <td>dermatophytosis of scalp</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0002256</td>
      <td>cervix disease</td>
      <td>disorder of uterine cervix</td>
      <td>mondo_current_release.owl</td>
    </tr>
    <tr>
      <td>MONDO:0016241</td>
      <td>alternating hemiplegia of childhood</td>
      <td>pediatric alternating hemiplegia</td>
      <td>mondo_current_release.owl</td>
    </tr>
  </tbody>
</table>



#### mondo-edit.obo (Errors: 200)



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>term</th>
      <th>term_label</th>
      <th>related</th>
      <th>ontology</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>MONDO:0021010</td>
      <td>skin lymphangiosarcoma</td>
      <td>lymphangiosarcoma of Stewart and Treves</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0000270</td>
      <td>lower respiratory tract disease</td>
      <td>disorder of lower respiratory tract</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0008738</td>
      <td>aganglionosis, total intestinal</td>
      <td>total intestinal aganglionosis</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0021534</td>
      <td>rectal neuroendocrine tumor G1</td>
      <td>rectum carcinoid tumor</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0015564</td>
      <td>Castleman disease</td>
      <td>angiofollicular lymph node hyperplasia</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0005289</td>
      <td>paranasal sinus neoplasm (disease)</td>
      <td>tumor of paranasal sinus</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0006266</td>
      <td>Leydig cell tumor</td>
      <td>interstitial cell neoplasm</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0024467</td>
      <td>apocrine sweat gland disease</td>
      <td>disorder of apocrine sweat gland</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0002540</td>
      <td>childhood oligodendroglioma</td>
      <td>pediatric oligodendroglioma</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0002485</td>
      <td>breast neuroendocrine neoplasm</td>
      <td>breast neuroendocrine tumor</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0005066</td>
      <td>metabolic disease</td>
      <td>disorder of metabolic process</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0003649</td>
      <td>esophageal neuroendocrine tumor</td>
      <td>neuroendocrine neoplasm of esophagus</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0002967</td>
      <td>dermatophytosis of scalp or beard</td>
      <td>dermatophytosis of scalp</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0002256</td>
      <td>cervix disease</td>
      <td>disorder of uterine cervix</td>
      <td>mondo-edit.obo</td>
    </tr>
    <tr>
      <td>MONDO:0016241</td>
      <td>alternating hemiplegia of childhood</td>
      <td>pediatric alternating hemiplegia</td>
      <td>mondo-edit.obo</td>
    </tr>
  </tbody>
</table>



#### mondo.owl (Errors: 200)



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>term</th>
      <th>term_label</th>
      <th>related</th>
      <th>ontology</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>MONDO:0021010</td>
      <td>skin lymphangiosarcoma</td>
      <td>lymphangiosarcoma of Stewart and Treves</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0000270</td>
      <td>lower respiratory tract disease</td>
      <td>disorder of lower respiratory tract</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0008738</td>
      <td>aganglionosis, total intestinal</td>
      <td>total intestinal aganglionosis</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0021534</td>
      <td>rectal neuroendocrine tumor G1</td>
      <td>rectum carcinoid tumor</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0015564</td>
      <td>Castleman disease</td>
      <td>angiofollicular lymph node hyperplasia</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0005289</td>
      <td>paranasal sinus neoplasm (disease)</td>
      <td>tumor of paranasal sinus</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0006266</td>
      <td>Leydig cell tumor</td>
      <td>interstitial cell neoplasm</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0024467</td>
      <td>apocrine sweat gland disease</td>
      <td>disorder of apocrine sweat gland</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0002540</td>
      <td>childhood oligodendroglioma</td>
      <td>pediatric oligodendroglioma</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0002485</td>
      <td>breast neuroendocrine neoplasm</td>
      <td>breast neuroendocrine tumor</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0005066</td>
      <td>metabolic disease</td>
      <td>disorder of metabolic process</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0003649</td>
      <td>esophageal neuroendocrine tumor</td>
      <td>neuroendocrine neoplasm of esophagus</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0002967</td>
      <td>dermatophytosis of scalp or beard</td>
      <td>dermatophytosis of scalp</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0002256</td>
      <td>cervix disease</td>
      <td>disorder of uterine cervix</td>
      <td>mondo.owl</td>
    </tr>
    <tr>
      <td>MONDO:0016241</td>
      <td>alternating hemiplegia of childhood</td>
      <td>pediatric alternating hemiplegia</td>
      <td>mondo.owl</td>
    </tr>
  </tbody>
</table>



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>check</th>
      <th>ontology</th>
      <th>errors</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>no-subclass-between-genetic-disease-warning</td>
      <td>mondo_current_release.owl</td>
      <td>68</td>
    </tr>
    <tr>
      <td>no-subclass-between-genetic-disease-warning</td>
      <td>mondo-edit.obo</td>
      <td>13</td>
    </tr>
    <tr>
      <td>no-subclass-between-genetic-disease-warning</td>
      <td>mondo.owl</td>
      <td>68</td>
    </tr>
    <tr>
      <td>single-child-warning</td>
      <td>mondo.owl</td>
      <td>1558</td>
    </tr>
    <tr>
      <td>single-child-warning</td>
      <td>mondo_current_release.owl</td>
      <td>1559</td>
    </tr>
    <tr>
      <td>single-child-warning</td>
      <td>mondo-edit.obo</td>
      <td>1385</td>
    </tr>
    <tr>
      <td>related-exact-synonym-warning</td>
      <td>mondo_current_release.owl</td>
      <td>200</td>
    </tr>
    <tr>
      <td>related-exact-synonym-warning</td>
      <td>mondo-edit.obo</td>
      <td>200</td>
    </tr>
    <tr>
      <td>related-exact-synonym-warning</td>
      <td>mondo.owl</td>
      <td>200</td>
    </tr>
  </tbody>
</table>


## Mondo Statistics

## Relationships


Table: Breakdown of the number of relationships in Mondo.



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>property</th>
      <th>mondo-edit.obo</th>
      <th>mondo.owl</th>
      <th>mondo_current_release.owl</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasDbXref</td>
      <td>128445.0</td>
      <td>99967.0</td>
      <td>99965.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2004/02/skos/core#exactMatch</td>
      <td>NaN</td>
      <td>70551.0</td>
      <td>70550.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasExactSynonym</td>
      <td>64371.0</td>
      <td>64371.0</td>
      <td>64352.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#subClassOf</td>
      <td>47000.0</td>
      <td>47546.0</td>
      <td>47538.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2002/07/owl#equivalentClass</td>
      <td>7403.0</td>
      <td>44979.0</td>
      <td>45007.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasRelatedSynonym</td>
      <td>37876.0</td>
      <td>37876.0</td>
      <td>37872.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#type</td>
      <td>24231.0</td>
      <td>24231.0</td>
      <td>24229.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#label</td>
      <td>24114.0</td>
      <td>24114.0</td>
      <td>24112.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#id</td>
      <td>24114.0</td>
      <td>24114.0</td>
      <td>24112.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2004/02/skos/core#closeMatch</td>
      <td>NaN</td>
      <td>16509.0</td>
      <td>16509.0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/IAO_0000115</td>
      <td>15492.0</td>
      <td>15492.0</td>
      <td>15492.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#inSubset</td>
      <td>13454.0</td>
      <td>13454.0</td>
      <td>13454.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#seeAlso</td>
      <td>3138.0</td>
      <td>3138.0</td>
      <td>3136.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2002/07/owl#deprecated</td>
      <td>1943.0</td>
      <td>1943.0</td>
      <td>1941.0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/IAO_0100001</td>
      <td>1667.0</td>
      <td>1667.0</td>
      <td>1665.0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#excluded_subClassOf</td>
      <td>1072.0</td>
      <td>1067.0</td>
      <td>1066.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#comment</td>
      <td>948.0</td>
      <td>948.0</td>
      <td>948.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasNarrowSynonym</td>
      <td>787.0</td>
      <td>787.0</td>
      <td>787.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasBroadSynonym</td>
      <td>486.0</td>
      <td>486.0</td>
      <td>483.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#consider</td>
      <td>284.0</td>
      <td>284.0</td>
      <td>284.0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/IAO_0000231</td>
      <td>122.0</td>
      <td>122.0</td>
      <td>122.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasAlternativeId</td>
      <td>117.0</td>
      <td>117.0</td>
      <td>117.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2002/07/owl#disjointWith</td>
      <td>76.0</td>
      <td>76.0</td>
      <td>76.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#created_by</td>
      <td>65.0</td>
      <td>65.0</td>
      <td>63.0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.org/dc/elements/1.1/date</td>
      <td>55.0</td>
      <td>55.0</td>
      <td>55.0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.org/dc/elements/1.1/creator</td>
      <td>54.0</td>
      <td>54.0</td>
      <td>54.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2004/02/skos/core#broadMatch</td>
      <td>NaN</td>
      <td>12.0</td>
      <td>12.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2004/02/skos/core#narrowMatch</td>
      <td>NaN</td>
      <td>11.0</td>
      <td>10.0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#excluded_synonym</td>
      <td>8.0</td>
      <td>8.0</td>
      <td>8.0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#pathogenesis</td>
      <td>1.0</td>
      <td>1.0</td>
      <td>1.0</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#creation_date</td>
      <td>1.0</td>
      <td>1.0</td>
      <td>1.0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#related</td>
      <td>1.0</td>
      <td>1.0</td>
      <td>1.0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/RO_0002161</td>
      <td>1.0</td>
      <td>1.0</td>
      <td>1.0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#confidence</td>
      <td>5571.0</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>property</th>
      <th>mondo.owl</th>
      <th>mondo_current_release.owl</th>
      <th>difference</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasExactSynonym</td>
      <td>64371</td>
      <td>64352</td>
      <td>19</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#subClassOf</td>
      <td>47546</td>
      <td>47538</td>
      <td>8</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasRelatedSynonym</td>
      <td>37876</td>
      <td>37872</td>
      <td>4</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasBroadSynonym</td>
      <td>486</td>
      <td>483</td>
      <td>3</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasDbXref</td>
      <td>99967</td>
      <td>99965</td>
      <td>2</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#type</td>
      <td>24231</td>
      <td>24229</td>
      <td>2</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#label</td>
      <td>24114</td>
      <td>24112</td>
      <td>2</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#id</td>
      <td>24114</td>
      <td>24112</td>
      <td>2</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#seeAlso</td>
      <td>3138</td>
      <td>3136</td>
      <td>2</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2002/07/owl#deprecated</td>
      <td>1943</td>
      <td>1941</td>
      <td>2</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/IAO_0100001</td>
      <td>1667</td>
      <td>1665</td>
      <td>2</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#created_by</td>
      <td>65</td>
      <td>63</td>
      <td>2</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2004/02/skos/core#exactMatch</td>
      <td>70551</td>
      <td>70550</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#excluded_subClassOf</td>
      <td>1067</td>
      <td>1066</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2004/02/skos/core#narrowMatch</td>
      <td>11</td>
      <td>10</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2002/07/owl#equivalentClass</td>
      <td>44979</td>
      <td>45007</td>
      <td>-28</td>
    </tr>
  </tbody>
</table>


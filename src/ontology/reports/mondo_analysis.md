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

### Overview of errors

This breaks down the errors in the generic ROBOT report.




<div>

<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th>Value</th>
    </tr>
    <tr>
      <th>Level</th>
      <th>Rule Name</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="2" valign="top">ERROR</th>
      <th>deprecated_class_reference</th>
      <td>54</td>
    </tr>
    <tr>
      <th>multiple_equivalent_classes</th>
      <td>37563</td>
    </tr>
    <tr>
      <th>INFO</th>
      <th>lowercase_definition</th>
      <td>300</td>
    </tr>
    <tr>
      <th rowspan="4" valign="top">WARN</th>
      <th>duplicate_exact_synonym</th>
      <td>1655</td>
    </tr>
    <tr>
      <th>duplicate_scoped_synonym</th>
      <td>1595</td>
    </tr>
    <tr>
      <th>equivalent_pair</th>
      <td>37603</td>
    </tr>
    <tr>
      <th>missing_definition</th>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>




#### multiple_equivalent_classes



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C2991</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>OGMS:0000031</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:64572001</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.ebi.ac.uk/efo/EFO_0000408</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.orpha.net/ORDO/Orphanet_377788</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000004</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C26691</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000004</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:386584007</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000009</td>
      <td>owl:equivalentClass</td>
      <td>58ccc7dd-9800-43e6-8056-66fa132bd860genid61</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000009</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:231200</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000044</td>
      <td>owl:equivalentClass</td>
      <td>58ccc7dd-9800-43e6-8056-66fa132bd860genid119</td>
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
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>http://linkedlifedata.com/resource/umls/id/C0019322</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>COHD:4245842</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>DOID:0060321</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>ICD9:553.1</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>MESH:D006554</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000911</td>
      <td>owl:equivalentClass</td>
      <td>http://linkedlifedata.com/resource/umls/id/C3151039</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000911</td>
      <td>owl:equivalentClass</td>
      <td>DOID:0110452</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000911</td>
      <td>owl:equivalentClass</td>
      <td>MESH:C566052</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0001445</td>
      <td>owl:equivalentClass</td>
      <td>http://linkedlifedata.com/resource/umls/id/C0005697</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>MONDO:0001445</td>
      <td>owl:equivalentClass</td>
      <td>DOID:12143</td>
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
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0003401</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor of the CNS</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0016739</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor of the CNS</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0003404</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0005744</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010420</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLP</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010627</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLP</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0017304</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLOA</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0021019</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLOA</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010209</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine oxidase deficiency</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0018106</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine oxidase deficiency</td>
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
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C2991</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>OGMS:0000031</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:64572001</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.ebi.ac.uk/efo/EFO_0000408</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.orpha.net/ORDO/Orphanet_377788</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000004</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C26691</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000004</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:386584007</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000005</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:203655</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000009</td>
      <td>owl:equivalentClass</td>
      <td>OMIMPS:231200</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>MONDO:0000015</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:363009005</td>
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
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000005</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000009</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000014</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000023</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000030</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000032</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000045</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000049</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000050</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000060</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
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
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000155</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of sequestering of triglyceride</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000155</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of sequestering of triglyceride</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000242</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>dermatophytosis of beard</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000242</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>dermatophytosis of beard</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000270</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>disorder of lower respiratory tract</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000270</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>disorder of lower respiratory tract</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000330</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>endemic typhus Fever</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000330</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>endemic typhus Fever</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000351</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of methionine catabolic process</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000351</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of methionine catabolic process</td>
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
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0000712</td>
      <td>IAO:0000115</td>
      <td>frontotemporal dementia plus amyotrophic lateral sclerosis.</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001554</td>
      <td>IAO:0000115</td>
      <td>secondary glaucoma caused by either excessive size or spheric shape of the lens.</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001709</td>
      <td>IAO:0000115</td>
      <td>sarcoidosis with a complication of hypercalcemia.</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001875</td>
      <td>IAO:0000115</td>
      <td>inflammation of the lateral epicondyle.</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0002121</td>
      <td>IAO:0000115</td>
      <td>neuritis of a single nerve.</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0004135</td>
      <td>IAO:0000115</td>
      <td>thyroiditis associated with painless enlargement of the thyroid gland. It occurs more frequently in females and is characterized by alterations between hyperthyroidism and hypothyroidism and the eventual return to normal thyroid gland function.</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005196</td>
      <td>IAO:0000115</td>
      <td>presence of structurally anomalous spermatozoa in the semen; malformations include the physical bending of the sperm to produce kinks or bends</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005448</td>
      <td>IAO:0000115</td>
      <td>liver injury resulting from hepatitis C infection</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005483</td>
      <td>IAO:0000115</td>
      <td>hair loss as a result of chemotherapy treatment</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005490</td>
      <td>IAO:0000115</td>
      <td>stroke caused by the blockage of blood flow in one of the large arteries feeding the brain</td>
      <td>INFO</td>
    </tr>
  </tbody>
</table>


# Other checks analyses


#### single-child-warning



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>?cls</th>
      <th>?total</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0016094&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0021396&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0016093&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0008882&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0006224&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0021394&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0018848&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0024249&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0000872&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0003729&gt;</td>
      <td>1</td>
    </tr>
  </tbody>
</table>



#### no-subclass-between-genetic-disease-warning



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>?d1</th>
      <th>?d1_label</th>
      <th>?d2</th>
      <th>?d2_label</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0013529&gt;</td>
      <td>catecholaminergic polymorphic ventricular tachycardia 3</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0008648&gt;</td>
      <td>ventricular tachycardia, familial</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0013966&gt;</td>
      <td>catecholaminergic polymorphic ventricular tachycardia 4</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0008648&gt;</td>
      <td>ventricular tachycardia, familial</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009597&gt;</td>
      <td>metaphyseal chondrodysplasia, Spahr type</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009943&gt;</td>
      <td>Pyle disease</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0012762&gt;</td>
      <td>catecholaminergic polymorphic ventricular tachycardia 2</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0008648&gt;</td>
      <td>ventricular tachycardia, familial</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0011211&gt;</td>
      <td>axial spondylometaphyseal dysplasia</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009943&gt;</td>
      <td>Pyle disease</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0014418&gt;</td>
      <td>myopathy, centronuclear, 5</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0100175&gt;</td>
      <td>TTN-related myopathy</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009709&gt;</td>
      <td>myopathy, centronuclear, 2</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0100175&gt;</td>
      <td>TTN-related myopathy</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0007983&gt;</td>
      <td>Schmid metaphyseal chondrodysplasia</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009943&gt;</td>
      <td>Pyle disease</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009593&gt;</td>
      <td>spondylometaphyseal dysplasia, Sedaghatian type</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009943&gt;</td>
      <td>Pyle disease</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0007982&gt;</td>
      <td>metaphyseal chondrodysplasia, Jansen type</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009943&gt;</td>
      <td>Pyle disease</td>
    </tr>
  </tbody>
</table>



#### related-exact-synonym-warning



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>?cls</th>
      <th>?label</th>
      <th>?related</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0014756&gt;</td>
      <td>tremor, hereditary essential, 5</td>
      <td>ETM5</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0006999&gt;</td>
      <td>tooth disease</td>
      <td>disorder of calcareous tooth</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009424&gt;</td>
      <td>Bartter disease type 2</td>
      <td>hyperprostaglandin E syndrome 2</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0017686&gt;</td>
      <td>inborn aminoacylase deficiency</td>
      <td>rare inborn error of aminoacylase activity</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0020680&gt;</td>
      <td>acute bronchiolitis</td>
      <td>acute bronchiolitis</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0000651&gt;</td>
      <td>thoracic disease</td>
      <td>disorder of thoracic segment of trunk</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0003832&gt;</td>
      <td>complement deficiency</td>
      <td>disorder of complement activation</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0002031&gt;</td>
      <td>cecal disease</td>
      <td>disorder of caecum</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0011018&gt;</td>
      <td>brachyolmia-amelogenesis imperfecta syndrome</td>
      <td>DASS</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0011012&gt;</td>
      <td>African iron overload</td>
      <td>iron overload in Africa</td>
    </tr>
  </tbody>
</table>


    WARNING!  excluded-subsumption-is-inferred-warning  is empty and has been skipped.


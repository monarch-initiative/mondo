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
      <td>1655</td>
    </tr>
    <tr>
      <th>duplicate_scoped_synonym</th>
      <td>1595</td>
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
      <td>MONDO:0021108</td>
      <td>owl:equivalentClass</td>
      <td>9a7b67ab-165d-4af7-a367-eb61b0f1990bgenid312398</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0021108</td>
      <td>owl:equivalentClass</td>
      <td>9a7b67ab-165d-4af7-a367-eb61b0f1990bgenid312402</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0045024</td>
      <td>owl:equivalentClass</td>
      <td>9a7b67ab-165d-4af7-a367-eb61b0f1990bgenid339146</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0045024</td>
      <td>owl:equivalentClass</td>
      <td>9a7b67ab-165d-4af7-a367-eb61b0f1990bgenid339150</td>
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



#### missing_superclass



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
      <td>missing_superclass</td>
      <td>MONDO:0000065</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000070</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000162</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000224</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000252</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000261</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000263</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000266</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000405</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000421</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
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
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0005594&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0027407&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0019383&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0000307&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0021396&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0002834&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0002836&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0003067&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0016093&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0017822&gt;</td>
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
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009597&gt;</td>
      <td>metaphyseal chondrodysplasia, Spahr type</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009943&gt;</td>
      <td>Pyle disease</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0011211&gt;</td>
      <td>axial spondylometaphyseal dysplasia</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009943&gt;</td>
      <td>Pyle disease</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0007982&gt;</td>
      <td>metaphyseal chondrodysplasia, Jansen type</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009943&gt;</td>
      <td>Pyle disease</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0012160&gt;</td>
      <td>spondylometaphyseal dysplasia-cone-rod dystrophy syndrome</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009943&gt;</td>
      <td>Pyle disease</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009711&gt;</td>
      <td>congenital fiber-type disproportion myopathy</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0100084&gt;</td>
      <td>actinopathy</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0044304&gt;</td>
      <td>hyperphenylalaninemia due to DNAJC12 deficiency</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009861&gt;</td>
      <td>phenylketonuria</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009593&gt;</td>
      <td>spondylometaphyseal dysplasia, Sedaghatian type</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009943&gt;</td>
      <td>Pyle disease</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009711&gt;</td>
      <td>congenital fiber-type disproportion myopathy</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0100084&gt;</td>
      <td>actinopathy</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009711&gt;</td>
      <td>congenital fiber-type disproportion myopathy</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0100084&gt;</td>
      <td>actinopathy</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0010486&gt;</td>
      <td>palmoplantar keratoderma, mutilating, with periorificial keratotic plaques, X-linked</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0019014&gt;</td>
      <td>mutilating palmoplantar keratoderma with periorificial keratotic plaques</td>
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
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0021010&gt;</td>
      <td>skin lymphangiosarcoma</td>
      <td>lymphangiosarcoma of Stewart and Treves</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0000270&gt;</td>
      <td>lower respiratory tract disease</td>
      <td>disorder of lower respiratory tract</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0008738&gt;</td>
      <td>aganglionosis, total intestinal</td>
      <td>total intestinal aganglionosis</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0021534&gt;</td>
      <td>rectal neuroendocrine tumor G1</td>
      <td>rectum carcinoid tumor</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0015564&gt;</td>
      <td>Castleman disease</td>
      <td>angiofollicular lymph node hyperplasia</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0005289&gt;</td>
      <td>paranasal sinus neoplasm (disease)</td>
      <td>tumor of paranasal sinus</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0006266&gt;</td>
      <td>Leydig cell tumor</td>
      <td>interstitial cell neoplasm</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0024467&gt;</td>
      <td>apocrine sweat gland disease</td>
      <td>disorder of apocrine sweat gland</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0002540&gt;</td>
      <td>childhood oligodendroglioma</td>
      <td>pediatric oligodendroglioma</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0002485&gt;</td>
      <td>breast neuroendocrine neoplasm</td>
      <td>breast neuroendocrine tumor</td>
    </tr>
  </tbody>
</table>


    WARNING!  excluded-subsumption-is-inferred-warning  is empty and has been skipped.


## Mondo Statistics

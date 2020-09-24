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

## Overview of errors

This breaks down the errors in the generic ROBOT report. _Note that the whole report is filtered to only show results pertaining to MONDO classes themselves_. All tables are cut off at {{ NUMBER_ERRORS_SHOWN }} rows.


Table: Breakdown of the number of relationships in Mondo.



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>Rule Name</th>
      <th>2017</th>
      <th>2018</th>
      <th>2019</th>
      <th>2020</th>
      <th>current</th>
      <th>edit</th>
      <th>mondo-owl</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>annotation_whitespace</td>
      <td>0</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <td>deprecated_class_reference</td>
      <td>1</td>
      <td>52</td>
      <td>49</td>
      <td>56</td>
      <td>60</td>
      <td>0</td>
      <td>1</td>
    </tr>
    <tr>
      <td>duplicate_definition</td>
      <td>0</td>
      <td>229</td>
      <td>132</td>
      <td>109</td>
      <td>4</td>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>0</td>
      <td>418</td>
      <td>1662</td>
      <td>1690</td>
      <td>1688</td>
      <td>1688</td>
      <td>1688</td>
    </tr>
    <tr>
      <td>duplicate_label</td>
      <td>0</td>
      <td>66</td>
      <td>3</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>2</td>
      <td>3835</td>
      <td>1443</td>
      <td>1579</td>
      <td>1597</td>
      <td>1595</td>
      <td>1595</td>
    </tr>
    <tr>
      <td>equivalent_pair</td>
      <td>0</td>
      <td>28681</td>
      <td>36995</td>
      <td>37031</td>
      <td>37604</td>
      <td>0</td>
      <td>37576</td>
    </tr>
    <tr>
      <td>invalid_xref</td>
      <td>0</td>
      <td>1</td>
      <td>4</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>1</td>
      <td>332</td>
      <td>391</td>
      <td>387</td>
      <td>300</td>
      <td>300</td>
      <td>300</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <td>missing_label</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <td>missing_obsolete_label</td>
      <td>2</td>
      <td>5</td>
      <td>3</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <td>misused_obsolete_label</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>0</td>
      <td>21299</td>
      <td>37274</td>
      <td>37364</td>
      <td>37565</td>
      <td>4</td>
      <td>37553</td>
    </tr>
  </tbody>
</table>



## Detailed breakdown of errors: Editors file



#### Duplicate definition



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
      <td>MONDO:0005318</td>
      <td>IAO:0000115</td>
      <td>Oral aphthous ulcers typically present as painful, sharply circumscribed fibrin-covered mucosal defects with a hyperemic border.</td>
      <td>edit</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>duplicate_definition</td>
      <td>MONDO:0001014</td>
      <td>IAO:0000115</td>
      <td>A slowly progressing leukemia characterized by a clonal (malignant) proliferation of maturing and mature myeloid cells or mature lymphocytes. When the clonal cellular population is composed of myeloid cells, the process is called chronic myelogenous leukemia. When the clonal cellular population is composed of lymphocytes, it is classified as chronic lymphocytic leukemia, hairy cell leukemia, or T-cell large granular lymphocyte leukemia.</td>
      <td>edit</td>
      <td>ERROR</td>
    </tr>
  </tbody>
</table>



#### Multiple equivalent classes



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
      <td>7556c063-2887-475e-9308-c20ae7117542genid330662</td>
      <td>edit</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0021108</td>
      <td>owl:equivalentClass</td>
      <td>7556c063-2887-475e-9308-c20ae7117542genid330666</td>
      <td>edit</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0045024</td>
      <td>owl:equivalentClass</td>
      <td>7556c063-2887-475e-9308-c20ae7117542genid357415</td>
      <td>edit</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0045024</td>
      <td>owl:equivalentClass</td>
      <td>7556c063-2887-475e-9308-c20ae7117542genid357419</td>
      <td>edit</td>
      <td>ERROR</td>
    </tr>
  </tbody>
</table>



#### Duplicate exact synonym



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
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0016739</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor of the CNS</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0003404</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0005744</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010420</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLP</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010627</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLP</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0017304</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLOA</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0021019</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLOA</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010209</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine oxidase deficiency</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0018106</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine oxidase deficiency</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010209</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine dehydrogenase deficiency</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0018106</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>xanthine dehydrogenase deficiency</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0007764</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>Worth syndrome</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0011878</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>Worth syndrome</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0005004</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>Wolffian duct neoplasm</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>



#### Missing definition



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
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000009</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000014</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000023</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000030</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000032</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000045</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000049</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000050</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000060</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000065</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000066</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000070</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000075</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>missing_definition</td>
      <td>MONDO:0000079</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>



#### Duplicate scoped synonym



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
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000155</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of sequestering of triglyceride</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000242</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>dermatophytosis of beard</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000242</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>dermatophytosis of beard</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000270</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>disorder of lower respiratory tract</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000270</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>disorder of lower respiratory tract</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000330</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>endemic typhus Fever</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000330</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>endemic typhus Fever</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000351</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of methionine catabolic process</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000351</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of methionine catabolic process</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000414</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>pediatric electroclinical syndrome</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000414</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>pediatric electroclinical syndrome</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000421</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of L-serine biosynthetic process</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000421</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of L-serine biosynthetic process</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
    <tr>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000424</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of cobalamin metabolic process</td>
      <td>edit</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>



#### Lowercase definition



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
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001554</td>
      <td>IAO:0000115</td>
      <td>secondary glaucoma caused by either excessive size or spheric shape of the lens.</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001709</td>
      <td>IAO:0000115</td>
      <td>sarcoidosis with a complication of hypercalcemia.</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0001875</td>
      <td>IAO:0000115</td>
      <td>inflammation of the lateral epicondyle.</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0002121</td>
      <td>IAO:0000115</td>
      <td>neuritis of a single nerve.</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0004135</td>
      <td>IAO:0000115</td>
      <td>thyroiditis associated with painless enlargement of the thyroid gland. It occurs more frequently in females and is characterized by alterations between hyperthyroidism and hypothyroidism and the eventual return to normal thyroid gland function.</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005196</td>
      <td>IAO:0000115</td>
      <td>presence of structurally anomalous spermatozoa in the semen; malformations include the physical bending of the sperm to produce kinks or bends</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005448</td>
      <td>IAO:0000115</td>
      <td>liver injury resulting from hepatitis C infection</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005483</td>
      <td>IAO:0000115</td>
      <td>hair loss as a result of chemotherapy treatment</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005490</td>
      <td>IAO:0000115</td>
      <td>stroke caused by the blockage of blood flow in one of the large arteries feeding the brain</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005584</td>
      <td>IAO:0000115</td>
      <td>serious heritable structural anomalies of the left side of the heart, including hypoplastic left heart syndrome, aortic valve stenosis, coarctation of the aorta, mitral valve anomalies and bicuspid aortic valve, that are present from birth</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005588</td>
      <td>IAO:0000115</td>
      <td>inflammation and ulceration of the oral mucosa as a result of chemotherapy treatment</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005589</td>
      <td>IAO:0000115</td>
      <td>pancreatits that is the result of treatment with thiopurine immunosuppressants such as azathioprine or mercaptopurine</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005768</td>
      <td>IAO:0000115</td>
      <td>tuberculosis that involves any region of the gastrointestinal tract, mostly in the distal ileum and the cecum. In most cases, mycobacterium tuberculosis is the pathogen. Clinical features include abdominal pain; fever; and palpable mass in the ileocecal area.</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>lowercase_definition</td>
      <td>MONDO:0005789</td>
      <td>IAO:0000115</td>
      <td>inflammation of the liver in humans caused by hepatitis delta virus, a defective rna virus that can only infect hepatitis B patients. For its viral coating, hepatitis delta virus requires the hepatitis B surface antigens produced by these patients. Hepatitis D can occur either concomitantly with (coinfection) or subsequent to (superinfection) hepatitis B infection. Similar to hepatitis B, it is primarily transmitted by parenteral exposure, such as transfusion of contaminated blood or blood products, but can also be transmitted via sexual or intimate personal contact.</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
  </tbody>
</table>



#### Missing superclass



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
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000070</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000162</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000224</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000252</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000261</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000263</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000266</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000405</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000421</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000488</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000541</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000543</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000545</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
    <tr>
      <td>missing_superclass</td>
      <td>MONDO:0000551</td>
      <td>rdfs:subClassOf</td>
      <td>NaN</td>
      <td>edit</td>
      <td>INFO</td>
    </tr>
  </tbody>
</table>


## Other Quality Control checks

    WARNING!  mondo-qc-2017-no-subclass-between-genetic-disease-warning.tsv  is empty and has been skipped.
    WARNING!  mondo-qc-2018-no-subclass-between-genetic-disease-warning.tsv  is empty and has been skipped.
    WARNING!  mondo-qc-2020-excluded-subsumption-is-inferred-warning.tsv  is empty and has been skipped.
    WARNING!  mondo-qc-2017-excluded-subsumption-is-inferred-warning.tsv  is empty and has been skipped.
    WARNING!  mondo-qc-2018-excluded-subsumption-is-inferred-warning.tsv  is empty and has been skipped.
    WARNING!  mondo-qc-2019-excluded-subsumption-is-inferred-warning.tsv  is empty and has been skipped.
    WARNING!  mondo-qc-edit-excluded-subsumption-is-inferred-warning.tsv  is empty and has been skipped.
    WARNING!  mondo-qc-current-excluded-subsumption-is-inferred-warning.tsv  is empty and has been skipped.
    WARNING!  mondo-qc-2017-single-child-warning.tsv  is empty and has been skipped.



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>check</th>
      <th>2017</th>
      <th>2018</th>
      <th>2019</th>
      <th>2020</th>
      <th>current</th>
      <th>edit</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>no-subclass-between-genetic-disease-warning</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>214.0</td>
      <td>71.0</td>
      <td>68.0</td>
      <td>13.0</td>
    </tr>
    <tr>
      <td>related-exact-synonym-warning</td>
      <td>1.0</td>
      <td>200.0</td>
      <td>200.0</td>
      <td>200.0</td>
      <td>200.0</td>
      <td>200.0</td>
    </tr>
    <tr>
      <td>single-child-warning</td>
      <td>NaN</td>
      <td>1280.0</td>
      <td>1637.0</td>
      <td>1580.0</td>
      <td>1559.0</td>
      <td>1384.0</td>
    </tr>
  </tbody>
</table>



### Check: related-exact-synonym-warning



#### edit (Errors: 13)



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
      <td>MONDO:0044304</td>
      <td>hyperphenylalaninemia due to DNAJC12 deficiency</td>
      <td>MONDO:0009861</td>
      <td>phenylketonuria</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0008477</td>
      <td>spondylometaphyseal dysplasia, Kozlowski type</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0009711</td>
      <td>congenital fiber-type disproportion myopathy</td>
      <td>MONDO:0100084</td>
      <td>actinopathy</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0010486</td>
      <td>palmoplantar keratoderma, mutilating, with periorificial keratotic plaques, X-linked</td>
      <td>MONDO:0019014</td>
      <td>mutilating palmoplantar keratoderma with periorificial keratotic plaques</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0009597</td>
      <td>metaphyseal chondrodysplasia, Spahr type</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0012160</td>
      <td>spondylometaphyseal dysplasia-cone-rod dystrophy syndrome</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0009593</td>
      <td>spondylometaphyseal dysplasia, Sedaghatian type</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0009652</td>
      <td>mucolipidosis type III gamma</td>
      <td>MONDO:0018931</td>
      <td>mucolipidosis type III</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0007983</td>
      <td>Schmid metaphyseal chondrodysplasia</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0009711</td>
      <td>congenital fiber-type disproportion myopathy</td>
      <td>MONDO:0100084</td>
      <td>actinopathy</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0007982</td>
      <td>metaphyseal chondrodysplasia, Jansen type</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0009711</td>
      <td>congenital fiber-type disproportion myopathy</td>
      <td>MONDO:0100084</td>
      <td>actinopathy</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0011211</td>
      <td>axial spondylometaphyseal dysplasia</td>
      <td>MONDO:0009943</td>
      <td>Pyle disease</td>
      <td>edit</td>
    </tr>
  </tbody>
</table>



### Check: related-exact-synonym-warning



#### edit (Errors: 1384)



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
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0007481</td>
      <td>1</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0002326</td>
      <td>1</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0021468</td>
      <td>1</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0003960</td>
      <td>1</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0011140</td>
      <td>1</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0021203</td>
      <td>1</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0021469</td>
      <td>1</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0002894</td>
      <td>1</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0006282</td>
      <td>1</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0020264</td>
      <td>1</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0044346</td>
      <td>1</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0001697</td>
      <td>1</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0003656</td>
      <td>1</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0001564</td>
      <td>1</td>
      <td>edit</td>
    </tr>
  </tbody>
</table>



### Check: related-exact-synonym-warning



#### edit (Errors: 200)



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
      <td>MONDO:0014756</td>
      <td>tremor, hereditary essential, 5</td>
      <td>ETM5</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0006999</td>
      <td>tooth disease</td>
      <td>disorder of calcareous tooth</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0009424</td>
      <td>Bartter disease type 2</td>
      <td>hyperprostaglandin E syndrome 2</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0017686</td>
      <td>inborn aminoacylase deficiency</td>
      <td>rare inborn error of aminoacylase activity</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0020680</td>
      <td>acute bronchiolitis</td>
      <td>acute bronchiolitis</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0000651</td>
      <td>thoracic disease</td>
      <td>disorder of thoracic segment of trunk</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0003832</td>
      <td>complement deficiency</td>
      <td>disorder of complement activation</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0002031</td>
      <td>cecal disease</td>
      <td>disorder of caecum</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0011018</td>
      <td>brachyolmia-amelogenesis imperfecta syndrome</td>
      <td>DASS</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0011012</td>
      <td>African iron overload</td>
      <td>iron overload in Africa</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0002081</td>
      <td>musculoskeletal system disease</td>
      <td>disorder of musculoskeletal system</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0003225</td>
      <td>bone marrow disease</td>
      <td>disorder of bone marrow</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0020240</td>
      <td>syndromic retinitis pigmentosa</td>
      <td>syndrome associated with retinitis pigmentosa</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0016241</td>
      <td>alternating hemiplegia of childhood</td>
      <td>pediatric alternating hemiplegia</td>
      <td>edit</td>
    </tr>
    <tr>
      <td>MONDO:0011127</td>
      <td>Bartter disease type 1</td>
      <td>hyperprostaglandin E syndrome 1</td>
      <td>edit</td>
    </tr>
  </tbody>
</table>


## Mondo Statistics

## Relationships


### Table: Breakdown of the number of relationships in Mondo.



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>property</th>
      <th>2019</th>
      <th>2020</th>
      <th>current</th>
      <th>mondo-owl</th>
      <th>edit</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasDbXref</td>
      <td>99234</td>
      <td>99326</td>
      <td>99965</td>
      <td>99967</td>
      <td>128446</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2004/02/skos/core#exactMatch</td>
      <td>69877</td>
      <td>69979</td>
      <td>70550</td>
      <td>70551</td>
      <td>0</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasExactSynonym</td>
      <td>63390</td>
      <td>63636</td>
      <td>64352</td>
      <td>64376</td>
      <td>64376</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#subClassOf</td>
      <td>46835</td>
      <td>46891</td>
      <td>47538</td>
      <td>47544</td>
      <td>46998</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2002/07/owl#equivalentClass</td>
      <td>44290</td>
      <td>44367</td>
      <td>45007</td>
      <td>44979</td>
      <td>7403</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasRelatedSynonym</td>
      <td>37814</td>
      <td>37757</td>
      <td>37872</td>
      <td>37876</td>
      <td>37876</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#type</td>
      <td>23555</td>
      <td>23623</td>
      <td>24229</td>
      <td>24232</td>
      <td>24232</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#label</td>
      <td>23442</td>
      <td>23510</td>
      <td>24112</td>
      <td>24115</td>
      <td>24115</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#id</td>
      <td>23443</td>
      <td>23510</td>
      <td>24112</td>
      <td>24115</td>
      <td>24115</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2004/02/skos/core#closeMatch</td>
      <td>16375</td>
      <td>16273</td>
      <td>16509</td>
      <td>16510</td>
      <td>0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/IAO_0000115</td>
      <td>15425</td>
      <td>15452</td>
      <td>15492</td>
      <td>15493</td>
      <td>15493</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#inSubset</td>
      <td>13335</td>
      <td>13383</td>
      <td>13454</td>
      <td>13453</td>
      <td>13453</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#seeAlso</td>
      <td>3062</td>
      <td>3063</td>
      <td>3136</td>
      <td>3140</td>
      <td>3140</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2002/07/owl#deprecated</td>
      <td>1756</td>
      <td>1794</td>
      <td>1941</td>
      <td>1945</td>
      <td>1945</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/IAO_0100001</td>
      <td>1540</td>
      <td>1564</td>
      <td>1665</td>
      <td>1667</td>
      <td>1667</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#excluded_subClassOf</td>
      <td>789</td>
      <td>909</td>
      <td>1066</td>
      <td>1067</td>
      <td>1072</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#comment</td>
      <td>947</td>
      <td>952</td>
      <td>948</td>
      <td>950</td>
      <td>950</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasNarrowSynonym</td>
      <td>768</td>
      <td>774</td>
      <td>787</td>
      <td>788</td>
      <td>788</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasBroadSynonym</td>
      <td>443</td>
      <td>455</td>
      <td>483</td>
      <td>486</td>
      <td>486</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#consider</td>
      <td>248</td>
      <td>251</td>
      <td>284</td>
      <td>285</td>
      <td>285</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/IAO_0000231</td>
      <td>112</td>
      <td>118</td>
      <td>122</td>
      <td>122</td>
      <td>122</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasAlternativeId</td>
      <td>113</td>
      <td>113</td>
      <td>117</td>
      <td>117</td>
      <td>117</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2002/07/owl#disjointWith</td>
      <td>72</td>
      <td>71</td>
      <td>76</td>
      <td>76</td>
      <td>76</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#created_by</td>
      <td>4</td>
      <td>20</td>
      <td>63</td>
      <td>66</td>
      <td>66</td>
    </tr>
    <tr>
      <td>&lt;http://purl.org/dc/elements/1.1/date</td>
      <td>55</td>
      <td>55</td>
      <td>55</td>
      <td>55</td>
      <td>55</td>
    </tr>
    <tr>
      <td>&lt;http://purl.org/dc/elements/1.1/creator</td>
      <td>54</td>
      <td>54</td>
      <td>54</td>
      <td>54</td>
      <td>54</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2004/02/skos/core#broadMatch</td>
      <td>15</td>
      <td>15</td>
      <td>12</td>
      <td>12</td>
      <td>0</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2004/02/skos/core#narrowMatch</td>
      <td>11</td>
      <td>12</td>
      <td>10</td>
      <td>11</td>
      <td>0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#excluded_synonym</td>
      <td>7</td>
      <td>7</td>
      <td>8</td>
      <td>8</td>
      <td>8</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#pathogenesis</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#related</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#creation_date</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/RO_0002161</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#confidence</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>5571</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#RELARED</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#EXACTS</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#BOAD</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#may_be_merged_into</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>





    <matplotlib.axes._subplots.AxesSubplot at 0x7facc937a130>




![png](mondo_analysis_files/mondo_analysis_20_1.png)



### Table: Current release vs Edit release: Differences in the number of specific relations



<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>property</th>
      <th>mondo-owl</th>
      <th>current</th>
      <th>difference</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasExactSynonym</td>
      <td>64376</td>
      <td>64352</td>
      <td>24</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#subClassOf</td>
      <td>47544</td>
      <td>47538</td>
      <td>6</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasRelatedSynonym</td>
      <td>37876</td>
      <td>37872</td>
      <td>4</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#seeAlso</td>
      <td>3140</td>
      <td>3136</td>
      <td>4</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2002/07/owl#deprecated</td>
      <td>1945</td>
      <td>1941</td>
      <td>4</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#created_by</td>
      <td>66</td>
      <td>63</td>
      <td>3</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#type</td>
      <td>24232</td>
      <td>24229</td>
      <td>3</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#label</td>
      <td>24115</td>
      <td>24112</td>
      <td>3</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#id</td>
      <td>24115</td>
      <td>24112</td>
      <td>3</td>
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
      <td>&lt;http://www.w3.org/2000/01/rdf-schema#comment</td>
      <td>950</td>
      <td>948</td>
      <td>2</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/IAO_0100001</td>
      <td>1667</td>
      <td>1665</td>
      <td>2</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#consider</td>
      <td>285</td>
      <td>284</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#hasNarrowSynonym</td>
      <td>788</td>
      <td>787</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2004/02/skos/core#narrowMatch</td>
      <td>11</td>
      <td>10</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/mondo#excluded_subClassOf</td>
      <td>1067</td>
      <td>1066</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2004/02/skos/core#exactMatch</td>
      <td>70551</td>
      <td>70550</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://purl.obolibrary.org/obo/IAO_0000115</td>
      <td>15493</td>
      <td>15492</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2004/02/skos/core#closeMatch</td>
      <td>16510</td>
      <td>16509</td>
      <td>1</td>
    </tr>
    <tr>
      <td>&lt;http://www.geneontology.org/formats/oboInOwl#inSubset</td>
      <td>13453</td>
      <td>13454</td>
      <td>-1</td>
    </tr>
    <tr>
      <td>&lt;http://www.w3.org/2002/07/owl#equivalentClass</td>
      <td>44979</td>
      <td>45007</td>
      <td>-28</td>
    </tr>
  </tbody>
</table>


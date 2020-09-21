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

This section aims 




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
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



<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C2991</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <th>1</th>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>OGMS:0000031</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <th>2</th>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:64572001</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <th>3</th>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.ebi.ac.uk/efo/EFO_0000408</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <th>4</th>
      <td>multiple_equivalent_classes</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.orpha.net/ORDO/Orphanet_377788</td>
      <td>ERROR</td>
    </tr>
  </tbody>
</table>
</div>



#### deprecated_class_reference



<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>37816</th>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>http://linkedlifedata.com/resource/umls/id/C00...</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <th>37817</th>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>COHD:4245842</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <th>37818</th>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>DOID:0060321</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <th>37819</th>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>ICD9:553.1</td>
      <td>ERROR</td>
    </tr>
    <tr>
      <th>37820</th>
      <td>deprecated_class_reference</td>
      <td>MONDO:0000747</td>
      <td>owl:equivalentClass</td>
      <td>MESH:D006554</td>
      <td>ERROR</td>
    </tr>
  </tbody>
</table>
</div>



#### duplicate_exact_synonym



<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>37871</th>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0003401</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor of the CNS</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>37872</th>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0016739</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor of the CNS</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>37873</th>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0003404</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>37874</th>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0005744</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>yolk Sac tumor</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>37875</th>
      <td>duplicate_exact_synonym</td>
      <td>MONDO:0010420</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>XLP</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>
</div>



#### equivalent_pair



<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>83574</th>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>NCIT:C2991</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>83575</th>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>OGMS:0000031</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>83576</th>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>SCTID:64572001</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>83577</th>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.ebi.ac.uk/efo/EFO_0000408</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>83578</th>
      <td>equivalent_pair</td>
      <td>MONDO:0000001</td>
      <td>owl:equivalentClass</td>
      <td>http://www.orpha.net/ORDO/Orphanet_377788</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>
</div>



#### missing_definition



<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>121277</th>
      <td>missing_definition</td>
      <td>MONDO:0000005</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>121278</th>
      <td>missing_definition</td>
      <td>MONDO:0000009</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>121279</th>
      <td>missing_definition</td>
      <td>MONDO:0000014</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>121280</th>
      <td>missing_definition</td>
      <td>MONDO:0000023</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>121281</th>
      <td>missing_definition</td>
      <td>MONDO:0000030</td>
      <td>IAO:0000115</td>
      <td>NaN</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>
</div>



#### duplicate_scoped_synonym



<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>128494</th>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000155</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>rare inborn error of sequestering of triglyceride</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>128495</th>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000155</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>rare inborn error of sequestering of triglyceride</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>128496</th>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000242</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>dermatophytosis of beard</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>128497</th>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000242</td>
      <td>oboInOwl:hasRelatedSynonym</td>
      <td>dermatophytosis of beard</td>
      <td>WARN</td>
    </tr>
    <tr>
      <th>128498</th>
      <td>duplicate_scoped_synonym</td>
      <td>MONDO:0000270</td>
      <td>oboInOwl:hasExactSynonym</td>
      <td>disorder of lower respiratory tract</td>
      <td>WARN</td>
    </tr>
  </tbody>
</table>
</div>



#### lowercase_definition



<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Rule Name</th>
      <th>Subject</th>
      <th>Property</th>
      <th>Value</th>
      <th>Level</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>130090</th>
      <td>lowercase_definition</td>
      <td>MONDO:0000712</td>
      <td>IAO:0000115</td>
      <td>frontotemporal dementia plus amyotrophic later...</td>
      <td>INFO</td>
    </tr>
    <tr>
      <th>130091</th>
      <td>lowercase_definition</td>
      <td>MONDO:0001554</td>
      <td>IAO:0000115</td>
      <td>secondary glaucoma caused by either excessive ...</td>
      <td>INFO</td>
    </tr>
    <tr>
      <th>130092</th>
      <td>lowercase_definition</td>
      <td>MONDO:0001709</td>
      <td>IAO:0000115</td>
      <td>sarcoidosis with a complication of hypercalcemia.</td>
      <td>INFO</td>
    </tr>
    <tr>
      <th>130093</th>
      <td>lowercase_definition</td>
      <td>MONDO:0001875</td>
      <td>IAO:0000115</td>
      <td>inflammation of the lateral epicondyle.</td>
      <td>INFO</td>
    </tr>
    <tr>
      <th>130094</th>
      <td>lowercase_definition</td>
      <td>MONDO:0002121</td>
      <td>IAO:0000115</td>
      <td>neuritis of a single nerve.</td>
      <td>INFO</td>
    </tr>
  </tbody>
</table>
</div>


# Other checks analyses


#### single-child-warning



<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>?cls</th>
      <th>?total</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0016094&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0021396&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0016093&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0008882&gt;</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0006224&gt;</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>



#### no-subclass-between-genetic-disease-warning



<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>?d1</th>
      <th>?d1_label</th>
      <th>?d2</th>
      <th>?d2_label</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0013529&gt;</td>
      <td>catecholaminergic polymorphic ventricular tach...</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0008648&gt;</td>
      <td>ventricular tachycardia, familial</td>
    </tr>
    <tr>
      <th>1</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0013966&gt;</td>
      <td>catecholaminergic polymorphic ventricular tach...</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0008648&gt;</td>
      <td>ventricular tachycardia, familial</td>
    </tr>
    <tr>
      <th>2</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009597&gt;</td>
      <td>metaphyseal chondrodysplasia, Spahr type</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009943&gt;</td>
      <td>Pyle disease</td>
    </tr>
    <tr>
      <th>3</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0012762&gt;</td>
      <td>catecholaminergic polymorphic ventricular tach...</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0008648&gt;</td>
      <td>ventricular tachycardia, familial</td>
    </tr>
    <tr>
      <th>4</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0011211&gt;</td>
      <td>axial spondylometaphyseal dysplasia</td>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009943&gt;</td>
      <td>Pyle disease</td>
    </tr>
  </tbody>
</table>
</div>



#### related-exact-synonym-warning



<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>?cls</th>
      <th>?label</th>
      <th>?related</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0014756&gt;</td>
      <td>tremor, hereditary essential, 5</td>
      <td>ETM5</td>
    </tr>
    <tr>
      <th>1</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0006999&gt;</td>
      <td>tooth disease</td>
      <td>disorder of calcareous tooth</td>
    </tr>
    <tr>
      <th>2</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0009424&gt;</td>
      <td>Bartter disease type 2</td>
      <td>hyperprostaglandin E syndrome 2</td>
    </tr>
    <tr>
      <th>3</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0017686&gt;</td>
      <td>inborn aminoacylase deficiency</td>
      <td>rare inborn error of aminoacylase activity</td>
    </tr>
    <tr>
      <th>4</th>
      <td>&lt;http://purl.obolibrary.org/obo/MONDO_0020680&gt;</td>
      <td>acute bronchiolitis</td>
      <td>acute bronchiolitis</td>
    </tr>
  </tbody>
</table>
</div>


    WARNING!  excluded-subsumption-is-inferred-warning  is empty and has been skipped.


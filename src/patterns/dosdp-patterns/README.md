# Pattern directory
This is a listing of all the patterns hosted as part of this directory

## Patterns in dosdp-patterns
### Omim disease series by gene
*This pattern is meant to be used for OMIM Mendelian diseases (ie unitary genetic diseases, as described in [PMID:33417889](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7820621/)), including children of OMIM phenotypic series (OMIMPS), which are represented as grouping classes in Mondo. Notes about the OMIMPS (see also OMIM_phenotypic_series.yaml):  - every instance of the OMIMPS metaclass should be equivalent to (via annotated xref) to something in OMIMPS namespace - the OMIMPS will never have an asserted causative gene as logical axiom (and no single causative gene in text def) - the OMIMPS must never be equivalent to an OMIM:nnnnnn (often redundant with the above rule) - the OMIMPS must have an acronym synonym, e.g. HPE - the OMIMPS must have two or more subclasses (direct or indirect) that are equivalent to OMIMs and conform to this pattern - the subclasses should (not must) have a logical def that uses the PS as a genus  - the OMIM subclasses must have acronym synonyms that are the parent syn + number, e.g. HPE1, HPE2 - the primary label for the children should also be parent + {"type"} + number - the first member will usually have the same number local ID as the PS Examples: [holoprosencephaly 1](http://purl.obolibrary.org/obo/MONDO_0009349), [3M syndrome 1](http://purl.obolibrary.org/obo/MONDO_0010117)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/disease_series_by_gene.yaml |
| Name | OMIM_disease_series_by_gene |
| Classes | MONDO:0000001, SO:0000704,  |
| Variables | disease (MONDO:0000001), gene (SO:0000704),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples |  |

### Omim phenotypic series
*This pattern is meant to be used for OMIM phenotypic series (OMIMPS), which are represented as grouping classes in Mondo. Note:  - every instance of this metaclass should be equivalent to (via annotated xref) to something in OMIMPS namespace - it will never have an asserted causative gene as logical axiom (and no single causative gene in text def) - it must never be equivalent to an OMIM:nnnnnn (often redundant with the above rule) - it must have an acronym synonym, e.g. HPE - it must have two or more subclasses (direct or indirect) that are equivalent to OMIMs - the subclasses should (not must) have a logical def that uses the PS as a genus (see http://purl.obolibrary.org/obo/mondo/patterns/disease_series_by_gene.yaml) - the OMIM subclasses must have acronym synonyms that are the parent syn + number, e.g. HPE1, HPE2 - the primary label for the children should also be parent + {"type"} + number - the first member will usually have the same number local ID as the PS - the first member in OMIM usually has documentation that is pertinent to the parent PS - the members may(?) generally share high semantic similarity - All OMIMPS disease should have a has modifier some inherited restricted, see http://purl.obolibrary.org/obo/mondo/sparql/omimps-should-be-inherited-violation.sparql
Examples: [holoprosencephaly](http://purl.obolibrary.org/obo/MONDO_0016296) [OMIMPS:236100](https://omim.org/phenotypicSeries/PS236100), '3-M syndrome'(http://purl.obolibrary.org/obo/MONDO_0007477) [OMIMPS:236100](https://omim.org/phenotypicSeries/PS273750).*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/OMIM_phenotypic_series.yaml |
| Name | OMIM_phenotypic_series |
| Classes | MONDO:0000001, MONDO:0021152,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples |  |

### Acquired
*Pattern for extending a etiology-generic disease class to an acquired form.  Here acquired means that basis for the disease is acquired during the individuals lifetime. It need not exclude genetic etiology, but it excludes inherited.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/acquired.yaml |
| Name | acquired |
| Classes | MONDO:0021141, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/acquired.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                | disease                                      | disease:label                |
|:---------------------------------------------|:-----------------------------------|:---------------------------------------------|:-----------------------------|
| MONDO:0018686 | acquired Creutzfeldt-Jakob disease | MONDO:0005357 | Creutzfeldt Jacob disease    |
| MONDO:0060779 | acquired Fanconi syndrome          | MONDO:0001083 | Fanconi renotubular syndrome |
| MONDO:0045023 | acquired adrenogenital syndrome    | MONDO:0015898 | adrenogenital syndrome       |
| MONDO:0019624 | acquired angioedema                | MONDO:0010481 | angioedema                   |
| MONDO:0015610 | acquired aplastic anemia           | MONDO:0015909 | aplastic anemia              |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/acquired.tsv)
### Acute
*This pattern is applied to diseases that are described as having an acute onset, i.e. the sudden appearance of disease manifestations over a short period of time.
Examples: [acute bronchiolitis](http://purl.obolibrary.org/obo/MONDO_0020680), [acute liver failure](http://purl.obolibrary.org/obo/MONDO_0019542)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/acute.yaml |
| Name | acute |
| Classes | PATO:0000389, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/acute.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                       | disease                                      | disease:label                       |
|:---------------------------------------------|:------------------------------------------|:---------------------------------------------|:------------------------------------|
| MONDO:0003540 | acute T cell leukemia                     | MONDO:0005525 | T-cell leukemia                     |
| MONDO:0001090 | acute anterolateral myocardial infarction | MONDO:0006652 | anterolateral myocardial infarction |
| MONDO:0020680 | acute bronchiolitis                       | MONDO:0002465 | bronchiolitis                       |
| MONDO:0001081 | acute cervicitis                          | MONDO:0002345 | cervicitis                          |
| MONDO:0001930 | acute cholangitis                         | MONDO:0004789 | cholangitis                         |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/acute.tsv)
### Adenocarcinoma
*Adenocarcinoma is a common cancer characterized by the presence of malignant glandular cells. This is a design pattern for classes representing adenocarcinomas based on their location. This may be the site of origin, but it can also represent a secondary site for metastatized cancer. We use the generic disease has location relation, which generalized over primary and secondary sites.
Examples: [adenocarcinoma of cervix uteri](http://purl.obolibrary.org/obo/MONDO_0016275), [pituitary adenocarcinoma (disease)](http://purl.obolibrary.org/obo/MONDO_0017582)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/adenocarcinoma.yaml |
| Name | adenocarcinoma disease has location X |
| Classes | MONDO:0004970, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/adenocarcinoma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                  | location                                      | location:label         |
|:---------------------------------------------|:-------------------------------------|:----------------------------------------------|:-----------------------|
| MONDO:0003853 | Bartholin gland adenocarcinoma       | UBERON:0000460 | major vestibular gland |
| MONDO:0003410 | Wolffian duct adenocarcinoma         | UBERON:0003074 | mesonephric duct       |
| MONDO:0016275 | adenocarcinoma of cervix uteri       | UBERON:0000002 | uterine cervix         |
| MONDO:0018351 | adenocarcinoma of penis              | UBERON:0000989 | penis                  |
| MONDO:0004173 | adenocarcinoma of skene gland origin | UBERON:0010145 | paraurethral gland     |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/adenocarcinoma.tsv)
### Adenoma
*Adenomas are neoplasms arising from epithelium. This is a design pattern for classes representing adenomas based on their location. This may be the site of origin, but it can also represent a secondary site for metastatized cancer. We use the generic `disease has location` relation, which is generalized over primary and secondary sites. Examples: [pituitary gland adenoma](http://purl.obolibrary.org/obo/MONDO_0006373), [breast adenoma](http://purl.obolibrary.org/obo/MONDO_0002058)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/adenoma.yaml |
| Name | adenoma disease has location X |
| Classes | MONDO:0004972, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/adenoma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label        | location                                      | location:label         |
|:---------------------------------------------|:---------------------------|:----------------------------------------------|:-----------------------|
| MONDO:0003419 | Bartholin gland adenoma    | UBERON:0000460 | major vestibular gland |
| MONDO:0021301 | adenoma of nipple          | UBERON:0002030 | nipple                 |
| MONDO:0021303 | adenoma of small intestine | UBERON:0002108 | small intestine        |
| MONDO:0003924 | adrenal cortex adenoma     | UBERON:0001235 | adrenal cortex         |
| MONDO:0006088 | appendix adenoma           | UBERON:0001154 | vermiform appendix     |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/adenoma.tsv)
### Adenosquamous carcinoma
*An adenosquamous carcinoma is a carcinoma composed of malignant glandular cells and malignant squamous cells. This is a design pattern for classes representing adenosquamous carcinomas based on their location. This may be the site of origin, but it can also represent a secondary site for metastatized cancer. We use the generic 'disease has location' relation, which generalized over primary and secondary sites.
Examples: [adenosquamous breast carcinoma](http://purl.obolibrary.org/obo/MONDO_0003548), [Bartholin gland adenosquamous carcinoma] (http://purl.obolibrary.org/obo/MONDO_0003555), [gastric adenosquamous carcinoma](http://purl.obolibrary.org/obo/MONDO_0006034)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/adenosquamous_carcinoma.yaml |
| Name | adenosquamous carcinoma disease has location X |
| Classes | MONDO:0006074, UBERON:0010000,  |
| Variables | location (UBERON:0010000),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/adenosquamous_carcinoma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                     | location                                      | location:label         |
|:---------------------------------------------|:----------------------------------------|:----------------------------------------------|:-----------------------|
| MONDO:0003555 | Bartholin gland adenosquamous carcinoma | UBERON:0000460 | major vestibular gland |
| MONDO:0003549 | adenosquamous bile duct carcinoma       | UBERON:0002394 | bile duct              |
| MONDO:0003548 | adenosquamous breast carcinoma          | UBERON:0000310 | breast                 |
| MONDO:0003554 | adenosquamous colon carcinoma           | UBERON:0001155 | colon                  |
| MONDO:0004973 | adenosquamous lung carcinoma            | UBERON:0002048 | lung                   |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/adenosquamous_carcinoma.tsv)
### Adult
*An instance of a disease that has an onset of signs or symptoms of disease between the age of 16 years or later (adult onset).
Examples: [adult brain stem neoplasm](http://purl.obolibrary.org/obo/MONDO_0024797), [adult-onset myasthenia gravis](http://purl.obolibrary.org/obo/MONDO_0018324)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/adult.yaml |
| Name | adult |
| Classes | HP:0003581, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/adult.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                     | disease                                      | disease:label                                 |
|:---------------------------------------------|:----------------------------------------|:---------------------------------------------|:----------------------------------------------|
| MONDO:0000814 | B-cell adult acute lymphocytic leukemia | MONDO:0000872 | B-cell childhood acute lymphoblastic leukemia |
| MONDO:0017723 | Sandhoff disease, adult form            | MONDO:0010006 | Sandhoff disease                              |
| MONDO:0017617 | acquired adult-onset immunodeficiency   | MONDO:0017769 | acquired immunodeficiency                     |
| MONDO:0060778 | adult Fanconi syndrome                  | MONDO:0001083 | Fanconi renotubular syndrome                  |
| MONDO:0016091 | adult Krabbe disease                    | MONDO:0009499 | Krabbe disease                                |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/adult.tsv)
### Allergic form of disease
*An etiological pattern that extends an etiology-generic disease to an allergic form (i.e. caused by pathological type I hypersensitivity reaction). The [allergy.yaml](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/allergy.yaml) pattern is to refine an existing disease by trigger.
Examples: [allergic respiratory disease](http://purl.obolibrary.org/obo/MONDO_0000771), [atopic eczema](http://purl.obolibrary.org/obo/MONDO_0004980), [allergic otitis media](http://purl.obolibrary.org/obo/MONDO_0021202)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/allergic_form_of_disease.yaml |
| Name | allergic_form_of_disease |
| Classes | MONDO:0000001, GO:0016068,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/allergic_form_of_disease.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label          | disease                                      | disease:label              |
|:---------------------------------------------|:-----------------------------|:---------------------------------------------|:---------------------------|
| MONDO:0004784 | allergic asthma              | MONDO:0004979 | asthma                     |
| MONDO:0006525 | allergic contact dermatitis  | MONDO:0005480 | contact dermatitis         |
| MONDO:0005271 | allergic disease             | MONDO:0000001 | disease or disorder        |
| MONDO:0021202 | allergic otitis media        | MONDO:0005441 | otitis media               |
| MONDO:0000771 | allergic respiratory disease | MONDO:0005087 | respiratory system disease |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/allergic_form_of_disease.tsv)
### Allergy
*Allergy classified according to allergic trigger. This pattern is to refine an existing disease by trigger, the [allergic_form_of_disease.yaml](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/allergic_form_of_disease.yaml) pattern is for a generic disease.
Examples: [egg allergy](http://purl.obolibrary.org/obo/MONDO_0005741), [peach allergy](http://purl.obolibrary.org/obo/MONDO_0000785), [gluten allergy](http://purl.obolibrary.org/obo/MONDO_0000606)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/allergy.yaml |
| Name | allergy |
| Classes | MONDO:0005271, owl:Thing,  |
| Variables | substance (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples |  |

### Autoimmune
*An instance of a disease that is brought about or caused by autoimmunity.
Examples: [autoimmune cardiomyopathy](http://purl.obolibrary.org/obo/MONDO_0030701), [autoimmune pancreatitis](http://purl.obolibrary.org/obo/MONDO_0015175)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/autoimmune.yaml |
| Name | autoimmune |
| Classes | MONDO:0000001, HP:0002960,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/autoimmune.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                        | disease                                      | disease:label                |
|:---------------------------------------------|:-------------------------------------------|:---------------------------------------------|:-----------------------------|
| MONDO:0030702 | autoimmune atherosclerosis                 | MONDO:0005311 | atherosclerosis              |
| MONDO:0030701 | autoimmune cardiomyopathy                  | MONDO:0004994 | cardiomyopathy               |
| MONDO:0007179 | autoimmune disease                         | MONDO:0000001 | disease or disorder          |
| MONDO:0000587 | autoimmune disease of ear, nose and throat | MONDO:0024623 | otorhinolaryngologic disease |
| MONDO:0020640 | autoimmune encephalitis                    | MONDO:0019956 | encephalitis                 |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/autoimmune.tsv)
### Autoimmune inflammation
*An instance of an autoimmune disease that is described by inflammation in a specific anatomical entity.
Example: [autoimmune thyroid disease](http://purl.obolibrary.org/obo/MONDO_0005623)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/autoimmune_inflammation.yaml |
| Name | autoimmune_inflammation |
| Classes | MONDO:0007179, UBERON:0000061,  |
| Variables | location (UBERON:0000061),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/autoimmune_inflammation.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label        | location                                      | location:label   |
|:---------------------------------------------|:---------------------------|:----------------------------------------------|:-----------------|
| MONDO:0005623 | autoimmune thyroid disease | UBERON:0002046 | thyroid gland    |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/autoimmune_inflammation.tsv)
### Autosomal dominant
*This pattern is applied to autosomal dominant forms of an inherited disease.
Examples: [autosomal dominant cerebellar ataxia](http://purl.obolibrary.org/obo/MONDO_0020380), [autosomal dominant osteopetrosis](http://purl.obolibrary.org/obo/MONDO_0020645)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/autosomal_dominant.yaml |
| Name | autosomal_dominant |
| Classes | HP:0000006, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/autosomal_dominant.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                                      | disease                                      | disease:label                         |
|:---------------------------------------------|:---------------------------------------------------------|:---------------------------------------------|:--------------------------------------|
| MONDO:0007086 | autosomal dominant Alport syndrome                       | MONDO:0018965 | Alport syndrome                       |
| MONDO:0007524 | autosomal dominant Ehlers-Danlos syndrome, vascular type | MONDO:0017314 | Ehlers-Danlos syndrome, vascular type |
| MONDO:0020336 | autosomal dominant Emery-Dreifuss muscular dystrophy     | MONDO:0016830 | Emery-Dreifuss muscular dystrophy     |
| MONDO:0007478 | autosomal dominant Kenny-Caffey syndrome                 | MONDO:0016516 | Kenny-Caffey syndrome                 |
| MONDO:0007779 | autosomal dominant Opitz G/BBB syndrome                  | MONDO:0017138 | Opitz G/BBB syndrome                  |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/autosomal_dominant.tsv)
### Autosomal recessive
*This pattern is applied to autosomal recessive forms of an inherited disease.
Examples: [autosomal recessive brachyolmia](http://purl.obolibrary.org/obo/MONDO_0018662), [autosomal recessive sideroblastic anemia](http://purl.obolibrary.org/obo/MONDO_0016828)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/autosomal_recessive.yaml |
| Name | autosomal_recessive |
| Classes | HP:0000007, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/autosomal_recessive.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                                       | disease                                      | disease:label                         |
|:---------------------------------------------|:----------------------------------------------------------|:---------------------------------------------|:--------------------------------------|
| MONDO:0011551 | TH-deficient dopa-responsive dystonia                     | MONDO:0016812 | dopa-responsive dystonia              |
| MONDO:0008719 | acrorenal syndrome, autosomal recessive                   | MONDO:0007059 | acrorenal syndrome                    |
| MONDO:0008762 | autosomal recessive Alport syndrome                       | MONDO:0018965 | Alport syndrome                       |
| MONDO:0002014 | autosomal recessive Ehlers-Danlos syndrome, vascular type | MONDO:0017314 | Ehlers-Danlos syndrome, vascular type |
| MONDO:0008406 | autosomal recessive Emery-Dreifuss muscular dystrophy     | MONDO:0016830 | Emery-Dreifuss muscular dystrophy     |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/autosomal_recessive.tsv)
### Basis in disruption of process
*A pattern for generic groupings of diseases based around the molecular basis for the disease in terms of a GO molecular function or cellular process.
For example: DNA repair or RAS signaling*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/basis_in_disruption_of_process.yaml |
| Name | basis_in_disruption_of_process |
| Classes | MONDO:0000001, BFO:0000015,  |
| Variables | process (BFO:0000015),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/basis_in_disruption_of_process.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label     | process                                   | process:label                                         |
|:---------------------------------------------|:------------------------|:------------------------------------------|:------------------------------------------------------|
| MONDO:0012996 | AGAT deficiency         | GO:0015068 | glycine amidinotransferase activity                   |
| MONDO:0021190 | DNA repair disease      | GO:0006281 | DNA repair                                            |
| MONDO:0018274 | GM3 synthase deficiency | GO:0047291 | lactosylceramide alpha-2,3-sialyltransferase activity |
| MONDO:0021060 | RASopathy               | GO:0007265 | Ras protein signal transduction                       |
| MONDO:0005271 | allergic disease        | GO:0016068 | type I hypersensitivity                               |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/basis_in_disruption_of_process.tsv)
### Benign
*This is a design pattern for classes representing benign neoplasms, extending a generic neoplasm class. For example, a benign adrenal gland pheochromocytoma, defined as being the benign form of the more general adrenal gland pheochromocytoma.
TODO: encode alternate way of representing*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/benign.yaml |
| Name | benign |
| Classes | MONDO:0005070, PATO:0002096,  |
| Variables | neoplasm (MONDO:0005070),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/benign.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                   | neoplasm                                     | neoplasm:label                                              |
|:---------------------------------------------|:--------------------------------------|:---------------------------------------------|:------------------------------------------------------------|
| MONDO:0036990 | benign Leydig cell tumor              | MONDO:0006266 | Leydig cell tumor                                           |
| MONDO:0020581 | benign PEComa                         | MONDO:0006359 | neoplasm with perivascular epithelioid cell differentiation |
| MONDO:0006103 | benign adrenal gland pheochromocytoma | MONDO:0004974 | adrenal gland pheochromocytoma                              |
| MONDO:0036781 | benign axillary neoplasm              | MONDO:0036779 | axillary neoplasm                                           |
| MONDO:0002065 | benign breast adenomyoepithelioma     | MONDO:0002066 | breast adenomyoepithelioma                                  |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/benign.tsv)
### Benign neoplasm
*Neoplasms are benign or malignant tissue growths resulting from uncontrolled cell proliferation cell types.
This is a design pattern for classes representing *benign* neoplasms based on their location.
See also: benign.yaml TODO: choose one over another*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/benign_neoplasm.yaml |
| Name | benign_neoplasm |
| Classes | MONDO:0005165, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/benign_neoplasm.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label              | location                                      | location:label                             |
|:---------------------------------------------|:---------------------------------|:----------------------------------------------|:-------------------------------------------|
| MONDO:0002193 | Bartholin gland benign neoplasm  | UBERON:0000460 | major vestibular gland                     |
| MONDO:0044764 | benign choroid plexus neoplasm   | UBERON:0001886 | choroid plexus                             |
| MONDO:0002278 | benign colon neoplasm            | UBERON:0001155 | colon                                      |
| MONDO:0006105 | benign conjunctival neoplasm     | UBERON:0001811 | conjunctiva                                |
| MONDO:0000385 | benign digestive system neoplasm | UBERON:0005409 | alimentary part of gastrointestinal system |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/benign_neoplasm.tsv)
### Cancer
*Cancers are malignant neoplasms arising from a variety of different cell types.
This is a design pattern for classes representing cancers based on their location. This may be the site of origin, but it can also represent a secondary site for metastatized cancer.
We use the generic 'disease has location' relation, which generalized over primary and secondary sites.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/cancer.yaml |
| Name | cancer |
| Classes | MONDO:0004992, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/cancer.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label        | location                                      | location:label           |
|:---------------------------------------------|:---------------------------|:----------------------------------------------|:-------------------------|
| MONDO:0000954 | Meckel diverticulum cancer | UBERON:0003705 | Meckel's diverticulum    |
| MONDO:0004685 | Waldeyer's ring cancer     | UBERON:0001735 | tonsillar ring           |
| MONDO:0002817 | adrenal gland cancer       | UBERON:0002369 | adrenal gland            |
| MONDO:0003606 | adrenal medulla cancer     | UBERON:0001236 | adrenal medulla          |
| MONDO:0000919 | ampulla of vater cancer    | UBERON:0004913 | hepatopancreatic ampulla |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/cancer.tsv)
### Carcinoma
*Carcinomas are malignant neoplasms arising from epithelial cells.
This is a Design pattern for classes representing carcinomas based on their location. This may be the site of origin, but it can also represent a secondary site for metastatized cancer.
We use the generic 'disease has location' relation, which generalized over primary and secondary sites.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/carcinoma.yaml |
| Name | carcinoma |
| Classes | MONDO:0004993, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/carcinoma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label       | location                                      | location:label      |
|:---------------------------------------------|:--------------------------|:----------------------------------------------|:--------------------|
| MONDO:0003975 | Littre gland carcinoma    | UBERON:0010186 | male urethral gland |
| MONDO:0004965 | acinar cell carcinoma     | CL:0000622     | acinar cell         |
| MONDO:0002814 | adrenal carcinoma         | UBERON:0002369 | adrenal gland       |
| MONDO:0006639 | adrenal cortex carcinoma  | UBERON:0001235 | adrenal cortex      |
| MONDO:0004202 | adrenal medulla carcinoma | UBERON:0001236 | adrenal medulla     |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/carcinoma.tsv)
### Carcinoma in situ
*This is a Design pattern for classes representing in situ carcinomas based on their location.
Examples: [breast carcinoma in situ](http://purl.obolibrary.org/obo/MONDO_0004658), [liver carcinoma in situ](http://purl.obolibrary.org/obo/MONDO_0004715)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/carcinoma_in_situ.yaml |
| Name | carcinoma_in_situ |
| Classes | MONDO:0004647, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/carcinoma_in_situ.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label          | location                                      | location:label   |
|:---------------------------------------------|:-----------------------------|:----------------------------------------------|:-----------------|
| MONDO:0004707 | anal canal carcinoma in situ | UBERON:0000159 | anal canal       |
| MONDO:0000374 | bile duct carcinoma in situ  | UBERON:0002394 | bile duct        |
| MONDO:0004703 | bladder carcinoma in situ    | UBERON:0001255 | urinary bladder  |
| MONDO:0004658 | breast carcinoma in situ     | UBERON:0000310 | breast           |
| MONDO:0000375 | bronchus carcinoma in situ   | UBERON:0002185 | bronchus         |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/carcinoma_in_situ.tsv)
### Childhood
*An instance of a disease that has an onset of signs or symptoms of disease between the age of 1 to 5 years (childhood onset).
Examples: [childhood astrocytic tumor](http://purl.obolibrary.org/obo/MONDO_0002505), [childhood malignant melanoma](http://purl.obolibrary.org/obo/MONDO_0042494)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/childhood.yaml |
| Name | childhood |
| Classes | HP:0011463, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/childhood.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                       | disease                                      | disease:label                  |
|:---------------------------------------------|:------------------------------------------|:---------------------------------------------|:-------------------------------|
| MONDO:0016241 | alternating hemiplegia of childhood       | MONDO:0016210 | alternating hemiplegia         |
| MONDO:0016114 | bulbospinal muscular atrophy of childhood | MONDO:0016113 | bulbospinal muscular atrophy   |
| MONDO:0000870 | childhood acute lymphoblastic leukemia    | MONDO:0004967 | acute lymphoblastic leukemia   |
| MONDO:0004996 | childhood acute myeloid leukemia          | MONDO:0018874 | acute myeloid leukemia         |
| MONDO:0044767 | childhood adrenal gland pheochromocytoma  | MONDO:0004974 | adrenal gland pheochromocytoma |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/childhood.tsv)
### Chronic
*This pattern is applied to diseases that are described as having an chronic duration, i.e. a disease having a slow progressive course of indefinite duration.
Examples: [chronic bronchitis](http://purl.obolibrary.org/obo/MONDO_0005607), [chronic hepatitis B virus infection](http://purl.obolibrary.org/obo/MONDO_0005366)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/chronic.yaml |
| Name | chronic |
| Classes | PATO:0001863, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/chronic.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                           | disease                                      | disease:label                  |
|:---------------------------------------------|:----------------------------------------------|:---------------------------------------------|:-------------------------------|
| MONDO:0016169 | chronic acquired demyelinating polyneuropathy | MONDO:0015923 | acquired peripheral neuropathy |
| MONDO:0001251 | chronic apical periodontitis                  | MONDO:0004508 | periapical periodontitis       |
| MONDO:0005607 | chronic bronchitis                            | MONDO:0003781 | bronchitis                     |
| MONDO:0004924 | chronic canaliculitis                         | MONDO:0005631 | actinomycosis                  |
| MONDO:0002030 | chronic cervicitis                            | MONDO:0002345 | cervicitis                     |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/chronic.tsv)
### Congenital
*An instance of a disease in which the disease is present at birth, regardless of cause.
Examples: [congenital agammaglobulinemia](http://purl.obolibrary.org/obo/MONDO_0001902), [congenital nystagmus](http://purl.obolibrary.org/obo/MONDO_0005712)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/congenital.yaml |
| Name | congenital |
| Classes | MONDO:0021140, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/congenital.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label               | disease                                      | disease:label                  |
|:---------------------------------------------|:----------------------------------|:---------------------------------------------|:-------------------------------|
| MONDO:0001902 | congenital agammaglobulinemia     | MONDO:0015977 | agammaglobulinemia             |
| MONDO:0000577 | congenital anemia                 | MONDO:0002280 | anemia                         |
| MONDO:0017375 | congenital enterovirus infection  | MONDO:0005747 | enterovirus infectious disease |
| MONDO:0004527 | congenital granular cell tumor    | MONDO:0006235 | granular cell tumor            |
| MONDO:0009332 | congenital hematological disorder | MONDO:0005570 | hematologic disease            |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/congenital.tsv)
### Consequence of infectious disease
*This pattern is applied to a disease that is caused by an infectious agent.
Examples: [hepatitis C induced liver cirrhosis](http://purl.obolibrary.org/obo/MONDO_0005448), [rubella encephalitis](http://purl.obolibrary.org/obo/MONDO_0020648)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/consequence_of_infectious_disease.yaml |
| Name | consequence_of_infectious_disease |
| Classes | MONDO:0000001, MONDO:0005550,  |
| Variables | parent (MONDO:0000001), cause (MONDO:0005550),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/consequence_of_infectious_disease.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                         | cause                                        | cause:label                   | parent                                       | parent:label              |
|:---------------------------------------------|:--------------------------------------------|:---------------------------------------------|:------------------------------|:---------------------------------------------|:--------------------------|
| MONDO:0020689 | AIDS dementia complex                       | MONDO:0005109 | HIV infectious disease        | MONDO:0001627 | dementia                  |
| MONDO:0005491 | Chagas cardiomyopathy                       | MONDO:0001444 | Chagas disease                | MONDO:0004994 | cardiomyopathy            |
| MONDO:0000890 | Zika virus congenital syndrome              | MONDO:0018661 | Zika virus infectious disease | MONDO:0000839 | congenital abnormality    |
| MONDO:0005448 | hepatitis C induced liver cirrhosis         | MONDO:0005231 | hepatitis C virus infection   | MONDO:0005155 | cirrhosis of liver        |
| MONDO:0034103 | infection-related hemolytic uremic syndrome | MONDO:0005550 | infectious disease            | MONDO:0001549 | hemolytic-uremic syndrome |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/consequence_of_infectious_disease.tsv)
### Dependence on substance
*Dependence on a substance that specifies the environmental stimulus such as alcohol, cocaine, etc. Example: [dependence on cocaine](http://purl.obolibrary.org/obo/MONDO_0005186).*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/dependence_on_substance.yaml |
| Name | dependence_on_substance |
| Classes | MONDO:0004938, CHEBI:24431,  |
| Variables | stimulus (CHEBI:24431),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432), [0000-0002-7463-6306](https://orcid.org/0000-0002-7463-6306),  |
| Examples |  |

### Disease by dysfunctional structure
*Diseases classified by a perturbation in an anatomical structure (such as a subcellular component, or an organ)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/disease_by_dysfunctional_structure.yaml |
| Name | disease_by_dysfunctional_structure |
| Classes | MONDO:0000001, UBERON:0000061,  |
| Variables | structure (UBERON:0000061),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/disease_by_dysfunctional_structure.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label             | structure                                     | structure:label       |
|:---------------------------------------------|:--------------------------------|:----------------------------------------------|:----------------------|
| MONDO:0004880 | bowel dysfunction               | UBERON:0004907 | lower digestive tract |
| MONDO:0001343 | impaired renal function disease | UBERON:0002113 | kidney                |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/disease_by_dysfunctional_structure.tsv)
### Disease series by gene
*This pattern is for diseases that are caused by a single variation or mutation in a single gene, that have gene-based names, such as new disease terms that are requested by ClinGen, like MED12-related intellectual disability syndrome.  Examples: [MED12-related intellectual disability syndrome](http://purl.obolibrary.org/obo/MONDO_0100000), [TTN-related myopathy](http://purl.obolibrary.org/obo/MONDO_0100175), [MYPN-related myopathy](http://purl.obolibrary.org/obo/MONDO_0015023)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/disease_series_by_gene.yaml |
| Name | disease_series_by_gene |
| Classes | MONDO:0000001, SO:0001217,  |
| Variables | disease (MONDO:0000001), gene (SO:0001217),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples |  |

### Disease series by gene and inheritance
*This pattern is for diseases that are caused by a single mutation in a single gene, that have gene-based names, and are inherited by a specific mechanism, succh as autosomal dominant and autosomal recessive. 
Examples: [Growth hormone insensitivity syndrome with immune dysregulation](https://omim.org/phenotypicSeries/PS245590), Growth hormone insensitivity with immune dysregulation 1, autosomal recessive and Growth hormone insensitivity with immune dysregulation 2, autosomal dominant*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/disease_series_by_gene.yaml |
| Name | disease_series_by_gene_and_inheritance |
| Classes | MONDO:0000001, SO:0000704, HP:0000005,  |
| Variables | disease (MONDO:0000001), gene (SO:0000704), mode_of_inheritance (HP:0000005),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432), [0000-0002-7356-1779](https://orcid.org/0000-0002-7356-1779),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/disease_series_by_gene_and_inheritance.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                            | disease                                      | disease:label           | gene                              | gene:label   | mode:of:inheritance                       | mode:of:inheritance:label       |
|:---------------------------------------------|:-----------------------------------------------|:---------------------------------------------|:------------------------|:----------------------------------|:-------------|:------------------------------------------|:--------------------------------|
| MONDO:0007818 | Hyper-IgE recurrent infection syndrome 1       | MONDO:0018037 | hyper-IgE syndrome      | http://identifiers.org/hgnc/11364 | STAT3        | HP:0000006 | Autosomal dominant inheritance  |
| MONDO:0100121 | SCN4A-related myopathy, autosomal recessive    | MONDO:0019952 | congenital myopathy     | http://identifiers.org/hgnc/10591 | SCN4A        | HP:0000007 | Autosomal recessive inheritance |
| MONDO:0010338 | X-linked distal spinal muscular atrophy type 3 | MONDO:0001516 | spinal muscular atrophy | http://identifiers.org/hgnc/869   | ATP7A        | HP:0001417 | X-linked inheritance            |
| MONDO:0020721 | X-linked sideroblastic anemia 1                | MONDO:0015194 | sideroblastic anemia    | http://identifiers.org/hgnc/397   | ALAS2        | HP:0001417 | X-linked inheritance            |
| MONDO:0007092 | amelogenesis imperfecta type 1B                | MONDO:0019507 | amelogenesis imperfecta | http://identifiers.org/hgnc/3344  | ENAM         | HP:0000006 | Autosomal dominant inheritance  |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/disease_series_by_gene_and_inheritance.tsv)
### Disrupts process
*A disease that disrupts a process, like immune system function, or early development.
Examples: [type III hypersensitivity disease](http://purl.obolibrary.org/obo/MONDO_0007004), [type IV hypersensitivity disease](http://purl.obolibrary.org/obo/MONDO_0002459), [neural tube closure defect](http://purl.obolibrary.org/obo/MONDO_0017059) (55 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/disrupts_process.yaml |
| Name | disease or disorder disease caused by disruption of X |
| Classes | MONDO:0000001, owl:Thing,  |
| Variables | process (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/disrupts_process.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label     | process                                   | process:label                                         |
|:---------------------------------------------|:------------------------|:------------------------------------------|:------------------------------------------------------|
| MONDO:0012996 | AGAT deficiency         | GO:0015068 | glycine amidinotransferase activity                   |
| MONDO:0021190 | DNA repair disease      | GO:0006281 | DNA repair                                            |
| MONDO:0018274 | GM3 synthase deficiency | GO:0047291 | lactosylceramide alpha-2,3-sialyltransferase activity |
| MONDO:0021060 | RASopathy               | GO:0007265 | Ras protein signal transduction                       |
| MONDO:0005271 | allergic disease        | GO:0016068 | type I hypersensitivity                               |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/disrupts_process.tsv)
### Environmental stimulus
*A disease that is caused by exposure to an environmental stimulus, like the sun or pesticides.  Examples: [carbon monoxide-induced parkinsonism](http://purl.obolibrary.org/obo/MONDO_0017639), [cocaine intoxication](http://purl.obolibrary.org/obo/MONDO_0019544)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/environmental_stimulus.yaml |
| Name | environmental_stimulus |
| Classes | MONDO:0000001, BFO:0000040,  |
| Variables | disease (MONDO:0000001), stimulus (BFO:0000040),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/environmental_stimulus.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label   | disease                                      | disease:label                 | stimulus                                     | stimulus:label   |
|:---------------------------------------------|:----------------------|:---------------------------------------------|:------------------------------|:---------------------------------------------|:-----------------|
| MONDO:0003969 | amphetamine abuse     | MONDO:0002491 | substance abuse               | CHEBI:2679    | amphetamine      |
| MONDO:0006654 | anthracosis           | MONDO:0015926 | pneumoconiosis                | ENVO:02000099 | coal dust        |
| MONDO:0016466 | asbestosis            | MONDO:0015926 | pneumoconiosis                | ENVO:02000106 | asbestos dust    |
| MONDO:0001540 | bagassosis            | MONDO:0004553 | extrinsic allergic alveolitis | ENVO:00002872 | bagasse          |
| MONDO:0004599 | barbiturate abuse     | MONDO:0002491 | substance abuse               | CHEBI:29745   | barbiturate      |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/environmental_stimulus.tsv)
### Hemangioma
*A hemangioma (a benign vascular lesion characterized by the formation of capillary-sized or cavernous vascular channels) that is located in a specific anatomical site.
Examples: [skin hemangioma](http://purl.obolibrary.org/obo/MONDO_0003110), [breast hemangioma](http://purl.obolibrary.org/obo/MONDO_0003126), [gastric hemangioma](http://purl.obolibrary.org/obo/MONDO_0002414) (20 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/hemangioma.yaml |
| Name | hemangioma disease has location X |
| Classes | MONDO:0006500, UBERON:0001062,  |
| Variables | location (UBERON:0001062),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/hemangioma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label               | location                                      | location:label         |
|:---------------------------------------------|:----------------------------------|:----------------------------------------------|:-----------------------|
| MONDO:0003126 | breast hemangioma                 | UBERON:0000310 | breast                 |
| MONDO:0003241 | central nervous system hemangioma | UBERON:0001017 | central nervous system |
| MONDO:0003948 | cerebral hemangioma               | UBERON:0001893 | telencephalon          |
| MONDO:0002414 | gastric hemangioma                | UBERON:0000945 | stomach                |
| MONDO:0021542 | hemangioma of choroid             | UBERON:0001776 | optic choroid          |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/hemangioma.tsv)
### Hereditary
*Pattern for extending a etiology-generic disease class to a hereditary form.  Here hereditary means that etiology is largely genetic, and that the disease is passed down or potentially able to be passed down via inheritance (i.e is germline).*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/hereditary.yaml |
| Name | hereditary |
| Classes | MONDO:0021152, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/hereditary.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                                         | disease                                      | disease:label                             |
|:---------------------------------------------|:------------------------------------------------------------|:---------------------------------------------|:------------------------------------------|
| MONDO:0003847 | Mendelian disease                                           | MONDO:0000001 | disease or disorder                       |
| MONDO:0007573 | acute erythroleukemia, familial                             | MONDO:0017858 | acute erythroid leukemia                  |
| MONDO:0008734 | adrenocortical carcinoma, hereditary                        | MONDO:0006639 | adrenal cortex carcinoma                  |
| MONDO:0016072 | anomaly of puberty or/and menstrual cycle of genetic origin | MONDO:0015860 | anomaly of puberty or/and menstrual cycle |
| MONDO:0018384 | avascular necrosis of genetic origin                        | MONDO:0018373 | avascular necrosis                        |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/hereditary.tsv)
### Idiopathic
*This pattern is applied to diseases that are described as being idiopathic, i.e. having an uncertain or unknown cause.
Examples: [idiopathic aplastic anemia](http://purl.obolibrary.org/obo/MONDO_0012197), [idiopathic avascular necrosis](http://purl.obolibrary.org/obo/MONDO_0018380)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/idiopathic.yaml |
| Name | idiopathic |
| Classes | MONDO:0700005, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-4142-7153](https://orcid.org/0000-0002-4142-7153),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/idiopathic.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                  | disease                                      | disease:label             |
|:---------------------------------------------|:-------------------------------------|:---------------------------------------------|:--------------------------|
| MONDO:0005579 | epilepsy, idiopathic generalized     | MONDO:0005027 | epilepsy                  |
| MONDO:0015344 | idiopathic acute transverse myelitis | MONDO:0015342 | acute transverse myelitis |
| MONDO:0100054 | idiopathic anaphylaxis               | MONDO:0100053 | anaphylaxis               |
| MONDO:0017256 | idiopathic anterior uveitis          | MONDO:0006651 | anterior uveitis          |
| MONDO:0005110 | idiopathic cardiomyopathy            | MONDO:0004994 | cardiomyopathy            |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/idiopathic.tsv)
### Inborn metabolic
*An acquired metabolic disease that causes disruption of a process.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/inborn_metabolic.yaml |
| Name | inborn_metabolic |
| Classes | MONDO:0019052, BFO:0000015,  |
| Variables | process (BFO:0000015),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/inborn_metabolic.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                  | process                                   | process:label                                                                                                 |
|:---------------------------------------------|:-------------------------------------|:------------------------------------------|:--------------------------------------------------------------------------------------------------------------|
| MONDO:0009825 | 5-oxoprolinase deficiency            | GO:0017168 | 5-oxoprolinase (ATP-hydrolyzing) activity                                                                     |
| MONDO:0005775 | G6PD deficiency                      | GO:0004345 | glucose-6-phosphate dehydrogenase activity                                                                    |
| MONDO:0007068 | adenylosuccinate lyase deficiency    | GO:0070626 | (S)-2-(5-amino-1-(5-phospho-D-ribosyl)imidazole-4-carboxamido)succinate AMP-lyase (fumarate-forming) activity |
| MONDO:0009665 | biotinidase deficiency               | GO:0047708 | biotinidase activity                                                                                          |
| MONDO:0015286 | congenital disorder of glycosylation | GO:0070085 | glycosylation                                                                                                 |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/inborn_metabolic.tsv)
### Inborn metabolic disrupts
*This pattern is used for inborn errors of metabolism that cause disruption of a specific biological process, such as enzyme activity or ion transport. 
Examples: ['5-oxoprolinase deficiency (disease)'](http://purl.obolibrary.org/obo/MONDO_0009825), [inborn disorder of methionine cycle and sulfur amino acid metabolism](http://purl.obolibrary.org/obo/MONDO_0019222), [inborn aminoacylase deficiency](http://purl.obolibrary.org/obo/MONDO_0017686) (51 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/inborn_metabolic_disrupts.yaml |
| Name | inborn errors of metabolism disease caused by disruption of X |
| Classes | MONDO:0019052, owl:Thing,  |
| Variables | process (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/inborn_metabolic_disrupts.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                  | process                                   | process:label                                                                                                 |
|:---------------------------------------------|:-------------------------------------|:------------------------------------------|:--------------------------------------------------------------------------------------------------------------|
| MONDO:0009825 | 5-oxoprolinase deficiency            | GO:0017168 | 5-oxoprolinase (ATP-hydrolyzing) activity                                                                     |
| MONDO:0005775 | G6PD deficiency                      | GO:0004345 | glucose-6-phosphate dehydrogenase activity                                                                    |
| MONDO:0007068 | adenylosuccinate lyase deficiency    | GO:0070626 | (S)-2-(5-amino-1-(5-phospho-D-ribosyl)imidazole-4-carboxamido)succinate AMP-lyase (fumarate-forming) activity |
| MONDO:0009665 | biotinidase deficiency               | GO:0047708 | biotinidase activity                                                                                          |
| MONDO:0015286 | congenital disorder of glycosylation | GO:0070085 | glycosylation                                                                                                 |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/inborn_metabolic_disrupts.tsv)
### Infantile
*An instance of a disease that has an onset of signs or symptoms of disease within the first 12 months of life (infantile onset).
Examples: [infant botulism](http://purl.obolibrary.org/obo/MONDO_0015804), [infantile glycine encephalopathy](http://purl.obolibrary.org/obo/MONDO_0017354)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/infantile.yaml |
| Name | infantile |
| Classes | HP:0003593, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/infantile.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label         | disease                                      | disease:label         |
|:---------------------------------------------|:----------------------------|:---------------------------------------------|:----------------------|
| MONDO:0000212 | hypercalcemia, infantile    | MONDO:0001566 | hypercalcemia disease |
| MONDO:0015804 | infant botulism             | MONDO:0005498 | botulism              |
| MONDO:0016089 | infantile Krabbe disease    | MONDO:0009499 | Krabbe disease        |
| MONDO:0043555 | infantile diarrhea          | MONDO:0001673 | diarrheal disease     |
| MONDO:0020071 | infantile epilepsy syndrome | MONDO:0015650 | epilepsy syndrome     |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/infantile.tsv)
### Infectious disease by agent
*Infectious diseases can be classified by the infectioos agent, such as bacteria, coronavirus, etc, that causes the disease.
Examples: [COVID-19](http://purl.obolibrary.org/obo/MONDO_0100096), [cholera](http://purl.obolibrary.org/obo/MONDO_0015766)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/infectious_disease_by_agent.yaml |
| Name | infectious_disease_by_agent |
| Classes | MONDO:0000001, NCBITaxon:1, MONDO:0005550,  |
| Variables | agent (NCBITaxon:1),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/infectious_disease_by_agent.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                     | agent                                         | agent:label          |
|:---------------------------------------------|:----------------------------------------|:----------------------------------------------|:---------------------|
| MONDO:0021747 | Acanthamoeba infectious disease         | NCBITaxon:5754 | Acanthamoeba         |
| MONDO:0006635 | Acinetobacter infectious disease        | NCBITaxon:469  | Acinetobacter        |
| MONDO:0006636 | Actinobacillus infectious disease       | NCBITaxon:713  | Actinobacillus       |
| MONDO:0006921 | Actinomycetales infectious disease      | NCBITaxon:2037 | Actinomycetales      |
| MONDO:0005117 | Aeromonas hydrophila infectious disease | NCBITaxon:644  | Aeromonas hydrophila |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/infectious_disease_by_agent.tsv)
### Infectious inflammation
*This combines the [infectious disease by agent pattern](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/infectious_disease_by_agent.yaml) and the [inflammatory disease by site](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/inflammatory_disease_by_site.yaml) pattern.
Examples: [bacterial endocarditis (disease)](http://purl.obolibrary.org/obo/MONDO_0006669), [fungal gastritis](http://purl.obolibrary.org/obo/MONDO_0002843)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/infectious_inflammation.yaml |
| Name | infectious_inflammation |
| Classes | MONDO:0000001, NCBITaxon:1, UBERON:0000061, MONDO:0005550,  |
| Variables | location (UBERON:0000061), agent (NCBITaxon:1),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples |  |

### Inflammatory disease by site
*Inflammatory diseases can be classified by the location in which the pathological inflammatory process occurs.
For inflammatory diseases caused by infection, this may be the site of infection.
Examples: ['Achilles bursitis'](http://purl.obolibrary.org/obo/MONDO_0001594), [blepharitis](http://purl.obolibrary.org/obo/MONDO_0004785), [epiglottitis](http://purl.obolibrary.org/obo/MONDO_0005753)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/inflammatory_disease_by_site.yaml |
| Name | inflammatory_disease_by_site |
| Classes | MONDO:0000001, UBERON:0000061,  |
| Variables | location (UBERON:0000061),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/inflammatory_disease_by_site.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label   | location                                      | location:label        |
|:---------------------------------------------|:----------------------|:----------------------------------------------|:----------------------|
| MONDO:0004551 | Meckel diverticulitis | UBERON:0003705 | Meckel's diverticulum |
| MONDO:0019838 | adenohypophysitis     | UBERON:0002196 | adenohypophysis       |
| MONDO:0000261 | adenoiditis           | UBERON:0001732 | pharyngeal tonsil     |
| MONDO:0020710 | amnionitis            | UBERON:0000305 | amnion                |
| MONDO:0006656 | aortitis              | UBERON:0000947 | aorta                 |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/inflammatory_disease_by_site.tsv)
### Inherited susceptibility
*This pattern should be used for children of MONDO_0020573'inherited disease susceptibility', including OMIM phenotypic series (OMIMPS) for which the subclasses are susceptibilities. Note, this pattern should not have an asserted causative gene as logical axiom (and no single causative gene in text definition), in those cases, the susceptibility_by_gene pattern should be used instead. The children should have asserted causative genes in the text definitions and in the logical axioms. This pattern is a superclass of the susceptibility_by_gene pattern.
Examples: ['microvascular complications of diabetes, susceptibility'](http://purl.obolibrary.org/obo/MONDO_0000065), ['epilepsy, idiopathic generalized'](http://purl.obolibrary.org/obo/MONDO_0005579), ['aspergillosis, susceptibility to'](http://purl.obolibrary.org/obo/MONDO_0013562).*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/inherited_susceptibility.yaml |
| Name | inherited_susceptibility |
| Classes | MONDO:0000001, MONDO:0020573,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/inherited_susceptibility.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                           | disease                                      | disease:label                          |
|:---------------------------------------------|:----------------------------------------------|:---------------------------------------------|:---------------------------------------|
| MONDO:0014707 | 14q32 duplication syndrome                    | MONDO:0020076 | myeloproliferative neoplasm            |
| MONDO:0007845 | Kaposi sarcoma, susceptibility to             | MONDO:0005055 | Kaposi's sarcoma                       |
| MONDO:0000093 | Schistosoma mansoni infection, susceptibility | MONDO:0044345 | Schistosoma mansoni infectious disease |
| MONDO:0013562 | aspergillosis, susceptibility to              | MONDO:0005657 | aspergillosis                          |
| MONDO:0020836 | autism, susceptiblity to                      | MONDO:0005260 | autism                                 |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/inherited_susceptibility.tsv)
### Isolated
*Some diseases exist in both isolated and syndromic forms. For example, aniridia ([MONDO_0019172 aniridia](http://purl.obolibrary.org/obo/MONDO_0019172), [MONDO_0020148'syndromic aniridia'](http://purl.obolibrary.org/obo/MONDO_0020148) and [MONDO_0007119 'isolated aniridia'](http://purl.obolibrary.org/obo/MONDO_0007119). Use this pattern to define the isolated form of a disease when a term exists for the isolated/syndromic-neutral version. In general, this pattern should be used in parallel with syndromic. E.g. if you make a term 'syndromic disease, you should also have 'isolated disease' [see pattern here(https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/syndromic.yaml).  Note that the isolated and syndromic forms will be inferred to be disjoint due to the GCI pattern.
Examples: ['isolated aniridia'](http://purl.obolibrary.org/obo/MONDO_0007119), ['isolated dystonia'](http://purl.obolibrary.org/obo/MONDO_0015494), ['isolated focal palmoplantar keratoderma'](http://purl.obolibrary.org/obo/MONDO_0017673)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/isolated.yaml |
| Name | isolated |
| Classes | MONDO:0021128, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/isolated.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                                          | disease                                      | disease:label                                   |
|:---------------------------------------------|:-------------------------------------------------------------|:---------------------------------------------|:------------------------------------------------|
| MONDO:0016342 | familial isolated arrhythmogenic right ventricular dysplasia | MONDO:0016587 | arrhythmogenic right ventricular cardiomyopathy |
| MONDO:0020075 | genetic non-syndromic obesity                                | MONDO:0019182 | monogenic obesity                               |
| MONDO:0017262 | inherited non-syndromic ichthyosis                           | MONDO:0015947 | inherited ichthyosis                            |
| MONDO:0016520 | isolated Klippel-Feil syndrome                               | MONDO:0001029 | Klippel-Feil syndrome                           |
| MONDO:0016462 | isolated agammaglobulinemia                                  | MONDO:0015977 | agammaglobulinemia                              |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/isolated.tsv)
### Juvenile
*An instance of a disease that has an onset of signs or symptoms of disease between the age of 5 and 15 years (juvenile onset).
Examples: [juvenile-onset Parkinson disease](http://purl.obolibrary.org/obo/MONDO_0000828), ['juvenile idiopathic scoliosis'](http://purl.obolibrary.org/obo/MONDO_0100076)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/juvenile.yaml |
| Name | juvenile |
| Classes | HP:0003621, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/juvenile.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                     | disease                                      | disease:label            |
|:---------------------------------------------|:----------------------------------------|:---------------------------------------------|:-------------------------|
| MONDO:0020655 | juvenile ankylosing spondylitis         | MONDO:0005306 | ankylosing spondylitis   |
| MONDO:0003955 | juvenile breast papillomatosis          | MONDO:0002063 | breast papillomatosis    |
| MONDO:0100076 | juvenile idiopathic scoliosis           | MONDO:0000726 | idiopathic scoliosis     |
| MONDO:0009066 | juvenile nephropathic cystinosis        | MONDO:0100151 | nephropathic cystinosis  |
| MONDO:0100037 | juvenile onset pityriasis rubra pilaris | MONDO:0100017 | pityriasis rubra pilaris |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/juvenile.tsv)
### Leiomyoma
*A leiomyoma (a well-circumscribed benign smooth muscle neoplasm characterized by the presence of spindle cells with cigar-shaped nuclei, interlacing fascicles, and a whorled pattern) that is located in a specific anatomical entity.
Examples: [leiomyoma cutis](http://purl.obolibrary.org/obo/MONDO_0003291), [ureter leiomyoma](http://purl.obolibrary.org/obo/MONDO_0001399), [urethra leiomyoma](http://purl.obolibrary.org/obo/MONDO_0002222) (30 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/leiomyoma.yaml |
| Name | leiomyoma disease has location X |
| Classes | MONDO:0001572, UBERON:0001062,  |
| Variables | location (UBERON:0001062),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/leiomyoma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label              | location                                      | location:label         |
|:---------------------------------------------|:---------------------------------|:----------------------------------------------|:-----------------------|
| MONDO:0003292 | anus leiomyoma                   | UBERON:0001245 | anus                   |
| MONDO:0003300 | appendix leiomyoma               | UBERON:0001154 | vermiform appendix     |
| MONDO:0001634 | bladder leiomyoma                | UBERON:0001255 | urinary bladder        |
| MONDO:0002057 | breast leiomyoma                 | UBERON:0000310 | breast                 |
| MONDO:0003287 | central nervous system leiomyoma | UBERON:0001017 | central nervous system |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/leiomyoma.tsv)
### Leiomyosarcoma
*An uncommon, aggressive malignant smooth muscle neoplasm, usually occurring in post-menopausal women that is characterized by a proliferation of neoplastic spindle cells that is located in a specific anatomical location.
Examples: [leiomyosarcoma of the cervix uteri](http://purl.obolibrary.org/obo/MONDO_0016283), [cutaneous leiomyosarcoma (disease)](http://purl.obolibrary.org/obo/MONDO_0003362), [breast leiomyosarcoma](http://purl.obolibrary.org/obo/MONDO_0003371) (29 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/leiomyosarcoma.yaml |
| Name | leiomyosarcoma disease has location X |
| Classes | MONDO:0005058, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/leiomyosarcoma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                   | location                                      | location:label         |
|:---------------------------------------------|:--------------------------------------|:----------------------------------------------|:-----------------------|
| MONDO:0003358 | anus leiomyosarcoma                   | UBERON:0001245 | anus                   |
| MONDO:0002624 | bone leiomyosarcoma                   | UBERON:0002481 | bone tissue            |
| MONDO:0003371 | breast leiomyosarcoma                 | UBERON:0000310 | breast                 |
| MONDO:0003349 | central nervous system leiomyosarcoma | UBERON:0001017 | central nervous system |
| MONDO:0003351 | colon leiomyosarcoma                  | UBERON:0001155 | colon                  |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/leiomyosarcoma.tsv)
### Lipoma
*A benign, usually painless, well-circumscribed lipomatous tumor composed of adipose tissue that is located in a specific anatomical location.
Examples: [skin lipoma](http://purl.obolibrary.org/obo/MONDO_0000964), [colorectal lipoma](http://purl.obolibrary.org/obo/MONDO_0003885), [tendon sheath lipoma](http://purl.obolibrary.org/obo/MONDO_0004076) (28 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/lipoma.yaml |
| Name | lipoma disease has location X |
| Classes | MONDO:0005106, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/lipoma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label           | location                                      | location:label         |
|:---------------------------------------------|:------------------------------|:----------------------------------------------|:-----------------------|
| MONDO:0000974 | axillary lipoma               | UBERON:0009472 | axilla                 |
| MONDO:0000970 | breast lipoma                 | UBERON:0000310 | breast                 |
| MONDO:0003844 | central nervous system lipoma | UBERON:0001017 | central nervous system |
| MONDO:0003843 | cerebral hemisphere lipoma    | UBERON:0001869 | cerebral hemisphere    |
| MONDO:0000971 | chest wall lipoma             | UBERON:0016435 | chest wall             |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/lipoma.tsv)
### Location
*A disease that is located in a specific anatomical site.
Examples: ['abdominal cystic lymphangioma'](http://purl.obolibrary.org/obo/MONDO_0021726), ['articular cartilage disease'](http://purl.obolibrary.org/obo/MONDO_0003816), ['urethral disease'](http://purl.obolibrary.org/obo/MONDO_0004184)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/location.yaml |
| Name | location |
| Classes | MONDO:0000001, UBERON:0001062, CL:0000000,  |
| Variables | disease (MONDO:0000001), location,  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/location.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                  | disease                                      | disease:label        | location                                      | location:label         |
|:---------------------------------------------|:-------------------------------------|:---------------------------------------------|:---------------------|:----------------------------------------------|:-----------------------|
| MONDO:0003909 | Bartholin gland adenomyoma           | MONDO:0005635 | adenomyoma           | UBERON:0000460 | major vestibular gland |
| MONDO:0004120 | Bartholin gland small cell carcinoma | MONDO:0000402 | small cell carcinoma | UBERON:0000460 | major vestibular gland |
| MONDO:0005665 | Bell's palsy                         | MONDO:0006496 | palsy                | UBERON:0001647 | facial nerve           |
| MONDO:0024283 | Demodex folliculitis                 | MONDO:0017280 | demodicidosis        | UBERON:0002073 | hair follicle          |
| MONDO:0018675 | IgG4-related ophthalmic disease      | MONDO:0017287 | IgG4-related disease | UBERON:0000970 | eye                    |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/location.tsv)
### Location top
*TBD.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/location_top.yaml |
| Name | location_top |
| Classes | MONDO:0000001, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/location_top.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                  | location                                      | location:label             |
|:---------------------------------------------|:-------------------------------------|:----------------------------------------------|:---------------------------|
| MONDO:0044965 | abdominal and pelvic region disorder | UBERON:0002417 | abdominal segment of trunk |
| MONDO:0020594 | abducens nerve disease               | UBERON:0001646 | abducens nerve             |
| MONDO:0002636 | accessory nerve disease              | UBERON:0002019 | accessory XI nerve         |
| MONDO:0002816 | adrenal cortex disease               | UBERON:0001235 | adrenal cortex             |
| MONDO:0005495 | adrenal gland disease                | UBERON:0002369 | adrenal gland              |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/location_top.tsv)
### Lymphoma
*A malignant (clonal) proliferation of B- lymphocytes or T- lymphocytes which involves the lymph nodes, bone marrow and/or extranodal sites. This category includes Non-Hodgkin lymphomas and Hodgkin lymphomas.
Examples: [marginal zone lymphoma](http://purl.obolibrary.org/obo/MONDO_0017604), [ureteral lymphoma](http://purl.obolibrary.org/obo/MONDO_0001977), [colorectal lymphoma](http://purl.obolibrary.org/obo/MONDO_0024656) (37 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/lymphoma.yaml |
| Name | lymphoma disease has location X |
| Classes | MONDO:0005062, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/lymphoma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label   | location                                      | location:label                    |
|:---------------------------------------------|:----------------------|:----------------------------------------------|:----------------------------------|
| MONDO:0007650 | MALT lymphoma         | UBERON:0001961 | mucosa-associated lymphoid tissue |
| MONDO:0001888 | anus lymphoma         | UBERON:0001245 | anus                              |
| MONDO:0001237 | appendix lymphoma     | UBERON:0001154 | vermiform appendix                |
| MONDO:0001381 | bladder lymphoma      | UBERON:0001255 | urinary bladder                   |
| MONDO:0003661 | breast lymphoma       | UBERON:0000310 | breast                            |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/lymphoma.tsv)
### Malignant
*This is a design pattern for classes representing malignant neoplasms, extending a generic neoplasm class.
Examples: [malignant carotid body paraganglioma](http://purl.obolibrary.org/obo/MONDO_0004650), [malignant germ cell tumor](http://purl.obolibrary.org/obo/MONDO_0006290)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/malignant.yaml |
| Name | malignant |
| Classes | MONDO:0005070, PATO:0002097, owl:Thing,  |
| Variables | neoplasm (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/malignant.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label           | neoplasm                                     | neoplasm:label               |
|:---------------------------------------------|:------------------------------|:---------------------------------------------|:-----------------------------|
| MONDO:0004992 | cancer                        | MONDO:0005070 | neoplasm                     |
| MONDO:0003113 | extragonadal germ cell cancer | MONDO:0018201 | extragonadal germ cell tumor |
| MONDO:0003252 | granular cell cancer          | MONDO:0006235 | granular cell tumor          |
| MONDO:0000377 | malignant Leydig cell tumor   | MONDO:0006266 | Leydig cell tumor            |
| MONDO:0000378 | malignant Sertoli cell tumor  | MONDO:0002696 | Sertoli cell tumor           |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/malignant.tsv)
### Melanoma
*Melanomas are malignant, usually aggressive tumor composed of atypical, neoplastic melanocytes. This is a design pattern for classes representing melanomas based on their location. This may be the site of origin, but it can also represent a secondary site for metastatized cancer. We use the generic 'disease has location' relation, which generalized over primary and secondary sites.
Examples: [cutaneous melanoma](http://purl.obolibrary.org/obo/MONDO_0005012), [malignant breast melanoma](http://purl.obolibrary.org/obo/MONDO_0002975), [malignant melanoma of the mucosa](http://purl.obolibrary.org/obo/MONDO_0015694) (22 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/melanoma.yaml |
| Name | melanoma disease has location X |
| Classes | MONDO:0005105, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/melanoma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label       | location                                      | location:label   |
|:---------------------------------------------|:--------------------------|:----------------------------------------------|:-----------------|
| MONDO:0006081 | anal melanoma             | UBERON:0001245 | anus             |
| MONDO:0005012 | cutaneous melanoma        | UBERON:0000014 | zone of skin     |
| MONDO:0045070 | digestive system melanoma | UBERON:0001007 | digestive system |
| MONDO:0001192 | esophageal melanoma       | UBERON:0001043 | esophagus        |
| MONDO:0000928 | eyelid melanoma           | UBERON:0001711 | eyelid           |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/melanoma.tsv)
### Meningioma
*A meningioma is a slow growing tumor attached to the dura mater. This is a design pattern for classes representing meningiomas based on their location. This may be the site of origin, but it can also represent a secondary site for metastatized cancer. We use the generic 'disease has location' relation, which generalized over primary and secondary sites.
Examples: [skin meningioma](http://purl.obolibrary.org/obo/MONDO_0004429), [brain meningioma](http://purl.obolibrary.org/obo/MONDO_0000642), [choroid plexus meningioma](http://purl.obolibrary.org/obo/MONDO_0003053) (26 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/meningioma.yaml |
| Name | meningioma disease has location X |
| Classes | MONDO:0016642, UBERON:0001062,  |
| Variables | location (UBERON:0001062),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/meningioma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label               | location                                      | location:label         |
|:---------------------------------------------|:----------------------------------|:----------------------------------------------|:-----------------------|
| MONDO:0002997 | anterior cranial fossa meningioma | UBERON:0003720 | anterior cranial fossa |
| MONDO:0000642 | brain meningioma                  | UBERON:0000955 | brain                  |
| MONDO:0002996 | cavernous sinus meningioma        | UBERON:0003712 | cavernous sinus        |
| MONDO:0003860 | cerebellopontine angle meningioma | UBERON:0014908 | cerebellopontine angle |
| MONDO:0004422 | cerebral falx meningioma          | UBERON:0006059 | falx cerebri           |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/meningioma.tsv)
### Mitochondrial subtype
*A disease that is classified as a mitochondrial subtype, due to a defect in a mitochondrial gene, such as MONDO:0100134 'mitochondrial complex I deficiency, mitochondrial type'.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/mitochondrial_subtype.yaml |
| Name | mitochondriaal_subtype |
| Classes | SO:0000088, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples |  |

### Mucoepidermoid carcinoma
*Mucoepidermoid carcinomas are carcinomas morphologically characterized the presence of cuboidal mucous cells, goblet-like mucous cells, squamoid cells, cystic changes, and a fibrotic stromal formation.
This is a design pattern for classes representing mucoepidermoid carcinomas based on their location. This may be the site of origin, but it can also represent a secondary site for metastatized cancer.
We use the generic 'disease has location' relation, which generalized over primary and secondary sites.
Examples: [cutaneous mucoepidermoid carcinoma](http://purl.obolibrary.org/obo/MONDO_0003091), [oral cavity mucoepidermoid carcinoma](http://purl.obolibrary.org/obo/MONDO_0044964), [mucoepidermoid breast carcinoma](http://purl.obolibrary.org/obo/MONDO_0003087) (18 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/mucoepidermoid_carcinoma.yaml |
| Name | mucoepidermoid carcinoma disease has location X |
| Classes | MONDO:0003036, UBERON:0001062,  |
| Variables | location (UBERON:0001062),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/mucoepidermoid_carcinoma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                             | location                                      | location:label         |
|:---------------------------------------------|:------------------------------------------------|:----------------------------------------------|:-----------------------|
| MONDO:0000531 | bronchus mucoepidermoid carcinoma               | UBERON:0002185 | bronchus               |
| MONDO:0003091 | cutaneous mucoepidermoid carcinoma              | UBERON:0000014 | zone of skin           |
| MONDO:0003089 | extrahepatic bile duct mucoepidermoid carcinoma | UBERON:0003703 | extrahepatic bile duct |
| MONDO:0006213 | floor of mouth mucoepidermoid carcinoma         | UBERON:0003679 | mouth floor            |
| MONDO:0003092 | lacrimal gland mucoepidermoid carcinoma         | UBERON:0001817 | lacrimal gland         |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/mucoepidermoid_carcinoma.tsv)
### Neoplasm
*Neoplasms are benign or malignant tissue growths resulting from uncontrolled cell proliferation cell types.
This is a design pattern for classes representing neoplasms based on their location. This may be the site of origin, but it can also represent a secondary site for malignant neoplasms that have metastasized.
We use the generic 'disease has location' relation, which generalized over primary and secondary sites.
Note that tumor is typically a synonym for neoplasm, although this can be context dependent. For NETs, NCIT uses the nomenclature 'tumor' to indicate 'well differentiated, low or intermediate grade tumor'. This can also be called carcinoid, see https://www.cancer.org/cancer/gastrointestinal-carcinoid-tumor/about/what-is-gastrointestinal-carcinoid.html We attempt to spell this out in our labels.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/neoplasm.yaml |
| Name | neoplasm |
| Classes | MONDO:0005070, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/neoplasm.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label          | location                                      | location:label         |
|:---------------------------------------------|:-----------------------------|:----------------------------------------------|:-----------------------|
| MONDO:0021114 | Bartholin gland neoplasm     | UBERON:0000460 | major vestibular gland |
| MONDO:0021082 | Meckel diverticulum neoplasm | UBERON:0003705 | Meckel's diverticulum  |
| MONDO:0001884 | abducens nerve neoplasm      | UBERON:0001646 | abducens nerve         |
| MONDO:0036591 | adrenal cortex neoplasm      | UBERON:0001235 | adrenal cortex         |
| MONDO:0021227 | adrenal gland neoplasm       | UBERON:0002369 | adrenal gland          |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/neoplasm.tsv)
### Neoplasm by origin
*TBD.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/neoplasm_by_origin.yaml |
| Name | neoplasm |
| Classes | MONDO:0005070, owl:Thing,  |
| Variables | structure (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/neoplasm_by_origin.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label               | structure                                    | structure:label               |
|:---------------------------------------------|:----------------------------------|:---------------------------------------------|:------------------------------|
| MONDO:0015157 | human herpesvirus 8-related tumor | MONDO:0005187 | human herpesvirus 8 infection |
| MONDO:0017341 | virus associated tumor            | MONDO:0005108 | viral infectious disease      |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/neoplasm_by_origin.tsv)
### Neuroendocrine neoplasm
*Note that tumor is typically a synonym for neoplasm, although this can be context dependent. For neuroendocrine tumors (NETs), NCIT uses the nomenclature 'tumor' to indicate 'well differentiated, low or intermediate grade tumor'. This can also be called carcinoid, see [https://www.cancer.org/cancer/gastrointestinal-carcinoid-tumor/about/what-is-gastrointestinal-carcinoid.html](https://www.cancer.org/cancer/gastrointestinal-carcinoid-tumor/about/what-is-gastrointestinal-carcinoid.html). We attempt to spell this out in our labels.
Examples: [breast neuroendocrine neoplasm](http://purl.obolibrary.org/obo/MONDO_0002485), [digestive system neuroendocrine neoplasm](http://purl.obolibrary.org/obo/MONDO_0024503), [ovarian neuroendocrine neoplasm](http://purl.obolibrary.org/obo/MONDO_0002481)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/neuroendocrine_neoplasm.yaml |
| Name | neoendocrine_neoplasm |
| Classes | MONDO:0019496, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/neuroendocrine_neoplasm.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                | location                                      | location:label     |
|:---------------------------------------------|:-----------------------------------|:----------------------------------------------|:-------------------|
| MONDO:0003504 | anal canal neuroendocrine neoplasm | UBERON:0000159 | anal canal         |
| MONDO:0024501 | appendix neuroendocrine neoplasm   | UBERON:0001154 | vermiform appendix |
| MONDO:0002485 | breast neuroendocrine neoplasm     | UBERON:0000310 | breast             |
| MONDO:0019963 | bronchial endocrine tumor          | UBERON:0002185 | bronchus           |
| MONDO:0002882 | colon neuroendocrine neoplasm      | UBERON:0001155 | colon              |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/neuroendocrine_neoplasm.tsv)
### Neuroendocrine neoplasm grade1
*We follow NCIT in making carcinoid tumor a synonym for neuroendocrine neoplasm G1 (G1 NET).
Examples: [carcinoid tumor (disease)](http://purl.obolibrary.org/obo/MONDO_0005369)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/neuroendocrine_neoplasm_grade1.yaml |
| Name | neoendocrine_neoplasm_grade1 |
| Classes | MONDO:0019496, MONDO:0024491, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/neuroendocrine_neoplasm_grade1.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                     | location                                      | location:label     |
|:---------------------------------------------|:----------------------------------------|:----------------------------------------------|:-------------------|
| MONDO:0006091 | appendix neuroendocrine tumor G1        | UBERON:0001154 | vermiform appendix |
| MONDO:0006093 | ascending colon neuroendocrine tumor G1 | UBERON:0001156 | ascending colon    |
| MONDO:0006126 | cecum neuroendocrine tumor G1           | UBERON:0001153 | caecum             |
| MONDO:0006155 | colon neuroendocrine tumor G1           | UBERON:0001155 | colon              |
| MONDO:0006162 | colorectal neuroendocrine tumor G1      | UBERON:0012652 | colorectum         |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/neuroendocrine_neoplasm_grade1.tsv)
### Nuclear subtype
*A disease that is classified as a nuclear subtype, due to a defect in a nuclear gene, such as MONDO:0009640 'mitochondrial complex I deficiency, nuclear type'.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/nuclear_subtype.yaml |
| Name | nuclear_subtype |
| Classes | SO:0000087, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples |  |

### Poisoning
*A disease that is caused by exposure to an environmental stimulus that causes poisoning.  Examples: [colchicine poisoning](http://purl.obolibrary.org/obo/MONDO_0017859), [cocaine intoxication](http://purl.obolibrary.org/obo/MONDO_0019544)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/poisoning.yaml |
| Name | poisoning |
| Classes | MONDO:0029000, BFO:0000040,  |
| Variables | stimulus (BFO:0000040),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432), [0000-0002-7463-6306](https://orcid.org/0000-0002-7463-6306),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/poisoning.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label       | stimulus                                   | stimulus:label             |
|:---------------------------------------------|:--------------------------|:-------------------------------------------|:---------------------------|
| MONDO:0019544 | cocaine intoxication      | CHEBI:27958 | cocaine                    |
| MONDO:0017859 | colchicine poisoning      | CHEBI:23359 | colchicine                 |
| MONDO:0017863 | digitalis poisoning       | CHEBI:4551  | digoxin                    |
| MONDO:0017861 | ethylene glycol poisoning | CHEBI:30742 | ethylene glycol            |
| MONDO:0017638 | manganese poisoning       | CHEBI:25154 | manganese molecular entity |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/poisoning.tsv)
### Postinfectious disease
*A design pattern for conditions such as post-herpetic neuralgia or postinfectious encephalitis, where the disease is secondary to the initial infection.
TODO: write better guidelines on what constitutes a secondary disease vs primary. * We do not use this pattern for AIDS-HIV for example, instead representing this is using SubClassOf. * We draw a distinction between infectious and postinfectious encepahlitis. * we do not use this pattern for chickenpox, but we do for shingles*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/postinfectious_disease.yaml |
| Name | postinfectious_disease |
| Classes | MONDO:0000001, MONDO:0005550, NCBITaxon:1,  |
| Variables | disease (NCBITaxon:1), feature (MONDO:0005550),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples |  |

### Primary infectious
*Pattern for extending a disease class to a primary infectious form, a characteristic of an infectious disease in which the disease affects an immunologically normal host. Example: MONDO_0000308 'primary systemic mycosis'.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/primary_infectious.yaml |
| Name | primary infectious |
| Classes | MONDO:0045036, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/primary_infectious.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                  | disease                                      | disease:label                |
|:---------------------------------------------|:-------------------------------------|:---------------------------------------------|:-----------------------------|
| MONDO:0000314 | primary bacterial infectious disease | MONDO:0005113 | bacterial infectious disease |
| MONDO:0000308 | primary systemic mycosis             | MONDO:0000256 | systemic mycosis             |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/primary_infectious.tsv)
### Rare
*TBD.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/rare.yaml |
| Name | rare |
| Classes | MONDO:0021136, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples |  |

### Rare genetic
*TBD.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/rare_genetic.yaml |
| Name | rare_genetic |
| Classes | MONDO:0021150, MONDO:0021136, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples |  |

### Realized in response to environmental exposure
*This pattern is used for a disease, where the cause of the disease is an exposure to an environmental stimulus (using ECTO exposure terms). Note that this pattern does not include infectious disease or classes that would include an organism, virus or viroid. Rather it includes exposures to chemicals (includng drugs), or mixtures.
Examples: [chemically-induced disorder](http://purl.obolibrary.org/obo/MONDO_0029001), [alcohol amnestic disorder](http://purl.obolibrary.org/obo/MONDO_0021702), [alcoholic polyneuropathy](http://purl.obolibrary.org/obo/MONDO_0006645) (26 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/realized_in_response_to_evironmental_exposure.yaml |
| Name | disease realized in response to environmental exposure |
| Classes | MONDO:0000001, ExO:0000002,  |
| Variables | disease (MONDO:0000001), exposure (ExO:0000002),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/realized_in_response_to_environmental_exposure.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                        | disease                                      | disease:label                | exposure                                    | exposure:label                  |
|:---------------------------------------------|:-------------------------------------------|:---------------------------------------------|:-----------------------------|:--------------------------------------------|:--------------------------------|
| MONDO:0060781 | Preeyasombat-Varavithya syndrome           | MONDO:0001083 | Fanconi renotubular syndrome | ECTO:9000364 | exposure to tetracycline        |
| MONDO:0003245 | aflatoxin-related hepatocellular carcinoma | MONDO:0007256 | hepatocellular carcinoma     | ECTO:0001108 | exposure to aflatoxin           |
| MONDO:0002046 | alcohol abuse                              | MONDO:0002491 | substance abuse              | ECTO:0001082 | exposure to alcohol consumption |
| MONDO:0021702 | alcohol amnestic disorder                  | MONDO:0001152 | amnestic disorder            | ECTO:0001082 | exposure to alcohol consumption |
| MONDO:0007079 | alcohol dependence                         | MONDO:0004938 | substance dependence         | ECTO:0001082 | exposure to alcohol consumption |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/realized_in_response_to_environmental_exposure.tsv)
### Refractory
*TBD.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/refractory.yaml |
| Name | refractory |
| Classes | HP:0031375, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/refractory.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                                    | disease                                      | disease:label                               |
|:---------------------------------------------|:-------------------------------------------------------|:---------------------------------------------|:--------------------------------------------|
| MONDO:0004110 | refractory hairy cell leukemia                         | MONDO:0018935 | hairy cell leukemia                         |
| MONDO:0004111 | refractory hematologic cancer                          | MONDO:0002334 | hematopoietic and lymphoid system neoplasm  |
| MONDO:0004816 | refractory plasma cell neoplasm                        | MONDO:0004959 | plasma cell neoplasm                        |
| MONDO:0004404 | refractory precursor T-lymphoblastic lymphoma/leukemia | MONDO:0003537 | precursor T-lymphoblastic lymphoma/leukemia |
| MONDO:0004401 | testis refractory cancer                               | MONDO:0003510 | malignant testicular germ cell tumor        |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/refractory.tsv)
### Rhabdomyosarcoma
*This is auto-generated. Add your description here
Examples: [rhabdomyosarcoma of the cervix uteri](http://purl.obolibrary.org/obo/MONDO_0016282), [breast rhabdomyosarcoma](http://purl.obolibrary.org/obo/MONDO_0002859), [testis rhabdomyosarcoma](http://purl.obolibrary.org/obo/MONDO_0002860) (15 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/rhabdomyosarcoma.yaml |
| Name | rhabdomyosarcoma disease has location X |
| Classes | MONDO:0005212, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/rhabdomyosarcoma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                     | location                                      | location:label         |
|:---------------------------------------------|:----------------------------------------|:----------------------------------------------|:-----------------------|
| MONDO:0002864 | anus rhabdomyosarcoma                   | UBERON:0001245 | anus                   |
| MONDO:0002859 | breast rhabdomyosarcoma                 | UBERON:0000310 | breast                 |
| MONDO:0002850 | central nervous system rhabdomyosarcoma | UBERON:0001017 | central nervous system |
| MONDO:0002577 | extrahepatic bile duct rhabdomyosarcoma | UBERON:0003703 | extrahepatic bile duct |
| MONDO:0002856 | gallbladder rhabdomyosarcoma            | UBERON:0002110 | gall bladder           |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/rhabdomyosarcoma.tsv)
### Sarcoma
*Sarcomas are malignant neoplasms arising from soft tissue or bone.
This is a design pattern for classes representing sarcomas based on their location. This may be the site of origin, but it can also represent a secondary site for metastatized sarcma.
We use the generic 'disease has location' relation, which generalized over primary and secondary sites.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/sarcoma.yaml |
| Name | sarcoma |
| Classes | MONDO:0005089, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/sarcoma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label     | location                                      | location:label   |
|:---------------------------------------------|:------------------------|:----------------------------------------------|:-----------------|
| MONDO:0019480 | Langerhans cell sarcoma | CL:0000453     | Langerhans cell  |
| MONDO:0016982 | angiosarcoma            | UBERON:0001981 | blood vessel     |
| MONDO:0002865 | anus sarcoma            | UBERON:0001245 | anus             |
| MONDO:0002862 | bile duct sarcoma       | UBERON:0002394 | bile duct        |
| MONDO:0001374 | bladder sarcoma         | UBERON:0001255 | urinary bladder  |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/sarcoma.tsv)
### Small cell carcinoma
*This is auto-generated. Add your description here
Examples: [cervical small cell carcinoma](http://purl.obolibrary.org/obo/MONDO_0006142), [pancreatic small cell neuroendocrine carcinoma](http://purl.obolibrary.org/obo/MONDO_0006348), [ureter small cell carcinoma](http://purl.obolibrary.org/obo/MONDO_0006482) (16 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/small_cell_carcinoma.yaml |
| Name | small cell carcinoma disease has location X |
| Classes | MONDO:0000402, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/small_cell_carcinoma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                            | location                                      | location:label         |
|:---------------------------------------------|:-----------------------------------------------|:----------------------------------------------|:-----------------------|
| MONDO:0004120 | Bartholin gland small cell carcinoma           | UBERON:0000460 | major vestibular gland |
| MONDO:0006142 | cervical small cell carcinoma                  | UBERON:0000002 | uterine cervix         |
| MONDO:0003978 | colon small cell neuroendocrine carcinoma      | UBERON:0001155 | colon                  |
| MONDO:0006197 | endometrial small cell carcinoma               | UBERON:0001295 | endometrium            |
| MONDO:0004116 | esophageal small cell neuroendocrine carcinoma | UBERON:0001043 | esophagus              |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/small_cell_carcinoma.tsv)
### Specific disease by disrupted process
*This is auto-generated. Add your description here
Examples: [disease of catalytic activity](http://purl.obolibrary.org/obo/MONDO_0044976), [disease of transporter activity](http://purl.obolibrary.org/obo/MONDO_0044975), [phagocytic cell dysfunction](http://purl.obolibrary.org/obo/MONDO_0024627) (49 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/X_disease_disrupts_X |
| Name | X disease disrupts X |
| Classes | owl:Thing, MONDO:0000001,  |
| Variables | disease (MONDO:0000001), process (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/specific_disease_by_disrupted_process.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label         | disease                                      | disease:label       | process                                   | process:label                         |
|:---------------------------------------------|:----------------------------|:---------------------------------------------|:--------------------|:------------------------------------------|:--------------------------------------|
| MONDO:0005937 | REM sleep behavior disorder | MONDO:0003406 | sleep-wake disorder | GO:0042747 | circadian sleep/wake cycle, REM sleep |
| MONDO:0001531 | blood coagulation disease   | MONDO:0000001 | disease or disorder | GO:0007596 | blood coagulation                     |
| MONDO:0000833 | bone remodeling disease     | MONDO:0005381 | bone disease        | GO:0046849 | bone remodeling                       |
| MONDO:0005557 | calcium metabolic disease   | MONDO:0005066 | metabolic disease   | GO:0055074 | calcium ion homeostasis               |
| MONDO:0045024 | cancer or benign tumor      | MONDO:0000001 | disease or disorder | GO:0008283 | cell population proliferation         |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/specific_disease_by_disrupted_process.tsv)
### Specific disease by dysfunctional structure
*This is auto-generated. Add your description here
Examples: [collagenopathy type 2 alpha 1](http://purl.obolibrary.org/obo/MONDO_0022800), [hemoglobinopathy](http://purl.obolibrary.org/obo/MONDO_0044348), [blood platelet disease](http://purl.obolibrary.org/obo/MONDO_0002245) (2195 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/specific_disease_by_dysfunctional_structure.yaml |
| Name | X disease has basis in dysfunction of X |
| Classes | owl:Thing, MONDO:0000001,  |
| Variables | disease (MONDO:0000001), structure (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/specific_disease_by_dysfunctional_structure.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                           | disease                                      | disease:label                               | structure                         | structure:label   |
|:---------------------------------------------|:----------------------------------------------|:---------------------------------------------|:--------------------------------------------|:----------------------------------|:------------------|
| MONDO:0008861 | 3-methylcrotonyl-CoA carboxylase 1 deficiency | MONDO:0018950 | 3-methylcrotonyl-CoA carboxylase deficiency | http://identifiers.org/hgnc/6936  | MCCC1             |
| MONDO:0008862 | 3-methylcrotonyl-CoA carboxylase 2 deficiency | MONDO:0018950 | 3-methylcrotonyl-CoA carboxylase deficiency | http://identifiers.org/hgnc/6937  | MCCC2             |
| MONDO:0009610 | 3-methylglutaconic aciduria type 1            | MONDO:0017359 | 3-methylglutaconic aciduria                 | http://identifiers.org/hgnc/890   | AUH               |
| MONDO:0009787 | 3-methylglutaconic aciduria type 3            | MONDO:0017359 | 3-methylglutaconic aciduria                 | http://identifiers.org/hgnc/8142  | OPA3              |
| MONDO:0012435 | 3-methylglutaconic aciduria type 5            | MONDO:0017359 | 3-methylglutaconic aciduria                 | http://identifiers.org/hgnc/30528 | DNAJC19           |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/specific_disease_by_dysfunctional_structure.tsv)
### Specific infectious disease by agent
*as for inflammatory_disease_by_site, but refining a specific disease*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/specific_infectious_disease_by_agent.yaml |
| Name | specific_inflammatory_disease_by_site |
| Classes | MONDO:0000001, NCBITaxon:1,  |
| Variables | disease (MONDO:0000001), agent (NCBITaxon:1),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples |  |

### Specific infectious disease by location
*TODO*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/specific_infectious_disease_by_location.yaml |
| Name | specific_infectious_disease_by_location |
| Classes | MONDO:0000001, UBERON:0000061,  |
| Variables | disease (MONDO:0000001), location (UBERON:0000061),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/specific_infectious_disease_by_location.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label            | disease                                      | disease:label       | location                                      | location:label        |
|:---------------------------------------------|:-------------------------------|:---------------------------------------------|:--------------------|:----------------------------------------------|:----------------------|
| MONDO:0001594 | Achilles bursitis              | MONDO:0002471 | bursitis            | UBERON:0003701 | calcaneal tendon      |
| MONDO:0022901 | Crohn disease of the esophagus | MONDO:0005011 | Crohn disease       | UBERON:0001043 | esophagus             |
| MONDO:0000709 | Crohn ileitis                  | MONDO:0005011 | Crohn disease       | UBERON:0002116 | ileum                 |
| MONDO:0021207 | Crohn jejunitis                | MONDO:0005011 | Crohn disease       | UBERON:0002115 | jejunum               |
| MONDO:0004551 | Meckel diverticulitis          | MONDO:0000001 | disease or disorder | UBERON:0003705 | Meckel's diverticulum |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/specific_infectious_disease_by_location.tsv)
### Specific inflammatory disease by site
*as for inflammatory_disease_by_site, but refining a specific disease*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/specific_inflammatory_disease_by_site.yaml |
| Name | specific_inflammatory_disease_by_site |
| Classes | MONDO:0000001, UBERON:0000061,  |
| Variables | disease (MONDO:0000001), location (UBERON:0000061),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/specific_inflammatory_disease_by_site.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label            | disease                                      | disease:label       | location                                      | location:label        |
|:---------------------------------------------|:-------------------------------|:---------------------------------------------|:--------------------|:----------------------------------------------|:----------------------|
| MONDO:0001594 | Achilles bursitis              | MONDO:0002471 | bursitis            | UBERON:0003701 | calcaneal tendon      |
| MONDO:0022901 | Crohn disease of the esophagus | MONDO:0005011 | Crohn disease       | UBERON:0001043 | esophagus             |
| MONDO:0000709 | Crohn ileitis                  | MONDO:0005011 | Crohn disease       | UBERON:0002116 | ileum                 |
| MONDO:0021207 | Crohn jejunitis                | MONDO:0005011 | Crohn disease       | UBERON:0002115 | jejunum               |
| MONDO:0004551 | Meckel diverticulitis          | MONDO:0000001 | disease or disorder | UBERON:0003705 | Meckel's diverticulum |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/specific_inflammatory_disease_by_site.tsv)
### Squamous cell carcinoma
*This is auto-generated. Add your description here
Examples: [cervical squamous cell carcinoma](http://purl.obolibrary.org/obo/MONDO_0006143), [skin squamous cell carcinoma](http://purl.obolibrary.org/obo/MONDO_0002529), [ureter squamous cell carcinoma](http://purl.obolibrary.org/obo/MONDO_0003502) (63 total)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/squamous_cell_carcinoma.yaml |
| Name | squamous cell carcinoma disease has location X |
| Classes | MONDO:0005096, owl:Thing,  |
| Variables | location (owl:Thing),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/squamous_cell_carcinoma.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                      | location                                      | location:label           |
|:---------------------------------------------|:-----------------------------------------|:----------------------------------------------|:-------------------------|
| MONDO:0003490 | ampulla of vater squamous cell carcinoma | UBERON:0004913 | hepatopancreatic ampulla |
| MONDO:0004132 | anal canal squamous cell carcinoma       | UBERON:0000159 | anal canal               |
| MONDO:0001470 | anal margin squamous cell carcinoma      | UBERON:0012336 | perianal skin            |
| MONDO:0006082 | anal squamous cell carcinoma             | UBERON:0001245 | anus                     |
| MONDO:0004053 | bartholin gland squamous cell carcinoma  | UBERON:0000460 | major vestibular gland   |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/squamous_cell_carcinoma.tsv)
### Substance abuse
*A substance abuse that specifies a specific environmental stimulus such as alcohol, cocaine, etc. Examples: [alcohol abuse](http://purl.obolibrary.org/obo/MONDO_0002046), [cocaine abuse](http://purl.obolibrary.org/obo/MONDO_0004456)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/substance_abuse.yaml |
| Name | substance_abuse |
| Classes | MONDO:0002491, BFO:0000040,  |
| Variables | stimulus (BFO:0000040),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432), [0000-0002-7463-6306](https://orcid.org/0000-0002-7463-6306),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/substance_abuse.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label   | stimulus                                   | stimulus:label   |
|:---------------------------------------------|:----------------------|:-------------------------------------------|:-----------------|
| MONDO:0003969 | amphetamine abuse     | CHEBI:2679  | amphetamine      |
| MONDO:0004599 | barbiturate abuse     | CHEBI:29745 | barbiturate      |
| MONDO:0004456 | cocaine abuse         | CHEBI:27958 | cocaine          |
| MONDO:0005912 | phencyclidine abuse   | CHEBI:8058  | phencyclidine    |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/substance_abuse.tsv)
### Susceptibility by gene
*This pattern should be used for terms in which a gene dysfunction causes a predisposition or susceptibility towards developing a specific disease. This pattern is a sub-pattern of [inherited_susceptibility.yaml](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/inherited_susceptibility.yaml)*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/susceptibility_by_gene.yaml
Examples - [autism, susceptibility to, X-linked 5](http://purl.obolibrary.org/obo/MONDO_0010449), [bulimia nervosa, susceptibility to, 2](http://purl.obolibrary.org/obo/MONDO_0012461), [nephrolithiasis susceptibility caused by SLC26A1](http://purl.obolibrary.org/obo/MONDO_0020722)' |
| Name | susceptibility_by_gene |
| Classes | MONDO:0000001, MONDO:0020573, SO:0000704,  |
| Variables | gene (SO:0000704), disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/susceptibility_by_gene.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                               | disease                                      | disease:label                                    | gene                              | gene:label   |
|:---------------------------------------------|:--------------------------------------------------|:---------------------------------------------|:-------------------------------------------------|:----------------------------------|:-------------|
| MONDO:0012153 | Alzheimer disease 9                               | MONDO:0015140 | early-onset autosomal dominant Alzheimer disease | http://identifiers.org/hgnc/37    | ABCA7        |
| MONDO:0010340 | Asperger syndrome, X-linked, susceptibility to, 1 | MONDO:0005259 | Asperger syndrome                                | http://identifiers.org/hgnc/14289 | NLGN3        |
| MONDO:0010343 | Asperger syndrome, X-linked, susceptibility to, 2 | MONDO:0005259 | Asperger syndrome                                | http://identifiers.org/hgnc/14287 | NLGN4X       |
| MONDO:0014786 | IgA nephropathy, susceptibility to, 3             | MONDO:0005342 | IgA glomerulonephritis                           | http://identifiers.org/hgnc/11270 | SPRY2        |
| MONDO:0020715 | Multiple system atrophy 1, susceptibility to      | MONDO:0007803 | multiple system atrophy                          | http://identifiers.org/hgnc/25223 | COQ2         |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/susceptibility_by_gene.tsv)
### Syndromic
*Some diseases exist in both isolated and syndromic forms. For example, aniridia ([MONDO_0019172 aniridia](http://purl.obolibrary.org/obo/MONDO_0019172), [MONDO_0020148'syndromic aniridia'](http://purl.obolibrary.org/obo/MONDO_0020148) and [MONDO_0007119 'isolated aniridia'](http://purl.obolibrary.org/obo/MONDO_0007119). Use this pattern to define the syndromic form of a disease when a term exists for the isolated/syndromic-neutral version. In general, this pattern should be used in parallel with isolated. E.g. if you make a term 'syndromic disease, you should also have 'isolated disease' [see pattern here(https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/isolated.yaml). 
Note that the isolated and syndromic forms will be inferred to be disjoint due to the GCI pattern.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/syndromic.yaml |
| Name | syndromic |
| Classes | MONDO:0021127, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165), [0000-0001-5208-3432](https://orcid.org/0000-0001-5208-3432),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/syndromic.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                   | disease                                      | disease:label                 |
|:---------------------------------------------|:--------------------------------------|:---------------------------------------------|:------------------------------|
| MONDO:0015150 | complex hereditary spastic paraplegia | MONDO:0019064 | hereditary spastic paraplegia |
| MONDO:0017263 | inherited ichthyosis syndromic form   | MONDO:0015947 | inherited ichthyosis          |
| MONDO:0016463 | syndromic agammaglobulinemia          | MONDO:0015977 | agammaglobulinemia            |
| MONDO:0020148 | syndromic aniridia                    | MONDO:0019172 | aniridia                      |
| MONDO:0015246 | syndromic anorectal malformation      | MONDO:0019938 | anorectal malformation        |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/syndromic.tsv)
### Vector borne disease
*An infectious disease where a pathogen is carried and transmitted by another organism that acts as disease vector. Examples: MONDO_0020601 'mosquito-borne viral encephalitis', MONDO_0017572 'tick-borne encephalitis'*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/vectorBorneDisease.yaml |
| Name | vectorBorneDisease |
| Classes | MONDO:0005550, OBI:0100026,  |
| Variables | infectious_disease (MONDO:0005550), vector (OBI:0100026),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/vectorBorneDisease.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label               | infectious:disease                           | infectious:disease:label     | vector                                          | vector:label         |
|:---------------------------------------------|:----------------------------------|:---------------------------------------------|:-----------------------------|:------------------------------------------------|:---------------------|
| MONDO:0020731 | arbovirus infection               | MONDO:0005108 | viral infectious disease     | NCBITaxon:6943   | Amblyomma americanum |
| MONDO:0001620 | louse-borne relapsing fever       | MONDO:0019633 | relapsing fever              | NCBITaxon:121225 | Pediculus humanus    |
| MONDO:0020601 | mosquito-borne viral encephalitis | MONDO:0006009 | viral encephalitis           | NCBITaxon:7157   | Culicidae            |
| MONDO:0006941 | rat-bite fever                    | MONDO:0005113 | bacterial infectious disease | NCBITaxon:10114  | Rattus               |
| MONDO:0001621 | tick-borne relapsing fever        | MONDO:0019633 | relapsing fever              | NCBITaxon:6944   | Ixodes               |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/vectorBorneDisease.tsv)
### X linked
*TBD.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/x_linked.yaml |
| Name | x_linked |
| Classes | HP:0001417, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/x_linked.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label                        | disease                                      | disease:label                     |
|:---------------------------------------------|:-------------------------------------------|:---------------------------------------------|:----------------------------------|
| MONDO:0018994 | Charcot-Marie-Tooth disease type X         | MONDO:0015626 | Charcot-Marie-Tooth disease       |
| MONDO:0010583 | Dyggve-Melchior-Clausen syndrome, X-linked | MONDO:0009130 | Dyggve-Melchior-Clausen disease   |
| MONDO:0010520 | X-linked Alport syndrome                   | MONDO:0018965 | Alport syndrome                   |
| MONDO:0010586 | X-linked Ehlers-Danlos syndrome            | MONDO:0020066 | Ehlers-Danlos syndrome            |
| MONDO:0010680 | X-linked Emery-Dreifuss muscular dystrophy | MONDO:0016830 | Emery-Dreifuss muscular dystrophy |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/x_linked.tsv)
### Y linked
*TBD.*

| Attribute | Info |
|----------|----------|
| IRI | http://purl.obolibrary.org/obo/mondo/patterns/y_linked.yaml |
| Name | y_linked |
| Classes | HP:0001450, MONDO:0000001,  |
| Variables | disease (MONDO:0000001),  |
| Contributors | [0000-0002-6601-2165](https://orcid.org/0000-0002-6601-2165),  |
| Examples | [mondo](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/y_linked.tsv) |

#### Data preview: 
| defined:class                                | defined:class:label             | disease                                      | disease:label                 |
|:---------------------------------------------|:--------------------------------|:---------------------------------------------|:------------------------------|
| MONDO:0000428 | Y-linked disease                | MONDO:0000001 | disease or disorder           |
| MONDO:0033304 | nonsyndromic deafness, Y-linked | MONDO:0019497 | nonsyndromic genetic deafness |
| MONDO:0010761 | retinitis pigmentosa Y-linked   | MONDO:0019200 | retinitis pigmentosa          |

See full table [here](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/data/matches/y_linked.tsv)

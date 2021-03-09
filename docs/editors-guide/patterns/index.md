# Design Patterns 


| Pattern | Description | 
|:---|:---|
| [acquired](acquired/) | Pattern for extending a etiology-generic disease class to an acquired form.  Here acquired means that basis for the disease is acquired during the individuals lifetime. It need not exclude genetic etiology, but it excludes inherited. |  
| [acute](acute/) | TBD. |  
| [adenocarcinoma disease has location X](adenocarcinoma/) | This is auto-generated. Add your description here |  
| [adenoma disease has location X](adenoma/) | This is auto-generated. Add your description here |  
| [adenosquamous carcinoma disease has location X](adenosquamous_carcinoma/) | This is auto-generated. Add your description here |  
| [adult](adult/) | TBD. |  
| [allergic_form_of_disease](allergic_form_of_disease/) |  |  
| [allergy](allergy/) |  |  
| [autoimmune](autoimmune/) | TBD. |  
| [autoimmune_inflammation](autoimmune_inflammation/) | TBD. |  
| [autosomal_dominant](autosomal_dominant/) | TBD. |  
| [autosomal_recessive](autosomal_recessive/) | TBD. |  
| [basis_in_disruption_of_process](basis_in_disruption_of_process/) |  |  
| [benign](benign/) |  |  
| [benign_neoplasm](benign_neoplasm/) |  |  
| [cancer](cancer/) |  |  
| [carcinoma](carcinoma/) |  |  
| [carcinoma_in_situ](carcinoma_in_situ/) | TBD. |  
| [childhood](childhood/) | TBD. |  
| [chronic](chronic/) | TBD. |  
| [congenital](congenital/) | TBD. |  
| [consequence_of_infectious_disease](consequence_of_infectious_disease/) | TBD. |  
| [disease or disorder disease caused by disruption of X](disrupts_process/) | A disease that disrupts a process, like immune system function, or early development. |  
| [disease realized in response to environmental exposure](realized_in_response_to_environmental_exposure/) | This pattern is used for a disease, where the cause of the disease is an exposure to an environmental stimulus (using ECTO exposure terms). |  
| [disease_by_dysfunctional_structure](disease_by_dysfunctional_structure/) |  |  
| [disease_series_by_gene](disease_series_by_gene/) | This pattern is for diseases that are caused by a single mutation in a single gene, that have gene-based names, such as new disease terms that are requested by ClinGen, like MED12-related intellectual disability syndrome.  Examples: [MED12-related intellectual disability syndrome](http://purl.obolibrary.org/obo/MONDO_0100000), [TTN-related myopathy](http://purl.obolibrary.org/obo/MONDO_0100175), [MYPN-related myopathy](http://purl.obolibrary.org/obo/MONDO_0015023) |  
| [disease_series_by_gene_and_inheritance](disease_series_by_gene_and_inheritance/) | This pattern is for diseases that are caused by a single mutation in a single gene, that have gene-based names, and are inherited by a specific mechanism, succh as autosomal dominant and autosomal recessive.  |  
| [environmental_stimulus](environmental_stimulus/) | A disease that is caused by exposure to an environmental stimulus, like the sun or pesticides.  Examples: [carbon monoxide-induced parkinsonism](http://purl.obolibrary.org/obo/MONDO_0017639), [cocaine intoxication](http://purl.obolibrary.org/obo/MONDO_0019544), [Colorado tick fever](http://purl.obolibrary.org/obo/MONDO_0005708) |  
| [genetic](genetic/) | TBD. |  
| [hemangioma disease has location X](hemangioma/) | A hemangioma (a benign vascular lesion characterized by the formation of capillary-sized or cavernous vascular channels) that is located in a specific anatomical site. |  
| [hereditary](hereditary/) |  |  
| [inborn errors of metabolism disease caused by disruption of X](inborn_metabolic_disrupts/) | This pattern is used for inborn errors of metabolism that cause disruption of a specific biological process, such as enzyme activity or ion transport.  |  
| [inborn_metabolic](inborn_metabolic/) | An acquired metabolic disease that causes disruption of a process. |  
| [infantile](infantile/) | An instance of a disease that has an onset of signs or symptoms of disease within the first 12 months of life (infantile onset). |  
| [infectious_disease_by_agent](infectious_disease_by_agent/) | Infectious diseases can be classified by the infectioos agent, such as bacteria, coronavirus, etc, that causes the disease. |  
| [infectious_inflammation](infectious_inflammation/) |  |  
| [inflammatory_disease_by_site](inflammatory_disease_by_site/) |  |  
| [inherited_susceptibility](inherited_susceptibility/) | This pattern should be used for children of MONDO_0020573'inherited disease susceptibility', including OMIM phenotypic series (OMIMPS) for which the subclasses are susceptibilities. Note, this pattern should not have an asserted causative gene as logical axiom (and no single causative gene in text definition), in those cases, the susceptibility_by_gene pattern should be used instead. The children should have asserted causative genes in the text definitions and in the logical axioms. This pattern is a superclass of the susceptibility_by_gene pattern. |  
| [isolated](isolated/) | Some diseases exist in both isolated and syndromic forms. For example, aniridia ([MONDO_0019172 aniridia](http://purl.obolibrary.org/obo/MONDO_0019172), [MONDO_0020148'syndromic aniridia'](http://purl.obolibrary.org/obo/MONDO_0020148) and [MONDO_0007119 'isolated aniridia'](http://purl.obolibrary.org/obo/MONDO_0007119). Use this pattern to define the isolated form of a disease when a term exists for the isolated/syndromic-neutral version. In general, this pattern should be used in parallel with syndromic. E.g. if you make a term 'syndromic disease, you should also have 'isolated disease' [see pattern here(https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/syndromic.yaml).  Note that the isolated and syndromic forms will be inferred to be disjoint due to the GCI pattern. |  
| [juvenile](juvenile/) | An instance of a disease that has an onset of signs or symptoms of disease between the age of 5 and 15 years (juvenile onset). |  
| [leiomyoma disease has location X](leiomyoma/) | A leiomyoma (a well-circumscribed benign smooth muscle neoplasm characterized by the presence of spindle cells with cigar-shaped nuclei, interlacing fascicles, and a whorled pattern) that is located in a specific anatomical entity. |  
| [leiomyosarcoma disease has location X](leiomyosarcoma/) | An uncommon, aggressive malignant smooth muscle neoplasm, usually occurring in post-menopausal women that is characterized by a proliferation of neoplastic spindle cells that is located in a specific anatomical location. |  
| [lipoma disease has location X](lipoma/) | A benign, usually painless, well-circumscribed lipomatous tumor composed of adipose tissue that is located in a specific anatomical location. |  
| [location](location/) | A disease that is located in a specific anatomical site. |  
| [location_top](location_top/) | TBD. |  
| [lymphoma disease has location X](lymphoma/) | A malignant (clonal) proliferation of B- lymphocytes or T- lymphocytes which involves the lymph nodes, bone marrow and/or extranodal sites. This category includes Non-Hodgkin lymphomas and Hodgkin lymphomas. |  
| [malignant](malignant/) | TBD. |  
| [melanoma disease has location X](melanoma/) | This is auto-generated. Add your description here |  
| [meningioma disease has location X](meningioma/) | This is auto-generated. Add your description here |  
| [mitochondriaal_subtype](mitochondrial_subtype/) | A disease that is classified as a mitochondrial subtype, due to a defect in a mitochondrial gene, such as MONDO:0100134 'mitochondrial complex I deficiency, mitochondrial type'. |  
| [mucoepidermoid carcinoma disease has location X](mucoepidermoid_carcinoma/) | This is auto-generated. Add your description here |  
| [neoendocrine_neoplasm](neuroendocrine_neoplasm/) |  |  
| [neoendocrine_neoplasm_grade1](neuroendocrine_neoplasm_grade1/) | we follow NCIT in making carcinoid a syn for G1 NET |  
| [neoplasm](neoplasm/) |  |  
| [neoplasm](neoplasm_by_origin/) | TBD. |  
| [nuclear_subtype](nuclear_subtype/) | A disease that is classified as a nuclear subtype, due to a defect in a nuclear gene, such as MONDO:0009640 'mitochondrial complex I deficiency, nuclear type'. |  
| [OMIM_disease_series_by_gene](OMIM_disease_series_by_gene/) |  |  
| [OMIM_phenotypic_series](OMIM_phenotypic_series/) | This pattern is meant to be used for OMIM phenotypic series (OMIMPS), which are represented as grouping classes in Mondo. Note:  - every instance of this metaclass should be equivalent to (via annotated xref) to something in OMIMPS namespace - it will never have an asserted causative gene as logical axiom (and no single causative gene in text def) - it must never be equivalent to an OMIM:nnnnnn (often redundant with the above rule) - it must have an acronym synonym, e.g. HPE - it must have two or more subclasses (direct or indirect) that are equivalent to OMIMs - the subclasses should (not must) have a logical def that uses the PS as a genus (see http://purl.obolibrary.org/obo/mondo/patterns/disease_series_by_gene.yaml) - the OMIM subclasses must have acronym synonyms that are the parent syn + number, e.g. HPE1, HPE2 - the primary label for the children should also be parent + {"type"} + number - the first member will usually have the same number local ID as the PS - the first member in OMIM usually has documentation that is pertinent to the parent PS - the members may(?) generally share high semantic similarity - All OMIMPS disease should have a has modifier some inherited restricted, see http://purl.obolibrary.org/obo/mondo/sparql/omimps-should-be-inherited-violation.sparql |  
| [postinfectious_disease](postinfectious_disease/) | A design pattern for conditions such as post-herpetic neuralgia or postinfectious encephalitis, where the disease is secondary to the initial infection. |  
| [primary infectious](primary_infectious/) |  |  
| [rare](rare/) | TBD. |  
| [rare_genetic](rare_genetic/) | TBD. |  
| [refractory](refractory/) | TBD. |  
| [rhabdomyosarcoma disease has location X](rhabdomyosarcoma/) | This is auto-generated. Add your description here |  
| [sarcoma](sarcoma/) |  |  
| [small cell carcinoma disease has location X](small_cell_carcinoma/) | This is auto-generated. Add your description here |  
| [specific_infectious_disease_by_location](specific_infectious_disease_by_location/) |  |  
| [specific_inflammatory_disease_by_site](specific_inflammatory_disease_by_site/) |  |  
| [specific_inflammatory_disease_by_site](specific_infectious_disease_by_agent/) |  |  
| [squamous cell carcinoma disease has location X](squamous_cell_carcinoma/) | This is auto-generated. Add your description here |  
| [susceptibility_by_gene](susceptibility_by_gene/) | This pattern should be used for terms in which a gene dysfunction causes a predisposition or susceptibility towards developing a specific disease. This pattern is a sub-pattern of [inherited_susceptibility.yaml](https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/inherited_susceptibility.yaml) |  
| [syndromic](syndromic/) | Some diseases exist in both isolated and syndromic forms. For example, aniridia ([MONDO_0019172 aniridia](http://purl.obolibrary.org/obo/MONDO_0019172), [MONDO_0020148'syndromic aniridia'](http://purl.obolibrary.org/obo/MONDO_0020148) and [MONDO_0007119 'isolated aniridia'](http://purl.obolibrary.org/obo/MONDO_0007119). Use this pattern to define the syndromic form of a disease when a term exists for the isolated/syndromic-neutral version. In general, this pattern should be used in parallel with isolated. E.g. if you make a term 'syndromic disease, you should also have 'isolated disease' [see pattern here(https://github.com/monarch-initiative/mondo/blob/master/src/patterns/dosdp-patterns/isolated.yaml).  |  
| [vectorBorneDisease](vectorBorneDisease/) | An infectious disease where a pathogen is carried and transmitted by another organism that acts as disease vector. Examples: MONDO_0020601 'mosquito-borne viral encephalitis', MONDO_0017572 'tick-borne encephalitis' |  
| [X disease disrupts X](specific_disease_by_disrupted_process/) | This is auto-generated. Add your description here |  
| [X disease has basis in dysfunction of X](specific_disease_by_dysfunctional_structure/) | This is auto-generated. Add your description here |  
| [x_linked](x_linked/) | TBD. |  
| [y_linked](y_linked/) | TBD. |  

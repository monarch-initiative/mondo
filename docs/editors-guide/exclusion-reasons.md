# Exclusion Reasons

## Description 
_This document is a work in progress._ Noted below are reasons for excluding external ontology or terminology terms from Mondo. 

Reasons for exclusion | Description | Example
---| ---| --- 
biological process | The concept describes a biological process and not a disease.| ICD10CM:O00-O08 Pregnancy with abortive outcome                                                                      
biomarker | A biomarker that is used for disease status, such as estrogen receptor status for breast cancer. | ICD10CM:Z17-Z17 Estrogen receptor status
complication | A secondary disease or condition aggravating an already existing one that is the result of an event (like birth), procedure or surgery. | J95-J95 Intraoperative and postprocedural complications and disorders of respiratory system, not elsewhere classified 
conditions caused by external force | A condition that is caused by an external force (such as a transport accident). | ICD10CM:V95-V97 Air and space transport accidents                                                                         disease causing agents | Agents, such as bacteria or other pathogens, that cause disease, but the code(s) do not refer to diseases themselves. | ICD10CM:B95-B97 Bacterial and viral infectious agents                                                                           |
presence of environmental materials | This code is for the presence of environmental materials, such as foreign body fragments or objects in the body and does not refer to a pathological process. | ICD10CM:Z18-Z18 Retained foreign body fragments                                                                         
genetic carrier | An individual who is heterozygous for a recessive gene and thus does not express the recessive phenotype but can transmit the gene to offspring. | ICD10CM:Z14-Z15 Genetic carrier and genetic susceptibility to disease
genetic form of disease | A disease that is characterized by the feature of having a genetic or inheritable component. We don't want to include in Mondo because it's too difficult to autoclassify these and keep them up to date. | Orphanet:183472 genetic dermis disorder
grouping class | A term that is not a disease itself but groups together classes that share common features, like grouping diseases together by phenotypic features. | Orphanet:138041 Pierre Robin syndrome associated with collagen disease
medical action | A clinically prescribed procedure, therapy, intervention, or recommendation. | ICD10CM:Z30-Z39 Persons encountering health services in circumstances related to reproduction
phenotype | Observable characteristics of an individual that is the product of interactions between genes and the environment. | ICD10CM:P09-P09 Abnormal findings on neonatal screening 
phenotype (for metastasis) | Characteristics of metastatic tumors (a tumor that has spread from the part of the body where it started (the primary site) to other parts of the body.) | ICD10CM:C7B-C7B Secondary neuroendocrine tumors                                                                            
phenotype for tumor | Characteristics of a tumor that causes the disease, but not the disease itself. | ICD10CM:C7A-C7A Malignant neuroendocrine tumors 
rare | We do not include rare subtypes of diseases as proper classes in Mondo, but rather use the rare subclass annotation | Orphanet:101954 rare adrenal disease
risk factor | Something that increases the chance of developing a disease. | Z20-Z29 Persons with potential health hazards related to communicable diseases 
conditions causes by external factor | A condition that is caused by an external factor or event (such as labor and delivery). | ICD10CM:N99-N99 Intraoperative and postprocedural complications and disorders of genitourinary system, not elsewhere classified
behavior | An action performed by an individual, not a disease. | O30-O48 Maternal care related to the fetus and amniotic cavity and possible delivery problems 
trait | A characteristic of an individual. | ICD10CM:Z67-Z67 Blood type                                                                              
traumatic cause | A secondary complication of a a distressing experience. | ICD10CM:T79-T79 Certain early complications of  trauma
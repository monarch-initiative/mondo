# Exclusion Reasons

## Description 
_This document is a work in progress._ Noted below are reasons for excluding external ontology or terminology terms from Mondo. See enum file [here](https://github.com/monarch-initiative/mondo/blob/master/src/schema/mondo.yaml).

ID| Reasons for exclusion | Description | Example
---| ---| --- | --
MONDO:excludeBiologicalProcess | biological process | The concept describes a biological process and not a disease.| ICD10CM:O00-O08 Pregnancy with abortive outcome                                                                      
MONDO:excludeBiomarker | biomarker | A biomarker that is used for disease status and not a disease, such as estrogen receptor status for breast cancer. | ICD10CM:Z17-Z17 Estrogen receptor status
MONDO:excludeCausingAgents | disease causing agents | Agents, such as bacteria or other pathogens, that cause disease, but the code(s) do not refer to diseases themselves. | ICD10CM:B95-B97 Bacterial and viral infectious agents          
MONDO:excludeClinicalModifier | clinical modifier | Diseases that are modified by a clinical modifier (such as symptomatic, severe, etc.) may be out of scope by Mondo. | MONDO:0034028 symptomatic form of hemochromatosis type 1
MONDO:excludeClinicalSituation | clinical situation | Particular clinical situations in a disease or syndrome, not diseases themselves. | Orphanet:244275 de novo thrombotic microangiopathy after kidney transplantation 
MONDO:excludeComplication | complication | A secondary disease or condition aggravating an already existing one that is the result of an event (like birth), procedure or surgery. | J95-J95 Intraoperative and postprocedural complications and disorders of respiratory system, not elsewhere classified 
MONDO:excludeConditionsCausedByExternalForce | conditions caused by external force | A condition that is caused by an external force (such as a transport accident) and not a disease. | ICD10CM:V95-V97 Air and space transport accidents                                                       
MONDO:excludeFinding | finding | The concept described is not a clinical finding, not a disease. | MONDO:0001424 sarcoid meningitis
MONDO:excludeGeneticCarrier | genetic carrier | The concept described is not a disease, it is for individual who is heterozygous for a recessive gene and thus does not express the recessive phenotype but can transmit the gene to offspring. | ICD10CM:Z14-Z15 Genetic carrier and genetic susceptibility to disease
MONDO:excludeGene | gene | A concept that refers to a gene (or protein). | OMIM:607044 T-BOX 24
MONDO:excludeGeneticFormOfDisease | genetic form of disease | A grouping class that that is characterized by the feature of having a genetic or inheritable component. We don't include these terms in Mondo because it is a grouping class that is not commonly used. | Orphanet:183472 genetic dermis disorder
MONDO:excludeGroupingClass | grouping class | A term that is not a disease itself but groups together classes that share common features, like grouping diseases together by phenotypic features. | Orphanet:138041 Pierre Robin syndrome associated with collagen disease
MONDO:excludeHistoricalDisease | historical disease | A term that is no longer considered a disease due to lack of supporting evidence. | MONDO:0010682 'myoclonic epilepsy, progressive, X-linked' 
MONDO:excludeMedicalAction | medical action | A clinically prescribed procedure, therapy, intervention, or recommendation, not a disease. | ICD10CM:Z30-Z39 Persons encountering health services in circumstances related to reproduction
MONDO:excludePatientGroup | patient group | We exclude diseases that specify certain groups of patients. | Orphanet:91127 adenovirus infection in immunocompromised patients
MONDO:excludePhenotype | phenotype | Observable characteristics of an individual that is the product of interactions between genes and the environment. The concept described is not a disease.  | ICD10CM:P09-P09 Abnormal findings on neonatal screening 
MONDO:excludePhenotypeForMetastasis | phenotype for metastasis | Characteristics of metastatic tumors (a tumor that has spread from the part of the body where it started (the primary site) to other parts of the body.). The concept described is not a disease.  | ICD10CM:C7B-C7B Secondary neuroendocrine tumors 
MONDO:excludePhenotypeForTumor | phenotype for tumor | Characteristics of a tumor that causes the disease, but not the disease itself. | ICD10CM:C7A-C7A Malignant neuroendocrine tumors 
MONDO:excludePresenceOfEnvironmentalMaterials | presence of environmental materials | This code is for the presence of environmental materials, such as foreign body fragments or objects in the body and does not refer to a disease. | ICD10CM:Z18-Z18 Retained foreign body fragments  
MONDO:excludeRare | rare | We do not include rare subtypes of diseases as proper classes in Mondo, but rather use the rare subclass annotation | Orphanet:101954 rare adrenal disease
MONDO:excludeRiskFactor | risk factor | Something that increases the chance of developing a disease, not the disease itself. | Z20-Z29 Persons with potential health hazards related to communicable diseases 
MONDO:excludeConditionsCausedByExternalFactor | conditions caused by external factor | A condition that is caused by an external factor or event (such as labor and delivery). The concept described is not a disease. | ICD10CM:N99-N99 Intraoperative and postprocedural complications and disorders of genitourinary system, not elsewhere classified
MONDO:excludeBehavior | behavior | An action performed by an individual, not a disease. | O30-O48 Maternal care related to the fetus and amniotic cavity and possible delivery problems 
MONDO:excludeTrait | trait | A characteristic of an individual, not a disease. | ICD10CM:Z67-Z67 Blood type 
MONDO:excludeTraumaticCause | traumatic cause | A secondary complication of a distressing experience, not a disease. | ICD10CM:T79-T79 Certain early complications of trauma

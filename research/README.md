# **Epigenetic Age Analysis of Alcoholic Cohorts**

This repository contains scripts developed to analyze the association between alcohol-related phenotypes and epigenetic age acceleration (EAA). The analyses explore various factors, such as alcohol consumption, liver enzyme levels, and demographic covariates, using statistical models, machine learning, and data visualizations.

---

## **Purpose of the Analyses**

Epigenetic age, as calculated using clocks like GrimAge Version 1 and GrimAge Version 2, serves as a proxy for biological age, with epigenetic age acceleration (EAA) representing the difference between epigenetic and chronological age [1,2]. Positive EAA values indicate faster biological aging [3]. Previous research has established that Alcohol Use Disorder (AUD) is associated with EAA calculated using PhenoAge and GrimAge Version 1; however, its relationship with EAA calculated using GrimAge Version 2 has not yet been explored [4]. Our analysis focuses on GrimAge Version 1 and GrimAge Version 2 to assess whether GrimAge Version 2 provides improved insights as an epigenetic clock.

The goal of these analyses is to:
1. **Validate and evaluate the performance of GrimAge Version 1 and Version 2** in a diverse cohort, as our patient data included approximately 50% European American and 50% African American participants.
2. **Investigate associations between alcohol-related phenotypes** (e.g., heavy drinking days, total drinks, liver enzyme levels) and EAA calculated using GrimAge Version 1 and Version 2.
3. **Examine the independent contributions of alcohol-related phenotypes to EAA**  while controlling for potential confounders such as smoking status, BMI, race, and immune cell proportions, to explore the mechanisms driving epigenetic aging.

These analyses are exploratory in nature and aim to generate hypotheses about the biological mechanisms linking alcohol consumption, demographic diversity, and aging.

---

## **Contents**

### 1. **Epigenetic Age Models**
- Located in **`epigenetic_age_analysis.R`**
- Scripts for running linear regression models assessing the association of:
  - **Liver enzyme levels** with EAA.
  - **Alcohol consumption variables** with EAA.
  - Subgroup analyses focused on Alcohol Use Disorder (AUD) patients.

### 2. **Predictive Modeling**
- Located in **`predictive_modeling.R`**
- Scaled variables and used predictive models to calculate mean EAA across subgroups (e.g., stratified by age, sex, and race).
- Used the `predict()` function to estimate adjusted EAA values after controlling for covariates.

### 3. **Data Visualization**
- Located in 
- Generated various types of visualizations for analysis results:
  - **Bar plots**: Predicted EAA by subgroup (e.g., AUD status, age, sex).
  - **Forest plots**: Confidence intervals and effect sizes for key variables.
  - **Manhattan plots**: Highlighted significant associations in supplemental analyses.
  - **Scatterplots**: Explored relationships between continuous variables and EAA.

### **Supplemental Data**
- **`data/`**: Placeholder for input files, such as liver enzyme and alcohol metrics datasets. (Datasets are excluded to protect PII.)

---

## **Notes**
- Datasets are excluded from this repository to protect Protected Health Information (PHI/PII).
- Research questions evolved iteratively with feedback from collaborators and PIs.
- Findings are intended to inform future research on the biological mechanisms of alcohol-related aging.

---

## **References**
1. Lu AT, Quach A, Wilson JG, et al. DNA methylation GrimAge strongly predicts lifespan and healthspan. Aging (Albany NY). 2019;11(2):303-327. doi:10.18632/aging.101684.
2. Lu AT, Binder AM, Zhang J, et al. DNA methylation GrimAge version 2. Aging (Albany NY). 2022;14(23):9484-9549. doi:10.18632/aging.204434.
3. Nwanaji-Enwerem JC, Weisskopf MG, Baccarelli AA. Multi-tissue DNA methylation age: molecular relationships and perspectives for advancing biomarker utility. Ageing Res Rev 2018; 45:15–23.
4. Jung J, McCartney DL, Wagner J, et al. Additive Effects of Stress and Alcohol Exposure on Accelerated Epigenetic Aging in Alcohol Use Disorder. Biol Psychiatry. 2023;93(4):331-341. doi:10.1016/j.biopsych.2022.06.036.



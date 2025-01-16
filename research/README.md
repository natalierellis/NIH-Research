# **Epigenetic Age Analysis of Alcoholic Cohorts**

This repository contains scripts developed to analyze the association between alcohol-related phenotypes and epigenetic age acceleration (EAA). The analyses explore various factors, such as alcohol consumption, liver enzyme levels, and demographic covariates, using statistical models, machine learning, and data visualizations.

---

## **Purpose of the Analyses**

Epigenetic age, as calculated using epigenetic clocks like GrimAge Version 1 and GrimAge Version 2, is considered a proxy for biological age [1,2]. Epigenetic age acceleration (EAA) represents the difference between epigenetic age and chronological age, with positive EAA values indicating faster biological aging [3]. 

The goal of these analyses is to:
1. **Validate original published models** (e.g., GrimAge, PhenoAge) in a diverse cohort, as our patient data included approximately 50% European American and 50% African American participants.
2. **Assess whether alcohol-related phenotypes** (e.g., heavy drinking days, total drinks, liver enzyme levels) are associated with EAA.
3. **Determine the independent contribution of alcohol-related phenotypes to EAA after accounting for potential confounders** (e.g., smoking status, BMI, race, immune cell proportions).

By including covariates, the models:
- **Control for confounding**: Ensuring that the observed relationship between alcohol-related phenotypes and EAA is not misattributed to other factors like smoking or BMI.
- **Test adjusted effects**: Identifying whether alcohol-related phenotypes independently explain EAA.
- **Explore potential pathways**: Providing insights into whether alcohol-related phenotypes may drive or contribute to accelerated epigenetic aging.

These analyses are exploratory in nature and aim to generate hypotheses about the biological mechanisms linking alcohol consumption, demographic diversity, and aging.

---

## **Contents**

### 1. **Epigenetic Age Models**
- Scripts for running linear regression models assessing the association of:
  - **Liver enzyme levels** with EAA.
  - **Alcohol consumption variables** with EAA.
  - Subgroup analyses focused on Alcohol Use Disorder (AUD) patients.

### 2. **Predictive Modeling**
- Scaled variables and used predictive models to calculate mean EAA across subgroups (e.g., stratified by age, sex, and race).
- Used the `predict()` function to estimate adjusted EAA values after controlling for covariates.

### 3. **Data Visualization**
- Generated various types of visualizations for analysis results:
  - **Bar plots**: Predicted EAA by subgroup (e.g., AUD status, age, sex).
  - **Forest plots**: Confidence intervals and effect sizes for key variables.
  - **Manhattan plots**: Highlighted significant associations in supplemental analyses.
  - **Scatterplots**: Explored relationships between continuous variables and EAA.

---

## **Key Scripts and Files**

### **Epigenetic Age Analysis**
- **`epigenetic_age_analysis.R`**: Contains the main analyses for liver enzyme levels and alcohol consumption metrics.
- **`predictive_modeling.R`**: Scripts for scaling variables, predicting EAA, and stratifying by demographic groups.

### **Visualization Scripts**
- **`visualization.R`**: Code for creating bar plots, scatterplots, and error bar visualizations.
- **`manhattan_plots.R`**: Scripts for generating Manhattan plots for supplemental datasets.
- **`forest_plot.R`**: Forest plot generation with confidence intervals and effect sizes.

### **Supplemental Data**
- **`data/`**: Placeholder for input files, such as liver enzyme and alcohol metrics datasets. (Datasets are excluded to protect PII.)

---

## **Usage**

1. **Running Models**:
   - Open `epigenetic_age_analysis.R` to run linear models on EAA for liver enzymes or alcohol consumption.
   - For subgroup-specific predictions, use `predictive_modeling.R`.

2. **Visualizations**:
   - Customize plots by editing the scripts in `visualization.R`, `manhattan_plots.R`, and `forest_plot.R`.

3. **Input Files**:
   - Ensure data files are appropriately formatted and saved in the `data/` folder before running scripts.

---

## **Notes**
- **Diverse Cohort**: This work aimed to validate published epigenetic clock models in a diverse cohort (approximately 50% European American and 50% African American) to assess their generalizability.
- Datasets are excluded from this repository to protect Protected Health Information (PHI/PII).
- These scripts were developed for exploratory analyses and visualization tasks.
- Research questions evolved iteratively with feedback from collaborators and PIs.
- Findings are intended to inform future research on the biological mechanisms of alcohol-related aging.

---

## **References**
1. Lu AT, Quach A, Wilson JG, et al. DNA methylation GrimAge strongly predicts lifespan and healthspan. Aging (Albany NY). 2019;11(2):303-327. doi:10.18632/aging.101684.
2. Lu AT, Binder AM, Zhang J, et al. DNA methylation GrimAge version 2. Aging (Albany NY). 2022;14(23):9484-9549. doi:10.18632/aging.204434.
3. Nwanaji-Enwerem JC, Weisskopf MG, Baccarelli AA. Multi-tissue DNA methylation age: molecular relationships and perspectives for advancing biomarker utility. Ageing Res Rev 2018; 45:15–23.



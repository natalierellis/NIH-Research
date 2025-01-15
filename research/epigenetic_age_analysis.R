# Epigenetic Age Analysis 
# These scripts represent example models we ran and do not include every single model used in our analyses.
# The overall goal was to perform similar analyses with both GrimAge and GrimAge Version 2 to determine whether
# GrimAge Version 2 provides better insights as an epigenetic clock. This comparison had not been conducted before.
# 
# In addition to the examples shown here, we explored associations between:
# - Other enzyme levels (e.g., ALT, AST) and EAA.
# - Other alcohol consumption variables (e.g., heavy drinking days, total drinks).
# - Subgroups within specific cohorts, such as patients with AUD, stratified by BMI, race, gender, etc.
# These scripts provide a small subset of models to illustrate the types of analyses performed.

# Load required libraries
library(ggplot2)
library(dplyr)

# Prepare the data for analysis
EAA <- F[, c(2, 218, 217, 171, 219, 220, 221, 222, 209, 176, 175, 174, 173, 172, 169, 166, 38, 39, 40, 41, 42)]

# Analysis 1: Association of GGT Levels with EAA 
# This analysis controls for AUD status to account for its potential confounding effect on the relationship
# between GGT levels (a liver enzyme) and EAA. 
EAA$Grouping <- ifelse(EAA$GGT <= 20, "Lowest",
                       ifelse(EAA$GGT >= 83, "Highest", "Unneeded"))
EAA <- EAA[!(EAA$Grouping %in% "Unneeded"), ]

# Linear models for GGT association with EAA
mod1 <- lm(AgeAdjustedGrimAge ~ relevel(as.factor(Grouping), ref = "Lowest") + 
             relevel(as.factor(AUD_Group.y), ref = "HC") + race1 + CD8T + CD4T + NK + Mono +
             Bcell + Female.y + FTND_SmokingStatus + BMI, data = EAA)
summary(mod1)

mod2 <- lm(AgeAdjustedGrimAge2 ~ relevel(as.factor(Grouping), ref = "Lowest") + 
             relevel(as.factor(AUD_Group.y), ref = "HC") + race1 + CD8T + CD4T + NK + Mono +
             Bcell + Female.y + FTND_SmokingStatus + BMI, data = EAA)
summary(mod2)

# Analysis 2: Alcohol Consumption Variables and EAA 
# This analysis does not control for AUD status as the primary focus is on total alcohol consumption 
# (e.g., total drinks, heavy drinking days) rather than AUD diagnosis. 
EAA$Grouping <- ifelse(EAA$TotalDrinks <= 37, "Lowest",
                       ifelse(EAA$TotalDrinks >= 923.25, "Highest", "Unneeded"))
EAA <- EAA[!(EAA$Grouping %in% "Unneeded"), ]

# Linear models for alcohol consumption and EAA
mod3 <- lm(AgeAdjustedGrimAge ~ relevel(as.factor(Grouping), ref = "Lowest") +
             race1 + CD8T + CD4T + NK + Mono + Bcell + Female.y + FTND_SmokingStatus + BMI, data = EAA)
summary(mod3)

mod4 <- lm(AgeAdjustedGrimAge2 ~ relevel(as.factor(Grouping), ref = "Lowest") +
             race1 + CD8T + CD4T + NK + Mono + Bcell + Female.y + FTND_SmokingStatus + BMI, data = EAA)
summary(mod4)

# Subgroup Analysis: AUD Patients 
# Subgroup analysis focuses on AUD patients only, as the relationship between alcohol-related variables and EAA
# may differ in this group. This helps identify whether the effects seen in broader analyses are also present
# in the AUD cohort.
AUD <- EAA[EAA$AUD_Group.y == 'AUD+', ]
AUD$Grouping <- ifelse(AUD$NoOfDrinkDays <= 61, "Lowest",
                       ifelse(AUD$NoOfDrinkDays >= 90, "Highest", "Unneeded"))
AUD <- AUD[!(AUD$Grouping %in% "Unneeded"), ]

# Linear models for AUD subgroup
mod_aud1 <- lm(AgeAdjustedGrimAge ~ Grouping + race1 + CD8T + CD4T + NK + Mono +
                 Bcell + Female.y + FTND_SmokingStatus + BMI, data = AUD)
summary(mod_aud1)

mod_aud2 <- lm(AgeAdjustedGrimAge2 ~ Grouping + race1 + CD8T + CD4T + NK + Mono +
                 Bcell + Female.y + FTND_SmokingStatus + BMI, data = AUD)
summary(mod_aud2)

# Descriptive Visualization 
# Visualize EAA across age bins
ggplot(EAA, aes(x = Age.y, y = AgeAdjustedGrimAge)) +
  stat_summary(fun = mean, geom = "bar", fill = "#34cfa1") +
  stat_summary(fun.data = "mean_se", geom = "errorbar", width = 0.1) +
  ylab("Age-Adjusted Epigenetic Age") +
  xlab("Age Bins") +
  theme_minimal()

# Save key visualizations and results
# Add export commands as necessary

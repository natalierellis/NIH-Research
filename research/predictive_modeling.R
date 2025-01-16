# === Predictive Modeling for Epigenetic Age Analysis ===
# These scripts are examples of analyses conducted to compare GrimAge and GrimAge Version 2 as epigenetic clocks.
# The overall goal was to assess whether GrimAge Version 2 provides better insights than GrimAge Version 1 in 
# analyzing the association of alcohol-related phenotypes with epigenetic age acceleration (EAA).
# We conducted these analyses across subgroups (e.g., age, sex, race, AUD status) and using various alcohol consumption 
# metrics and liver enzyme levels. These scripts do not cover every model run but illustrate the type of exploratory analyses performed.

# === Libraries and Data Preparation ===
library(dplyr)
library(ggplot2)
library(rstatix)

# Scale variables to normalize and improve model performance
EAA$normalizedAST <- scale(EAA$AST)
EAA$normalizedALT <- scale(EAA$ALT)
EAA$normalizedGGT <- scale(EAA$GGT)
EAA$normalizedHDD <- scale(EAA$HeavyDrinkDays)
EAA$normalizedTD <- scale(EAA$TotalDrinks)
EAA$normalizedAge <- scale(EAA$Age.y)

# Example: Restricting analyses to patients with AUD
EAA_AUD <- EAA[EAA$AUD_Group.y == 'AUD+',]

# === Linear Models to Predict EAA ===
# These models investigate the relationship between covariates and EAA as measured by GrimAge Version 1 and Version 2.

# GrimAge Version 2 with covariates
mod2 <- lm(AgeAdjustedGrimAge2 ~ BMI +
             relevel(as.factor(AUD_Group.y), ref = "HC") +
             relevel(as.factor(Female.y), ref = 1) +
             FTND_SmokingStatus + race1 + CD8T + CD4T + NK + Mono + Bcell, data = EAA)
summary(mod2)

# Predict EAA for each patient using GrimAge Version 2
predict_V2 <- predict(mod2)
predict_V2 <- merge(EAA, as.data.frame(predict_V2), by = 0, suffixes = c("", "_Predicted"))

# Stratify data by age group (e.g., Young vs. Old)
predict_V2$AgeGrouping <- ifelse(predict_V2$Age.y >= 40, "Old", "Young")

# === Visualization of Predicted EAA ===
# Calculate mean predicted EAA and confidence intervals for subgroups
values_V2 <- predict_V2 %>%
  group_by(AgeGrouping, AUD_Group.y) %>%
  summarise(mean = mean(predict_V2_Predicted, na.rm = TRUE),
            std.error = sd(predict_V2_Predicted, na.rm = TRUE) / sqrt(n()))

values_V2 <- values_V2 %>%
  mutate(CImin = mean - 1.96 * std.error,
         CImax = mean + 1.96 * std.error)

# Bar plot of predicted EAA for GrimAge Version 2
ggplot(values_V2, aes(x = reorder(AUD_Group.y, AgeGrouping), 
                      y = mean, fill = AUD_Group.y)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  scale_fill_brewer(direction = -1) +
  geom_errorbar(aes(ymin = CImin, ymax = CImax), width = .2, 
                position = position_dodge(.9)) +
  labs(x = "AUD/Age Grouping", 
       y = "Age-Adjusted DNAm GrimAge (yr)", 
       title = "Predicted EAA: GrimAge Version 2") +
  theme_dark()

# Save the plot
ggsave(filename = "GrimAge_Version2_Predicted_EAA.png")

# Repeat for GrimAge Version 1 (similar structure)
# Example code for GrimAge Version 1 omitted for brevity but follows the same workflow.

# === Insights ===
# These models and visualizations allow us to:
# - Observe differences in predicted EAA across AUD and non-AUD groups.
# - Evaluate whether GrimAge Version 2 offers improved insights over Version 1.
# - Disentangle the effects of covariates (e.g., BMI, smoking status) from alcohol-related phenotypes.
# - Generate hypotheses about the biological mechanisms linking alcohol consumption and aging.

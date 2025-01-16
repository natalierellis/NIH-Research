# Predictive Modeling for Epigenetic Age Analysis 
# These models and visualizations allow us to:
# - Observe differences in predicted EAA across AUD and non-AUD groups stratified by age (Young vs. Old).
# - Evaluate whether GrimAge Version 2 offers improved insights over Version 1.
# - Disentangle the effects of covariates (e.g., BMI, smoking status) from alcohol-related phenotypes.
# - Generate hypotheses about the biological mechanisms linking alcohol consumption and aging.

# Libraries and Data Preparation
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

# Linear Models to Predict EAA
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

# Calculate mean predicted EAA and confidence intervals for subgroups
values_V2 <- predict_V2 %>%
  group_by(AgeGrouping, AUD_Group.y) %>%
  summarise(mean = mean(predict_V2_Predicted, na.rm = TRUE),
            std.error = sd(predict_V2_Predicted, na.rm = TRUE) / sqrt(n()))

values_V2 <- values_V2 %>%
  mutate(CImin = mean - 1.96 * std.error,
         CImax = mean + 1.96 * std.error)

# Bar plot of predicted EAA for GrimAge Version 2
p_v2 <- ggplot(values_V2, aes(x = interaction(AgeGrouping, AUD_Group.y), 
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
ggsave(filename = "GrimAge_Version2_Predicted_EAA.png", plot = p_v2)

# Repeat for GrimAge Version 1
mod1 <- lm(AgeAdjustedGrimAge ~ BMI +
             relevel(as.factor(AUD_Group.y), ref = "HC") +
             relevel(as.factor(Female.y), ref = 1) +
             FTND_SmokingStatus + race1 + CD8T + CD4T + NK + Mono + Bcell, data = EAA)
summary(mod1)

# Predict EAA for each patient using GrimAge Version 1
predict_V1 <- predict(mod1)
predict_V1 <- merge(EAA, as.data.frame(predict_V1), by = 0, suffixes = c("", "_Predicted"))

# Stratify data by age group (e.g., Young vs. Old)
predict_V1$AgeGrouping <- ifelse(predict_V1$Age.y >= 40, "Old", "Young")

# Calculate mean predicted EAA and confidence intervals for GrimAge Version 1
values_V1 <- predict_V1 %>%
  group_by(AgeGrouping, AUD_Group.y) %>%
  summarise(mean = mean(predict_V1_Predicted, na.rm = TRUE),
            std.error = sd(predict_V1_Predicted, na.rm = TRUE) / sqrt(n()))

values_V1 <- values_V1 %>%
  mutate(CImin = mean - 1.96 * std.error,
         CImax = mean + 1.96 * std.error)

# Bar plot of predicted EAA for GrimAge Version 1
p_v1 <- ggplot(values_V1, aes(x = interaction(AgeGrouping, AUD_Group.y), 
                              y = mean, fill = AUD_Group.y)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  scale_fill_brewer(direction = -1) +
  geom_errorbar(aes(ymin = CImin, ymax = CImax), width = .2, 
                position = position_dodge(.9)) +
  labs(x = "AUD/Age Grouping", 
       y = "Age-Adjusted DNAm GrimAge (yr)", 
       title = "Predicted EAA: GrimAge Version 1") +
  theme_dark()

# Save the plot
ggsave(filename = "GrimAge_Version1_Predicted_EAA.png", plot = p_v1)

# Combined Insights
# Both plots contain mean predicted EAA across four subgroups:
# - AUD + Young
# - AUD + Old
# - HC (Healthy Control) + Young
# - HC + Old
# This approach allows us to directly compare the performance of GrimAge Version 1 and GrimAge Version 2.



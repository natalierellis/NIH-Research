# Data Visualization Scripts
# This script contains code to generate bar plots, Manhattan plots, forest plots, 
# and other visualizations used in manuscripts. Output visualizations are not included 
# because they are considered to be NIH property.  

# ---------------------------
# Section 1: Bar Plots
# ---------------------------
library(ggplot2)

# Basic Error Bar Plot
ggplot(SexPlot) +
  geom_bar(aes(x = Version, y = EAA, fill = Sex), stat = "identity", alpha = 0.7, position = position_dodge()) +
  geom_errorbar(aes(x = Version, ymin = EAA - ic, ymax = EAA + ic), 
                width = 0.4, colour = "orange", alpha = 0.9, size = 1.3) +
  theme_classic()

# Sex Plot
p <- ggplot(SexPlot, aes(x = Version, y = EAA, fill = Sex)) + 
  geom_bar(stat = "identity", position = position_dodge()) +
  geom_errorbar(aes(ymin = EAA - ic, ymax = EAA + ic), width = 0.2, position = position_dodge(0.9)) +
  scale_fill_brewer(palette = "Paired") + theme_classic()

# Race Plot
p <- ggplot(RacePlot, aes(x = Version, y = EAA, fill = Race)) + 
  geom_bar(stat = "identity", position = position_dodge()) +
  geom_errorbar(aes(ymin = EAA - ic, ymax = EAA + ic), width = 0.2, position = position_dodge(0.9)) +
  scale_fill_brewer(palette = "Paired") + theme_classic()

# Age Plot
p <- ggplot(AgePlot, aes(x = Version, y = EAA, fill = Age)) + 
  geom_bar(stat = "identity", position = position_dodge()) +
  geom_errorbar(aes(ymin = EAA - ic, ymax = EAA + ic), width = 0.2, position = position_dodge(0.9)) +
  scale_fill_brewer(palette = "Paired") + theme_classic()

# ---------------------------
# Section 2: LDL/HDL Ratio Plot
# ---------------------------
install.packages("ggpubr")
library(ggpubr)

p <- ggplot() + theme_classic() +
  geom_point(data = metac2, aes(x = LDLHDLratio, y = AgeAdjustedGrimAge), color = "magenta1", shape = 2) +
  geom_point(data = metac2, aes(x = LDLHDLratio, y = AgeAdjustedGrimAge2), shape = 1, color = "mediumblue") +
  geom_smooth(data = metac2, aes(x = LDLHDLratio, y = AgeAdjustedGrimAge), method = lm, color = "magenta1") +
  geom_smooth(data = metac2, aes(x = LDLHDLratio, y = AgeAdjustedGrimAge2), method = lm, color = "mediumblue") +
  stat_regline_equation(data = metac2, aes(x = LDLHDLratio, y = AgeAdjustedGrimAge), color = "magenta1", label.y = 16) +
  stat_regline_equation(data = metac2, aes(x = LDLHDLratio, y = AgeAdjustedGrimAge2), color = "mediumblue", label.y = 15)

p
ggsave(p, filename = "/Users/ellisnr/Desktop/LDLHDLratio.png")

# ---------------------------
# Section 3: Manhattan Plots
# ---------------------------

library(dplyr)
library(gridExtra)
library(ggrepel)

# Alcohol Intake Frequency (AIF)
# Load dataset
AIF <- read.csv("/Users/ellisnr/Desktop/Dan Projects/AIF.csv")

# Add a column to identify significant points based on P-value
AIF <- AIF %>%
  mutate(Significant = ifelse(Pvalue < 0.05, "Significant", "Not Significant"))

# Generate Manhattan plot for AIF
p_AIF <- ggplot(AIF, aes(x = QTL.source, y = -log10(Pvalue), color = Significant)) +
  geom_point(size = 4, alpha = 0.7) +
  geom_label_repel(
    aes(label = ifelse(Pvalue < 0.05, hgnc.Symbol, "")),
    size = 3,
    box.padding = 0.5,
    point.padding = 0.5,
    max.overlaps = Inf
  ) +
  theme_bw() +
  theme(
    axis.text.x = element_text(size = 14, angle = 60, hjust = 1),
    axis.text.y = element_text(size = 14),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    axis.line = element_line(),
    legend.position = "top"
  ) +
  geom_hline(yintercept = 1.301, linetype = "dashed", color = "red") +
  scale_y_continuous(limits = c(0, 5), expand = c(0, 0)) +
  scale_color_manual(values = c("Not Significant" = "blue", "Significant" = "red")) +
  labs(
    title = "Manhattan Plot: Alcohol Intake Frequency",
    x = "QTL Source",
    y = "-log10(P-value)",
    color = "Significance"
  )

# Display plot
print(p_AIF)

# Save plot
ggsave("Manhattan_Plot_AIF.png", plot = p_AIF, width = 10, height = 6, dpi = 300)


# Repeat for other outcomes (e.g., drinks per week, binge drinking, PAU)

# ---------------------------
# Section 4: Forest Plots
# ---------------------------
library(viridis)

example <- read.csv("/Users/ellisnr/Desktop/Dan Projects/Forest Plot Replication/example.csv")
forest <- ggplot(
  data = example,
  aes(x = QTL.source, y = rr, ymin = low_ci, ymax = up_ci)
) +
  geom_pointrange(aes(col = QTL.source)) +
  scale_color_viridis(discrete = TRUE, option = "D") +
  geom_hline(yintercept = 0, colour = "red") +
  xlab("QTL Source") +
  ylab("95% Confidence Interval") +
  geom_errorbar(aes(ymin = low_ci, ymax = up_ci, col = QTL.source), width = 0, cex = 1) +
  theme_classic() +
  facet_wrap(~X, strip.position = "top", nrow = 9, scales = "free_y") +
  theme(
    panel.background = element_blank(), strip.background = element_rect(colour = NA, fill = NA),
    strip.text.y = element_text(face = "bold", size = 12),
    strip.text = element_text(face = "bold"),
    legend.position = "none",
    axis.title = element_text(face = "bold"),
    plot.title = element_text(face = "bold", hjust = 0.5, size = 13)
  ) +
  coord_flip()
forest

# Optional: Debugging or additional adjustments for the table

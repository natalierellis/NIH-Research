# This script covers data import, descriptive statistics, 
# visualization, regression analysis, and statistical tests in R. 

# 1. Data Import and Setup

# Load necessary libraries
library(tidyverse)
library(car)      # For checking normality
library(rstatix)  # For summary stats and statistical tests

# Import data (navigate to your file, import, and copy the generated code here)
# Example:
# dataset <- read.csv("path/to/your/file.csv")

# View the dataset
View(dataset)

# Check available datasets in R
data()

# Get an overview of the dataset
glimpse(dataset)

# 2. Descriptive Statistics

# Summary statistics for a column
mean(dataset$column_name)
median(dataset$column_name)
range(dataset$column_name)  # Returns min and max as a vector
min(dataset$column_name)
max(dataset$column_name)
sd(dataset$column_name)     # Standard deviation
quantile(dataset$column_name)  # Quartiles
IQR(dataset$column_name)       # Interquartile range

# 3. Data Subsetting and Transformation

# Subset data based on a condition
new_data <- dataset %>% filter(column_name > 5)

# Create a new column using mutate()
dataset <- dataset %>% mutate(new_column = old_column / 1000)

# Group data and calculate mean
grouped_mean <- dataset %>%
  group_by(class) %>%
  summarise(mean_value = mean(column_name, na.rm = TRUE))

# Convert quantitative to qualitative data
dataset <- dataset %>% mutate(qualitative_column = ifelse(column_name > 50, "High", "Low"))

# 4. Check Normality

# Q-Q plot for normality
qqPlot(dataset$column_name)

# Shapiro-Wilk test for normality
dataset %>%
  group_by(group_column) %>%
  shapiro_test(column_name)

# 5. Data Visualization

# Histogram
ggplot(dataset, aes(x = column_name)) +
  geom_histogram(binwidth = 5) +
  labs(title = "Histogram", x = "Column Name", y = "Frequency")

# Scatterplot with regression line
ggplot(dataset, aes(x = independent_var, y = dependent_var)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Scatterplot with Regression Line", x = "X-axis Label", y = "Y-axis Label")

# Bar chart of means grouped by a variable
ggplot(dataset, aes(x = class, y = column_name, fill = class)) +
  stat_summary(fun = "mean", geom = "bar") +
  labs(title = "Bar Chart of Means", x = "Class", y = "Mean Value")

# 6. Regression Analysis

# Simple linear regression
model1 <- lm(dependent_var ~ independent_var, data = dataset)
summary(model1)

# Multiple linear regression
model2 <- lm(dependent_var ~ independent_var1 + independent_var2, data = dataset)
summary(model2)

# Check assumptions of regression
plot(model2)

# 7. Outlier Removal

# Identify outliers in a column
outliers <- boxplot(dataset$column_name, plot = FALSE)$out

# Remove outliers from the dataset
cleaned_data <- dataset %>% filter(!column_name %in% outliers)

# 8. T-Test

# Run Welch's t-test (default: unequal variances)
t.test(column_name ~ group, data = dataset, var.equal = FALSE)

# Run paired t-test
t.test(dataset$column1, dataset$column2, paired = TRUE)

# 9. Checking Assumptions for Statistical Tests

# Boxplot for visualizing group differences
ggplot(dataset, aes(x = group_column, y = column_name)) +
  geom_boxplot() +
  labs(title = "Boxplot", x = "Group", y = "Value")

# Levene's test for equal variances
dataset %>%
  levene_test(column_name ~ group_column)

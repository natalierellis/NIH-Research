https://statsandr.com/blog/descriptive-statistics-in-r/
#reading in data
#navigate to correct file, click to import, copy commands into doc
view(dataset)
#load tidyverse
library(tidyverse)
#datasets already in R
data()
#overall variable summary 
glimpse()

#descriptive stats
mean(), median(), mfv()[modeest], range(), 
min(), maximum(), sd(), quantile(),
IQR()

#correlation
cor(dat$Sepal.Length, dat$Sepal.Width)

#to subset a dataframe based on a filter
new_data <- filter(data, column > 5)
new_data <- data %>%
  filter(column == "value") 
##Use mutate() to create a new column from existing data by performing a calculation or other command##
data %>%
  mutate(newcolumn = oldcolumn / 1000)
#find mean and median of specific column within dataframe
mean <- mpg %>%
  group_by(class) %>%
  summarise(mean(cty))

#turning quantitative to qualitative 
ifelse 

#check normality 
library(car) # package must be installed first
qqPlot(dat$Sepal.Length)

#data visualization 
#first example - histogram (frequencies)
#you can layer things
ggplot(mpg, aes(x=cty)) + 
  geom_histogram()
#scatterplot with regression line
ggplot(mpg, aes(x=cty,
                y=hwy))+
  geom_point()+
  geom_smooth(method = "lm")+
  labs(title = "blanK",
       x = )
#scatterplot, grouped by class - needs geom_point for scatterplot
#with all of these, runs regressions for each class
cars
ggplot(cars, aes(x=speed,
                y=dist,
                fill = class))+
  geom_point()+
  geom_smooth(method = "lm")

#barchart - only works using original dataset
ggplot(mpg, aes(x = class,
                y = cty, 
                fill = class))+
 stat_summary_bin(fun = "mean", geom = "bar")

#taking from dataset where stats were already applied
p <- ggplot(mean, 
            aes(x=class,
                y=cty,
                fill=class)) + 
  geom_bar(stat="identity")

p + scale_fill_brewer(palette="Paired") + theme_classic()

#regression analyses:
#simple linear
ggplot(cars, aes(x=speed,
                 y=dist))+
  geom_point()+
  geom_smooth(method = "lm")
model1 <- lm(dist ~ speed, data = cars)
summary(model1)

#multiple linear
ggpairs(df)
#run model
plots(model) - check assumptions 
#what does it mean?
#estimate - rise over run when others left in model
#P-value: reject null that coefficient is equal to zero

#removing outliers (in one column):
outliers <- boxplot(mpg$cty)$out
x <- mpg
x <- x[-which(x$cty %in% outliers),]

#t-test and assumptions:
#tests for equality of means
#welch t-test does not assume equal sample sizes or equal variances
#if variances are equal, correct and make it pooled t-test
#view boxplot 
ggplot(blocks, aes(x=independent variable
                   y = dependent variable))+
  geom_boxplot()

#check summary stats
library(rstatix)
ancova %>%
  group_by(Race) %>%
  get_summary_stats(AgeAdjGrimAge2)

#check for normality 
ancova %>%
  group_by(CTQ_Group) %>%
  shapiro_test(AgeAdjGrimAge)

#check for equal variances 
ancova %>% levene_test(AgeAdjGrimAge ~ AUD_Group)

#run t-test, alternative if one-sided
t.test(AgeAdjGrimAge2 ~ Sex, data=ancova, var.equal = FALSE, alternative = "greater")
t.test(data$IV, data$IV, paired = TRUE)



#1. Using the faithful data, use kmeans to make reasonable clusters of the data
#   Plot the data with clusters colored and points representing the final k-means centers
#   Do the clusters seem reasonable?
library(tidyverse)
view(faithful)
#plot data to see where clusters might be located
ggplot(faithful, aes(x=waiting,
                 y=eruptions))+
  geom_point()
#establish clusters
kvals=kmeans(faithful, data.frame(c(55,2), c(80,4.5)))

#need to merge datasets 
faithful$cluster=kvals$cluster
df <- data.frame(
  x = c(80.28, 54.75),
  y = c(4.30, 2.06)
)
#create plot with k-means centers
ggplot(faithful, aes(x=waiting,
                     y=eruptions,
                     color = cluster))+
  geom_point()+
geom_point(aes(x=80.28, y=4.30), color = "red", shape = 4)+
  geom_point(aes(x=54.75, y=2.06), color = "red", shape = 4)

#yes, the clusters seem mostly reasonable 

#2. Calculate the first and second principal components of the faithful data
#   Plot the data with point size representing one PC and color representing the other
#   Can you tell what "lines" were used to calculate each PC based on this representation?
#   Define data clusters based on PC1 and visualize them - do these clusters make sense?
#   Do the same for PC2 - do these clusters make sense?

data(faithful)
pcs = prcomp(faithful)
summary(pcs)

faithful$PC1=pr$x[,1]
faithful$PC2=pr$x[,2]

library(ggplot2)
ggplot()+
  geom_point(data=faithful, aes(x=eruptions, 
                                y=waiting, 
                                size=PC1, 
                                color=PC2))

faithful$PC1c=ifelse(faithful$PC1>mean(faithful$PC1), "1", "2")
faithful$PC2c=ifelse(faithful$PC2>mean(faithful$PC2), "1", "2")

ggplot()+
  geom_point(data=faithful, aes(x=eruptions, 
                                y=waiting, 
                                color=PC1c))
ggplot()+
  geom_point(data=faithful, aes(x=eruptions, 
                                y=waiting, 
                                color=PC2c))

#3. Fit a random forest model with the Anage data to predict class (Aves, Mammalia, or Teleostei)
#   using the maximum longevity and adult weight variables
#   How well does your model do?
anage=read.table("/Users/ellisnr/Downloads/anage_data.txt", quote="", sep = "\t", stringsAsFactors = F, header = T)
glimpse(anage)
library(randomForest)
rf <- anage[,c(4,19,21)]
colnames(rf)[2] = "weight"
colnames(rf)[3] = "longevity"
rf=rf[rf$Class %in% c("Aves", "Mammalia", "Teleostei"),]
mod <- randomForest(Class ~ weight, longevity, data = rf)
rf <- na.omit(rf)
mod <- randomForest(as.factor(Class)~., data = rf)
preds=predict(mod, type = "response")
table(rf$Class, preds)

#this model is reasonable as the majority of instances fall along the diagonal

#4. Using the same data as Q3, fit a basic neural network using nnet.
#   How do the predictions compare to those from randomForest?
library(nnet)
glimpse(rf)
mod <- nnet(as.factor(Class)~., data = rf, size =5)
preds=predict(nn, type = "class")
preds
table(rf$Class, preds)

#comparing the two prediction matrices, random forest model performs better because
#there are more instances on the diagonal in the random forest prediction matrix







library(tidyverse)
library(caTools)
library(ggplot2)
library(ElemStatLearn)
library(broom)
library(class) # for KNN

## import data
social <- read_csv("Social_Network_Ads.csv")
dim(social)
summary(social)
glimpse(social)

'Social network`s automotive business client has launched its brand new luxury SUV and purchased ads for its marketing campaign. The 
social network collected data on the users and whether or not the bought the SUV after seeing the ad

We will only use age and salary to predict this'

## Cut down dataset
social <- social %>%
  select(Age,EstimatedSalary,Purchased) %>% # cut down cols
  mutate(Purchased = factor(Purchased, levels = c(0,1)),
         # scale data (age is in 10s, salary in 10k's)
         Age = c(scale(Age)), # use c(scale)) to prevent scale from changing class of the column
         EstimatedSalary = c(scale(EstimatedSalary))) # Encode target/outcome variable as fact

## Split data
set.seed(123)
spl <- sample.split(social$Purchased, SplitRatio = 3/4)
training <- subset(social, spl == T)
test <- subset(social, spl == F)


## Train model w/ training set + make predictions (at once)
# be sure to not use outcome variable for training or tests sets
y.pred.train <- knn(training[,-3], test[,-3], cl = training$Purchased, k = 5)
summary(y.pred.train)

## Make Confusion Matrix
(table(test$Purchased, y.pred.train))

fpr <- 5/(5+30) # FP / (FP + TP)
fnr <- 6/(6+59) # FN / (FN + TN)


## Create function to visualize different set results
plot.knn.model <- function(set) {
  x1 <- seq(min(set[,1]) - 1, max(set[,1]) + 1, by = 0.05) # get sminimum scaled age + go up to the max by increments of .1
  x2 <- seq(min(set[,2]) - 1, max(set[,2]) + 1, by = 0.05) # get minimum scaled salary + go up to the max by increments of .1
  
  set.grid <- expand.grid(x1,x2) # Create DF from all possible combos of the age + salary vectors to make a grid
  colnames(set.grid) <- c("Age","EstimatedSalary")
  
  y.pred.grid <- knn(training[,-3], set.grid, cl = training$Purchased, k = 5) # use grid to predict values w/ our model
  
  plot(set[,-3],
       main = "KNN",
       xlab = "Age",
       ylab = "Estimated Salary",
       xlim = range(x1),
       ylim = range(x2))
  
  contour(x1,x2, matrix(as.numeric(y.pred.grid), length(x1), length(x2)), add = T) # add logistic regression "split" line
  
  points(set.grid, pch = 19, col = if_else(y.pred.grid == 1, "springgreen3", "tomato"))
  points(set, pch = 19, col = if_else(set[,3] == 1, "green4", "red3"))
  
}

plot.knn.model(training)
plot.knn.model(test)
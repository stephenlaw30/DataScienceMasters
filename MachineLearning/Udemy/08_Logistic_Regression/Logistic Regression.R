library(tidyverse)
library(caTools)
library(ggplot2)
library(ElemStatLearn)

## import data
social <- read_csv("Social_Network_Ads.csv")
dim(social)
summary(social)
glimpse(social)

'Social network`s automotive business client has launched its brand new luxury SUV and purchased ads for its marketing campaign. The 
social network collected data on the users and whether or not the bought the SUV after seeing the ad

We will only use age and salary to predict this'

(social <- social %>%
  select(Age,EstimatedSalary,Purchased))

# splitting data
library(caTools)
set.seed(123)

spl <- sample.split(social$Purchased, SplitRatio = .75)
training <- subset(social, spl == T) # 300 obs
test <- subset(social, spl == F) # 100 obs

## feature scaling
# age + EstimatedSalary are on very different scales

training <- training %>%
  mutate(Age = c(scale(Age)), # use c(scale)) to prevent scale from changing class of the column
         EstimatedSalary = c(scale(EstimatedSalary))) 
head(training)

test <- test %>%
  mutate(Age = c(scale(Age)),
         EstimatedSalary = c(scale(EstimatedSalary)))
head(test)

## fit to training data
log.reg <- lm(Purchased ~ ., training, family = "binomial") # binomial regression (1 or 0, yes or no, etc.)
summary(log.reg)

# Both age and salary are "good" predictors of purchased, but our R2 is quite low

# predict test set probabilities whilst removing the last column (the outcome)
test.prob <- predict(log.reg, newdata = test[-3], type= "response")
head(test)
head(test.prob)
'Looks pretty good'

# get the 0/1 results
y.pred <- if_else(test.prob > .5, 1, 0)
table(y.pred)

# accuracy confusion matrix w/ table(real,pred)
table(test$Purchased,y.pred)

fpr <- 7/(25+7) # FP / (FP + TP)
fnr <- 11/(11+57) # FN / (FN + TN)

## Visualize Traning Set Results
#set <- training
x1 <- seq(min(training[,1]) - 1, max(training[,1]) + 1, by = 0.1) # get the minimum scaled age + go up to the max by increments of .1
x2 <- seq(min(training[,2]) - 1, max(training[,2]) + 1, by = 0.1) # get the minimum scaled salary + go up to the max by increments of .1

training.grid <- expand.grid(x1,x2) # Create DF from all possible combos of the age + salary vectors
colnames(training.grid) <- c("Age","EstimatedSalary")

training.probability <- predict(log.reg, newdata = training.grid.set, type = "response") # use grid to predict values w/ our model
y.pred.grid <- if_else(training.probability > .5, 1, 0)

plot(training[,-3],
     main = "Logistic Regression (Training Set)",
     xlab = "Age",
     ylab = "Estimated Salary",
     xlim = range(x1),
     ylim = range(x2))

contour(x1,x2, matrix(as.numeric(y.pred.grid), length(x1), length(x2)), add = T) # add logistic regression "split" line

points(training.grid, pch = ".", col = if_else(y.pred.grid == 1, "springgreen3", "tomato"))
points(training, pch = 21, col = if_else(training[,-3] == 1, "green4", "green3"))
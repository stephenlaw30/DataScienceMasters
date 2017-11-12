library(tidyverse)
library(caTools)
library(ggplot2)
library(ElemStatLearn)
library(broom)

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
log.reg <- glm(Purchased ~ ., training, family = "binomial") # binomial regression (1 or 0, yes or no, etc.)
summary(log.reg)

tidy(log.reg)


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

## Create function to visualize different set results
plot.logistic.model <- function(set) {
  x1 <- seq(min(set[,1]) - 1, max(set[,1]) + 1, by = 0.05) # get sminimum scaled age + go up to the max by increments of .1
  x2 <- seq(min(set[,2]) - 1, max(set[,2]) + 1, by = 0.05) # get minimum scaled salary + go up to the max by increments of .1
  
  set.grid <- expand.grid(x1,x2) # Create DF from all possible combos of the age + salary vectors to make a grid
  colnames(set.grid) <- c("Age","EstimatedSalary")
  
  set.probability <- predict(log.reg, newdata = set.grid, type = "response") # use grid to predict values w/ our model
  y.pred.grid <- if_else(set.probability > .5, 1, 0)
  
  plot(set[,-3],
       main = "Logistic Regression (set Set)",
       xlab = "Age",
       ylab = "Estimated Salary",
       xlim = range(x1),
       ylim = range(x2))
  
  contour(x1,x2, matrix(as.numeric(y.pred.grid), length(x1), length(x2)), add = T) # add logistic regression "split" line
  
  points(set.grid, pch = 19, col = if_else(y.pred.grid == 1, "springgreen3", "tomato"))
  points(set, pch = 19, col = if_else(set[,3] == 1, "green4", "red3"))
  
}

## Visualize Training Set Results
plot.logistic.model(training)

'We can see most training set observations who actually made a purchase (green circles) are in the green area (classifier predictions
of purchased = 1) and most training set observations who did NOT make a purchase (red circles) are in the red region (classifier 
predictions of purchased = 0)

The *straight, linear* line splitting these 2 regions is our **prediction boundary**. Younger users with lower estimated salaries 
were less likely to but the SUV and less did. The opposite goes for older users with higher estimated salaries.

The social network can focus their SUV marketing campaign towards users who would fall into the green region as they are predicted
to be more likely to make a purchase.

Prediction boundary will not be a straight line for non-linear classifiers.

Our logistic regression classifier does a pretty good job of catching the correct users who purchased and those who did not. Incorrect
predictions are due to the fact that our classifier is linear but our data is *not* linearly distributed.

Now see if the classifier generalizes well to new data.'

## Visualize Test Set Results
plot.logistic.model(test)

'Again, the majority of red points are in the red region, and the majority of the green points are in the green region.'
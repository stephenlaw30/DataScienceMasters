install.packages("shiny")
install.packages("RPresto")
devtools::install_github("ricardo-bion/ggtech", dependencies=TRUE)
install.packages("extrafont")
library(extrafont)
library(utils)
## Facebook 
download.file("http://social-fonts.com/assets/fonts/facebook-letter-faces/facebook-letter-faces.ttf", "C:/Users/NEWNSS/Dropbox/facebook-letter-faces.ttf", method="curl")

font_import(pattern = "C:/Users/NEWNSS/Dropbox/facebook-letter-faces.ttf", prompt=FALSE)


## Google 
download.file("http://social-fonts.com/assets/fonts/product-sans/product-sans.ttf", "C:/Users/NEWNSS/Dropbox/product-sans.ttf", method="curl")

font_import(pattern = 'product-sans.ttf', prompt=FALSE)


## Airbnb 
download.file("https://github.com/ricardo-bion/ggtech/blob/master/Circular%20Air-Medium%203.46.45%20PM.ttf", "C:/Users/NEWNSS/Dropbox/Circular Air-Medium 3.46.45 PM.ttf", method="curl")

download.file("https://github.com/ricardo-bion/ggtech/blob/master/Circular%20Air-Bold%203.46.45%20PM.ttf", "C:/Users/NEWNSS/Dropbox/Circular Air-Bold 3.46.45 PM.ttf", method="curl")

font_import(pattern = 'Circular', prompt=FALSE)


## Etsy 
download.file("https://www.etsy.com/assets/type/Guardian-EgypTT-Text-Regular.ttf", "C:/Users/NEWNSS/Dropbox/Guardian-EgypTT-Text-Regular.ttf", method="curl")

font_import(pattern = 'Guardian-EgypTT-Text-Regular.ttf', prompt=FALSE)


## Twitter 
download.file("http://social-fonts.com/assets/fonts/pico-black/pico-black.ttf", "C:/Users/NEWNSS/Dropbox/pico-black.ttf", method="curl")

download.file("http://social-fonts.com/assets/fonts/arista-light/arista-light.ttf", "C:/Users/NEWNSS/Dropbox/arista-light.ttf", method="curl")

font_import(pattern = 'pico-black.ttf', prompt=FALSE)
font_import(pattern = 'arista-light.ttf', prompt=FALSE)

library(devtools)
install.packages("RTools")
install_github("susanathey/causalTree")

install.packages("NLopt")

install.packages("dygraphs")

install.packages("leaflet")

install.packages("DiagrammeR")

install.packages("plotly")

install.packages("broom")

install.packages("pwr")



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
library(broom)
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

## Visualize Training Set Results
#set <- training
x1 <- seq(min(training[,1]) - 1, max(training[,1]) + 1, by = 0.05) # get sminimum scaled age + go up to the max by increments of .1
x2 <- seq(min(training[,2]) - 1, max(training[,2]) + 1, by = 0.05) # get minimum scaled salary + go up to the max by increments of .1

training.grid <- expand.grid(x1,x2) # Create DF from all possible combos of the age + salary vectors to make a grid
colnames(training.grid) <- c("Age","EstimatedSalary")

training.probability <- predict(log.reg, newdata = training.grid, type = "response") # use grid to predict values w/ our model
y.pred.grid <- if_else(training.probability > .5, 1, 0)

plot(training[,-3],
     main = "Logistic Regression (Training Set)",
     xlab = "Age",
     ylab = "Estimated Salary",
     xlim = range(x1),
     ylim = range(x2))

contour(x1,x2, matrix(as.numeric(y.pred.grid), length(x1), length(x2)), add = T) # add logistic regression "split" line

points(training.grid, pch = 19, col = if_else(y.pred.grid == 1, "springgreen3", "tomato"))
points(training, pch = 19, col = if_else(training[,3] == 1, "green4", "red3"))

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
#set <- test
x1 <- seq(min(test[,1]) - 1, max(test[,1]) + 1, by = 0.05) # get sminimum scaled age + go up to the max by increments of .1
x2 <- seq(min(test[,2]) - 1, max(test[,2]) + 1, by = 0.05) # get minimum scaled salary + go up to the max by increments of .1

test.grid <- expand.grid(x1,x2) # Create DF from all possible combos of the age + salary vectors
colnames(test.grid) <- c("Age","EstimatedSalary")

test.probability <- predict(log.reg, newdata = test.grid, type = "response") # use grid to predict values w/ our model
y.pred.grid <- if_else(test.probability > .5, 1, 0)

plot(test[,-3],
     main = "Logistic Regression (Test Set)",
     xlab = "Age",
     ylab = "Estimated Salary",
     xlim = range(x1),
     ylim = range(x2))

contour(x1,x2, matrix(as.numeric(y.pred.grid), length(x1), length(x2)), add = T) # add logistic regression "split" line

points(test.grid, pch = 19, col = if_else(y.pred.grid == 1, "springgreen3", "tomato"))
points(test, pch = 19, col = if_else(test[,3] == 1, "green4", "red3"))

'Again, the majority of red points are in the red region, and the majority of the green points are in the green region.'
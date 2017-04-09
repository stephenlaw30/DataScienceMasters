# Data Preprocessing

# Importing the dataset
setwd('C:/Users/Nimz/Dropbox/DataScienceMasters/R/MachineLearningAZ/01_Data_Preprocessing')
dataset = read.csv('Data.csv')

str(dataset)

#check for NA's
summary(dataset)

#see in Age and Salary

# Taking care of missing data by imputting the mean of the missing value from the entire dataset, ignoring that NA
dataset$Age = ifelse(is.na(dataset$Age),
                      mean(dataset$Age, na.rm = TRUE), #ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)),dataset$Age)
                        dataset$Age)
                     
dataset$Salary = ifelse(is.na(dataset$Salary),
                          mean(dataset$Salary, na.rm = TRUE), #ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)),dataset$Salary)
                            dataset$Salary)

#add new encoding to categorical variables
dataset$Country <- factor(dataset$Country, levels = c('France','Spain','Germany'), labels = c(1,2,3))

dataset$Purchased <- factor(dataset$Purchased, levels = c('No','Yes'), labels = c(0,1))

str(dataset)

#split data into test and training
library(caTools)
set.seed(123)

#split so that 80% of data is in training, 20% in test and preserve relative rations (0.8) of Purchased Dep Var
spl = sample.split(dataset$Purchased, SplitRatio = 0.8)

training_set = subset(dataset, spl == TRUE)
test_set = subset(dataset, spl == FALSE)

'********************FEATURE SCALING*********************

Age and Salary are not on the same scale (2-60 vs. 40k-80k), which will cause some issues in the machine learning model

This is b/c most ML models are based on the *Euclidean Distance* = the distance between 2 points = Sqrt[(x2 - x1)^2 + (y2-y1)^2]

Since salary has a much larger scale, it will dominate the Euclidean Distance, so we need to *transform* the 2 variables so that 
they are on the same scale, -1 -> +1

A common way of feature scaling is *STANDARDIZATION*, where we subtract the mean from each observation and divide it by the SD
  - Xst = (X - mean(x)) / SD(x)

Another is *NORMALIZATION*, in which we subtract the min value of the variable from the observation and divide by the max value minus
the min value
  - Xnorm = (X - min(x)) / (max(x) - min(x))'

#SCALE() only the cols we need to --> age and salary
training_set.std <- training_set
test_set.std <- test_set

training_set.std[,2:3] <- scale(training_set.std[,2:3])
test_set.std[,2:3] <- scale(test_set.std[,2:3])

'Now our data is ready to offer good precision and accuracy and a fast-working ML model (it will converge rapidly)'
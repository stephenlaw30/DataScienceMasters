---
title: "SVM"
author: "Steve Newns"
output: html_document
---

# Kernel SVM


```r
library(tidyverse)
library(ggplot2)
library(caTools)
library(e1071) # most popular SVM libary, other is `kernlab`
library(ElemStatLearn)
```

Social network`s automotive business client has launched its brand new luxury SUV and purchased ads for its marketing campaign. The social network collected data on the users and whether or not the bought the SUV after seeing the ad.

We will only use age and salary to predict this. 

Can use kernel SVM to overcome to non-linear relationship between our variables.


```r
## import data 
social <- read_csv("Social_Network_Ads.csv")

## Cut down dataset
social <- social %>%
  select(Age,EstimatedSalary,Purchased) %>% # cut down cols
  mutate(Purchased = factor(Purchased, levels = c(0,1)), # encode outcome
         # scale data (age is in 10s, salary in 10k's)
         Age = c(scale(Age)), # use c(scale)) to prevent scale from changing class of the column
         EstimatedSalary = c(scale(EstimatedSalary))) # Encode target/outcome variable as fact
```

Now to get to the modeling.


```r
# split data into Training + Test sets
set.seed(123)

spl <- sample.split(social$Purchased, SplitRatio = 0.75) # tidy does not work here

(training <- social %>%
  subset(spl == TRUE))
```

```
## # A tibble: 300 x 3
##           Age EstimatedSalary Purchased
##         <dbl>           <dbl>    <fctr>
##  1 -1.7795688      -1.4881825         0
##  2 -1.1118131      -0.7843075         0
##  3 -1.0164195      -0.3443855         0
##  4 -1.0164195       0.4181458         0
##  5 -0.5394512       2.3538022         1
##  6 -0.2532702      -0.1390886         0
##  7 -1.1118131       0.3008333         0
##  8 -1.6841751       0.4768020         0
##  9 -0.5394512      -1.5175106         0
## 10 -1.8749625       0.3594895         0
## # ... with 290 more rows
```

```r
(test <- social %>%
  subset(spl == FALSE))
```

```
## # A tibble: 100 x 3
##           Age EstimatedSalary Purchased
##         <dbl>           <dbl>    <fctr>
##  1 -0.2532702      -1.4588544         0
##  2 -1.0164195      -0.3737137         0
##  3 -1.7795688       0.1835208         0
##  4 -1.2072068      -1.0775887         0
##  5 -1.1118131      -0.5203543         0
##  6  0.7006665      -1.2828856         1
##  7  0.7960601      -1.2242294         1
##  8  0.9868474      -1.1949012         1
##  9  0.8914538      -0.6083387         1
## 10 -0.8256322      -0.7843075         0
## # ... with 90 more rows
```

## Fitting Kernel SVM to the Training set

We will set `type` to be **C-classification** to make sure we're doing a classification machine and `kernel` to be **linear**, as we are starting w/ the most basic kernel, the **linear kernel**.

Then, we will make predictions on the test set with the **(Gaussian) Radial Basis Function** kernel.


```r
social.svm <- svm(Purchased ~ ., training, type = 'C-classification', kernel = 'radial')

# Predict on test set results
y_pred.svm <- predict(social.svm, test[-3])
```

Now we will check our prediction results vs. the actual results with a confusion matrix.

```r
## Making the Confusion Matrix
(cm <- table(test$Purchased, y_pred.svm))
```

```
##    y_pred.svm
##      0  1
##   0 58  6
##   1  4 32
```

```r
sensitivity <- cm[4] / (cm[4] + cm[2]) # true positive rate = TP / (TP + FN)
specificity <- cm[1] / (cm[1] + cm[3]) # recall = true negative rate = TN / (TN + FP)
precision <- cm[1] / (cm[1] + cm[2]) # TP / predicted Pos
accuracy <- (cm[4]+cm[1]) / sum(cm) # TP + TN / n

cat("\nSensitivity (TP rate): ",sensitivity)
```

```
## 
## Sensitivity (TP rate):  0.8888889
```

```r
cat("\nSpecificity (TN rate or Recall): ",specificity)
```

```
## 
## Specificity (TN rate or Recall):  0.90625
```

```r
cat("\nPrecision (Positive Predictive Value): ",precision)
```

```
## 
## Precision (Positive Predictive Value):  0.9354839
```

```r
cat("\nAccuracy: ",accuracy)
```

```
## 
## Accuracy:  0.9
```

Now we need to visualize the results.

```r
## Create function to visualize different set results
plot.svm.model <- function(set) {
  x1 <- seq(min(set[,1]) - 1, max(set[,1]) + 1, by = 0.05) # get sminimum scaled age + go up to the max by increments of .1
  x2 <- seq(min(set[,2]) - 1, max(set[,2]) + 1, by = 0.05) # get minimum scaled salary + go up to the max by increments of .1
  
  set.grid <- expand.grid(x1,x2) # Create DF from all possible combos of the age + salary vectors to make a grid
  colnames(set.grid) <- c("Age","EstimatedSalary")
  
  y_pred.svm.grid <- predict(social.svm, set.grid) # use grid to predict values w/ our model
  
  plot(set[,-3],
       main = c("Radial SVM (", deparse(substitute(set))," set)"), # get set name from argument given
       xlab = "Age",
       ylab = "Estimated Salary",
       xlim = range(x1),
       ylim = range(x2))
  
  contour(x1,x2, matrix(as.numeric(y_pred.svm.grid), length(x1), length(x2)), add = T) # add logistic regression "split" line
  
  points(set.grid, pch = 19, col = if_else(y_pred.svm.grid == 1, "springgreen3", "tomato"))
  points(set, pch = 19, col = if_else(set[,3] == 1, "green4", "red3"))
  
}

plot.svm.model(training)
```

<img src="KernelSVM_files/figure-html/unnamed-chunk-6-1.png" width="672" />

```r
plot.svm.model(test)
```

<img src="KernelSVM_files/figure-html/unnamed-chunk-6-2.png" width="672" />

See that our classifier is indeed non-linear + also capture most DP's correctly.

Since our data is in a 2D space and our classifer is non-linear, that means our data was mapped/projected onto a 3D space and a **hyperplane** was found that linearly seperated the data in the 3D space. Then the data and the hyperplane were projected back into the 2D space to give the plots above with the non-linear classifier.

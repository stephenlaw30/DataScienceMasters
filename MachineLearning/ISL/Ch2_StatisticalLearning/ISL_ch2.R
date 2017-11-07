setwd('C:/Users/Nimz/Dropbox/DataScienceMasters/Stats/ISL/Ch2_StatisticalLearning')

## develop an accurate modelthat can be used to predict sales on the basis of the different 
##    channels' advertising budgets.'

ads <- read.csv('Advertising.csv')
head(ads)

library(dplyr)
library(ggplot2)

glimpse(ads)

'Quantitative response variable Y = Sales with 3 predictors (channels) + we assume some relationship written as
  Y = f(X) + E where f(X) is a function of the values of the channels and E = epsilon/error w/ mean = 0 and is 
  independent of X

We are estimating Y based on given X values/points. The errors in our predictions vs. actual values should have
   a mean = 0.

Statistical learning refers to a set of approaches for estimating f.'

tv_sales <- ggplot(ads) + geom_point(aes(TV,Sales)) # most condensed plot
nwsppr_sales <- ggplot(ads) + geom_point(aes(Newspaper,Sales)) # most scattered plot
radio_sales <- ggplot(ads) + geom_point(aes(Radio,Sales))

'2 main reasons to estimate f:
  - prediction
    - may have x values readily available, but cannot easily obtain y values
    - since E averages to 0, we can predict with w/ y_hat = f_hat(x)
    - f_hat is usually a black box, provided it yields accurate predictions for y
    - accuracy of y_hat in relation to y depends on REDUCIBLE ERROR and IRREDUCIBLE ERROR
    - f_hat will generally not be a perfect estimate of f, and the error in this estimate 
        is REDUCIBLE
    - We can potentially improve the accuracy of f_hat via the most appropriate statisical
        learning technique
    - Even if we found the "perfect" estimate, we would still have error because Y is also
         a function of E, which cannot be predicted with X, by definition
    - Therefore variability in E also affects prediction accuracy, and is the IRREDUCIBLE 
        error
    - E may contain unmeasures variables useful in predicting Y, and since we do not 
      measure them, we cannot use them in f to predict Y
    - E may also carry unmeasurable variation (variation in drug manufacturing or in how
         a patient is feeling may vary the risk of an adverse reaction)
    - E(Y - Y_hat)^2
  - inference
'

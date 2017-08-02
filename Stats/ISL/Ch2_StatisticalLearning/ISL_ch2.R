setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/Stats/ISL/Ch2_StatisticalLearning')

'Suppose we are statistical consultants hired by a client to provide advice on how to improve sales of a product. 
  The dataset contains sales (in thousands of units) of a product over 200 different markets w/ advertising budgets
  for different channels/media.

It is not possible for our client to directly increase sales of the product. On the other hand, they can control
the advertising expenditure in each of the 3 channels. Therefore, if we determine that there is an association 
between advertising and sales, we can instruct our client to adjust advertising budgets, thereby indirectly 
increasing sales.

In other words, our goal is to develop an accurate modelthat can be used to predict sales on the basis of the 
3 channels budgets.'

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

statistical learning refers to a set of approaches for estimating f.'

tv_sales <- ggplot(ads) + geom_point(aes(TV,Sales)) # most condensed plot
nwsppr_sales <- ggplot(ads) + geom_point(aes(Newspaper,Sales)) # most scattered plot
radio_sales <- ggplot(ads) + geom_point(aes(Radio,Sales))


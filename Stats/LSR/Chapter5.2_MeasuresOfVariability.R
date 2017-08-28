'#Learning Statistics with R - University of Adelaide

## Part IIIV - Working with Data

### Chapter 5 - Descriptive Stats
#### 5.2 - Measures of Variability'

load('aflsmall.Rdata')
#install.packages('lsr')
#install.packages('ggplot2')
library(lsr)
library(ggplot2)

#see range
range(afl.margins)

#calculate range
max(afl.margins)-min(afl.margins)

#check quantiles
quantile(afl.margins) 
#get Q1
quantile(afl.margins, probs = 0.25) 
#get Q2/median
quantile(afl.margins, probs = 0.5)
#get Q3
quantile(afl.margins, probs = 0.75)

##IQR
# see Q1 and Q3
quantile(afl.margins, probs = c(.25,.75))
# calculate IQR
quantile(afl.margins, probs = 0.75) - quantile(afl.margins, probs = 0.25) 
IQR(afl.margins)

data <- c(56, 31, 56, 8, 32)
mean(data) #36.6

#calculate MEAN ABSOLUTE DEVIATION
variations <- abs(data - mean(data))
mean(variations) #15.52 = mean absolute deviation for these 5 scores

#calculate MEAN ABSOLUTE DEVIATION via add() function from lsr packages
aad(data)

'**Variance**'
variance <- (data - mean(data))^2
mean(variance) #324.64

#Base R function for variance
var(data) #405.8

'Answers are different? Check w/ afl.margins data'
variance <- (afl.margins - mean(afl.margins))^2

mean(variance) #675.9718
var(afl.margins) #679.8345

#R is evaluating a slightly different formula 
#   - Instead of averaging squared deviations (divide by the number of data points N = population), R divides by N - 1 (sample)'

sum((data-mean(data))^2)/4 #405.8
var(data) #405.8

#Std Dev
sd(afl.margins)

#**Median absolute deviation (MAD)**
median(abs(afl.margins - median(afl.margins))) #19.5

#R stats function
mad(afl.margins, constant = 1) #19.5
#default value of constant = 1.4826
mad(afl.margins) #28.9107
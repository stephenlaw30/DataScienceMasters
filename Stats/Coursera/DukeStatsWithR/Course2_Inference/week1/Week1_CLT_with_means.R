' About to take a trip to visit parents + drive is 6 hours + I make a random playlist of 100 songs. 
What is the probability my playlist lasts the entire drive?'

## 6 hours = 360 minutes ??? need 360 minutes worth of songs. 
mu <- 3.45
sigma <- 1.63
## P(X1 + X2 + . + X100 >= 360)
## Equivalent to average length of 100 songs being > 360 / 100 = 3.6 minutes
##??? P(X_ >= 3.6)

##Now have X.bar, the sample mean,
## CLT might be helpful to find the distribution of the sample mean pretty easily. 

## CLT says X.bar will be distributed nearly normally w/ mean = population mean, 3.45 min. + the standard error, SE_x = the population SD, sigma,
##    divided by the square root of n, the sample size
 
## random variable:, X_, our sample mean
## its distribution = normal
## its sampling distribution mean
X <- mu
## know something about its variability, the standard error (basically the SD of X.bar)
se_x <- sigma / sqrt(100)
## interested in some probability 
 
## Looking for observation of interest = 3.6 minutes + everything above that. 

# calculate Z-score
z <- (3.6 - X)/se_x

# get proportion of values lower than this z-score on the curve
pnorm(X,3.6,se_x)

#0.1787223 = 17.9% chance playlist lasts long enough

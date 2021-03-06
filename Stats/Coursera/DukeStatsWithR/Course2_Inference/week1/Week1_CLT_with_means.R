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





# get cutoff values for 90% CI 
qnorm(.05) # ~ -1.96
qnorm(1-.05) # ~ 1.96

# get cutoff values for 95% CI 
qnorm(.025) # ~ -1.96
qnorm(1-.025) # ~ 1.96

# get cutoff/critical values for 98% CI 
qnorm((1 - .98)/2) # ~ -1.96
qnorm(1-(1 - .98)/2) # ~ 1.96




# required sample size for MoE
target.MoE <- 4
alpha = .9
z = qnorm(1-((1-alpha)/2))
sigma = 18

(n.needed <- ((z*sigma)/target.MoE)^2)

target.MoE <- 2
alpha = .9
z = qnorm(1-((1-alpha)/2))
sigma = 18

(n.needed <- ((z*sigma)/target.MoE)^2)

## sample of 50 college students = avg 3.2 relationships w/ SD = 1.74, sample distribution skewed slightly right
# find 95% CI for the true avg. # of relationships
n = 50
sigma = 1.74
x.bar = 3.2
## since n = 50 < 10% of all US college students, we meet the indepedence assumption (sampling w/out replacement)
## since distribution is not THAT skewed and n >= 30, we can assume population is not that skewed
## therefore we meet the sample size/skew condition
z.crit <- qnorm(1-(1 - .95)/2) # ~ 1.96

se.x <- sigma/sqrt(n)
mOe <- z.crit*se.x

(ci.low <- x.bar - mOe)
(ci.low <- x.bar + mOe)

## quiz # 6
n = 36
sigma = 4.31
x.bar = 30.69
## since n = 36 < 10% of all gifted children in a large city, we meet the indepedence assumption (sampling w/out replacement)
## since distribution is not THAT skewed and n >= 30, we can assume population is not that skewed
## therefore we meet the sample size/skew condition
z.crit <- qnorm(1-(1 - .90)/2) # ~ 1.64

se.x <- sigma/sqrt(n)
mOe <- z.crit*se.x

(ci.low <- x.bar - mOe)
(ci.low <- x.bar + mOe)


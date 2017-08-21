'#Learning Statistics with R - University of Adelaide

## Part IIIV - Working with Data

### Chapter 9 - Intro to Probability
#### 9.4 - The Binomial Distribution'

# probability of getting exactly 4 fives when rolling a fair 6-sided dice 20 times
dbinom(x = 4, size = 20, prob = 1/6) #20.22%

# get probability of rolling 4 or less fives on 20 twenty rolls of 6-sided dice
pbinom(q = 4, size = 20, prob = 1/6) #76.87%
# "A value of 4 is actually the 76.9th percentile of this binomial distribution"

# find value of x that gives 75th percentile of the binomial distribution
qbinom(p = 0.75, size = 20, prob = 1/6) #4

pbinom(q = 3, size = 20, prob = 1/6) #56.65%


# "simulate" dice experiment 100 times to generate random outcomes from the binomial distribution.
# gives how many of a single we roll after rolling a dice 20 times
rbinom(n = 100, size = 20, prob = 1/6)

# calculate density of x = 1 for a normally-distributed variable w/ mean = 1 + SD = 0.1
dnorm( x = 1, mean = 1, sd = 0.1 ) # 3.989423

# generate 1000 normally-distributed observations (normal distribution of 1K values)
normal.a <- rnorm(1000, mean = 0, sd = 1)
library(ggplot2)
ggplot() + geom_histogram(aes(normal.a))

# generate 1000 values in a chi-squared distribution w/ dF = 3
chisq.a <- rchisq(1000, df = 3)
ggplot() + geom_histogram(aes(chisq.a))

# way #2 --> sum of squares
# square values of 3 distributions and sum
normal.b <- rnorm(1000)
normal.3 <- rnorm(1000)
chi.sq.3 <- (normal.a)^2 + (normal.a)^2 + (normal.a)^2
ggplot() + geom_histogram(aes(chi.sq.3))

# create t-distribution from scaled chi-squared
scaled.chisq.3 <- chi.sq.3/3
normal.d <- rnorm(1000)
t.3 <- normal.d / sqrt(scaled.chisq.3)
ggplot() + geom_histogram(aes(t.3), bins = 10)

#generating 2 chi-square variables w/ dF = 3 + dF = 20 via ratio of 2 chi-sq distributions
chi.sq.20 <- rchisq( 1000, 20) 
scaled.chi.sq.20 <- chi.sq.20 / 20
F.3.20 <- scaled.chi.sq.3 / scaled.chi.sq.20
> hist( F.3.20 ) # ... and draw a picture


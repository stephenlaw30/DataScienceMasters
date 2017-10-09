# calculate z-score for college kids in relationships where H0: mu = 3 and H1: mu > 3
n = 50
trueNull.mu <- 3
x.bar = 3.2
s <- 1.74
se <- s/sqrt(n)
z <- (x.bar - trueNull.mu)/se # test statistic of .81
1 - ?pnorm(x.bar,trueNull.mu,se)

'Researchers investigating characteristics of gifted children collected data from schools in a large city on a random sample of 
36 children IDed as gifted children soon after they reached the age of 4. 

In this study, along w/ variables on the children, researchers also collected data on mothers` IQ scores

Perform a hypothesis test to evaluate if these data provide convincing evidence of a difference between average IQ score of 
mothers of gifted children vs. average IQ score for the population at large, which happens to be 100. Use a significance level of .01'
n <- 36
min <- 101
x.bar <- 118.2
trueNull.mu <- 100
sigma <- 6.5
max <- 135
N <- 100
alpha <- .01

se <- sigma/sqrt(n)
(z <- (x.bar - trueNull.mu)/se) # test statistic of .81
1 - pnorm(x.bar,trueNull.mu,se)

'A stats student interested in sleep habits of domestic cats took a random sample of 144 cats + monitored their sleep. 

The cats slept an average of 16 hours/day +, according to online resources, domestic dogs sleep on average 14 hours/day. 

We want to find out if these data provide convincing evidence of different sleeping habits for domestic cats + dogs w/ respect to 
how much they sleep. 
'
z <- 1.73
n <- 16
x.bar <- 16
trueNull.mu <- 14
alpha <- .01
(se <- (x.bar - trueNull.mu)/z)
1 - pnorm(x.bar,trueNull.mu,se)
2*(1 - pnorm(x.bar,trueNull.mu,se)) # two-tailed test

'A 2010 Pew Research foundation poll indicates among 1,099 college graduates, 33% watch the Daily Show, an American late-night TV Show.
The standard error of this estimate = 0.014. Estimate the 95% CI for the proportion of college graduates who watch The Daily Show.'
n <- 1099
x.bar <- .33
alpha <- .05
se.x <- .014
(z.crit <- qnorm(1-(1 - .95)/2)) # ~ 1.96
mOe <- z.crit*se.x
(ci.low <- x.bar - mOe)
(ci.low <- x.bar + mOe)
'We are 95% confident between 30.3% and 35.7% of college graduates watch the Daily Show

The 3rd National Health and Nutrition Examination Survey (NHANES), collected body fat % + gender data from over 13,000 subjects ages 
20-80. Average BF% for the 6,580 men in the sample = 23.9 + this was 35% for the 7,021 women. SE for the difference between the average 
male + female BF% = 0.114. Do these data provide convincing evidence that men and women have different average BF%`s? Assume the 
distribution of the point estimate is nearly normal.'

# know distribution of point estimate is normal = can use known framework
# 1) set hypotheses --> h0: x.bar(m) = x.bar(f) ==> x.bar(m) - x.bar(f) = 0        h1 = x.bar(m) - x.bar(f) != 0
# 2) point estimate = difference between means
n.m <- 6580
n.f <- 7021
x.bar.m <- .239
x.bar.f <- .35
(x.bar.diff <- x.bar.m - x.bar.f)
# 3) check conditions --> told distribution is nearly normal + since this is a *national* survery, we can assume the observations are 
#   from a  random sample and are independent to each w/ respect to BF%
se <- .114
# null says difference = 0
(z <- (x.bar.diff - 0)/se) 
(1 - pnorm(x.bar,0,se))

'In context, we`ve determined that these data provide convincing evidence that the average body fat percentages of men and women 
are indeed different from each other.'

'SAT scores are distributed w/ a mean = 1,500 + a SD = 300. You`re interested in estimating the average SAT score of 1st year 
students at your college. If you'd like to limit the margin of error of your 98% CI to 40 points, at least how many students should 
you sample?'
sigma <- 300
n <- 306
SE <- sigma/sqrt(n)
(z.crit <- qnorm(1-(1 - .98)/2)) # ~ 2.32
(moe <- z.crit*SE)

'Researchers investigating characteristics of gifted children collected data from schools in a large city on a random sample of 
36 children IDed as gifted children soon after they reached the age of 4. 

Suppose you read online that children first count to 10 successfully when 32 months old, on average. You perform a hypothesis test
evaluating whether the average age at which gifted children first count to 10 is different than the general average of 32 months.
What is the p-value of the hypothesis test?'
n <- 36
min <- 21
x.bar <- 30.69
trueNull.mu <- 32
sigma <- 4.31
max <- 39

se <- sigma/sqrt(n)
(z <- (x.bar - trueNull.mu)/se) # test statistic of .81
1 - pnorm(x.bar,trueNull.mu,se)
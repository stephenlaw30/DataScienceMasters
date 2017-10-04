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

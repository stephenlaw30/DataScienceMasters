'Question 2 - Students collected 8 random bags of a specific brand of potato chips + carefully weighed the contents 
  of each bag, recording the following weights (in grams): 
  29.4      29.0      28.4      28.8      28.9      29.3      28.5      28.2 

The students want to test the claim that the mean weight of these bags is 28.5 grams.  They think it may be different'
chips <- c(29.4,29,28.4,28.8,28.9,29.3,28.5,28.2)

'2a. What is the appropriate null hypotheses for this test?'

# - H0: mu???? = 28.5

'2b. What are the sample mean and standard deviation? (Round each to 2 decimal places.)'
round(mean(chips),2) #28.81
round(sd(chips),2) #0.43

'2c. What is the test statistic for this hypothesis test? (t-statistic for the sample mean)
  NOTE: Be sure to use the proper formula + rounded answers to previous questions to determine the statistic'

mu <- 28.5
mu.x <- round(mean(chips),2)
s <- round(sd(chips),2)
n <- length(chips)
se <- s/sqrt(n)
t <- round((mu.x - mu)/se,2)

#unrounded
t.test(chips,mu = mu)
'	One Sample t-test

data:  chips
t = 2.0761, df = 7, p-value = 0.07652
alternative hypothesis: true mean is not equal to 28.5
95% CI: (28.45658 29.16842)
sample estimates:
mean of x: 28.8125 '

'2d. What is t-critical for this test, assuming an alpha level of 0.05? (Round to 3 decimal places.)'
dF <- n - 1
t.crit <- 2.365

'2e. What was the outcome of your test?'
t < -t.crit | t > t.crit #False --> Fail to reject the null hypothesis, p > 0.05

'2f. In addition to random selection, what other condition of data must be true for our t-test outcome to be reliable?'

# - The bags of potato chips must have an approximately Normal *population* distribution for weight.

'2g. Does your data provide sufficient evidence to suggest the mean weight of these bags of potato chips is NOT 
28.5 g per bag?'

# - No
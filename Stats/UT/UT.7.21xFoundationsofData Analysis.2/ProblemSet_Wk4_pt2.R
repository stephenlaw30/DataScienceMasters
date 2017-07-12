'************Course Week 4: Hypothesis Testing (Categorical Data) Problem Set Question 2**********

When crossing white + yellow summer squash, a genetic model predicts that 75% of resulting offspring will 
be white, 15% will be yellow and 10% will be green. 

Below are the results from an experiment run on a random sample of 205 squash offspring.
Color 	        White 	Yellow 	Green
# of Offspring 	152 	  39 	    14

2a. Which method should we use to test if these data are consistent w/ the ratio of offspring colors 
predicted by the genetic model?'

# Chi Square Goodness of Fit Test

'2b. What is the expected count of white offspring?'

exp.white <- 205*0.75
exp.yellow <- 205*0.15
exp.green <- 205*0.10

obs.white <- 152
obs.yellow <- 39
obs.green <- 14

'2e. Is the sample size condition met?'

# Yes - no expected value < 5

'2f. What are the degrees of freedom and the critical value for this test, assuming alpha = 0.05'

# Degrees of Freedom = 2, crit = 5.991 	

'2g. What is the Chi Square statistic for this test? (Round to 2 decimal places.)'

chi <- round(sum((obs.white - exp.white)^2/exp.white,
    (obs.yellow - exp.yellow)^2/exp.yellow, (obs.green - exp.green)^2/exp.green),2)

# 4.29 = Fail to reject the null hypothesis
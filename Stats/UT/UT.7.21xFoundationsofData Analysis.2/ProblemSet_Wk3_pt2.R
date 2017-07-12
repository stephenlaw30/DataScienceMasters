'****Question 2 - A study was conducted to compare resting pulse rates of college smokers + non-smokers.
The data for a randomly selected group is summarized in the table below. Pulse rates were normally distributed w/in each group.



Group	      Sample Size (n)	Average Pulse Rate (bpm)	Standard Deviation of Scores
Smokers	        26	                80	                      5
Non-Smokers	    32	                74	                      6

2a. What is the appropriate method for analyzing this data?'

# Independent T-Test

'2b. What is the alternative hypothesis for this test if the researchers expect smoking to raise pulse rates?'
mu.nonSmokers

# mu.smokers > mu.nonSmokers

'2c. How many degrees of freedom should we use for this test if we are to estimate rather than use a calculator?'

# lowest n of the groups - 2 --> 26 - 1 = 25

'2d. What is t-critical, assuming ??=0.05?'

# directional (look at h(a)) --> 1.708

'2e. Calculate the standard error.'

n.s <- 26
n.ns <- 32
dF <- n.s - 1

mu.s <- 80 
mu.ns <- 74

s.s <- 5
s.ns <- 6

se <- round(sqrt((s.s^2/n.s) + (s.ns^2/n.ns)),2)

'2f. Calculate the test statistic.'

t <- round((mu.s - mu.ns)/se,2)
t.crit <- 1.708

t > t.crit

# 4.17 > 1.708 = evidence to suggest that the pulse rate of smokers is higher on average than the pulse rate of non-smokers

'2g. How would the p-value be reported in your conclusion?'

# p < 0.05
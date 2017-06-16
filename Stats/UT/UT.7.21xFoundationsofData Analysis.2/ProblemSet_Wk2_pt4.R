'Question 4 - You are studying a population of peregrine falcons + want to estimate average wingspan. You collect a 
random sample of 12 adult male birds + measure a mean wingspan = 42.6 cm, w/ SD = 5.3 cm. Assume the distribution of 
measurements was approximately normal.

4a. What is t-critical for a 90% confidence interval?'

# 1.796 (alpha = 0.1, 2-tail --> alpha = 0.05)

'4b. Calculate a 90% CI for the mean wingspan for the population of male peregrine falcons'
mu <- 42.6
s <- 5.3
n <- 12
se <- s/sqrt(n)
t.crit <- 1.796
moe <- t.crit*se
upper <- round(mu + moe,2) #39.85
lower <- round(mu - moe,2) #45.35

'4c. If you calculated a 95% CI for the population mean from the same data, would your Ci be narrower or wider?'

# - wider --> need more values to be more sure to capture

mu <- 42.6
s <- 5.3
n <- 12
se <- s/sqrt(n)
t.crit <- 2.201
moe <- t.crit*se
upper <- round(mu + moe,2) #39.23
lower <- round(mu - moe,2) #45.97
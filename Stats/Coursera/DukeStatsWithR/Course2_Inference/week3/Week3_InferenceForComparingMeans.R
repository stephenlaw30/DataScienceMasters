# Calculate probability of absolute value of Z > 2
(pnorm(2,0,lower.tail = F)*2) # only 1-sided hypothesis

# probability of absolute value of t w/ 50 dF freedom > 2
pt(2, 50, lower.tail = F)*2

# lower dF
pt(2, 10, lower.tail = F)*2

## find critical value of t for sample size of 22
n <- 22
dF <- n - 1
abs(qt(p = .025, df = dF)) # find percentile

# construct the confidence interval for the average snacking level of distracted eaters
x.bar.s <- 52.1
s <- 45.1
t.crit <- abs(qt(p = .025, df = dF))
SE <- s / sqrt(n)
mOe <- t.crit * SE
(lower <- x.bar.s - mOe)
(upper <- x.bar.s + mOe)

' Do these data provide convincing evidence the amount of snacks consumed by distracted eaters post lunch is different than the 
suggested serving size (30 g)'
null.mu <- 30
(t <- (x.bar.s - null.mu) / SE)

# probability of obtaining this mean x.bar.s t w/ 21 dF if null = 30 is true
pt(t, dF, lower.tail = F)*2


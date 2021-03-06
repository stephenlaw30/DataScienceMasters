# Calculate probability of absolute value of Z > 2
(pnorm(2,0,lower.tail = F)*2) # only 1-sided hypothesis

# probability of absolute value of t w/ 50 dF freedom > 2
pt(2, 50, lower.tail = F)*2

# lower dF
pt(2, 10, lower.tail = F)*2

### SINGLE MEAN T-TEST

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


### INDEPENDENT SAMPLES T-TEST

'Estimate difference between the average post-meal snack consumption between those who eat with + w/out distractions'
# find t-critical value for comparing the 2 means
n.dist <- 22
n.nondistract <- 22
dF <- min(n.dist - 1, n.nondistract - 1)
(t.crit <- abs(qt(p = .025, df = dF)))

# get point estimate
x.bar.dist <- 52.1
x.bar.nondistract <- 27.1
(pe <- x.bar.dist - x.bar.nondistract)

# get margin of error
var.dist <- 45.1
var.nondist <- 26.4
(se.diff.2.means <- sqrt(((var.dist^2)/n.dist) + ((var.nondist^2)/n.nondistract)))
(m0e <- t.crit*se.diff.2.means)

# get CI
(lower <- pe - m0e)
(upper <- pe + m0e)

## hypothesis test to see if there is significant difference between these 2 population means
## h0: mu.dist = mu.nondist (mu.dist - mu.nondist = 0)
## h1: mu.dist != mu.nondist
(t.21 <- (pe - 0)/se.diff.2.means)

## probability of obtaining this OBSERVED DIFFERENCE (our point estimate) w/ 21 dF if null = 0 is true
pt(t.21, dF, lower.tail = F)*2

### PAIRED-SAMPLES T.TEST

## hypothesis test to see if there is significant difference between reading and writing scores
## h0: mu.diff = 0 (mu.dist - mu.nondist = 0)
## h1: mu.diff != 0
mu.diff <- 0
x.bar.diff <- -.545
s.diff <- 8.887
n.diff <- 200
(dF <- n.diff - 1)
(se.diff <- s.diff/sqrt(n.diff))
(t.199 <- (x.bar.diff - mu.diff)/se.diff)

## probability of obtaining this OBSERVED DIFFERENCE (x.bar.diff) w/ 199 dF if null = 0 is true
pt(abs(t.199), dF, lower.tail = F)*2



## MULTIPLE COMPARISONS ANOVA
'Is there a significant difference between average vocab scores between middle + lower class Americans?'
n.low <- 41
n.mid <- 331

x.low <- 5.07
x.mid <- 6.76

dF.btwn <- 3
dF.w <- 791

ss.b <- 236.56
ss.w <- 2869.8

ms.b <- ss.b / dF.btwn
ms.w <- ss.w / dF.w # ms.w = MS errors
ms.e <- ms.w

(f <- ms.b / ms.w)

pf(f, dF.btwn, dF.w, lower.tail = F)

x.diff <- x.mid - x.low
mu <- 0

(se <- sqrt((ms.e/n.low) + (ms.e/n.mid)))

(t.791 = (x.diff - mu)/se)

pt(abs(t.791), dF.w, lower.tail = F)*2

## Bootstrapping

'See distribution of medians of 100 bootstrap samples from the original sample + estimate the 90% bootstrap CI for median rent, 
based on this bootstrap distribution, 1st using the SE method'
n <- 100
dF <- 19
x.bar <- 887
# 90% sig level
(t.crit.90 <- abs(qt(p = .05, df = dF)))
se.boot <- 89.5758
m0E <- t.crit.90*se.boot
(lower <- x.bar - m0E)
(upper <- x.bar + m0E)
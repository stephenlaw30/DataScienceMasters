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


'Suppose researchers would like to run a clinical trial on patients w/ systolic BPs between 140-180 ml of mercury + suppose previously
published studies suggest the SD of both patient groups BPs will be ~12 ml of mercury + the distribution of patient BPs will be
approximately symmetric. There are 100 patients in each group.'
n.tx <- 100
n.control <- 100
dF <- min(n.tx - 1, n.control - 1)
(crit <- abs(qt(p = .025, df = dF)))

# get margin of error
var.tx <- 12
var.control <- 12
(se.diff.meds <- sqrt(((var.tx^2)/n.tx) + ((var.control^2)/n.control)))
(m0e <- crit*se.diff.meds) # value to be away from mean to reject null

'Suppose the company researchers care about finding ANY effect on BP that is a drop of 3+ mm of mercury vs. the standard medication. 
What is the power of the test that can detect this effect (the 3+ mm)?'

min.effect.needed <- -3
(z <- (-m0e - min.effect.needed)/se.diff.meds) # negative m0E b/c concerned w/ drop in mercury

# find AUC = probability of being able to reject the null if the true effect size is -3 
pnorm(round(z,1))

## WORK BACKWARDS TO GET HIGHER POWER UP TO MIN OF 80%
# calculate z-score for desired AUC/power of .8
desired.pwr <- .8
(desired.z <- qnorm(desired.pwr))

# effect size of 3 mm
(effect.size <- desired.z + crit)

(new.se <- abs(min.effect.needed) / round(effect.size,1))

# solve for new sample size via SE formula
(new.n <- (var.tx^2 + var.control^2)/(new.se^2))
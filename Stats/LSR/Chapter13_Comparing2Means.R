setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/Stats/LSR/sample-master')
load('zeppo.Rdata')
grades
mean(grades)
#higher than class average of 67.5

# 1
x_bar <- mean(grades)

# 2
sig_true <- 9.5 # true SD from assumptions
mu_null <- 67.5 # mean that null (H0) specifies

# 3
n = length(grades) # sample size

# 4
sem <- sig_true / sqrt(n)

# 5
z <- (x_bar - mu_null) / sem
# 2.2596

# calculate p-value
upper.area <- pnorm(q = z, lower.tail = FALSE) # lower.tail = F ==> calculate AUC from 2.26 upwards
lower.area <- pnorm(q = -z, lower.tail = TRUE)
p.value <- lower.area + upper.area 
#0.02384574


'**********************************************************************************************'
'1 sample t-test'
'**********************************************************************************************'
# estimate of pop SD, sigma
sd(grades)

library(lsr)
oneSampleTTest(x = grades, mu = 67.5)

'**********************************************************************************************'
'Independent samples Student`s t-test'
'**********************************************************************************************'
load('harpo.Rdata')
head(harpo)
library(lsr)

independentSamplesTTest(grade ~ tutor, harpo, var.equal = T)

'**********************************************************************************************'
'Independent samples Welch`s t-test'
'**********************************************************************************************'
independentSamplesTTest(grade ~ tutor, harpo, var.equal = F)

chico <- read.csv("chico.Rdata")

'**********************************************************************************************'
'1-sample t-test'
'**********************************************************************************************'
# one-sided t-test --> interested if true mean was > 67.5
oneSampleTTest(grades, mu = 67.5, one.sided = "greater")

# interested if group A's scores were higher than group B's
independentSamplesTTest(
  formula = grade ~ tutor,
  data = harpo,
  one.sided = "Anastasia"
)

'pairedSamplesTTest(
  ~ grade_test2 + grade_test1,
  data = chico,
  one.sided = "grade_test2"
)'


# use t-test function to do 1 sample t-test
t.test(grades, mu = 67.5)

# welch's independent samples
t.test(grade ~ tutor, harpo)

# student's independent samples
t.test(grade ~ tutor, harpo, var.equal = T)

# paired samples t-test
t.test(x = chico$grade_test2, y = chico$grade_test1, # variable 1 = "test2" scores, variable 2 = "test1" scores
          paired = TRUE) # paired test

# Compute an effect size for the data from class:
cohensD(grades, 67.5) # compare students grades mean to hypothesized population mean

# compute Cohen's D in long format
(mean(grades) - 67.5) / sd(grades)
'psych students are achieving grades (mean = 72.3%) that are about .5 SDs higher than the level you`d 
  expect (67.5%) if they were performing at the same level as other students. 
    - Judged against Cohen`s rough guide, this is a MODERATE effect size.'

# compute effect size for Student t test (outcome ~ group)
cohensD(grade ~ tutor, harpo, method = "pooled")

# compute effect size for Welch's t-test
cohensD(grade ~ tutor, harpo, method = "unequal")
'version of Cohen`s d reported by independentSamplesTTest() whenever it runs a Welch t-test'

'**********************************************************************************************
Checking Normality
**********************************************************************************************' 
# generate N = 100 normally distributed numbers
data <- rnorm(n = 100)

# histogram of sample
hist(data)

# qq plot
qqnorm(data)


'**********************************************************************************************
Shapiro-Wilk
**********************************************************************************************' 
# normal data
shapiro.test(data)
# w = high = not a sig departure from normality p > .001

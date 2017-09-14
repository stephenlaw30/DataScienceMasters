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

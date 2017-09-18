setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/Stats/LSR/sample-master')
load('clinicaltrial.Rdata')
library(tidyverse)
library(lsr)

# see how many people are in each test group (# of obsverations broken out by drug)
xtabs(~ drug, clin.trial)

# Calculate means + SDs for mood.gain variable broken down by drug 
aggregate(mood.gain ~ drug, clin.trial, mean)
aggregate(mood.gain ~ drug, clin.trial, sd)

# plot means for all 3 drug groups
library(gplots)
plotmeans(mood.gain ~ drug, data = clin.trial, xlab = "Drug Administered", ylab = "Mood Gain",
             n.label = FALSE) # don't display sample size
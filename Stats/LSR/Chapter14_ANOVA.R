setwd('C:/Users/NIMZ/Dropbox/DataScienceMasters/Stats/LSR/sample-master')
load('clinicaltrial.Rdata')
library(tidyverse)
library(lsr)

'.	Suppose you've become involved in a clinical trial in testing a new antidepressant drug Joyzepam. 
.	In order to construct a fair test of drug's effectiveness, the study involves 3 separate drugs to be 
    administered = yours, a placebo, an existing antidepressant/anti-anxiety drug Anxifree. 
.	A collection of 18 participants w/ moderate to severe depression are recruited for initial testing. 
.	B/c the drugs are sometimes administered in conjunction w/ psychological therapy, study includes 9 people 
    undergoing cognitive behavioral therapy (CBT) + 9 who are not. 
.	Participants are randomly assigned (doubly blinded) a treatment, such that there are 3 CBT people + 3 
    no-therapy people assigned to each of the 3 drugs. 
.	A psychologist assesses mood of each person after a 3-month run w/ each drug + overall improvement in each 
    person's mood is assessed on a scale ranging from -5 to 5'

# see how many people are in each test group (# of obsverations broken out by drug)
xtabs(~ drug, clin.trial)
xtabs(~ therapy + drug, clin.trial)
# 6 total, 3 CTB, 3 Non-CTB
# all groups have same # of observations = BALANCED experimental design

# Calculate means + SDs for mood.gain variable broken down by drug 
aggregate(mood.gain ~ drug, clin.trial, mean)
aggregate(mood.gain ~ drug, clin.trial, sd)

# plot means for all 3 drug groups
library(gplots)
plotmeans(mood.gain ~ drug, data = clin.trial, xlab = "Drug Administered", ylab = "Mood Gain",
             n.label = FALSE) # don't display sample size
# see larger improvement for our drug, but is this difference significant? (real or due to chance?)

'
H0: it is true that µP = µA = µJ 
H1: it is not true that µP = µA = µJ '

outcome_var <- clin.trial$mood.gain
grouping_var <- clin.trial$drug

# get all group means for each observation
grp_means <- tapply(outcome_var, grouping_var, mean)
grp_means_split <-  grp_means[grouping_var]

# get group deviations from the group means
within_group_deviations <- outcome_var - grp_means_split

# get within-group SS
(SSw <- sum(within_group_deviations^2))

# get grand mean
grand_mean <- mean(clin.trial$mood.gain)

# get group mean deviations from grand mean
between_group_deviations_sq <- (grp_means - grand_mean)^2

# get # of observations in each groups
grp_size <- tapply(outcome_var, grouping_var, length)

# calculate SSb
(SSb <- sum(grp_size*between_group_deviations_sq))

# get dF
DFb <- length(grp_size)-1
DFw <- length(grp_means_split) - length(grp_size)

# get means square values
MSw <- SSw / DFw
MSb <- SSb / DFb

# calculate F ration
(F_value = MSb / MSw)
# large value needed (since F-test is always 1-sided), so this suggests we reject null
# check if result of F-test is significant
pf(F_value, df1 = DFb, df2 = DFw, lower.tail = F)
# very significant result (to the -5 power) unless we're being extremely conservative about Type I error rate
'F(2,15) = 18.6, P < .001'

'********************ANOVA IN R CODE********************'
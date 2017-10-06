setwd('C:/Users/newnss/Dropbox/DataScienceMasters/Stats/LSR/sample-master')
load('clinicaltrial.Rdata')
library(tidyverse)
library(lsr)

'.	Suppose you`ve become involved in a clinical trial in testing a new antidepressant drug Joyzepam. 
.	In order to construct a fair test of drug`s effectiveness, the study involves 3 separate drugs to be 
    administered = yours, a placebo, an existing antidepressant/anti-anxiety drug Anxifree. 
.	A collection of 18 participants w/ moderate to severe depression are recruited for initial testing. 
.	B/c the drugs are sometimes administered in conjunction w/ psychological therapy, study includes 9 people 
    undergoing cognitive behavioral therapy (CBT) + 9 who are not. 
.	Participants are randomly assigned (doubly blinded) a treatment, such that there are 3 CBT people + 3 
    no-therapy people assigned to each of the 3 drugs. 
.	A psychologist assesses mood of each person after a 3-month run w/ each drug + overall improvement in each 
    person`s mood is assessed on a scale ranging from -5 to 5'

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
H0: it is true that uP = uA = uJ 
H1: it is not true that uP = uA = uJ '

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
drug.anova <- aov(mood.gain ~ drug, clin.trial)
class(drug.anova) # object is both an aov obj + a linear model

names(drug.anova) # lots of things w/in
print(drug.anova) # drug = SSb, Residuals = SSw (all other/leftover variability)

# get f-value + p-value
summary(drug.anova) # F(2,15) = 18.61, p < .0001

# effect size = eta squared
SStot <- SSb + SSw
(eta_sq <- SSb/SStot)
# 71.27% of variability in mood.gain (outcome) can be described in terms of the drug (predictor) = high relationship
(eta <- sqrt(eta_sq))
# think of .8442 as being equivalent to correlation of .84 = strong relationship between drug + mood.gain

#lsr has function
etaSquared(drug.anova) # simple ANOVA = eta squared + partial eta squared are equal

'****************which groups are actually different from one another?****************************'
'null is actually claiming 3 different things all at once here. 
  .	Competitor`s drug (Anxifree) is no better than a placebo (i.e., uA = uP ) 
  .	Your drug (Joyzepam) is no better than a placebo (i.e., uJ = uP )
  .	Anxifree + Joyzepam are equally effective (i.e., uJ = uA) 

If any of above 3 are false, null is false'

## pairwise t-tests --> b/c we have 3 seperate pairs of means
# no correction
pairwise.t.test(clin.trial$mood.gain, clin.trial$drug, p.adjust.method = "none")
# p < .001 for J vs A and J vs P, p > .05 for A vs. P

# use LSR for same thing
posthocPairwiseT(drug.anova, p.adjust.method = "none") # same output (almost)

# holm correction (default)
posthocPairwiseT(drug.anova) # same results, different numbers

'each individual t-test above is designed to have a 5% Type I error rate (alpha = .05) + we ran 3 of these tests. 
If we had 10 groups (needs 45 tests), 2 or 3 would be significantly different by chance

Want to control Type I error rate (FP rate), but running a bunch of tests, the FP rate over the family of tests
gets out of control

adjustment to p-values = aims to control FP rate over family of tests = *correction for multiple comparisons/simultaneous inference*'

# bonferri correction = multiply raw p-values by # of tests (m) + hope its < the desired threshold for highest FP rate is (say alpha = .9)
# reject null if new p-value p` = m*p < alpha 
# arranged so that each test has a FP rate of at most alpha/m --> so the total FP rate across tests cannot be larger than alpha

pairwise.t.test(clin.trial$mood.gain, clin.trial$drug, p.adjust.method = "bonferroni")
posthocPairwiseT(drug.anova, p.adjust.method = "bonferroni") # same output (almost)
# compared to no correction, p-values have just been multiplied by 3 (# of tests)

'bonferroni = simplest, but holm = best
  - pretend you`re doing tests sequentially, starting w/ the smallest (raw) p-value + moving onto the largest one +
adjustments are performed on whichever are smaller
  - more powerful than bonferroni as it has lower FN rate (but w/ same FP rate)
  - in practice, no reason to use bonferroni if holm = more powerful'

pairwise.t.test(clin.trial$mood.gain, clin.trial$drug)
posthocPairwiseT(drug.anova) # same output (almost)
# largest p-value unchanged (bc largest)
# original lowest p-value multiplied by 3

'*****************Checking the homogeneity of variance/homoscedasticity assumption*****************'
# levene test = run an ANOVA on the new variable Z(i, k) = a measure of how i-th observation in k-th group deviates from its group mean. 
# should be high = all groups means are NOT indentical (reject the null in favor of alternative)
# calculated in exactly the same way F-statistic for regular ANOVA, just using a Z(i, k) rather than Y(i, k)
library(car)
leveneTest(drug.anova) # not significant difference = data have homoscedasticity = population SD is the same for all groups.
 # 'center = median' --> actually am doing Brown-Forsythe test 

# REAL levene test
leveneTest(drug.anova, center = "mean") # not significant difference = data have homoscedasticity = population SD is the same for all groups.

#  best to stick to the default value, since Brown-Forsythe = bit more robust than Levene test. 

# levene test v2 + v3
leveneTest(mood.gain ~ drug, clin.trial)
leveneTest(clin.trial$mood.gain,clin.trial$drug)

'when homoscedasticity is violated (population SD is different for all groups, use Welch 1-way ANOVA test'
oneway.test(mood.gain ~ drug, clin.trial, var.equal = F)

# compare to var.equal = T (assumption holds)
oneway.test(mood.gain ~ drug, clin.trial, var.equal = T)

# welch decreased DFw and F-value increased (less significant though (higher p))

'******************************Checking the normality assumption************************************'
# pull out residuals + check QQplots + run shapiro-wilks test
drug_residuals <- drug.anova$residuals

hist(drug_residuals)
qqnorm(drug_residuals) # both look quite normal

# shapiro-wilks test
shapiro.test(drug_residuals) # close to 1 = no indication normality is violated

# if normality IS violated, switch to NONPARAMETRIC test (don't rely on distribution assumptions)
# 2 groups = Wilcoxon test 
# 3+ groups = Kruskal-Wallis rank sum test (similar to ANOVA in ways)

# KWRS test ranks values of outcome variables and conducts ANOVA on the rankings
# calculate sum of square deviations of mean rank of groups from grand rank mean and of individual ranks from mean group ranks
# then perform test as if ANOVA
# sampling distribution of K (Kruskal-Wallis test-statistic) = chi-squared w/ dF = G - 1 (G = # of groups)
# larger value of K = less consistent data are w/ the null 
# this is a one-sided test: reject H0 when K is sufficiently large. 

# K = analogue of ANOVA based on ranks, but ONLY when there are no ties in the raw data (no 2 observations have the exact same value)
# must then introduce a correction factor (TCF)

kruskal.test(mood.gain ~ drug, clin.trial) # large K, p < .01 = significant difference

# Sometimes it can be useful to specify x as a list
data <- list(clin.trial$mood.gain[clin.trial$drug == "placebo"],clin.trial$mood.gain[clin.trial$drug == "joyzepam"],
             clin.trial$mood.gain[clin.trial$drug == "anxifree"])
kruskal.test(data) # same results


##  ANOVA w/ 2 groups = identical to the Student t-test

# ANOVA w/ therapy as predictor (2 groups, CBT + non-CBT)
summary(aov(mood.gain ~ therapy, clin.trial))

# student't t-test on same data
t.test(mood.gain ~ therapy, clin.trial, var.equal = T)

# see that p is the same, and t^2 = F
(-1.3068)^2

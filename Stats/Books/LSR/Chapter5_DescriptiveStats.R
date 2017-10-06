'#Learning Statistics with R - University of Adelaide

## Part IIIV - Working with Data

### Chapter 5 - Descriptive Stats
#### 5.1 - Descriptive Stats'

load("aflsmall.Rdata")
library(lsr)
library(ggplot2)

# see the 2 vectors/variable names = margins (point differential) and finalists
who() 
str(afl.margins) # vector of margins
str(afl.finalists) # vector of finalists (CHAR)

summary(afl.margins) # numerical summary stats
summary(afl.finalists) # frequency table

ggplot() + 
  geom_histogram(aes(x = afl.margins), binwidth = 10, colour = 'red')
'Right/positively-skewed (tail to the right) = use median as measure of center' 

# A fairly substantial differences between mean and median indicates mean may be influenced a bit too much by extreme values
dataset <- c( -15,2,3,4,5,6,7,8,9,12)
summary(dataset)

# 10% trimmed mean (trim off top + bottom 10% of data)
mean(dataset, trim = .1)
# same answer as median = 5.5

# 5% trimmed mean for the afl.margins data
mean(afl.margins, trim = 0.05) #33.75

## Produce frequency table of of every team that played in any AFL final from 1987-2010
sort(table(afl.finalists), decreasing = TRUE)
# Over the 24 years for which we have data, Geelong played in more finals than any other team = mode of the finalists'

#core packages in R don't have a function for calculating mode 
# lsr package does with modeOf() + maxFreq() = tells you what that modal frequency is
modeOf(afl.finalists)
maxFreq(afl.finalists)

'mode = most often calculated w/ *nominal* data (b/c means + medians are useless w/ this data)
  - afl.margins variable --> clearly ratio data (point differential)

Consider a friend of yours is offering a bet to pick a football game at random + you have to guess the exact margin. 
If you guess correctly, win $50, if not, lose $1
For this bet, mean + median are completely useless, and it is the mode you should bet on'
modeOf(afl.margins) # 3 pt. margin
maxFreq(afl.margins) # occured 8 times

(maxFreq(afl.margins)/length(afl.margins))*100 # 4.545% chance of winning if we pick the mode
(sum(round(mean(afl.margins)) == afl.margins)/length(afl.margins))*100 # 2.272727% chance of winning if we pick the mean
(sum(round(median(afl.margins)) == afl.margins)/length(afl.margins))*100 # 0.5681818% chance of winning if we pick the median

'********************************************************
Measures of Variability
********************************************************'
# see range (pretty useless bc not robust)
range(afl.margins)
# calculate range
max(afl.margins) - min(afl.margins)

# check quantiles
quantile(afl.margins) 
# get Q1
quantile(afl.margins, probs = 0.25) 
# get Q2/median
quantile(afl.margins, probs = 0.5)
# get Q3
quantile(afl.margins, probs = 0.75) # 75% of point differentials are < 50.5
# do for other percentile
quantile(afl.margins, probs = .333333)

## IQR = measure of variability for *skewed* data bc its more robust than range
# see Q1 and Q3
quantile(afl.margins, probs = c(.25,.75))

# calculate IQR
quantile(afl.margins, probs = 0.75) - quantile(afl.margins, probs = 0.25) 
# get IQR
IQR(afl.margins)

## calculate MEAN ABSOLUTE DEVIATION = typical deviation from the reference point of the mean
data <- c(56, 31, 56, 8, 32)
mean(data) #36.6
variations <- abs(data - mean(data))
mean(variations) #15.52 = mean absolute deviation for these 5 scores

m

# calculate MEAN ABSOLUTE DEVIATION via add() function from lsr pkg
aad(data)
# = how far observations are on average from the mean, is very interpretable, but has few minor issues
# less attractive to statisticians than SD, so it is used sometimes, but not often.

## Variance
variance <- (data - mean(data))^2
mean(variance) #324.64

# Base R function for variance
var(data) #405.8

'Answers are different? Check w/ afl.margins data'
variance2 <- (afl.margins - mean(afl.margins))^2
mean(variance2) # 675.9718
var(afl.margins) # 679.8345

# R is evaluating a slightly different formula 
#   - Instead of *averaging* squared deviations (divide by number of DPs, N = population size), R divides by N - 1 (sample)'

sum((data-mean(data))^2)/4 #405.8
var(data) #405.8

## variance = probably "right" way to describe variation around a mean, but is uninterpretable b/c not in same units as the data

#Std Dev = same units = easy to interpret/report
sd(afl.margins)

## Median absolute deviation (MAD) = typical (i.e. median) deviation from the median, simple + interpretable in raw form, a robust way to 
##    estimate SD in the corrected form, used for *some* kinds of data sets, not used very often, but does get reported sometimes.
median(abs(afl.margins - median(afl.margins))) #19.5

# R stats function
mad(afl.margins, constant = 1) #19.5
# default value of constant = 1.4826 to multiply raw MAD value by to get better estimate of SD (ASSUMING DATA ARE NORMAL)
mad(afl.margins) #28.9107


'********************************************************
SKEWNESS AND KURTOSIS
********************************************************'
skew(afl.margins) #0.7671555

# psych package has kurtosi() to calculate the kurtosis of data.'
library(psych)
kurtosi(afl.margins) # close to mesokurtic = just pointy enough.


'********************************************************
SUMMARIZING DATA
********************************************************'
load('clinicaltrial.Rdata')
summary(clin.trial) # see coutns for factor variables

library(tidyverse)
glimpse(clin.trial)

describe(clin.trial) # only useful for NOMINAL DATA = interval or ratio
# ignore variables w/ *'s 

# break out summary stats by group
describeBy(clin.trial, clin.trial$therapy)

# general solution
by(clin.trial, clin.trial$therapy, describe)

# get summary mood gain by all possible combos of drug and therapy
aggregate(mood.gain ~ therapy + drug, clin.trial, summary)

'********************************************************
STANDARD SCORES
********************************************************'
# get theoretical percentile rank for z = 3.6
pnorm(3.6) # values above this z-score are > 99.98% of the data

# higher z-score = more unusual value relative to its population

# z-scores for each item in a matrix-like element
scale(afl.margins)

'********************************************************
CORRELATIONS
********************************************************'
load('parenthood.RData')
glimpse(parenthood)
describe(parenthood)
hist(parenthood$dan.sleep) # left-skew
hist(parenthood$baby.sleep) # bimondal/normal-ish
hist(parenthood$dan.grump) # right-skew

ggplot(parenthood) + 
  geom_point(aes(dan.sleep, dan.grump)) # negative linear
ggplot(parenthood) + 
  geom_point(aes(baby.sleep, dan.grump)) # negative, not very linear

# covariance = generalization of notion of variance
#   - mathematically simple way of describing relationship between 2 variables = not very informative to humans
#   - average CROSS-PRODUCT between X + Y 
#   - = 0 if variables are unrelated, is > 0 for positive, is < 0 for negative

## pearson correlation coefficient r standardizes covariance in same way as a z-score = divide by both SD's of the variables
cov(parenthood$dan.sleep, parenthood$dan.grump) # -9.22
cov(parenthood$dan.sleep, parenthood$dan.grump)/(sd(parenthood$dan.grump)*sd(parenthood$dan.sleep)) # -.90
cor(parenthood$dan.sleep, parenthood$dan.grump) # -.90
# very strong negative linear relationship --> more sleep = less grump

cor(parenthood) # slight positive for both sleeps, moderate negative for baby sleep + grump

# CORRELATIONS MIGHT NOT MEAN WHAT WE THINK THEY MEAN = ALWAYS GRAPH THE DATA
#   - they only measure of the extent to which the data all tend to fall on a single, perfectly straight line. 

# ordinal relationships --> non-linear
# if a student works more than another, they will be guaranteed to get a better grade
# but its harder to get from 80% to 90% than from 0-35%, so relationship isn't linear
# must describe relationship in ORDER of hours worked, not raw terms
load("effort.Rdata")

glimpse(effort)

ggplot(effort) + 
  geom_point(aes(hours, grade))
  geom_line(aes(hours, grade))

hrs.rank <- rank(effort$hours)
grade.rank <- rank(effort$grade)

cor(hrs.rank,grade.rank) # perfect SPEARMAN'S RANK-ORDER ORRELATION COEFFICIENT of 1

# spearman easirer
cor(hrs.rank, grade.rank, method = "spearman")

# correlations only work for NUMERIC VARIABLES
load("work.Rdata")
glimpse(work)

# to get correlation matrix, subset out the factors
work %>%
  select(hours, tasks, pay, day, week) %>%
  cor

# or use lsr correlation()
correlate(work)
correlate(work, corr.method = "spearman")
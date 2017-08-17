'#Learning Statistics with R - University of Adelaide

## Part IIIV - Working with Data

### Chapter 5 - Descriptive Stats
#### 5.7 - Correlations'

#z-score
(x - mean(x))/sd(x)

load('aflsmall.Rdata')
load('clinicaltrial.Rdata')

#z-scores for each item in a matrix-like element
scale(afl.margins)

#single correlation coefficient r
cor(clin.trial$mood.gain,clin.trial$drug)

#correlation matrix
cor(clin.trial)

#spearman correlation coefficient p - 1
hours.rank <- rank( effort$hours ) # rank students by hours worked
grade.rank <- rank( effort$grade ) # rank students by grade received
cor(hours.rank,grade.rank)

#spearman correlation coefficient p - 2
cor(effort$hours, effort$grade, method = 'spearman')


#correlation matrix w/ correlate() from lsr package to ignore factors
library(lsr)
correlate(work)
'#Learning Statistics with R - University of Adelaide

## Part IIIV - Working with Data

### Chapter 5 - Descriptive Stats
#### 5.5 - Descriptive Statistics Separately For Each Group'

load('aflsmall.Rdata')
#install.packages('lsr')
#install.packages('ggplot2')
library(lsr)
library(ggplot2)
library(psych)

#get summary stats for clinical trials grouped by therapy type with psych package describeBy()
describeBy(clin.trial, clin.trial$therapy)

#reproduce describeBy with base R by() function
by(clin.trial, clin.trial$therapy, describe)

by(clin.trial, clin.trial$therapy, summary)
#For the 2 factors (drug and therapy) we get a frequency table, whereas for numeric variable mood.gain 
# we get summary stats

#average mood gain separately for all possible combinations of drug + therapy via R stats aggregate()
aggregate(mood.gain ~ drug + therapy,
          data = clin.trial,
          mean)

#SD of mood gain separately for all possible combinations of drug + therapy via R stats aggregate()
aggregate(mood.gain ~ drug + therapy,
          data = clin.trial,
          sd)
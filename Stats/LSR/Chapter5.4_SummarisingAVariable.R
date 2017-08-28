'#Learning Statistics with R - University of Adelaide

## Part IIIV - Working with Data

### Chapter 5 - Descriptive Stats
#### 5.4 - Summarising a Variable'

load('aflsmall.Rdata')
#install.packages('lsr')
#install.packages('ggplot2')
library(lsr)
library(ggplot2)

#view all summary statistics
summary(afl.margins)

#summary acts very differently based on the class of the object given to it

#numeric summary
class(afl.margins)
summary(afl.margins)

#logical vector summary
blowouts <- afl.margins > 50
class(blowouts)
summary(blowouts)

#factor summary --> akin to table()
class(afl.finalists)
summary(afl.finalists)
table(afl.finalists)

#convert factor to character summary
finalists2 <- as.character(afl.finalists)
class(finalists2)
summary(finalists2)

#summary() on DataFrames produces a slightly condensed summary of each variable inside it
load('clinicaltrial.Rdata')
summary(clin.trial)

#more summary stats calculate regardless of class --> but only useful for interval or ratio data
describe(afl.margins)

#these stats only make sense for numeric vectors (interval or ratio)
#factor vectors (nominal or ordinal), most descriptive stats are not that useful

#describe() convers factors + logical vectors into numeric vectors to do calculations (marked w/ *)
describe(clin.trial)
#these variables won't make much sense
#mood.gain is still useful
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

ggplot() + geom_histogram(aes(x = afl.margins), binwidth = 10, colour = 'red')
'Right/positively-skewed (tail to the right) = use median as measure of center' 

# Fairly substantial differences between mean and median indicate mean may be influenced a bit too much by extreme values
dataset <- c( -15,2,3,4,5,6,7,8,9,12)
summary(dataset)

# 10% trimmed mean (trim off top + bottom 10% of data)
mean(dataset, trim = .1)
# same answer as median = 5.5

# 5% trimmed mean for the afl.margins data
mean(afl.margins, trim = 0.05) #33.75

# Produce frequency table of of every team that played in any AFL final from 1987-2010
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



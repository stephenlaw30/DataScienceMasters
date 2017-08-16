'#Learning Statistics with R - University of Adelaide

## Part IIIV - Working with Data

### Chapter 5 - Descriptive Stats
#### 5.1 - Descriptive Stats

Any time you get a new data set to look at, 1 of the first tasks to do is find ways of summarising the data in a 
compact, easily-understood fashion. This is what **descriptive statistics** (as opposed to **inferential 
statistics**) is all about. In fact, too many people the term "statistics" is synonymous with descriptive 
statistics. '

load('aflsmall.Rdata')
#install.packages('lsr')
#install.packages('ggplot2')
library(lsr)
library(ggplot2)

# see the 2 vectors/variable names, margins (point differential) and finalists
who() 
str(afl.margins)
summary(afl.margins)
ggplot() + geom_histogram(aes(x = afl.margins), binwidth = 10, colour = 'red')

'Histogram is Right/positively-skewed (tail to the right) = use median as center of measure/measure' 

dataset <- c( -15,2,3,4,5,6,7,8,9,12)
summary(dataset)

'Fairly substantial difference between mean and median, but mean may be influenced a bit too much by extreme values'

#10% trimmed mean
mean(dataset, trim = .1)

'This is same answer as the median'

#5% trimmed mean for the afl.margins data
mean(afl.margins, trim = 0.05) #33.75

#Producing frequency table of of every team that played in any AFL final from 1987-2010
sort(table(afl.finalists), decreasing = TRUE)

'Over the 24 years for which we have data, Geelong played in more finals than any other team = it is the mode of the finalists'

#core packages in R don't have a function for calculating mode but lsr package does with modeOf() 
#maxFreq() = tells you what that modal frequency is

modeOf(afl.finalists)
maxFreq(afl.finalists)

'mode is most often calculated w/ *nominal* data (b/c means and medians are useless)
  - afl.margins variable --> clearly ratio data (point differential)

Consider a friend of yours is offering a bet to pick a football game at random and you have to guess the exact margin. 
If you guess correctly, win $50, if not, lose $1
For this bet, mean and median are completely useless, and it is the mode you should bet on'

modeOf(afl.margins) # 3 pt. margin
maxFreq(afl.margins) # occured 8 times
sum(round(mean(afl.margins)) == afl.margins)
# % chance
(maxFreq(afl.margins)/length(afl.margins))*100 #4.545% chance of winning if we pick the mode
(sum(round(mean(afl.margins)) == afl.margins)/length(afl.margins))*100 #2.272727% chance of winning if we pick the mean
(sum(round(median(afl.margins)) == afl.margins)/length(afl.margins))*100 #0.5681818% chance of winning if we pick the median



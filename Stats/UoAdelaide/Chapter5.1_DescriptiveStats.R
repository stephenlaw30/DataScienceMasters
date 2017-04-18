'#Learning Statistics with R - University of Adelaide

## Part IIIV - Working with Data

### Chapter 5 - Descriptive Stats
#### 5.1 - Descriptive Stats

Any time you get a new data set to look at, 1 of the first tasks to do is find ways of summarising the data in a 
compact, easily-understood fashion. This is what **descriptive statistics** (as opposed to **inferential 
statistics**) is all about. In fact, too many people the term "statistics" is synonymous with descriptive 
statistics. '

setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UoAdelaide')
load('aflsmall.Rdata')
#install.packages('lsr')
#install.packages('ggplot2')
library(lsr)
library(ggplot2)

who() #get 2 vectors/variables, margins (point differential) and finalists
str(afl.margins)
summary(afl.margins)
ggplot() + geom_histogram(aes(x = afl.margins), binwidth = 10, colour = 'red')

'Histogram is Right/positively-skewed --> higher margins = less frequent --> use median as center of measure/measure 
of central tendancy because mean is pulled to the right
  * mean = center of mass/gravity of the data set (balancing point if we put the histogram on a seesaw)
  * If data are **nominal**, dont use either mean or median, since both rely on the idea that the *numbers assigned 
  to values are meaningful.*
  * If the numbering scheme is arbitrary, it is probably best to use **mode** instead.
  * If data are **ordinal**, we are more likely to want to use median, which only makes use of the *order* info 
  within data (i.e., which numbers are bigger), but does not depend on the *precise* numbers involved, which is
  exactly the situation that applies when data are ordinal. 
  * The mean, on the other hand, makes use of the *precise numeric values* assigned to observations, so it is not 
  really appropriate for ordinal data.
  * For **interval** and **ratio** data, either mean or median is generally acceptable, depending on what you are 
  trying to achieve. 
    * mean advantage = it uses ALL the info in the data (useful when you do not have a lot of data)
    * mean disadvantage = *very sensitive to extreme values*
  * There are systematic differences between mean and median when the histogram is *asymmetric/skewed*. 
    * median is closer to the "body" of the histogram, whereas mean is dragged towards the tail (extreme values). 

1 of the fundamental rules of applied statistics = **the data are messy**, since real life is never simple, so data 
sets you obtain are never as straightforward as the statistical theory says.
  * **robust statistics** = tries to grapple with the messiness of real data and develop theory to cope with it.
  * Ex: 100, 2, 3, 4, 5, 6, 7, 8, 9, 10 --> If observed in real life data set, probably suspect something funny 
    going on with 100, probably an outlier, and might consider removing it from the data set
  * In real life, however, you don't always get such cut-and-dried examples. 
  * For instance, might get (15, 2, 3, 4, 5, 6, 7, 8, 9, 12), and 15 may look suspicious, but nowhere as much as 100
  * little trickier, as it might be a legitimate observation, it might not.
  * When faced with a situation where some most extreme-valued observations might not be quite trustworthy, mean is 
    not necessarily a good measure of central tendency =  highly sensitive to even just 1 or 2 extreme values, and 
    is thus not considered to be a **robust measure**. 
  * 1 remedy = to use the median

More general solution = use a **trimmed mean** --> "discard" most extreme examples on both ends (largest and 
smallest) and take the mean of everything else. 
  * Goal = preserve the best characteristics of the mean and median --> like median = not highly influenced by 
    extreme outliers, but like mean = "use" more than 1 of the observations. 
  * Generally describe a trimmed mean in terms of the % of observation on either side that are discarded. 
  * Ex: 10% trimmed mean discards largest and smallest 10% of observations and takes the mean of the remaining 80% 
  * 0% trimmed mean = regular mean, 50% trimmed mean = median. 
  * In this sense, trimmed means provide a whole family of central tendency measures that span the range from 
    regular mean to the median.'

dataset <- c( -15,2,3,4,5,6,7,8,9,12)
summary(dataset)

'Fairly substantial difference between mean and median, but mean may be influenced a bit too much by extreme values'

#10% trimmed mean
mean(dataset, trim = .1)

'Same answer as the median. Calculate 5% trimmed mean for the afl.margins data'
mean(afl.margins, trim = 0.05) #33.75

'Producing a **frequency table** of of every team that played in any AFL final from 1987-2010'

sort(table(afl.finalists), decreasing = TRUE)

'Over the 24 years for which we have data, Geelong played in more finals than any other team = mode of the finalists
  * core packages in R don't have a function for calculating the mode but lsr package does with **modeOf()**, and 
  **maxFreq()** = tells you what that modal frequency is.'

modeOf(afl.finalists)
maxFreq(afl.finalists)

'Generally true the mode is most often calculated when you have *nominal* data (b/c means and medians are useless 
for those variables), there are some situations in which you really *DO* want to know the mode of an ordinal, 
interval or ratio scale variable. 
  * Ex: afl.margins variable --> clearly a ratio (point differential), so in most situations mean or median is the 
  measure of central tendency you want. 
  * Consider a friend of yours is offering a bet to pick a football game at random and you have to guess the exact 
    margin. 
  * If you guess correctly, win $50, if not, lose $1
  * For this bet, mean and median are completely useless, and it is the mode you should bet on'

modeOf(afl.margins) #3
maxFreq(afl.margins) #8 times
length(afl.margins)
#% change
(maxFreq(afl.margins)/length(afl.margins))*100 #4.545% chance of winning

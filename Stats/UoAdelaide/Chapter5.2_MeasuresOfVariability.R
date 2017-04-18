'#Learning Statistics with R - University of Adelaide

## Part IIIV - Working with Data

### Chapter 5 - Descriptive Stats
#### 5.2 - Measures of Variability

Statistics discussed so far all relate to **central tendency** --> all talk about which values are "in the middle" 
or "popular" in the data. 

Central tendency is not the only type of summary statistic to calculate, and the 2nd thing we want is a **measure 
of the variability** of the data --> how *spread out* are the data, how *far* away from the mean/median do 
observed values tend to be? 

For now, assume the data are interval or ratio scale --> continue to use the afl.margins data. '

setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UoAdelaide')
load('aflsmall.Rdata')
#install.packages('lsr')
#install.packages('ggplot2')
library(lsr)
library(ggplot2)

'**Range** = biggest value minus the smallest value.'

max(afl.margins)-min(afl.margins)
range(afl.margins) #min max

'Although range is the simplest way to quantify variability, it's one of the worst because we want our summary 
measure to be **robust** and if the data has 1 or 2 extremely bad values in it, we would like our stats not to be 
unduly influenced by these cases. 
  * Ex: (100, 2, 3, 4, 5, 6, 7, 8, 9, 10) --> range of 110 is not robust, but if the outlier 100 were removed, we 
    would have a range of only 8.

**interquartile range (IQR)** --> like the range, but instead the difference between biggest + smallest value, it 
  is difference between the 25th quartile/percentiles (1st) and the 75th quartile/percentiles (3rd). 
  * Reminder = 10th percentile of a data set = smallest number x such that 10% of data is less than x. 
  * median = 50th quartile/percentile (2nd quartile)'

quantile(afl.margins) 
quantile(afl.margins, probs = 0.25) 
quantile(afl.margins, probs = 0.5) #median
quantile(afl.margins, probs = 0.75) - quantile(afl.margins, probs = 0.25) 
quantile(afl.margins, probs = c(.25,.75))

#IQR
quantile(afl.margins, probs = 0.75) - quantile(afl.margins, probs = 0.25) 
IQR(afl.margins)

'Obvious how to interpret the range, a little less obvious to interpret IQR. 
  * simplest way to think about it --> IQR = range spanned by the "middle half" of the data --> 1/4 of the data 
    falls below and above the 25th and 75th percentiles, leaving the "middle half" of the data between the two. 

**Mean absolute deviation** --> The 2 measures so far, range + IQR, both rely on the idea that we can measure the
  spread of the data by looking at the quartiles of the data. 
  * However, this isn't the only way to think about the problem. A different approach is to select a meaningful 
    reference point (usually mean or median) and then report the "typical" deviations from that reference point.
  * *typical* deviation = usualyl the mean or median value of these deviations
  * In practice, this leads to 2 different measures = **mean absolute deviation** (from mean)" and **median 
    absolute deviation** (from median)
  * The measure based on the median seems to be used in statistics, and does seem to be the better of the 2
  * The measure based on the mean does occasionally show up in psychology though.

Ex: 5 games w/ winning margins of 56, 31, 56, 8, 32.'
data <- c(56, 31, 56, 8, 32)
mean(data)
variations <- abs(data - mean(data))
mean(variations) #15.52 = mean absolute deviation for these 5 scores

#lst function
aad(data)

'**Variance**
Although the mean absolute deviation measure has its uses, it's not the best measure of variability to use. 
  * From a purely mathematical perspective, there are some solid reasons to prefer *squared* deviations rather than 
    absolute deviations --> obtains a measure = **variance**, s^2, which has a lot of really nice statistical 
    properties and 1 massive psychological flaw 
  * Basically same formula as mean absolute deviation, except with squares of deviations rather than absolute value
  * NOTE: Variances are **additive** - X and Y have variances VarX and VarY --> now to define a new variable Z that
    is the sum of X + Y, it turns out, VarZ = VarX + VarY, a very useful property (but not true of other measures)'
variance <- (data - mean(data))^2
mean(variance) #324.64
#R function
var(data) #405.8

'Answers are different? Check w/ afl.margins data'
variance <- (afl.margins - mean(afl.margins))^2
mean(variance) #675.9718

var(afl.margins) #679.8345

'Now they are similar, which seems like too much of a coincidence to be a mistake
  * R is evaluating a slightly different formula 
  * Instead of averaging the squared deviations (divide by the number of data points N), R divides by N - 1. '

sum((data-mean(data))^2)/4 #405.8

'There is a subtle distinction between "describing a sample" and "making guesses about a population from which the 
  sample came".
  * Up to this point, it's been a distinction without a difference. 
  * Regardless of whether describing a sample or drawing inferences about a population, mean is calculated the same
  * Not so for the variance or standard deviation, or for many other measures
  * Most of the time = not interested in the sample in and of itself but have a sample exist to tell you something 
    about the world. 
  * Starting to move away from a **statistic** to a **parameter**. 

How do you interpret the variance?
  * Descriptive statistics are supposed to describe things and right now the variance is a gibberish number. 
  * Really is no human-friendly interpretation of variance --> the most serious problem with variance. 
  * Although it has some elegant mathematical properties that suggest it is a fundamental quantity for expressing 
    variation, it is completely useless if you want to communicate with an actual human.
  * Variances = completely uninterpretable *in terms of the original variable* 
  * All numbers have been squared and do not mean anything anymore = a huge issue. 
  * Ex: Game 1 Margin was "376.36 points-squared higher than the average margin" = not a real unit of measurement

**Standard deviation**
  * Suppose you like using variance because of mathematical properties not talked about yet
  * But want a measure expressed in the same units as the data itself (i.e. points, not points-squared)
  * Take the square root of the variance = **standard deviation** = **root mean squared deviation (RMSD)**
  * much easier to understand "a standard deviation of 18.01 points", since it's expressed in the original units. '

sd(afl.margins)

'Interpreting SDs is slightly more complex b/c SD is derived from variance, a quantity w/ little to no meaning to
  humans
  * Consequence, rely on a simple rule of thumb = In general, expect 68% of data to fall w/in 1 SD of the mean, 95% 
    to fall within 2 SD, and 99.7% to fall within 3 SD 
  * Tends to work pretty well most of the time, but it's not exact + is calculated based on an assumption that the
  data is symmetric/normal/bell-shaped, and AFL winning margins is not
  * In this case, 65.3% of the AFL margins lies within 1 SD = pretty consistent with the "approximately 68% rule" 

**Median absolute deviation (MAD)**
  * pretty much identical to the idea behind the mean absolute deviation (AAD) but you use the median everywhere. '

median(abs(afl.margins - median(afl.margins))) #19.5

'This has a straightforward interpretation: every observation in the data lies some distance away from the typical 
  value (here, the median). 
  * The MAD = an attempt to describe a typical deviation from a typical value in the data set. 
  * Wouldn't be unreasonable to interpret the MAD value of 19.5 for AFL by saying "The median winning margin in 
    2010 was 30.5, indicating that a typical game involved a winning margin of about 30 points. However, there was 
    a fair amount of variation from game to game, with a MAD value = 19.5, indicating that a typical winning margin 
    would differ from this median value by about 19-20 points.'

#R function
mad(afl.margins, constant = 1) #19.5

'Constant argument --> Although the "raw" MAD value is completely interpretable on its own terms, it is not 
  actually how it's used in a lot of real world contexts. 
  * Instead, a researcher actually wants to calculate the SD but since the mean is very sensitive to extreme 
    values, so it the SD
  * So, just like using the median as a "robust" way of calculating "something that is like the mean", it's not 
    uncommon to use MAD as a method for calculating "something that is like the SD". 
  * Unfortunately, a raw MAD value (19.5) doesn't do this, while our SD = 26.07. 
  * However under certain assumptions, you can multiply the raw MAD value by 1.4826 and obtain a number that is 
    directly comparable to the SD 
  * As a consequence, the default value of **constant** = 1.4826, so when you use mad() w/out manually setting a 
    value:'

mad(afl.margins) #28.9107

'If you want to use this "corrected" MAD value as a *robust version of the SD*, you really are relying on the 
  assumption that the data is normal, which is not true for afl.margins

**Summary**
  * Range = full spread of the data, very vulnerable to outliers, and as a consequence is not often used unless you
    have good reasons to care about the extremes in the data.
  * IQR = where the "middle half" of the data sits, is pretty robust, and complements median nicely
  * Mean absolute deviation (AAD) = how far "on average" observations are from the mean, is very interpretable, but
    has a few minor issues (not discussed here) that make it less attractive to statisticians than the SD, so it 
    is Used sometimes, but not often.
  * Variance = average squared deviation from the mean, mathematically elegant, is probably the "right" way to
    describe variation around the mean, but is completely uninterpretable b/c it does not use the same units as the
    data, so almost never used except as a mathematical tool but is buried "under the hood" of a very large number
    of statistical tools.
  * SD = square root of the variance, fairly elegant mathematically, expressed in same units as data, so is 
    interpreted pretty well, in situations where mean = the measure of central tendency, this is the default, by 
    far the most popular measure of variation.
  * Median absolute deviation (MAD) = typical (i.e. median) deviation from the median value, is simple and 
    interpretable in the raw form, is a robust way to estimate the SD in the corrected form, for *some* kinds of 
    data sets, not used very often, but does get reported sometimes.

In short, the IQR and the SD are easily the 2 most common measures used to report variability of data, but there 
are situations in which the others are used. 
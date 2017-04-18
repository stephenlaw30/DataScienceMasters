'#Learning Statistics with R - University of Adelaide

## Part IIIV - Working with Data

### Chapter 5 - Descriptive Stats
#### 5.3 - Skew and Kurtosis

In practice, neither skew nor kurtosis is used anywhere near as frequently as the measures of central tendency and 
variability 
  * **Skew** is pretty important, so you see it mentioned a fair bit; but **kurtosis** is rarely reported in a 
    scientific manner

**Skewness** = a measure of asymmetry
  * data w/ a lot of extreme small values, lower tail is "longer" than the upper tail, not many extremely large 
  values = negatively/left skewed. 
  * more extremely large values than extremely small ones = positively skewed. 
  * actual formula for the skewness of a data set = Sum((x - mean(x))^3) / n*SD^3

psych package contains skew() to calculate skewness.'

setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UoAdelaide')
load('aflsmall.Rdata')
#install.packages('lsr')
#install.packages('ggplot2')
#install.packages('psych')
library(lsr)
library(ggplot2)
library(psych)

skew(afl.margins) #0.7671555

'Not surprisingly, AFL winning margins data is fairly skewed.

**Kurtosis** = a measure of the "pointiness" of a data set
  * By convention, the "normal curve" = 0 kurtosis = **mesokurtic** = just pointy enough --> so pointiness of a 
    data set is assessed relative to *this* curve. 
  * not pointy enough (bit of a uniform distribution) = negative kurtosis = **platykurtic** 
  * too pointy (large peak relative to all else) = kurtosis = positive = **leptokurtic** 

The equation for kurtosis is pretty similar in spirit to the formulas seen already for variance and skewness:
  * Sum((x - mean(x))^4 - 3) / n*SD^4

psych package has kurtosi() to calculate the kurtosis of data.'
kurtosi(afl.margins) #close to mesokurtic = just pointy enough.

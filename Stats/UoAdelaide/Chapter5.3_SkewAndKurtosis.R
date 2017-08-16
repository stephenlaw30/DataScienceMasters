'#Learning Statistics with R - University of Adelaide

## Part IIIV - Working with Data

### Chapter 5 - Descriptive Stats
#### 5.3 - Skew and Kurtosis'

#psych package contains skew() to calculate skewness

load('aflsmall.Rdata')
#install.packages('lsr')
#install.packages('ggplot2')
#install.packages('psych')
library(lsr)
library(ggplot2)
library(psych)

skew(afl.margins) #0.7671555

#psych package has kurtosi() to calculate the kurtosis of data.'
kurtosi(afl.margins) 
#close to mesokurtic = just pointy enough.
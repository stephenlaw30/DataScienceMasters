'#Learning Statistics with R - University of Adelaide

## Part IIIV - Working with Data

### Chapter 5 - Descriptive Stats

Any time you get a new data set to look at, 1 of the first tasks to do is find ways of summarising the data in a 
compact, easily understood fashion. This is what **descriptive statistics** (as opposed to **inferential statistics**)
is all about. In fact, too many people the term "statistics" is synonymous with descriptive statistics. It is this 
topic that we'll consider in this chapter, but before going into any
details, let's take a moment to get a sense of why we need descriptive statistics. To do this, let's load the
aflsmall.Rdata file, and use the who() function in the lsr package to see what variables are stored inthe file:'

setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UoAdelaide')
load('aflsmall.Rdata')
#install.packages('lsr')
library(lsr)
library(ggplot2)

who() #get 2 vectors/variables, margins (point differential) and finalists

summary(afl.margins)
ggplot() + geom_histogram(aes(x = afl.margins), binwidth = 10, colour = 'red')
'right/positively-skewed --> higher margins = less frequent --> use median as center of measure/measure of central
tendancy because mean is pulled to the right
  - mean = center of mass/gravity of the data set (balancing point if we put the histogram on a seesaw

. If data are **nominal**, dont use either the mean or the median, since both rely on the idea that the numbers 
    assigned to values are meaningful. 
    - If the numbering scheme is arbitrary, it's probably best to use the **mode** instead.
. If data are **ordinal**, more likely to want to use the median, which only makes use of the order info in data 
    (i.e., which numbers are bigger), but doesn't depend on the *precise* numbers involved. 
    - That's exactly the situation that applies when data are ordinal. 
    - The mean, on the other hand, makes use of the precise numeric values assigned to the observations, so it's not
        really appropriate for ordinal data.
. For **interval** and **ratio** data, either one is generally acceptable, depending a bit on what you are trying to
  achieve. 
    - The mean has the advantage that it uses ALL the info in the data (useful when you don't have a lot of data), 
      but it's *very sensitive to extreme values*


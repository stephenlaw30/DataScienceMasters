'Lab 5: Track and Field World Records

We want to find the best-fitting linear model for mens pole vault world records since 1970.'

setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UT/UT.7.11xFoundationsofData Analysis.1')
wr<- read.csv('WorldRecords.csv')

'1.  Create a new data frame that contains the world record cases in the mens pole vault event in 1970 and later. '
mens70.pv <- subset(wr, Event == 'Mens Polevault' & Year >= 1970)

mens70.pv[which.max(mens70.pv$Record),]
'6.14 is the standing world record height (in meters) for mens pole vault, and 1986 was the year the pole vault record
first exceeded 6 meters.

Create a scatterplot showing the mens pole vault records since 1970 as a function of year and fit a linear model to
the data.'
library(ggplot2)
library(SDSFoundations)

ggplot(mens70.pv) + geom_point(aes(x = Year, y = Record)) +
  geom_smooth(aes(x = Year, y = Record), method = "lm", se = FALSE) + 
  stat_smooth_func(geom="text",method="lm",hjust=0,parse=TRUE)

cor(mens70.pv$Year,mens70.pv$Record)
linFit(mens70.pv$Year,mens70.pv$Record)

'The record pole vault height steadily increases over time.

The correlation coefficient (R) is 0.9863971, the coefficient of determination (R2) is 0.97298, the intercept is 
-51.8541, and the slope is 0.02911 for the linear model that describes the change in the mens pole vault world 
record since 1970. So, the record has increased by an average of 0.03 meters per year since 1970.
The record has increased by an average of 0.97 meters per year since 1970.
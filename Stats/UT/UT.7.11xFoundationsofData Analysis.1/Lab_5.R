'Lab 4: Track and Field World Records

Every 4 years, track and field athletes take the world stage at the Summer Olympics.  Some of the most exciting events 
during each Olympics are those in which athletes push the limits of their sport, breaking their own personal best 
records, national records, or even world records.  We have compiled the world record times for track events like the 
100m dash and record distances for field events like the shotput into a single dataset. This dataset includes info on 
the person who broke the record, his/her nationality, where the record was broken, and year it was broken. Note that
not all world records are broken during the Olympics, with many occurring in regional or national competitions.

In this lab, you will use linear modeling to answer a question of interest. When fitting a linear model to data, 
you should first create a scatterplot of the two variables of interest to examine the data. The R-squared 
(correlation coefficient) will tell you the proportion of variance in the dependent variable that can be explained 
by the independent variable. A questions that might be answered using linear modeling would be "How have world 
record times for the mens and womens mile changed over the years?"

**Primary Research Question** - How have the world record times for the mens and womens mile event changed over the 
years?'

setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UT/UT.7.11xFoundationsofData Analysis.1')
wr<- read.csv('WorldRecords.csv')

str(wr)
summary(wr)

'1. Create a subset of the data that contains World Record cases for both mens and womens Mile event.'
mens <- subset(wr, Event == "Mens Mile")
womens <- subset(wr, Event == "Womens Mile")

'3. Create a scatterplot for each relationship of Mile time and year: one for men and one for women.'
library(ggplot2)
library(SDSFoundations)
ggplot(mens) + geom_point(aes(x = Year, y = Record))
ggplot(womens) + geom_point(aes(x = Year, y = Record))

'5. Run a linear model for each event and interpret the results'
ggplot(mens) + geom_point(aes(x = Year, y = Record)) +
  ggtitle('mens') + 
  geom_smooth(aes(x = Year, y = Record), method = "lm", se = FALSE)
ggplot(womens) + geom_point(aes(x = Year, y = Record)) +
  ggtitle('womens') + 
  geom_smooth(aes(x = Year, y = Record), method = "lm", se = FALSE)

'Men show a stronger linear relationship (more actual points on best-fit/linear regression line)'

#calculate R and R2
cor(mens$Year,mens$Record) #-0.9886641
cor(mens$Year,mens$Record)^2 #0.9774568

cor(womens$Year,womens$Record) #-0.9463519
cor(womens$Year,womens$Record)^2 #0.8955819

'Both --> as year increases, record decrease (negative R values)'

linFit(mens$Year,mens$Record)
linFit(womens$Year,womens$Record)

'On average, men trim 0.39347 seconds (slope of line) off the world record time in the Mile each year, and women 
trim 0.97288 seconds (slope of line) off the world record time in the Mile each year. So, we would predict it would
take about 2.5 years for the men's mile record to decrease by 1 full second and about 1 year for the womens to do 
so. The proportion of variance in the mens World Record times in the Mile that can be explained by year is 0.97746 
(R2), and the proportion for women is 0.89558. A reasonable conclusion to draw from this analysis is "World record 
times in the Mile have decreased linearly over the last several decades for both men and women."

Based on scatterplots of the mens and womens world record mile event, both of these events follow a strong, negative
linear relationship over time. For both groups, the assumption of linearity appears to be satis???ed. The mens world 
record mile time decreases by an average of 0.394 seconds per year, while the womens record decreases by an average
of 0.973 seconds per year. Because the intercept estimate is the value of the record when year is equal to 0, it is
not interpretable in the context of the problem. Both linear models ???t the data well, with R-squared values for the 
mens and womens models equal to 0.97746 and 0.89558, respectively. For the mens world record, 97.7% of the 
variability/variance is explained by the linear model of YEAR, while for the female world record, 89.6% of the 
variability/variance in performance can be explained by the linear model of YEAR.
'Lab 4: Track and Field World Records

Every 4 years, track and field athletes take the world stage at the Summer Olympics.  Some of the most exciting events 
during each Olympics are those in which athletes push the limits of their sport, breaking their own personal best 
records, national records, or even world records.  We have compiled the world record times for track events like the 
100m dash and record distances for field events like the shotput into a single dataset. This dataset includes info on 
the person who broke the record, his/her nationality, where the record was broken, and year it was broken. Note that
not all world records are broken during the Olympics, with many occurring in regional or national competitions.

**Primary Research Question** - How has the men's shotput world record changed over time?  What about the women's?'

setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UT/UT.7.11xFoundationsofData Analysis.1')
wr<- read.csv('WorldRecords.csv')

str(wr)
summary(wr)

'10 different types of events (e.g. "Mens 100m," "Womens shotput," etc.) are represented in the dataset.'

wr[wr$Athlete=='Usain Bolt',]

'Usain Bolt first break the world record for the men 100m dash in 2008'

table(wr$Event)
wr[wr$Event=='Womens Mile' & wr$Record < 260,]

'Mary Slaney was the first woman to break the women's 1 mile world record with a time of less than 260 seconds

Let us find the variables we need to answer the question (variables of interest). RECORD tells us the record-setting
time or distance, and its quantitative. YEAR tells us when the record was broken and its quantitative.
2 points possible (graded)

For each sex, we will begin our analysis by generating a scatterplot of shotput distance and year because it will
show us if these 2 numeric variables are linearly related.

Once we fit a linear model to this shotput world record data, we will be able to report the average rate of change 
in world record shotput distance per year.

1. Create 2 subsets of the dataset that contain only the World Record cases for mens and then womens shotput.'
mens <- subset(wr, Event == 'Mens Shotput')
womens <- subset(wr, Event == 'Womens Shotput')

#3. Create a scatterplot of year and record shotput distance: one for men and one for women.  
library(ggplot2)
ggplot(mens) + geom_point(aes(Year, Record)) + ggtitle('mens')
ggplot(womens) + geom_point(aes(Year, Record)) + ggtitle('womens')

#4. Confirm from these plots that a linear model is appropriate and run a linear model for each event
ggplot(mens) + geom_point(aes(Year, Record)) + ggtitle('mens') +
  geom_smooth(aes(x = Year, y = Record), method = "lm", se = FALSE)
ggplot(womens) + geom_point(aes(Year, Record)) + ggtitle('womens') + 
  geom_smooth(aes(x = Year, y = Record), method = "lm", se = FALSE)

library(SDSFoundations)
linFit(mens$Year,mens$Record)
linFit(womens$Year,womens$Record)
#rate of change of women is greater for each time the record is broken/year

#calculate R and R2
cor(mens$Year,mens$Record)
cor(mens$Year,mens$Record)^2

cor(womens$Year,womens$Record)
cor(womens$Year,womens$Record)^2

'Based on scatterplots of the men's and women's world record shotput distance, both of these events follow a strong,
positive linear relationship over time. The men's world record distance increases by an average of 0.13411 meters 
per year, while the women's record distance increases by an average of 0.23366 meters per year. Because the 
intercept estimate is the value of the record distance when Year is equal to 0, it is not interpretable in the 
context of the problem. Both linear models fit the data well, with R-squared values for the men's and women's models 
equal to 0.9411 and 0.96227, respectively.'
'Lab 3: Professional Bull Riding

During a professional bull-riding event, riders usually attempt to ride a bull 3+ times. This means they can record a
"ride" (successfully staying on the bull) multiple times in the same event.'

setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UT/UT.7.11xFoundationsofData Analysis.1')
library(SDSFoundations)
bull <- read.csv("BullRiders.csv")
RidesPerEvent14 <- new_bull$Rides14/new_bull$Events14

'Subset the dataset for riders that had at least 1 ride in the 2014 season, new_bull.'
new_bull <- subset(bull, Rides14 > 0)

'Create a new variable for the average number of rides per event for each bull rider in the new_bull dataset'
new_bull$RidesPerEvent14 <- new_bull$Rides14/new_bull$Events14

'Make a histogram of "rides per event" and find the 5-number summary for it.'
library(ggplot2)
ggplot(new_bull) + geom_histogram(aes(x = RidesPerEvent14), binwidth = 0.25)

fivenum(new_bull$RidesPerEvent14)

' Create a scatterplot of "rides per event" and yearly ranking (Rank14) and add a line of best fit. The relationship
between these 2 variables is a negative liner one'

ggplot(data = new_bull) + geom_point(aes(x = RidesPerEvent14, y = Rank14)) + 
  geom_smooth(aes(x = RidesPerEvent14, y = Rank14), method = "lm", se = FALSE)

'The correlation coefficient for rides per event and yearly ranking is -0.495'
cor(new_bull$RidesPerEvent14,new_bull$Rank14)

'Suppose college GPA and grad school GPA have a correlation coefficient of 0.75. Based on this, the proportion of 
variation in grad school GPA left unexplained after taking college GPA into account is 1 - (r**2) = 1 - (0.75**2) = 
0.4375


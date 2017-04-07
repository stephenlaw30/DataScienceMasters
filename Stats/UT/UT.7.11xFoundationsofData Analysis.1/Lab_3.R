'Lab 3: Professional Bull Riding

Over 1,200 bull riders from around the world are members of the Professional Bull Riders (PBR), who compete in more
than 300 PBR-affiliated bull riding events per year. In the American tradition, the rider must stay atop the 
bucking bull for a full 8 seconds. This data set includes info about the top-ranked bull riders for 2013. Rankings 
are based on a system which awards points for qualified rides at events throughout the season. 

**Primary Research Question** - For the 2013 season, is there a linear relationship between how often a rider 
placed in the Top 10 and the number of times he stayed on his bull for a full 8 seconds?'

setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UT/UT.7.11xFoundationsofData Analysis.1')
library(SDSFoundations)
bull <- read.csv("BullRiders.csv")

'A correlation can tell us the direction and strength of a linear relationship between 2 quantitative variables. The 
value of a correlation would increase if outliers were removed.

A question that can be answered with correlation would be "Which variable has the strongest linear relationship with 
earnings: successful ride percentage or Cup points?

Let's break this analysis into the different steps needed to construct a complete answer. Create a dataset which 
contains riders that participated in at least 1 event in 2012.'
new_bull12 <- subset(bull, Events12 > 0)

'Make a histogram to visualize the distribution of Earnings for 2012.'
library(ggplot2)
ggplot(new_bull12) + geom_histogram(aes(x = Earnings12), binwidth = 50000)

'Generate the appropriate descriptive statistics for this distribution.'
summary(new_bull12$Earnings12)
fivenum(new_bull12$Earnings12)

'Make a correlation matrix for Earnings12, RidePer12 and CupPoints12.'
cor(new_bull12[,c('Earnings12','RidePer12','CupPoints12')])

'Plot a scatterplot for Earnings12 with each variable of interest with Earnings12 on the y-axis and check for
outliers.'
ggplot(data = new_bull12) + geom_point(aes(x = RidePer12, y = Earnings12)) + 
  geom_smooth(aes(x = RidePer12, y = Earnings12), method = "lm", se = FALSE)

ggplot(data = new_bull12) + geom_point(aes(x = CupPoints12, y = Earnings12)) + 
  geom_smooth(aes(x = CupPoints12, y = Earnings12), method = "lm", se = FALSE)

'The shape of the Earnings distribution for 2012 is positively/right-skewed, and the average amount earned by a 
bull rider in 2012 was $147952, while the highest amount was $ 1464476.

The scatterplot of Earnings and Ride Percentage shows a linear relationship with a correlation of 0.593

The scatterplot of Earnings and Cup Points shows a linear relationship with a correlation of 0.656

An outlier can have a significant impact on the correlation coefficient. Sometimes it is important to remove these 
points to examine the size of this impact. ID the extreme data value in Earnings'

new_bull12[which(new_bull12$Earnings12 == max(new_bull12$Earnings12)),]

'The extreme earnings data point belonged to Silvano Alves, the rider that came in 1st Place in 2012. This data 
point falls above the best-fit line in the scatterplot

Remove this data point from the dataset to assess what kind of impact, if any, it had on our correlation analysis.
Then rerun the correlation matrix and the scatterplots to see the difference. '
noOutlier <- new_bull12[new_bull12$Earnings12 < 1000000,] 

cor(noOutlier[,c('Earnings12','RidePer12','CupPoints12')])

ggplot(data = noOutlier) + geom_point(aes(x = RidePer12, y = Earnings12)) + 
  geom_smooth(aes(x = RidePer12, y = Earnings12), method = "lm", se = FALSE)

ggplot(data = noOutlier) + geom_point(aes(x = CupPoints12, y = Earnings12)) + 
  geom_smooth(aes(x = CupPoints12, y = Earnings12), method = "lm", se = FALSE)

'After removing the outlier, the new correlation of Earnings and Ride Percentage for 2012 was 0.803 and was 0.893 
for the new correlation of Earnings and Cup Points for 2012.

We would say that this data point was an influential point because it masked the strength of the relationships 
between Earnings and the other variables

An initial examination of the relationships between Ride Percentage (RidePer) and Earnings, and Cup Points 
(CupPoints) and Earnings showed that Cup Points had the strongest relationship to Earnings. Ride Percentage and 
Earnings showed a correlation value of 0.5934110 while Cup Points and Earnings had a correlation value of 0.6569363.
Visual examination showed an outlier in both relationships via a rider who has earned over $1M. Removal of this
increased the initial relationship: Ride Percentage and Earnings now had a correlation value of 0.8035574 and Cup
Points and Earnings had a correlation value of 0.8929208. CupPoints12 still had the higher relationship to Earnings. 
Visual examination showed a good linear relationship for both Ride Percentage and Cup Points, indicating the correct
use of the correlation coefficient.'
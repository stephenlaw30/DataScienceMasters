'Pre-Lab 3: Professional Bull Riding

Over 1,200 bull riders from around the world are members of the Professional Bull Riders (PBR), who compete in more
than 300 PBR-affiliated bull riding events per year. In the American tradition, the rider must stay atop the 
bucking bull for a full 8 seconds. This data set includes info about the top-ranked bull riders for 2013. Rankings 
are based on a system which awards points for qualified rides at events throughout the season. 

**Primary Research Question** - For the 2013 season, is there a linear relationship between how often a rider 
placed in the Top 10 and the number of times he stayed on his bull for a full 8 seconds?'

setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UT/UT.7.11xFoundationsofData Analysis.1')
library(SDSFoundations)
bull <- read.csv("BullRiders.csv")

dim(bull) #58 obs of 14 vars
str(bull)
head(bull,10)

head(bull,15) 

'Of the first 10 riders in the dataset, 3 have been pro for 10 years or more. Of the top 15 riders so far in 2015, 
0 rides were completed by the rider with the fewest buck-outs in 2014, Kaique Pacheco.

**Top10_13** tells us how many times the rider has placed in the Top 10 at the end of the 2013 season and Rides13 
tells us the number of times a rider stayed on his bull for the full 8 seconds in 2013. Both are numerical.

We should be using correlation for the analysis because we want to explore a linear relationship between 2 
quantitative variables. We should generate a scatterplot of these 2 variables before we continue our analysis because
we want to confirm that the relationship is linear.

Create a subset of the data which contains only riders that have participated in at least one event in 2013.'

rider13 <- subset(bull, Events13 > 0)
#rider13 <- bull[bull$Events13  > 0 ,]

'Create a scatterplot of the two variables of interest.'
hist(rider13$Rides13)
summary(rider13$Rides13)
fivenum(rider13$Rides13)
hist(rider13$Top10_13)
summary(rider13$Top10_13)
fivenum(rider13$Top10_13)

'Both right-skewed, if anything'

library(ggplot2)
ggplot(data = rider13) + geom_point(aes(x = Top10_13, y = Rides13))

'Check to see that the relationship is linear, which it is. Plot a line of best fit as a guide.'
ggplot(data = rider13) + geom_point(aes(x = Top10_13, y = Rides13)) + 
  geom_smooth(aes(x = Top10_13, y = Rides13), method = "lm", se = FALSE)

'If the relationship is linear, calculate the correlation coefficient.'
cor(rider13[,c('Top10_13','Rides13')])
cor(rider13$Top10_13,rider13$Rides13) #0.916606

'A correlation matrix allows you to calculate multiple correlation coefficients at a time. Create one between 
Rides13 and Top10_13. If you wanted to include other variables as well, you would add those variable names to the
"vars" object.'

plot(bull$Events12, bull$BuckOuts12)
abline(lm(bull$Events12~bull$BuckOuts12)) #linear model of event as a function of buckouts

'In this scatterplot, the line of best fit seems to not be going through the center of the scatterpot because Events
and BuckOuts should be switched in abline(). Below is the correct code'
abline(lm(bull$BuckOuts12~bull$Events12)) #linear model of buckouts as a function of events

'The histogram and descriptive statistics tell us that, on average, a bull rider in 2013 has 19 rides, which is the
median, because the histogram is not symmetrical. Also, these 2013 bull riders made it into the Top 10 an average 
of 6 times in 2013. 

The scatterplot show us a relationship that looks linear, moderately strong, and positive, so it looks like bull 
riders that appear frequently in the Top 10 list tend to have a higher number of successful rides.

The correlation, rounded to 3 decimal places, between the number of Top 10 appearances and the number of successful
rides for 2013 is r = 0.917 and appears twice in the correlation matrix.

On the scatterplot, we see a data point with a fairly large residual, a rider had 22 rides, but only placed in the
Top 10 2 times. This rider data point falls below the line of best fit. If his data followed the line of best fit, 
he should have placed in the Top 10 about 6 times. ID the rider'

rider13[which(rider13$Top10_13 == 2 & rider13$Rides13 == 22),]

#identify a specific record
which(new_bull$Top10_13==2 & new_bull$Rides13==22)

'After looking at the data for Nathan Schaper, we can explain why he has placed in the Top 10 so few times, which is
because His ride % was only about 33%, which was not high enough to place him in the Top 10.

So, There is a strong positive linear relationship between the # of 8-second rides a bull rider completed and the 
total number of times he made it in the Top 10 after the 2013 season, (r = 0.917). The average number of rides for 
these bull riders was around 19, and there were no significant outliers. 1 rider appeared to have placed in the 
top-10 rankings only twice, despite an above-average number of rides. Upon closer inspection, we could see he did
not have a very high ride %, which might account for his few appearances in the Top 10.'
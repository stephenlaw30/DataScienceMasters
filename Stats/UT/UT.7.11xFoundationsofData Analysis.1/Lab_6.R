'Lab 6: Worldwide Trends in Internet Usage

When choosing between 2 models with very similar R2 values, an additional statistic you should examine to help 
select the best-fitting model are the residuals. The parameter that represents the rapidity of growth (or change) 
in both the exponential and the logistic model is b. Most biological data will follow a logistic growth model 
because the logistic model takes into account the fact that most growth does not continue indefinitely.

**Primary Research Question** - Denmark is a high-income country in Europe of about 5.5 million people. What is the
best-fitting model for growth of internet usage in Denmark since 1990?  '

setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UT/UT.7.11xFoundationsofData Analysis.1')
bank <- read.csv('WorldBankData.csv')

str(bank)
summary(bank) #lot of NAs


'1. Create a variable representing proportion of the population using the internet (internet users / population).'
denmark <- subset(bank, Country == 'Denmark')
denmark$internet.prop <- denmark$internet.users / denmark$population
denmark$internet.users.mil <- denmark$internet.users/1000000

'2. Create a subset of the data that only contains data from 1990 onward.'
denmark90 <- subset(denmark, year >= 1990)

'3. Create a new variable that is "years since 1990". '
denmark90$yearsSince90 <- denmark90$year - 1990

'5. Determine the best-fitting model (exponential or logistic) for internet usage for Denmark from 1990 onward.'
library(SDSFoundations)

#linear
linFit(denmark90$yearsSince90,denmark90$internet.prop)
' Intercept =  -0.12456 
 Slope =  0.05395 
R-squared =  0.92272
'
#exponential
expFit(denmark90$yearsSince90, denmark90$internet.prop, xlab = 'Year', ylab = 'Proportion of Internet Users')
' a =  0.00585 
 b =  1.34666 
 R-squared =  0.80012
'
#logistic
logisticFit(denmark90$yearsSince90, denmark90$internet.prop, xlab = 'Year', ylab = 'Proportion of Internet Users')
'Logistic Fit 
 C =  0.89668 
a =  308.8345 
b =  1.73124 
R-squared =  0.99487
'

#all
tripleFit(denmark90$yearsSince90, denmark90$internet.prop, xlab = 'Year', ylab = 'Internet Users')

'The best-fitting model for growth of internet usage in Denmark from 1990 onward was the logistic model. The growth
factor (b) for the exponential model is 1.34666, and the percent growth rate (r = b - 1) of internet use, according
to the exponential model is 34.67% -> 35%

The carrying capacity in Denmark is 0.89668 and the growth indicator is 1.73124. 

The exponential model predicts that 70% of the Denmark population would be using the internet in the year 2006
  * 0.7 = 0.00585*(1.34666 )^t --> 0.7/0.00585 = 1.34666^t --> log(0.7/0.00585) = t*log(1.34666) 
    --> log(0.7/0.00585) / log(1.34666)  = t = 16.07593'

#check with expFitPred()
expFitPred(denmark90$yearsSince90, denmark90$internet.prop,16.07593)

'The logistic model predicts that 70% of the Denmark population would be using the internet in the year 2002
  * 0.7 =  0.89668 / (1 + 308.8345*(1.73124)^-t --> (0.89668/0.7) = 1 + 308.8345*(1.73124)^-t -->
    (0.89668/0.7) - 1 = 308.8345*(1.73124)^-t --> ((0.89668/0.7) - 1)/308.8345 = (1.73124)^-t -->
    log(((0.89668/0.7) - 1)/308.8345) = -t*log(1.73124) --> log(((0.89668/0.7) - 1)/308.8345) / log(1.73124) = -t 
    --> -12.75843 * -1 --> 12.75843

After using both an exponential AND a logistic function to model the growth of internet usage since 1990 in Denmark, 
we found the logistic model fit better with a high R-squared value of 0.99487, compared to an R-squared value of
0.80012 for the exponential model. In addition, it is visually clear from the graphs that the logistic model fit the
observed data better than the exponential model. All of this suggests that we should trust predictions from the 
logistic model more than predictions from the exponential model. The exponential model suggests that in 1990, there 
was a predicted proportion of 0.00585 of the population of Denmark that used internet, with the proportion of 
internet users increasing by a factor of 1.34666 every year after 1990, on average. The logistic model shows that 
the predicted carrying capacity of the proportion of people who use internet in Denmark was .8967. Since the 
logistic model fits better, the proportion of internet users in Denmark will probably eventually level off rather 
than continuing to grow exponentially.'
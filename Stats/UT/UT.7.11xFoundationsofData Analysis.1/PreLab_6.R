'Lab 6: Worldwide Trends in Internet Usage

The World Bank is a data collection of info on all the world's countries. Data is collected by country, and includes 
items such as total population, CO2 emissions, and the number of mobile device subscriptions. We will examine some 
of the trends in this dataset and interpret the parameters of the fitted models to best describe the change over 
time.


**Primary Research Question** - What model best describes the 1st decade of internet usage (90-99) in the US? Which
model is a better long-term fit?'

setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UT/UT.7.11xFoundationsofData Analysis.1')
bank <- read.csv('WorldBankData.csv')

str(bank)
summary(bank) #lot of NAs

head(bank[bank$IncomeGroup == 'Low income',])
bank$rural.population[bank$Country == 'Aruba' & bank$year ==1970]
bank[bank$Country == 'Australia',]

'The first "Low Income" country in the dataset is Afghanistan, the rural population of Aruba in 1970 was 29164, and
the first year Australia had data on the number of mobile device subscriptions was 1987.

internet.users tells us the number of internet users in a specific year and its quantitative. year tells us when the
number of internet users was recorded and its quantitative.

We be using for this analysis and why?

R-squared is the statistic helps us determine how well a particular model fits the data. We will calculate residuals
(the difference between a predicted value and the actual observed value.) after fitting both an exponential and a
logistic model to a set of data.

1. Create a subset of the dataset that contains only the information for the United States.'
usa <- subset(bank, Country == 'United States')

'2. Create a subset of the US data that contains only the years 1990 to 1999.  '
us90 <- subset(usa, year >=1990 & year <= 1999)

'3. Use a function to fit both an exponential and a logistic model to the data.  '
#more interpretable internet user count
us90$internet.users.mil <- us90$internet.users/1000000

#years since '90
us90$yearsSince90 <- us90$year - 1990

library(SDSFoundations)

#linear
linFit(us90$yearsSince90,us90$internet.users.mil)
' Intercept =  -16.36681 
 Slope =  11.16679 
R-squared =  0.88059
'
#exponential
expFit(us90$yearsSince90, us90$internet.users.mil, xlab = 'Year', ylab = 'Internet Users')
' a =  1.87184 
 b =  1.60845 
R-squared =  0.98266
'
#logistic
logisticFit(us90$yearsSince90, us90$internet.users.mil, xlab = 'Year', ylab = 'Internet Users')
' C =  127.7935 
 a =  121.4 
b =  1.96391 
R-squared =  0.99802
'
#all
tripleFit(us90$yearsSince90, us90$internet.users.mil, xlab = 'Year', ylab = 'Internet Users')

'4. Using each model, predict the number of internet users in 2006. '
##linear
-16.36681 + 11.16679*((2006-1990)) # = 162.3018 M

#exponential
1.87184*(1.60845)^(2006-1990) #3756.555 M

#logistic
127.7935/(1+121.4*(1.96391)^-(2006-1990)) #= 127.4775 M

expFitPred(us90$yearsSince90, us90$internet.users.mil, (2006-1990)) #3756.413 M
logisticFitPred(us90$yearsSince90, us90$internet.users.mil, (2006-1990)) #= 127.477 M

'5. Compare size of the residuals for 2006 to determine which model appears to have better long-term fit = LOGISTIC

In both of these models, Year 0 corresponds to 1990. expFit() and logisticFit() are use to fit exponential and 
logistic models to the data. The value of "us90$yearsSince90" for 2006 is 16. In 1990, the number of internet users
in the US was 1,958,863. The value of "us90$internet.users.mil" for 1990 is then 1.958863'

usa$internet.users[usa$year == 2006]/1000000

'The actual number of internet users (in millions) in the United States in 2006 was 205.6768.

The exponential model predicted 3756.413 million users in 2006. The residual was 205.6768 - 3756.413 = -3550.736.
The logistic model predicted 127.477 million users in 2006. The residual was 205.6768 - 127.477 = 78.1998

Based on the model residuals for 2006, the logistic model does a better job of predicting (long-term) the number of 
internet users.

Both the logistic and exponential models do a fairly good job of fitting the pattern of internet usage in the US 
from 1990-1999, as shown by R-squared values > 0.95. If we look ahead to 2006, however, we see that the logistic 
model has a better long-term fit. This model predicted  127.5 million users in 2006, with a smaller residual of 
78.2  million. The exponential model predicted far more users than there really were (> 3 billion). It appears the
number of new internet users grew rapidly at first but then began to level off over time.'
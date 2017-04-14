'Problem Set 6.1: Worldwide Trends in Internet Usage

**Primary Research Question** - How has mobile phone usage in Brazil changed since 1995?'

setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UT/UT.7.11xFoundationsofData Analysis.1')
bank <- read.csv('WorldBankData.csv')

str(bank)
summary(bank) #lot of NAs
names(bank)

'1. Create a subset of the world bank data that contains records from Brazil 1995 and later.'
brazil95 <- subset(bank, Country == 'Brazil' & year >= 1995)
head(brazil95,15)

'2. Add "years since 1995" and update the units of the "mobile.users" to millions of users. '
brazil95$yearsSince95 <- brazil95$year - 1995
brazil95$mobile.users.mill <- brazil95$mobile.users/1000000

brazil95$mobile.users.mill[brazil95$year == 2000]

'The number of mobile users in Brazil (in millions) in 2000 is 23.18817'

brazil95[,c('year','mobile.users.mill')]

'Brazil first record more than 100 million mobile users in 2007'

'enerate a scatterplot and fit a linear, exponential and logistic model to the data.'

linFit(brazil95$yearsSince95, brazil95$mobile.users.mill)
' Intercept =  -40.92135 
 Slope =  14.85529 
R-squared =  0.9136'

expFit(brazil95$yearsSince95, brazil95$mobile.users.mill)
' a =  3.22757 
 b =  1.33871 
 R-squared =  0.93243'

logisticFit(brazil95$yearsSince95, brazil95$mobile.users.mill)
' C =  347.9316 
 a =  72.74891 
 b =  1.3595 
 R-squared =  0.99785
'
tripleFit(brazil95$yearsSince95, brazil95$mobile.users.mill)

'The Logistic Growth Model best describes the increase in mobile users in Brazil since 1995 (best R2) The proportion
of variation in mobile users is explained by years since 1995 in the best-fitting logistic model 0.99785 (the R2).
Using the best-fitting logistic model, the predicted number of mobile users (in millions) in Brazil in 2025 is 345'

347.9316 / (1 + 72.74891*(1.3595)^-30) #345.4266
logisticFitPred(brazil95$yearsSince95, brazil95$mobile.users.mill,30) #345.427
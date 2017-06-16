'Question 1 - How much money do professional bull riders earn by participating in an event?'
library(SDSFoundations)
bulls <- BullRiders

'1. Create a new variable earnings_per for average earnings per event in the 2012 season for each bull rider'
head(bulls)
bulls$earnings_per12 <- bulls$Earnings12/bulls$Events12

#bulls12 <- bulls[!is.na(bulls$earnings_per12),]

'2. Make a histogram of your "earnings per event" variable.'
library(ggplot2)
ggplot(bulls) + geom_histogram(aes(x = earnings_per12), color = 'white')

'1a. Have we met the assumptions for being able to calculate a 95% CI to estimate the true mean earnings-per-event 
for a professional bull rider (using t)? Use the histogram to help answer this question.'

# - No, the distribution of "earnings_per" is positively skewed, with an outlier

'When a variable is highly skewed, we can transform the data into a shape that allows us to conduct our analysis. 
1. Create a new variable that is the log of your "earnings_per" variable.'

bulls$earnings_per12 <- log(bulls$earnings_per12)

ggplot(bulls) + geom_histogram(aes(x = earnings_per12), color = 'white')

'1b. Now can we reliably calculate a 95% confidence interval for the mean of this transformed variable?'

# - Yes, the distributuon of the log-transformed variable looks relatively normal (some slight positive skew).

'1c. What is the mean of the log-transformed earnings-per-event variable? (Round to 2 decimal places.)'
mean(bulls$earnings_per12, na.rm = T) #8.846387 = 8.85

'1d. What are the lower + upper-bounds for a 95% CI around this transformed mean?'

t.test(bulls$earnings_per12, mu=8.85)
'	One Sample t-test

data:  bulls$earnings_per12
t = -0.026988, df = 28, p-value = 0.9787
alternative hypothesis: true mean is not equal to 8.85
95% CI: (8.572169 9.120605)
mean of x: 8.846387 '


'To best interpret the 95% CI, we need to transform the UNROUNDED lower + upper bound estimates back into $ per events.'

#to convert logs back to normal units, raise E to that value b/c y = ln(x) --> E^y = x
round(exp(8.572169)) #5282.575 = 5283
round(exp(9.120605)) #9141.731 = 9142
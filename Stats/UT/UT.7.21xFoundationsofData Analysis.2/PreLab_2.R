library(SDSFoundations)
bull  <- BullRiders

'**********Primary Research Question*********
The average American adult man weighs 190 pounds.  Do professional bull riders from the US weigh the same?
'
summary(bull)

'We will use a one-sample t-test to help us answer this lab question b/c we want to compare the average weight of 
these bull riders to a claimed value. h0 = mu - 190 (The average weight of a bull-rider in this sample is 190 pounds)
?????190
unanswered

The formula to calculate a t-statistic is t = (x-??)/SE, where SE tells us the difference we wouldd  expect, based on 
chance alone

1. Create a data frame for  US bull riders + calculate sample mean + SD deviation for the weight of the bull-riders.'
table(bull$Country)
bulls.usa <- bull[bull$Country == 'USA',]
dim(bulls.usa)

mu <- 190
mean(bulls.usa$Weight) #153.1081
sd(bulls.usa$Weight) #13.02302
se <- sd(bulls.usa$Weight)/nrow(bulls.usa) #0.3519736
t <- (153.1081-mu)/se

'2. Create a histogram to visualize the distribution of bull-rider weights.'
library(ggplot2)
ggplot(bulls.usa) + geom_histogram(aes(x = Weight), bins = 8, color = 'white') + 
  ggtitle('Histogram of US Bull Rider Weights') + xlab('Weight (lbs)')

'3. Confirm the assumptions of the one-sample t-test via t.test(x(i) values, mu)'
t.test(bulls.usa$Weight, mu=190)
'	One Sample t-test

data:  bulls.usa$Weight
t = -17.231, df = 36, p-value < 2.2e-16
alternative hypothesis: true mean is not equal to 190
95 percent confidence interval: 148.7660 157.4502
sample estimates:
mean of x: 153.1081'

'4. Run the t-test and interpret the results.'
't-value is very large, well w/in z-crit, p-value = v. small no matter the alpha = statistically sig

So, w/ this small p, if bull-riders really do weigh 190 pounds on average, observing this sample mean is 
very unlikely

We reject the null and say it appears bull riders weigh less than the average man

The distribution of weight for this sample of US professional bull riders is approx. normal w/ mean = 153.11 lbs + 
SD = 13.02 lbs. We found that their mean weight was significantly different than 190 lbs, with t= -17.2, p < 0.05. 
We are 95% confident that the true mean of professional bull riders is between 148.8 lbs and 157.5 lbs, suggesting 
that professional bull riders weigh less the average adult male'
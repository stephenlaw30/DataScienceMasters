'Lab 2: Bull Rider Data

Over 1,200 bull riders from around the world are members of Professional Bull Riders (PBR) + compete in the more than 
300 PBR affiliated bull riding events per year. This data set includes info about the top 50 ranked bull riders for 
the 2013, according to the PBR standings reported in July of 2013. Rankings are based on a system which awards points 
for qualified rides at events throughout the season.  

In this lab, you will use a 1-sample t-test to answer a question of interest.

1a. What is the goal of a hypothesis test?'
# - To determine if the sample data is consistent, or inconsistent, with the null hypothesis about the population.

'1b. For your test result to be considered trustworthy, your data must meet the assumptions for a 1-sample t-test. 
What are assumptions of this test?'
# - The sample is made up of independent observations.
# - The population distribution should be nearly Normal, or the sample should be large.
# - A random sample is used.

library(SDSFoundations)
bull <- BullRiders

'2. One of the following questions will be answered in this lab using a one-sample t-test. Select the question that can
be answered with this method.
# - Is the average ride percentage of professional bull riders at least 50%?

***********************Primary Research Question**************************

Do professional bull riders stay on their bulls 50% of the time? Test the hypothesis that the mean ride percentage is 
0.500 in 2014, using riders with at least 5 events in 2014.

break this question down into the different descriptive stats you will need to construct your answer. 

1. Select the riders that participated in at least 5 events in 2014.'
atLeast5 <- bull[bull$Events14 >= 5,]

'2. Calculate the sample mean and standard deviation of ride percentage in 2014.'
x <- mean(atLeast5$RidePer14) #0.3346643
sd <- sd(atLeast5$RidePer14) #0.1065763

'3. Generate a histogram to look at the distribution of the ride percentage in 2014.'
library(ggplot2)
ggplot(atLeast5) + geom_histogram(aes(RidePer14), bins = 15)

'4. Confirm the assumptions of a one-sample t-test.'
# - looks normal 

'5. Run the t-test and interpret the results.'
t.test(atLeast5$RidePer14, mu=0.5)
'	One Sample t-test

data:  atLeast5$RidePer14
t = -10.054, df = 41, p-value = 1.253e-12
alternative hypothesis: true mean is not equal to 0.5
95% CI:    0.3014528 0.3678758
mean of x: 0.3346643 '

'reject the null hypothesis = Professional bull riders do not stay on their bulls 50% of the time.


Answer the question and support your answer with statistics:
The distribution of the % of time a professional bull rider stays on the bull for this sample is approximately normal
w/ mean = 33.5% + SD = 10.7%. We found their mean ride % was indeed significantly different from 50%, w/ t = -10.05 +
p < 0.05. We are 95% confident the true mean of ride % of professional bull riders is between 30.1% + 36.8%, suggesting
that professional bull riders ride the full 8 seconds about 1/3 of the time.
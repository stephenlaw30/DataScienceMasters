'We will draw samples to answer the following question: What % of the time are college students happy? 

The CLT predicts as sample size increases, our sample means should become less variable + be closer to the true mean.
To increase the sample size in a simulation means to draw more individuals in each of our samples, and as we increase 
our sample size, our sampling distributions means should remain about the same, but the Std Errs should decrease.'

library(SDSFoundations)
survey <- StudentSurvey

'******Primary Research Question******
What % of the time are college students happy?  How does sn estimate of the true mean change as sample size increases?

Break this question down into the different descriptive statistics needed to construct an answer.  

Determine the population parameters:
  1. Visualize the shape of the population data by making a histogram.  '
library(ggplot2)
ggplot() + aes(survey$happy)+ geom_histogram(binwidth=10, colour="black", fill="white")
#left-skewed/negatively skewed

  '2. Calculate the "true" mean and standard deviation of the population.'
fivenum(survey$happy)
mean(survey$happy)
sd(survey$happy)

'The shape of the population happiness scores is negatively skewed and college students happy 78% of the time on 
average w/ a SD of the happiness percent scores = 16.3, so it is more common for students to have high happiness % 
scores relative to the range of percent scores in the population

Compare the sample statistics:  
  3. Draw 1,000 samples of size n=5 from the population data.  Calculate the mean of each sample. '
samples <- rep(NA,1000)
for (i in 1:length(samples)) {
  #get sample
  x <- sample(survey$happy,5)
  #find mean of sample and store
  samples[i] <- mean(x)
}

  '4. Graph these 1,000 sample means in a histogram and examine the shape.'
ggplot() + aes(samples)+ geom_histogram(binwidth=5, colour="black", fill="white")

  '5. Calculate the mean and standard deviation of the sampling distribution.'
fivenum(samples)
mean(samples)
sd(samples)
# Compare to the std dev predicted by the CTL (StdErr)
16.3/sqrt(5)

  '6. Repeat this process for samples of size n=15 and n=25.'
samples15 <- rep(NA,1000)
for (i in 1:length(samples15)) {
x <- sample(survey$happy,15)
samples15[i] <- mean(x)
}
fivenum(samples15)
mean(samples15)
sd(samples15)
# Compare to the std dev predicted by the CTL.(StdErr)
16.3/sqrt(15)

samples25 <- rep(NA,1000)
for (i in 1:length(samples25)) {
x <- sample(survey$happy,25)
samples25[i] <- mean(x)
}
fivenum(samples25)
mean(samples25)
sd(samples25)
# Compare to the std dev predicted by the CTL.(StdErr)
16.3/sqrt(25)

ggplot() + aes(samples25)+ geom_histogram(binwidth=2, colour="black", fill="white")

'For the sampling distributions:
  
The mean was about the same for all 3 sampling distributionsw while SE decreased and the distribution became more 
normal as n increased

According to the CLT, we expect the mean for each sampling distribution to be the same as the population mean, 79.03, 
and the SE for the sampling distribution was 7.29 for n=5, 4.21 for n=15, and 3.26 for n=25

Based on these simulations, the relationship between the shape of the population and the shape of the sampling 
distribution of means is if the sample size is large enough, the sampling distribution will be Normal no matter the 
shape of the population.

In this lab, we knew the average % of the time college students are happy for our population of college students was
79.03% and the SD was 16.31%, and the happiness scores were negatively/left-skewed.

We drew samples of different sizes from our population to simulate the CLT, which says 3 things:
  1. As sample size increases, sampling distributions become more Normal.
  2. The mean of the sampling distribution will be the population mean.
  3. The variability of the sample means, or the std error, can be predicted by dividing the population SD by the 
    square root of the sample size.

Our simulation results were consistent with this theory. As we increased the size of our sample from 5 to 25, the 
sample means become less variable + tended to cluster more tightly around the true mean. In other words, our sample 
means became better estimators of the true population mean. In addition, the shape of the distribution became more
normal as sample size increased.
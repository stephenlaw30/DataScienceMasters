'Our population data consists of data collected from statistics students at The University of Texas at Austin, telling
us several things about themselves, including how happy they are + amount of time they study.  

We will run a few simulations on this data to see if we can replicate what the CLT tells us about sampling'

library(SDSFoundations)

'****Primary Research Question*****  How many letters long is the typical students name?  How does our estimate 
  change as we increase the sample size?'


survey <- StudentSurvey
#How many students are in this dataset?
nrow(survey)

#How many of the first 10 students in the dataset had names longer than 5 letters?
table(head(survey$name_letters > 5,10))

#How long is the name of the first student in the dataset who is happy less than 40% of the time?
head(survey$happy < 40,25)
survey[11,]

'What makes something a samplING distribution, not a SAMPLE distribution? - It is a distribution of sample statistics, 
  such as a distribution of sample means.

What does the Central Limit Theorem predict about a sampling distribution of means?
  - The distribution looks more and more Normal as you draw larger samples.
  - The sample means become less variable as your sample size increases.
  - You will find the population mean at the center of the sampling distribution.'



'Break this analysis into its required steps:
  - Determine the population parameters:
    1. Visualize the shape of the population data by making a histogram.'  
hist(survey$name_letters)
    '2. Calculate the "true" mean and standard deviation of the population.'
fivenum(survey$name_letters)
mean(survey$name_letters)
sd(survey$name_letters)

'  - Compare the sample statistics: 
    3. Draw 1,000 samples of size n=5 from the population data.  Calculate the mean of each sample.'
samples <- rep(NA,1000)
for (i in 1:length(samples)) {
  #get sample
  x <- sample(survey$name_letters,5)
  #find mean of sample and store
  samples[i] <- mean(x)
}
  
'    4. Graph these 1,000 sample means in a histogram and examine the shape.'
hist(samples)
library(ggplot2)
ggplot() + aes(samples)+ geom_histogram(binwidth=1, colour="black", fill="white")
'
    5. Calculate the mean and standard deviation of the sampling distribution.'
fivenum(samples)
mean(samples)
sd(samples)
# Compare to the std dev predicted by the CTL (StdErr)
sd(survey$name_letters)/sqrt(5)
'
    6. Repeat this process for samples of size n=15 and n=25.'
samples15 <- rep(NA,1000)
for (i in 1:length(samples15)) {
  x <- sample(survey$name_letters,15)
  samples15[i] <- mean(x)
}
fivenum(samples15)
mean(samples15)
sd(samples15)
# Compare to the std dev predicted by the CTL.(StdErr)
sd(survey$name_letters)/sqrt(15)

samples25 <- rep(NA,1000)
for (i in 1:length(samples25)) {
  x <- sample(survey$name_letters,25)
  samples25[i] <- mean(x)
}
fivenum(samples25)
mean(samples25)
sd(samples25)
# Compare to the std dev predicted by the CTL.(StdErr)
sd(survey$name_letters)/sqrt(25)
'
    7. Compare the results you get to the predictions of the Central Limit Theorem.'


'Population Parameters

What is the average name length, in number of letters, for all of the students in the population, + by how many 
letters, on average, do names vary from the mean?'
mean(survey$name_letters)
sd(survey$name_letters)

'Each time we sampled from our population we kept # of samples the same at 1k, but increased sample size from 5 to 25.
The mean was about the for all 3 sampling distributions, the size of the SE decreased as the sample size increased 
from 5 to 25, and the distributions became more and more normal as the sample size increased.

According to the Central Limit Theorem, the mean of the sampling distribution (for n=5, 15, or 25) is the same as the
population mean, 5.97, and our results of the simulations consistent with what the CLT predicted

In this lab, we knew the average name length for our population of college students was 5.97, the SD was 1.49, and
the distribution was normal.

We drew samples of different sizes from our population to simulate the Central Limit Theorem. In short, the CLT says 
3 things:
  1. As sample size increases, sampling distributions become more normal
  2. The mean of the sampling distribution will be the about the same as the population mean
  3. The variability of the sample means can be predicted by dividing the population SD by the sample size (Std Err)

Our simulation results were consistent with this theory. As we increased the size of our sample from 5 to 25, the 
sample means become less variable and tended to cluster more tightly around the true mean

In other words, our sample means became better estimators of the true population mean. 
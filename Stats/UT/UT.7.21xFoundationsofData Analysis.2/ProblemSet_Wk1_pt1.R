'Question 1
On a scale of 1 to 10, how much do UT Austin students like Austin?
  1. What are the true mean and SD for our population of UT Austin students?
  2. What should the sampling distribution of the mean look like, as predicted by the CLT?
  3. How do our simulated values compare to these predicted values?'

library(SDSFoundations)
survey <- StudentSurvey

'1a. Create a histogram of "austin" for the entire population of students that took the survey. Which best describes
the shape of the distribution?'
library(ggplot2)
ggplot(survey) + geom_histogram(aes(x = austin), bins = 5, color = 'white')
'Left (Negative) Skewed

1b. What is the population mean for the "austin" variable? (Round to 2 decimal places.)'
mu <- mean(survey$austin) #8.390501

'1c. What is the population standard deviation for the "austin" variable? (Report to 2 decimal places.)'
sd.p <- sd(survey$austin) #1.510725

'1d. Use the Central Limit Theorem to predict the mean + standard deviation of the sampling distribution of means 
for samples of size n=10 drawn from this population'
n <- 10
'
  - What is the expected mean? --> 8.390501 = same as populatino
  - What is the expected standard deviation? --> expected SD of sample mean = Standard Error = SD / Sqrt(n)'

se <- sd.p/sqrt(n) #0.4777332

'1e. Simulate drawing 1k random samples of sample size n=10 from the "austin" distribution + create a histogram of the 
sampling distribution + calculate the mean + SD.'
smpl <- rep(sample(survey$austin,10),1000)

library(ggplot2)
ggplot() + geom_histogram(aes(x = smpl), bins = 5, color = 'white')

xBar <- mean(smpl) #8.4
se1 <- sd(smpl) #1.496738

'How do these simulated values compare to the those predicted by the Central Limit Theorem?
  - The values are close to one another.
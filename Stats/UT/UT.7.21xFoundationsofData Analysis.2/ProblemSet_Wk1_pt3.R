'Question 3
A very large company has its headquarters in a 15-story downtown office building. The morning commute time for 
employees of this company is normally distributed w/ mean = 28 minutes + SD =  11 minutes. The company in the 
building next door samples 23 employees + finds a mean commute time = 35.1 minutes. Is there evidence that their 
commute time is longer than the other company, or is this just random sampling error?

Use the CLT to determine if this sample mean is likely to be observed, assuming commute time is the same for both 
companies.

3a. What is the expected mean in minutes of the sampling distribution for samples of size n=23?'
# - same as population b/c normal distribution so CLT applies = 28

'3b. What is the expected SD of the sampling distribution for samples of n=23?'
mu <- 28
sig = 11
x1 = 35.1
n = 23
se1 <- sig/sqrt(n) #2.293659

'3c. What is the z-score for the neighboring company sample mean?'
z_nc <- (x1 - mu)/se1 #3.095491 = 3.10

'3d. What is the probability of observing a sample mean this high (or higher), if the employees really do commute the 
amount of time?'
z.crit <- 0.9990
1 - z.crit
# - Less than 0.001

'3e. What should we conclude about the sample mean of 35.1 minutes?'
# - It is a sample mean that is not likely to be observed.

'3f. What should we conclude about the commute time of the employees in the building next door?'
# - THEIR average commute time is probably NOT the same as the large company next door (our original population).

'3g. What must we assume about the 23 people that were sampled for our conclusion to be valid?'
# - They must be a representative sample of employees at the company.
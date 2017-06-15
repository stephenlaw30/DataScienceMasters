'Question 2
    A population of sunflower plants is described as having a monthly growth rate that follows a normal distribution 
      w/ ?? = 3.08 in and ?? = 0.40 in.

2a. What is the probability that a randomly chosen sunflower plant grows more than 3.2 inches in a month?'
mu <- 3.08
sig <- 0.40
x <- 3.2
z <- (x - mu)/sig
z_crit <- 0.6179
prob1 <- 1 - 0.6179 #0.3821

'2b. A middle-school science class grew 25 of these sunflowers. How many inches would they expect these flowers to 
have grown, on average, 1 month later?'
# - 3.08, same as population due to CLT w/ normal distribution in population

'2c. The middle school science teacher replicates her study w/ 25 new sunflowers every year. How much variability in 
inches should she expect in the average monthly growth of these samples?'
n = 25
se1 <- sig/sqrt(n) #0.08

'2d. The science teacher notices that the average monthly growth of her 25 sunflowers has never exceeded 3.2 inches. 
What should she conclude?'
# -   We wouldn't expect to see an average monthly growth of 3.2 inches for a sample of 25 plants. Her data is 
#       probably fine. We expect it to be 3.08, w/ only a 38% chance of being 3.2 or greater

'2e. What is the probability her next sample of 25 sunflowers will grow an average of more than 2.9, but less than 3.2 
inches, in a month? '
mu <- 3.08
sig <- 0.40
x1 <- 2.9
x2 <- 3.2
z1 <- (x1 - mu)/se1
z2 <- (x2 - mu)/se1

z_crit1 <- 0.0122 #99% of data are above this point
z_crit2 <- 0.9332 #7% of data are above this point

prob2 <- z_crit2 - z_crit1 #0.921 
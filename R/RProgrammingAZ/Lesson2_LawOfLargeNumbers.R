#Lesson 2 - HW - Law of Large Numbers

setwd("C:/Users/snewns/Dropbox/NewLearn/UDEMY/R/RProgrammingAZ")

#Avg(Xn) -> E(X) when n -> Infinity
# - so this means that 

#Example Scenario: Observing a sample and measuring a value
# -  n coin tosses where n = 100 tosses + are measuring whether each toss is H or T
# -  X = the measured value --> 1 if H, 0 if T
# -  We then take the average of X over n (over the whole sample --> 43 H's over 100 tosses)
# - E(X) = EXPECTED VALUE OF X/THEORETICAL VALUE OF X
#     - theoretically, when tossing a coin, we have 50/50 chance of H or T
#     - out of 100 coin tosses, expect 50 H and 50 T
# - So this law says that the average of our sample size will approach the expected measured value as n, 
#     AKA our sample size, grows larger and larger
# -  "Average of Actually-Measured Value converges to Expected-Measurement Value as n approaches Inf."

#Normal Distribution --> 68.2% of data w/in 1 SD, 95.4% w/in 2 SD, 99.6% w/in 3

#Prove the law of large #'s exists via R script for N random, normally-distributed #'s w/ mean = 0 + SD = 1
# - Count how many #'s fall between -1 and 1 SD and divide by N
# - We know E(x) = 68.2%
# - Check Mean(Xn) -> E(Xn) as we rerun script while increasing N

#create set of 1000 normally distributed variables
numbers <- rnorm(1000)
summary(numbers)
head(numbers)
stdd
#numbers[1] <= mean(numbers)-sd(numbers)

i <- 0
betweenNegPosOne <- 0;
for(i in numbers){
  #if within 1 SD of the mean = 0 for normal distribution
 if (i <= 1 && i >= -1) {
    betweenNegPosOne <- betweenNegPosOne + 1
 }
}
totalCount <- betweenNegPosOne/length(numbers)
totalCount #= 0.678 which is close to our expected .682

numbers <- rnorm(10000)
summary(numbers)
head(numbers)
stdd
#numbers[1] <= mean(numbers)-sd(numbers)

i <- 0
betweenNegPosOne <- 0;
for(i in numbers){
  #if within 1 SD of the mean = 0 for normal distribution
  if (i <= 1 && i >= -1) {
    betweenNegPosOne <- betweenNegPosOne + 1
  }
}
totalCount <- betweenNegPosOne/length(numbers)
totalCount #= 0.6856 which is close to our expected .682


numbers <- rnorm(100000)
summary(numbers)
head(numbers)
stdd
#numbers[1] <= mean(numbers)-sd(numbers)

i <- 0
betweenNegPosOne <- 0;
for(i in numbers){
  #if within 1 SD of the mean = 0 for normal distribution
  if (i <= 1 && i >= -1) {
    betweenNegPosOne <- betweenNegPosOne + 1
  }
}
totalCount <- betweenNegPosOne/length(numbers)
totalCount #= 0.68309 which is close to our expected .682

numbers <- rnorm(1000000)
summary(numbers)
head(numbers)
stdd
#numbers[1] <= mean(numbers)-sd(numbers)

i <- 0
betweenNegPosOne <- 0;
for(i in numbers){
  #if within 1 SD of the mean = 0 for normal distribution
  if (i <= 1 && i >= -1) {
    betweenNegPosOne <- betweenNegPosOne + 1
  }
}
totalCount <- betweenNegPosOne/length(numbers)
totalCount #= 0.682754 which is close to our expected .682


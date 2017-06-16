'Question 3 - An industrial plant dumps its waste into a nearby river, but claims that it is not impacting the native 
species of frogs that live in the river. The frogs are able to tolerate calcium concentrations up to 91 mg/L.  
You measure the concentration of calcium in 25 random samples from the river.  
Your measurements are approximately normally distributed, w/ mean 93.6 mg/L + SD = 7.8 mg/L.  

3a. What is the appropriate alternative hypothesis if the industrial plant runoff is believed to be producing higher 
calcium concentrations than are deemed acceptable for the frogs? '

# - u > 91

'3b. Calculate the test statistic. (Round to 2 decimal places.)'
mu <- 91
mu.x <- 93.6
s <- 7.8
n <- 25
dF <- n-1
se <- s/sqrt(n)
t <- round((mu.x - mu)/se,2) #1.67

'3c. What is the t-critical value? Assume an alpha level of .05'
t.crit <- 1.711

'3d. Does data provide sufficient evidence to suggest the calcium concentration in the river is more than 91 mg/L?'
t > t.crit #false

# - No

'3e. Suppose as part of a broader investigation into the plant impact on the river ecosystem, an environmental group 
conducted a large-scale study + found the actual mean calcium concentration level downstream from the plant is 95 mg/L.
Did you make an error in your hypothesis test, and if so, what type was it?'
mu <- 91
mu.x <- 95
s <- 7.8
n <- 25
dF <- n-1
se <- s/sqrt(n)
t <- round((mu.x - mu)/se,2) #12.56
t.crit <- 1.711
t > t.crit #True

#Yes, a Type II Error --> said there was no effect = could not reject null --> this was false = FN
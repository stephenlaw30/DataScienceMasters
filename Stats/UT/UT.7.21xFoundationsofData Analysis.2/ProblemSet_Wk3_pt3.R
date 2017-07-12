'******Question 3 - Some nerve cells have the ability to regenerate. Researchers think these cells may generate 
creatine phosphate (CP) to stimulate new cell growth.

To test this hypothesis, researchers cut the nerves emanating from the left side of the spinal cord in a sample of
rhesus  monkeys, while the nerves on the right side were kept intact. They then compared the CP levels (mg/100g) in 
nerve cells on both sides. 

Monkey ID     CP on Left Side (regenerating)	CP on Right Side (control)
1	                    16.3	                    11.5
2		                  4.8		                    3.5
3		                  10.7		                  12.8
4		                  14.0		                  7.9
5		                  15.7		                  15.2
6		                  9.9		                    9.8
7		                  29.3		                  24.0
8		                  20.4		                  14.9
9		                  15.7		                  12.6
10		                7.6		                    8.2
11	                  16.2		                  8.4
12	                  14.7		                  11.0
13		                15.0		                  12.5
14		                8.4		                    9.2
15		                23.3		                  17.5
16		                17.7		                  11.1


3a. Which is the appropriate method for testing the researchers hypothesis?'

# Dependent t-test


'Assume the researchers calculated the difference scores as **d = CPleft - CPright** w/ alpha = 0.05. 

3b. How many degrees of freedom are there + what is the t-critical value?'

# 15 and 1.753 (1-direction = one group of cells expected to be better than other)

'3d. How much of a difference in CP was observed, on average, between the left + right nerve cells?'

cp.l <- c(16.3,4.8,10.7,14,15.7,9.9,29.3,20.4,15.7,7.6,16.2,14.7,15,8.4,23.3,17.7)
cp.r <- c(11.5,3.5,12.8,7.9,15.2,9.8,24,14.9,12.6,8.2,8.4,11,12.5,9.2,17.5,11.1)

cp.d <- cp.l-cp.r

mu.d <- mean(cp.d)
mean(cp.l)-mean(cp.r)

# 3.1

'3e. What is the Standard Deviation of the difference scores?'

sd.d <- round(sd(cp.d),2)

'3f. What is the Standard Error for your t-test?'

se.d <- round(sd.d/sqrt(length(cp.d)),2)

'3g. What is your test statistic?'

t.d <- round(mu.d/se.d,2)

t.test(cp.d)

'	One Sample t-test

data:  cp.d
t = 4.062, df = 15, p-value = 0.001022
alternative hypothesis: true mean is not equal to 0
95% CI (1.473358, 4.726642)
sample estimates:
mean of x = 3.1  '

'3h. Is there sufficient evidence to suggest the levels of CP are higher in regenerating cells than in 
the normal (control) cells?'

t.d > 1.753 # Yes

'3i. The researchers finish their analysis by calculating a 95% CI for the true increase in CP levels 
in rejuvenating nerve cells. What are the lower and upper bounds? (Round each to 1 decimal place.)'

marginOfErr <- round(1.753*se.d,2)

low <- round(t.d - marginOfErr,1)
high <- round(t.d + marginOfErr,1)
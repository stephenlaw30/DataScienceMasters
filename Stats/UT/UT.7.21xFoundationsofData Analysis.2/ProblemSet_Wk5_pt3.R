'******Course Week 5: Hypothesis Testing (More Than Two Group Means)****

Question 3

A local police department has divided the city into 3 sections, and each is 
patrolled by a different set of 6 officers. The police chief wants to determine
if officers are biased in the number of disorderly conduct tickets they give out
in each section.
H
ere are the number of tickets given by the officers in each section in the last week:
Section 1 	Section 2 	Section 3
8 	        3         	1
4 	        7 	      	2
6 	        0 	      	7
8 	        2 	      	6
6 	        7 	      	5
4 	        5 	      	0'

sec1 <- c(8,4,6,8,6,4)
sec2 <- c(3,7,0,2,7,5)
sec3 <- c(1,2,7,6,5,0)

'3a. Which of the following is the alternative hypothesis for this test?'

# HA: Police officers in at least 1 section of the city give out a different number
#   of ???tickets on average.

'2c. What are the degrees of freedom for this test?'

# Numerator Degree of Freedom = groups - 1 = k - 1 = 3 - 1 = 2
# Denominator Degree of Freedom = sample - groups = N - k = 18 - 3 = 15

'3c. What is SSTotal for this problem? (Round to 1 decimal place.)'

grand.mu <- mean(c(sec1,sec2,sec3))

SS.t <- sum((sec1 - grand.mu)^2,(sec2 - grand.mu)^2,(sec3 - grand.mu)^2)

'3d. What is MSBetween for this problem? (Round to 1 decimal place.)'

sec1.mu <- mean(sec1)
sec2.mu <- mean(sec2)
sec3.mu <- mean(sec3)

SS.w <- sum((sec1 - sec1.mu)^2,(sec2 - sec2.mu)^2,(sec3 - sec3.mu)^2)

SS.b = SS.t - SS.w
 
MS.b <- SS.b / 2 # 10.5

'3e. What is MSWithin for this problem? (Round to 1 decimal place.)'

MS.w <- SS.w / 15 #6.5

'3f. What is the F statistic for this test? (Round to 3 decimal places.)'

f <- MS.b / MS.w # 1.615385 = 1.615

'3g. What is the appropriate conclusion for this test?'

f.crit <- 3.6823
f > f.crit

# There is NO evidence to suggest that police officers are giving out a different number 
#   of tickets in these three sections, on average.
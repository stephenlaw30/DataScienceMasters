'*************Course Week 4: Hypothesis Testing (Categorical Data) Problem Set Question 3***********

Approximately 13% of the world population is left-handed, but is this proportion the same across men and women?
To answer this, you decide to collect data from a random sample of adults from your neighborhood, with the 
following results:

ID 	Gender 	Dominant Hand
1 	M 	    L
2 	M 	    R
3 	F 	    R
4 	M 	    R
5 	F 	    R
6 	F 	    L
7 	F 	    L
8 	M 	    R
9 	F 	    R
10 	F 	    R
11 	M 	    L
12 	F 	    R
13 	M 	    R
14 	M 	    R
15 	F 	    R
16 	M 	    R
17 	M 	    R
18 	F 	    R
19 	F 	    L
20 	M 	    R
21 	F 	    R

3a. Which of these is the appropriate null hypothesis for this test?'

# Gender and hand-dominance are independent.

'3b. What would be the estimated degrees of freedom + critical value for this analysis, assuming ?? = 0.05?'

gender <- c('M','M','F','M','F','F','F','M','F','F','M','F','M','M','F','M','M','F','F','M','F')
hand <- c('L','R','R','R','R','L','L','R','R','R','L','R','R','R','R','R','R','R','L','R','R')

df <- (2 - 1)*(2 - 1)
crit <- 3.841

'3c. What are the expected counts for Males?'

table(gender,hand)
'      hand
gender L R
     F 3 8
     M 2 8
'

obs.female.left <- 3
obs.male.left <- 2
obs.female.right <- 8
obs.male.right <- 8

female.ttl <- 11
male.ttl <- 10

left.ttl <- 5
right.ttl <- 16

ttl <- left.ttl + right.ttl

exp.female.left <- round((female.ttl*left.ttl)/ttl,2)
exp.male.left <- round((male.ttl*left.ttl)/ttl,2)
exp.female.right <- round((female.ttl*right.ttl)/ttl,2)
exp.male.right <- round((male.ttl*right.ttl)/ttl,2)

'3e. Are all relevant conditions met to run this analysis?'

# No <- some expected counts are < 5
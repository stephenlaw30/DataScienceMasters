# find percentile for a score of 21 from a normal distribution w/ mean 21 and SD 5
pnorm(24,21,5)

# calculate z-score for same observation
(24-21)/5

# find cutoff value for lowest score one could get to be in top 10% of normal SAT distribution
# with mean = 1500 + SD = 300
# i.e. find the 90th percentile (90% of scores lower than this value)
qnorm(.90, 1500, 300)
# can score 1884.465 and score higher than 90% of test takers

# find cutoff value for highest score one could get to stay in bottom 10% of normal ACT distribution
# with mean = 21 + SD = 5
# i.e. find the 1-th percentile (10% of scores lower than this value)
qnorm(.1, 21, 5)
# 14.6

'Suppose weights of checked baggage of airline passengers follow a nearly normal distribution with mean 45 pounds 
and standard deviation 3.2 pounds. Most airlines charge a fee for baggage that weigh in excess of 50 pounds.
What percent of airlines passengers are expected to incur this fee? '
# find percentile of those weight ABOVE this value
1 - pnorm(50,45,3.2)

# z-score
(50 - 45)/3.2

'average daily high in June in LA = 77 degrees F, with SD of 5 degrees F. Suppose temperatures in June closely
follow a normal distribution. How cold are the coldest 20% of the days during June in LA?'
# find cutoff value for highest temp in the coldest 20% of days in June
# i.e find temp where 20% of temps are colder than it
qnorm(.2, 77, 5)

'******************************BINOMIAL DISTRIBUTIONS************************************'

### Choose Function

## how many scenarios leads to 2 successes (in any order) out of 9 trials?
choose(n = 9, k = 2)

## other way of computing
factorial(9) / (factorial(2)*factorial(9 - 2))

# gallup survey
n = 10
k = 8
p = .13
f = 1 - p

n_choose_k <- choose(n,k)

p_success <- n_choose_k*((p)^k)*((f)^(n-k))

choose(n,(n-1))

# calculate same thing with ?dbinom()
dbinom(8,10,.13)

# gallup obesity --> 5 out of 20 exactly are obese if 26.2% of people are obese
dbinom(5,20,.262)

# 100 random employees
dbinom(8,100,.13)

### find chances an average FB user (245 friends) has at least 70 friends who are considered power users
prob_success <-  .25
n <-  245

# estimate mean + SD
mean <- prob_success*n
sd <- sqrt(n*prob_success*(1-prob_success))

# calculate chance of having > 70 friends out of 245 for each value 70+, then sum up for
# overall prob of having 70+ power-user friends
sum(dbinom(70:n,n,prob_success))
# 11.27%
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


'
# test the null that a response probability is 1/2 (p = .5) using data in which x = 62 of n = 100 people made a correct response
# use stats package function binom.test()
# Note that the p in this has nothing to do with a p value + insteads corresponds to the probability of making a correct response, 
#   according to the null (the ?? value)

binom.test(x = 62, n = 100, p = .5 )

# p-value = 0.02098
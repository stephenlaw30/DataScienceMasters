probabilities <- c(clubs = .25, diamonds = .25, hearts = .25, spades = .25)

# calculate expected frequencies if null (probability of all suites are equal) were true
n = 200
expected.i <- n * probabilities

# expect 50 of each

observed.i <- c(35,51,64,50)

observed.i - expected.i

# don't want negatives, so square the deviations
(observed.i - expected.i)^2

((observed.i - expected.i)^2)/expected.i

#goodness of fit test statistic
chi.sq <- sum(((observed.i - expected.i)^2)/expected.i)

# calculate the 95th percentile of a chi-squared distribution w/ k - 1 = 3 dF 
qchisq(.95,3)

# want an exact p-value for observed X2 value
pchisq(8.44,3, lower.tail = F)

# another way to get p-value
1 - pchisq(8.44,3)

# do all this w/ 1 function from lsr package
library(lsr)
load('cards.Rdata')
summary(suit.choice)

goodnessOfFitTest(suit.choice)

# new null
nullProbs <- c(clubs = .2, diamonds = .3, hearts = .3, spades = .2)
goodnessOfFitTest(suit.choice, p = nullProbs)

'*******************************************************************************************************'
load('chapek9.Rdata')
summary(chapek9)

# need a more detailed description of the dat
# look at the choices broken down by species via??? cross-tabulation
# Since data are stored in a data frame, use xtabs()

# produce contingency table
xtabs(~ choice + species, chapek9)

# chi-squared association test
library(lsr)
associationTest(~ choice + species, chapek9)
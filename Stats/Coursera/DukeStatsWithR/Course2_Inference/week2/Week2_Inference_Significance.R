# calculate z-score for college kids in relationships where H0: mu = 3 and H1: mu > 3
n = 50
trueNull.mu <- 3
x.bar = 3.2
s <- 1.74
se <- s/sqrt(n)
z <- (x.bar - trueNull.mu)/se # test statistic of .81
1 - pnorm(x.bar,trueNull.mu,se)

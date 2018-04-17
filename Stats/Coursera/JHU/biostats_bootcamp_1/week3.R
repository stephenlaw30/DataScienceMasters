## Study of 513 organo-lead manufacturing workers reported an average TBV of 1150.315 cm3 w/ σ = 105.997.
## Assuming normality of the underlying measurements, calculate a CI for population variation in TBV

## Create CI for variance
x_bar <- 1150.315
s <- 105.997
sample_var <- s**2
n <- 513
alpha <- .05
qtiles <- qchisq(p = c(alpha/2,1-alpha/2), df = n-1)

## rev() = reverse elements
(pop_var_CI <- rev((n-1)*sample_var/qtiles))
# interval for sd
(pop_sd_ci <- sqrt(pop_var_CI))

## plot likelihood
sigmaVals <- seq(90,120,length=1000) #90-120 to contain interval above
# evaluate gamma likelihood
likeVals <- dgamma((n-1)*sample_var,
                   shape=(n-1)/2,
                   scale=2*sigmaVals**2) # evaluate likelihood over 1000 pts (sigmaVals)
# normalize the likelihood
likeVals <- likeVals/max(likeVals)

# plot marginal likelihood for sigma
plot(sigmaVals,likeVals,type="l")

## create reference lines
# taking coordinates + join corresponding points w/ line segments
lines(range(sigmaVals[likeVals>=1/8]), c(1/8,1/8))
lines(range(sigmaVals[likeVals>=1/16]), c(1/16,1/16))


#### Gosset's (Student's) t-distribution
## get sleep data analyzed in Gosset's Biometrika paper
##  shows increase in hours for 10 pts on 2 sopoforic drugs
## R treats as 2 groups rather than paired observations
data("sleep")
group1 <- sleep$extra[1:10]
group2 <- sleep$extra[11:20]
difference <- group2 - group1
(mu_n <- mean(difference))
(s <- sd(difference))
n <- 10
## create CI = mean + t-quantile @ .975 (for 95% confidence) * std. err
tquant_conf95 <- qt((1-(1-.95)/2), n-1)
stdErr <- s/sqrt(n)
# manual CI
mu_n + c(-1,1)*tquant_conf95*stdErr
# automatic CI
t.test(difference)$conf.int


## 1D likelihood for effect size = µ/σ 
tStat <- sqrt(n)*mu/s
effectSizeVals <- seq(0,3,length=1000)
# get t density w/ dt(quantiles,dF,# of observations)    ncp = non-centrality parameter (loop over all of them)
likelihoodVals <- dt(tStat, df = n-1, ncp = sqrt(n)*effectSizeVals)
# normalize the likelihood
likelihoodVals <- likelihoodVals/max(likelihoodVals)

plot(effectSizeVals,likelihoodVals,type="l")
lines(range(effectSizeVals[likelihoodVals>=1/8]),c(1/8,1/8))
lines(range(effectSizeVals[likelihoodVals>=1/16]),c(1/16,1/16))

### profile likelihood
muVals <- seq(0,3,length=1000)
likelihoodVals <- sapply(muVals, function(mu){
  (sum((difference-mu)**2) / sum((difference-mu_n)**2))**(-n/2)
})
plot(muVals,likelihoodVals,type="l")
lines(range(muVals[likelihoodVals>=1/8]),c(1/8,1/8))
lines(range(muVals[likelihoodVals>=1/16]),c(1/16,1/16))








data(islands)
hist(islands)
hist(log10(islands))

stem(log10(islands))

dotchart(log10(islands))

data(InsectSprays)
attach(InsectSprays)
plot(c(.5,6.5), range(count))
sprayTypes <- unique(spray)
for (i in 1:length(sprayTypes)) {
  y <- count[spray==sprayTypes[i]]
  n <- sum(spray==sprayTypes[i])
  points(jitter(rep(i,n),amount=.1),y)
  lines(i + c(.12,.28),rep(mean(y),2),lwd=3)
  # CI
  lines(rep(i + .2, 2),
        mean(y) + c(-1.96,1.96)*sd(y)/sqrt(n))
}
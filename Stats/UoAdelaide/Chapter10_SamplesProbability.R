# generate 10k rounded IQ scores
IQ <- round(rnorm(n = 100, mean = 100, sd = 15))
head(IQ)

mean(IQ)
library(ggplot2)
hist(IQ)


IQ2 <- round(rnorm(n = 10000, mean = 100, sd = 15))
head(IQ2)

mean(IQ2)
hist(IQ2)

IQ3 <- round(rnorm(n = 1000000, mean = 100, sd = 15))
head(IQ3)

mean(IQ3)
hist(IQ3)

# bigger sample = more normal (like population)

'********************Sampling Distribution*******************************************'
iq <- rnorm(5,100,15)
mean(iq)

'********************Population SD Estimate*******************************************'
sample_sd = rep(NA, 10000)
for(i in 1:10000){
  sample_sd[i] = sd(rnorm(2,100,15))
}
hist(sample_sd)

#******sd() and var() are calculating SAMPLE statistics (divide by N - 1)

'**********************CONFIDENCE INTERVALS****************************'
#find Q1 and Q3 of the normal distribution
qnorm(c(0.025,0.975))

# suppose sample size is 10,000
n <- 10000 

#calculate the 97.5th quantile of the t-dist
qt( p = .975, df = n - 1) 

#But when n is small, we get a much bigger number when we use the t distribution:
n = 10
qt( p = .975, df = n - 1) 

#core R doesn't have CI for the mean functions, but lsr does --> ciMean(vectorOfData, confidenceLvl)
library(lsr)
load('afl24.Rdata')

# calculate CI of the mean attendance --> 95% probability a CI would contain the sample mean
ciMean(afl$attendance)
'        2.5%    97.5%
[1,] 31597.32 32593.12'


#install.packages('sciplot')
library( sciplot ) # bargraph.CI() and lineplot.CI() functions
library( gplots ) # plotmeans() function

# plot means + CI's of attendance by year
bargraph.CI(x.factor = year, # grouping variable
               response = attendance, # outcome 
               data = afl, # data
               ci.fun= ciMean, # name of function to calculate CIs
               xlab = "Year", # x-axis label
               ylab = "Average Attendance" # y-axis label
)
 
# can use the same arguments when calling lineplot.CI()
lineplot.CI(x.factor = year, # grouping variable
                response = attendance, # outcome 
                data = afl, # data
                ci.fun= ciMean, # name of function to calculate CIs
                xlab = "Year", # x-axis label
                ylab = "Average Attendance" # y-axis label
  )

#do same line plot with plotmeans():
plotmeans(attendance ~ year, # outcome ~ group
               afl, # data frame with the variables 
               n.label = FALSE # don't show sample size on each bar
)
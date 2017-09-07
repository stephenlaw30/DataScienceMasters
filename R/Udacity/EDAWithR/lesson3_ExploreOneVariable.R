setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/R/Udacity/EDAWithR')
# check wd for files
list.files()

# load in FB tab data w/ read.csv but indicate the data is seperated by tab
facebook <- read.csv('pseudo_facebook.tsv', sep = '\t')
head(facebook)

library(tidyverse)
glimpse(facebook)
# all ints but gender which is a factor

dim(facebook)
# 99k users --> variables describe user demos + their behavior (what they are doing on FB + what they use)

# histograms of user birthdays in 2 ways
library(ggplot2)
ggplot(facebook) + geom_histogram(aes(x = dob_day))

qplot(facebook$dob_day)

# break out the days of the month in the graph
ggplot(facebook) + geom_histogram(aes(x = dob_day), binwidth = 1)
# Majority of people born in 1st of month
# would expect similar counts among all days, except the 31st (as not all months have 31 days)

# break out histogram by dob_month into 12 histograms, one for each month --> i.e. break out by month
# do this w/ facet_wrap which breaks out plot by levels of a categorical variable
ggplot(facebook) + geom_histogram(aes(x = dob_day), binwidth = 1) + 
  facet_wrap(~ dob_month)

# now break out  by dob_month into 12 months into 3 rows SPECIFIED
ggplot(facebook) + geom_histogram(aes(x = dob_day), binwidth = 1) + 
  facet_wrap(~ dob_month, 3)

# now break out by dob_month into 12 months into 3 cols
ggplot(facebook) + geom_histogram(aes(x = dob_day), binwidth = 1) + 
  facet_wrap(~ dob_month, ncol = 3)
# days of birth are similar among all months, except Jan, with an abnormal amount of births on Jan 1
# possibly due to default values from Facebook

# facet_grid is similar, but we split by facet_grid(variableOnVerticalAxis ~ variableOnHorizontalAxis)
# facet_grid = better for 2+ variabels, facet_wrap = better for 1 variable

# create histogram of friend counts
ggplot(facebook) + geom_histogram(aes(x = friend_count))
qplot(x = friend_count, data = facebook)

# see long-tailed data w/ some having users well over 1000
# want to adjust code + plot to focus on bulk of user friend counts
qplot(x = friend_count, data = facebook, xlim = c(0,1000))

ggplot(facebook) + 
  geom_histogram(aes(x = friend_count)) + 
  scale_x_continuous(limits = c(0, 1000))

# try new bin widths
ggplot(facebook) + 
  geom_histogram(aes(x = friend_count), binwidth = 25) + 
  scale_x_continuous(limits = c(0, 1000), breaks = seq(0,1000,50))
  

qplot(x = friend_count, data = facebook, xlim = c(0,1000), binwidth = 25) + 
  scale_x_continuous(limits = c(0,1000), breaks = seq(0,1000,50))

# split these by genderggplot(facebook) + 
ggplot(facebook) + 
  geom_histogram(aes(x = friend_count), binwidth = 25) + 
  scale_x_continuous(limits = c(0, 1000), breaks = seq(0,1000,50)) +
  facet_wrap(~ gender)

qplot(x = friend_count, data = facebook, xlim = c(0,1000), binwidth = 25) + 
  scale_x_continuous(limits = c(0,1000), breaks = seq(0,1000,50)) +
  facet_wrap(~ gender)

# see the NA's + remove them by subsetting the dataset to those records that are not NA
ggplot(subset(facebook, !is.na(gender))) + 
  geom_histogram(aes(x = friend_count), binwidth = 25) + 
  scale_x_continuous(limits = c(0, 1000), breaks = seq(0,1000,50)) +
  facet_wrap(~ gender)

qplot(x = friend_count, data = subset(facebook, !is.na(gender)), 
      binwidth = 25) + 
  scale_x_continuous(limits = c(0,1000), breaks = seq(0,1000,50)) +
  facet_wrap(~ gender)

# can't really tell which gender has more friends on average
# get a table to see if there are more males or females
table(facebook$gender)

# a bit more males

# apply a function (mean friends) to the facebook dataset that is split by factors of gender
by(facebook$friend_count, facebook$gender, mean)
# females have more friends on average

# see more summary stats
by(facebook$friend_count, facebook$gender, summary)

# should use median bc these distributions are skewed, but median is still higher for female (resistant to extremes)

# to better understand users a bit more --> examine tenure (how many days using FB)
ggplot(facebook) + 
  geom_histogram(aes(x = tenure), color = 'black', fill = I('#099DD9'), binwidth = 30)

#qplot(x = tenure, data = facebook, bindwidth = 30, color = I('black'), fill = I('#099DD9'))

# can see this in years rather than days
ggplot(facebook) + 
  geom_histogram(aes(x = tenure/365), binwidth = 0.25, color = 'black', fill = I('#099DD9'))
#qplot(x = tenure/365, data = facebook, bindwidth = 0.25, color = I('black'), fill = I('#099DD9'))


#seems likes most users on facebook have been on less than 2/5 years

# set x-axis to 1 year jumps
ggplot(facebook) + 
  geom_histogram(aes(x = tenure/365), binwidth = 0.25, color = 'black', fill = I('#099DD9')) + 
  scale_x_continuous(breaks = seq(1,7,1), limits = c(0,7)) + 
  xlab('Number of Years on Facebook') +
  ylab('Count')
#qplot(x = tenure, data = facebook, bindwidth = 30, color = I('black'), fill = I('#099DD9')) + 
# scale_x_continuous(breaks = seq(1,7,1), limits = c(0,7)) 


# create a histograms by age
ggplot(facebook) + 
  geom_histogram(aes(x = age), binwidth = 1, color = 'black', fill = I('#099DD9')) + 
  xlab('Age') +
  ylab('Count')
# looks like rollercoaster, most under age of 30
# can see unusual spikes in mid-late 20's, w/ no users < 13, and odd spikes above 100 (probably fake/mistakes)
# user must be at least 13 so that makes sense

# make same plot but from 0 to 113 by 5 years (max age in dataset)
ggplot(facebook) + 
  geom_histogram(aes(x = age), binwidth = 1, color = 'black', fill = I('#099DD9')) + 
  scale_x_continuous(breaks = seq(0,113,5)) + 
  xlab('Age') +
  ylab('Count')

'******************************************************************************************************'
                        'ENGAGEMENT VARIABLES + TRANSFORMING DATA'
'******************************************************************************************************'
# some people have ORDERS OF MAGNITUDE more likes, comments, shares, etc. than any other users
# this means the data is OVER-DISPERSED (very-long tailed)
# helps to transform these values to see SD's or orders of magnitude so that we can shorten the tail

# shorten friend count tail w/ nlog transform
ggplot(facebook) + 
  geom_histogram(aes(log(friend_count)), color = 'white')
# this is base 10 by default
# many users have 0 friends, so base 10 is not defined for 0 (-Inf), so we see an error for 1962 rows
# looks much more normal = better for common statistical technique that assume this distribution

# specify base 10 + add 1 to result to remove errors
ggplot(facebook) + 
  geom_histogram(aes(log10(friend_count+1)), color = 'orange')
# same plot shape, different x-axis
# comparing friend counts on orders of magnitude of 10 when doing log10 (10 pt scale)

summary(log10(facebook$friend_count+1))

# show 3 histograms of friend count = original, log10 transform, and sqrt transform

library(gridExtra) # multiple plots on 1 graph
p1 = ggplot(facebook) + 
  geom_histogram(aes(friend_count), color = 'white')
p2 = ggplot(facebook) + 
  geom_histogram(aes(log10(friend_count+1)), color = 'green')
p3 = ggplot(facebook) + 
  geom_histogram(aes(sqrt(friend_count)), color = 'red')
grid.arrange(p1,p2,p3)
# sqrt is better than no transform at all, but log10 is best bc most normal

# ALTERNATE SOLUTION
p1 = ggplot(facebook) + 
  geom_histogram(aes(friend_count), color = 'white')
# use previous plot + add scale the x-axis using log10
p2 = p1 + 
  scale_x_log10()
# use 1st plot + add scale the x-axis using sqrt
p3 = p1 + 
  scale_x_sqrt()
grid.arrange(p1,p2,p3)

# Notice a different x-scale on this 2nd method
logScale <- ggplot(facebook) + 
  geom_histogram(aes(log10(friend_count+1)), color = 'green')

countScale <- ggplot(facebook) + 
  geom_histogram(aes(friend_count), color = 'white') + 
  scale_x_log10()

grid.arrange(logScale, countScale)

# scale_x_log10 shows x-axis is actual friend counts, log10() wrapper shows it in log units
# just keep this in mind when making plots 
# might be easier to think in terms of actual counts w/ scale layer

'******************************************************************************************************'
                            'FREQUENCY POLYGON'
'******************************************************************************************************'
# this another plot that lets us compare distributions
# similar to histograms in but via a curve that connect counts in a histogram
# can see shapes + peaks in distributions in more detail

# remake the gender friend count comparison via a frequency polygram
ggplot(subset(facebook, !is.na(gender))) + 
  geom_freqpoly(aes(x = friend_count), binwidth = 25) + 
  scale_x_continuous(limits = c(0, 1000), breaks = seq(0,1000,50)) +
  facet_wrap(~ gender)

'qplot(x = friend_count, data = subset(facebook, !is.na(gender)), 
      binwidth = 25, geom = \'freqpoly\') + 
  scale_x_continuous(limits = c(0,1000), breaks = seq(0,1000,50)) +
  facet_wrap(~ gender)'

# make 1 plot but use color to show different genders
ggplot(subset(facebook, !is.na(gender))) + 
  geom_freqpoly(aes(x = friend_count, color = gender), binwidth = 25) + 
  scale_x_continuous(limits = c(0, 1000), breaks = seq(0,1000,50))

'qplot(x = friend_count, data = subset(facebook, !is.na(gender)), 
      binwidth = 25, geom = \'freqpoly\', color = gender) + 
  scale_x_continuous(limits = c(0,1000), breaks = seq(0,1000,50))'

# can now compare 2+ distributions at once on same graph
# but still doesn't answer question of who has more friends on average
# change y-axis to proportions instead of counts
ggplot(subset(facebook, !is.na(gender))) + 
  geom_freqpoly(aes(x = friend_count, y = ..count../sum(..count..), 
                    color = gender), binwidth = 10) + 
  scale_x_continuous(limits = c(0, 1000), breaks = seq(0,1000,50)) + 
  xlab('Friend Count') + 
  ylab('Proportion of Users with that friend count')

'qplot(x = friend_count, data = subset(facebook, !is.na(gender)), y = ..count../sum(..count..),  
      binwidth = 10, geom = \'freqpoly\', color = gender) + 
scale_x_continuous(limits = c(0,1000), breaks = seq(0,1000,50))'

# can now see a higher proportion of males have lower friend counts
# females most likely overtake males in the tail end of the graph
ggplot(subset(facebook, !is.na(gender))) + 
  geom_freqpoly(aes(x = friend_count, y = ..count../sum(..count..), 
                    color = gender), binwidth = 10) + 
  scale_x_continuous(limits = c(450, 1000), breaks = seq(450,1000,50)) + 
  xlab('Friend Count') + 
  ylab('Proportion of Users with that friend count')


'***********************which gender creates more traffic on the web?********************************'
ggplot(subset(facebook, !is.na(gender))) + 
  geom_freqpoly(aes(x = www_likes, 
                    color = gender))

# transform
'ggplot(subset(facebook, !is.na(gender))) + 
  geom_freqpoly(aes(x = log10(www_likes+1), 
                    color = gender))'

ggplot(subset(facebook, !is.na(gender))) + 
  geom_freqpoly(aes(x = www_likes, 
                    color = gender)) + 
  scale_x_log10()

#proportions
ggplot(subset(facebook, !is.na(gender))) + 
  geom_freqpoly(aes(x = www_likes, y = ..count../sum(..count..),
                    color = gender)) + 
  scale_x_log10()

# females have more on average, and more larger proportion of males direct less traffic
# let's try numerical statistics to dive into this more

c('male likes: ', sum(subset(facebook,gender == 'male')$www_likes), 
  'female likes: ', sum(subset(facebook,gender == 'female')$www_likes))
# so females have more overall likes, almost 2x

# ALTERNATE
# apply a function (sum) to the www traffic split by factors of gender
by(facebook$www_likes, facebook$gender, sum)

'******************************************************************************************************'
                                      'BOX PLOTS'
'******************************************************************************************************'
# also helpful for viewing distributions

# view friend count by gender --> categorical variable (grouping) = x, continous variable = y
ggplot(subset(facebook, !is.na(gender))) +
  geom_boxplot(aes(gender, friend_count))

# see so many outliers, show just the boxes (< 100 friends)
ggplot(subset(subset(facebook, !is.na(gender)), friend_count < 1000)) +
  geom_boxplot(aes(gender, friend_count))

# alternate
ggplot(subset(facebook, !is.na(gender))) +
  geom_boxplot(aes(gender, friend_count)) +
  ylim(0,1000)

# alternate 2
ggplot(subset(facebook, !is.na(gender))) +
  geom_boxplot(aes(gender, friend_count)) +
  scale_y_continuous(limits = c(0,1000))
# females seem to have a higher median, but still not accurate bc we're removing rows (see output msg)

# alternate 3 w/out removing rows
ggplot(subset(facebook, !is.na(gender))) +
  geom_boxplot(aes(gender, friend_count)) +
  coord_cartesian(ylim = c(0,1000))
# females seem to have a higher median of friends (higher on "average"), and tops of boxes seems higher
# different isn't very large in average # of friends

# check middle 50% (box)
ggplot(subset(facebook, !is.na(gender))) +
  geom_boxplot(aes(gender, friend_count)) +
  coord_cartesian(ylim = c(0,250))
# medians seem more similar now

# check quartiles (75% of females have friend counts < 244)
# or 25% of female users have > 244 friends
by(facebook$friend_count, facebook$gender, summary)
# males have smaller box = less variable

# on average, who initiated more friendships?
ggplot(subset(facebook, !is.na(gender))) +
  geom_boxplot(aes(gender, friendships_initiated))

ggplot(subset(facebook, !is.na(gender))) +
  geom_boxplot(aes(gender, friendships_initiated)) + 
  coord_cartesian(ylim = c(0,200))

by(facebook$friendships_initiated, facebook$gender, summary)
# females barely

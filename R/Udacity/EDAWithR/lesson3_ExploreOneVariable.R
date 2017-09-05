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
# see the NA's
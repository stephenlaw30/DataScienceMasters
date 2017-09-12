setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/R/Udacity/EDAWithR/lesson3')
library(ggplot2)
data(diamonds)

library(tidyverse)
glimpse(diamonds)
levels(diamonds$cut)

# histogram of price
ggplot(diamonds) + 
  geom_histogram(aes(price))
summary(diamonds$price)

sum(diamonds$price < 500)
sum(diamonds$price < 250)
sum(diamonds$price >= 15000)

# explore peak
ggplot(diamonds) + 
  geom_histogram(aes(price), color = 'black', binwidth = 50) + 
  coord_cartesian(xlim = c(300,2000)) + 
  xlab('Price') + 
  ylab('Count') +
  ggtitle('Limited Set of Diamond Price (<= $2,000)')
# see no diamonds cost $1500, and most are around $700

# histogram of price broken out by cut
ggplot(diamonds) + 
  geom_histogram(aes(price), binwidth = 1000) + 
  facet_wrap(~ cut)

by(diamonds$price,diamonds$cut,summary)
# odd that ideal diamond cut is tied for lowest price (with premium, the next highest cut)
# also odd that ideal diamond has lowest median, and premium has the most-expensive diamond

# looking at the medians and quartiles --> they are reasonably close = distributions should be smaller
# histograms don't show that
# Fair and good seem somewhat more uniform, excluding long tail to the right

# remove fixed-y axis
ggplot(diamonds) + 
  geom_histogram(aes(price), binwidth = 1000) + 
  facet_wrap(~ cut, scales = "free_y")
# now they look more similar

# histogram of price per carat
ggplot(diamonds) + 
  geom_histogram(aes(price/carat), binwidth = 1000, color = 'white') 
#right-skew

# transform x-axis
ggplot(diamonds) + 
  geom_histogram(aes(log10(price/carat)), binwidth = 0.1, color = 'white') 
# looks more normal

# break out by cut
ggplot(diamonds) + 
  geom_histogram(aes(log10(price/carat)), binwidth = 0.05, color = 'white') + 
  facet_grid(~cut)
# all look relatively normal, with very good looking a bit bimodal (premium a bit less so)

# boxplots
ggplot(diamonds) +
  geom_boxplot(aes(clarity, price)) +
  coord_cartesian(ylim = c(0,7500))
# clarity of S2 has highest median price, while IF and VVS1 have lowest, as well as least variability
# VS2 and VS1 have most variability (tallest boxes)

by(diamonds$price,diamonds$clarity,summary)
# all relatively similar max and min prices

ggplot(diamonds) +
  geom_boxplot(aes(cut, price)) + 
  coord_cartesian(ylim = c(0,7500))
# cut of Premium has highest median price, while Ideal, Fair has least variability
# Premium also has most variability

by(diamonds$price,diamonds$cut,summary)
# all relatively similar max and min prices

ggplot(diamonds) +
  geom_boxplot(aes(color, price)) + 
  coord_cartesian(ylim = c(0,7600))
# J "worst" color has highest median price, while "best" D is 2nd to lowest
# "worse" colors increase in median price, as well as variability

by(diamonds$price,diamonds$color,summary)

IQR(subset(diamonds, color == 'D')$price)
IQR(subset(diamonds, color == 'J')$price)

# price per carat across colors
ggplot(diamonds) +
  geom_boxplot(aes(color, price/carat)) +
  coord_cartesian(ylim = c(0,6000))
# relatively similar, while H is highest median, and E is lowest median
by(diamonds$price/diamonds$carat,diamonds$color,summary)

# weight of diamonds (carat) with frequency polygon
ggplot(diamonds) + 
  geom_freqpoly(aes(x = carat, binwidth = .01)) + 
  scale_x_continuous(limits = c(0,3), breaks = seq(0,5,.1))
table(diamonds$carat) > 2000
# counts of carat sizes of 0.1, 0.8, 2.9, 3.0, & 5.0 are under 2k, while 0.3 and 1.01 are > 2k

'****************************GAPMINDER****************************'
# download a data set of your choice + create 2-5 plots that make use of the techniques from Lesson 3.
# ====================================================================================
forest <- read.csv("forest_land.csv")

forest <- forest %>%
  rename("Country" = Forest.area..sq..km.) %>%
  select(c("Country","X1990","X2000","X2005","X2010")) 

forest[is.na(forest)] <- 0

glimpse(forest)
forest <- forest %>%
  arrange(desc(X2010))

top_10 <- forest[1:10,]

# top 10 largest sq km of forest
ggplot(top_10) +
  geom_boxplot(aes(Country, X2010)) +
  coord_cartesian(ylim = c(0,6000))
# relatively similar, while H is highest median, and E is lowest median
by(diamonds$price/diamonds$carat,diamonds$color,summary)

reddit <- read.csv('reddit.csv')

library(tidyverse)
library(ggplot2)

glimpse(reddit)

# all factors except ID and gender (a binary variable)

# see factor levels
str(reddit) 
ggplot(reddit) + geom_bar(aes(income.range))

# possible ORDERED FACTORS = age.range, income range

# set levels of ordered factor age.range
reddit$age.range <- factor(reddit$age.range, levels = c('Under 18', '18-24', '25-34', '35-44', '45-54', '55-64', '65 or Above'),
                           ordered = T)

ggplot(reddit) + geom_bar(aes(age.range))

# reorder income range level
table(reddit$income.range)
reddit$income.range <- factor(reddit$income.range, levels = c('Under $20,000', '$20,000 - $29,999', '$30,000 - $39,999', 
                                                              '$40,000 - $49,999', '$50,000 - $69,999', '$70,000 - $99,999',
                                                              '$100,000 - $149,999', '$150,000 or more'), ordered = T)

ggplot(reddit) + geom_bar(aes(income.range))
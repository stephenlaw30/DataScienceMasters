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

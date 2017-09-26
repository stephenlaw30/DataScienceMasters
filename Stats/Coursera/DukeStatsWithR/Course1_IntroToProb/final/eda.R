load("C:/brfss2013.RData")

who()

library(tidyverse)
glimpse(brfss2013)

head(brfss2013$sleptim1) # hours
head(brfss2013$smokday2)
head(brfss2013$avedrnk2)

library(ggplot2)
ggplot(brfss2013, aes(avedrnk2, sleptim1)) + 
  geom_point() + 
  geom_smooth() + 
  coord_cartesian(ylim = c(0,15))

brfss2013 %>%
  arrange(desc(sleptim1)) %>%
  select(sleptim1)

smpl <- ?sample_n(brfss2013, 1000)

ggplot(smpl, aes(exerhmm1, sleptim1)) + 
  geom_point() + 
  geom_smooth()
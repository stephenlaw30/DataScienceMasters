load("C:/brfss2013.RData")

who()

library(tidyverse)
glimpse(brfss2013)
names(brfss2013)


'*****************states highest proprpotion of smokers and those who stopped'
#smokday2: Frequency Of Days Now Smoking
#stopsmk2: Stopped Smoking In Past 12 Months
#lastsmk2: Interval Since Last Smoked

# get count observations from each states
brfss2013 %>%
  group_by(X_state) %>%
  count()

brfss2013 %>%
  group_by(X_state) %>%
  summarise(count = n())
# state = "0"?

summary(brfss2013$stopsmk2)

# get only those who answered frequency of smoking question
smokers <- brfss2013 %>%
  filter(!is.na(smokday2))

# get proportion of each level of smoking by state
smokers %>%
  group_by(X_state, smokday2) %>%
  summarise(count = n()) %>%
  mutate(prop = count / sum(count)) %>%
  filter(smokday2 == "Every day") %>%
  arrange(desc(prop))

# guam?
levels(smokers$X_state)

# function to be opposite of %IN%
`%not in%` <- function (x, table) is.na(match(x, table, nomatch=NA_integer_))

# keep only us official states
smokers_test <- smokers %>% 
  filter(X_state %not in% c("0", "80", "Guam", "Puerto Rico"))
table(smokers_test$X_state)

smokers_test %>%
  group_by(X_state, smokday2) %>%
  summarise(count = n()) %>%
  mutate(prop = count / sum(count)) %>%
  filter(smokday2 == "Every day") %>%
  arrange(desc(prop))
  
  
  
stop_smoke <- brfss2013 %>%
  filter(!is.na(stopsmk2))

'****************************************college students who drink
  

head(brfss2013$sleptim1) # hours
head(brfss2013$smokday2)
head(brfss2013$avedrnk2)


'
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
  geom_smooth()'
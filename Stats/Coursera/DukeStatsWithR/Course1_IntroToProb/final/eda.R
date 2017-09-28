load("C:/Users/NEWNSS/Dropbox/brfss2013.RData")
who()

library(plyr)
library(tidyverse)
library(ggplot2)
library(maps)
#library(mapproj)
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
smokers <- smokers %>% 
  filter(X_state %not in% c("0", "80", "Guam", "Puerto Rico"))
table(smokers$X_state)

top_every_day_smoker_states <- smokers %>%
  group_by(X_state, smokday2) %>%
  summarise(count = n()) %>%
  mutate(prop = count / sum(count)) %>%
  filter(smokday2 == "Every day") %>%
  arrange(desc(prop))

'***********HEAT MAP************************'
top_every_day_smoker_states$region <- tolower(top_every_day_smoker_states$X_state)
library(mapproj)

states <- map_data("state")
map.df <- merge(states,top_every_day_smoker_states, by="region", all.x=T)
map.df <- map.df[order(map.df$order),]
ggplot(map.df, aes(x=long,y=lat,group=group))+
  geom_polygon(aes(fill=prop))+
  geom_path()+ 
  scale_fill_gradientn(colours=rev(heat.colors(10)),na.value="grey90")+
  coord_map()

#top 15 states
top_every_day_smoker_states %>%
  head(15) %>%
  ggplot() + 
  geom_bar(aes(reorder(X_state, -prop), prop), stat = "identity") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
  xlab('State') + 
  ylab('Proportion') + 
  ggtitle('Proportion of Every Day Smokers Over All Smokers')


#get those top 15 states
top_every_day_states <- top_every_day_smoker_states %>%
  head(15) %>% 
  select(X_state) %>%
  as.data.frame %>%

top_every_day_states <- top_every_day_states[,1]
  
#'West Virginia' %in% top_every_day_states

smokers %>%
  group_by(X_state, smokday2) %>%
  summarise(count = n()) %>%
  mutate(prop = count / sum(count)) %>%
  arrange(desc(prop)) %>%
  #head(10) %>%
  filter(X_state %in% top_every_day_states) %>%
  ggplot() + 
    geom_bar(aes(X_state, prop, fill = smokday2), stat = "identity") + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1))'' + 
    xlab("State") + 
    ylab("Proportion") + 
    ggtitle("Proportion of Every Day Smokers Over All Smokers")



'****************************************college grads'

brfss2013 %>%
  filter(educa == "College 4 years or more (College graduate)") %>%
  count

# calculate chance of having income > mean income for college grads
# overall prob of having 70+ power-user friends
sum(?dbinom(70:n,n,prob_success))

college_grads_not_retired <- brfss2013 %>%
  filter(educa == "College 4 years or more (College graduate)",
         employ1 %in% c("Employed for wages","Self-employed"))
table(college_grads_not_retired$income2)

# rename factors to numerics
college_grads_not_retired$incomeRank <- mapvalues(college_grads_not_retired$income2, from = c("Less than $10,000","Less than $15,000",
                                                                                "Less than $20,000","Less than $25,000","Less than $35,000",
                                                                                "Less than $50,000","Less than $75,000","$75,000 or more"), 
                                            to = c(1, 2, 3, 4, 5, 6, 7, 8))
ggplot(college_grads_not_retired) + 
  geom_histogram(aes(as.numeric(incomeRank)), binwidth = 1)

# percent of people making more than 50k
college_grads_not_retired %>%
  group_by(income2) %>%
  summarize(prop = mean(as.numeric(incomeRank) > 6, na.rm = T))
#0.7699314 = 76%

'****************************************college grads'

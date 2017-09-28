load("C:/Users/NEWNSS/Dropbox/brfss2013.RData")
who()

#library(plyr)
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
  as.data.frame() #%>%

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
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
    xlab("State") + 
    ylab("Proportion") + 
    ggtitle("Proportion of Every Day Smokers Over All Smokers")


'****************************************college grads'

brfss2013 %>%
  filter(educa == "College 4 years or more (College graduate)") %>%
  count

college_grads_not_retired <- brfss2013 %>%
  filter(educa == "College 4 years or more (College graduate)",
         employ1 %in% c("Employed for wages","Self-employed"))
#table(college_grads_not_retired$income2)

# rename factors to numerics
college_grads_not_retired$incomeRank <- recode(college_grads_not_retired$income2, "Less than $10,000" = 1, "Less than $15,000" = 2,
                                                                                "Less than $20,000" = 3, "Less than $25,000" = 4,
                                                                                "Less than $35,000" = 5, "Less than $50,000" = 6,
                                                                                "Less than $75,000" = 7,"$75,000 or more" = 8)
ggplot(college_grads_not_retired) + 
  geom_histogram(aes(as.numeric(incomeRank)), binwidth = 1)

# percent of people making more than 50k
college_grads_not_retired %>%
  summarize(prop = mean(as.numeric(incomeRank) > 6, na.rm = T))
#0.7699314 = 77%

'****************************************p[hys mentakl health veggies and exercise'
table(brfss2013$physhlth)
table(brfss2013$menthlth)

healthy <- brfss2013 %>%
  filter(physhlth == 0 & menthlth == 0 & !(is.na(physhlth)) & !(is.na(menthlth)))

non_healthy_prelim <- brfss2013 %>%
  filter(physhlth %not in% c(0, 60) & menthlth %not in% c(0,247,5000) & !(is.na(physhlth)) & !(is.na(menthlth)))

summary(non_healthy_prelim$physhlth)
hist(non_healthy_prelim$physhlth)

summary(non_healthy_prelim$menthlth)
hist(non_healthy_prelim$menthlth)

non_healthy_prelim2 <- non_healthy_prelim %>%
  filter(physhlth > 15 & menthlth > 15)

summary(non_healthy_prelim2$physhlth)
hist(non_healthy_prelim2$physhlth)

summary(non_healthy_prelim2$menthlth)
hist(non_healthy_prelim2$menthlth)

prop.table(table(healthy$exerany2)) #many healthy exercises

prop.table(table(non_healthy_prelim2$exerany2)) # more did not exercise


healthy %>%
  filter(exerany2 == "Yes") %>%
  group_by(exract11) %>%
  summarize(count = n()) %>%
  mutate(prop = count / sum(count)) %>%
  arrange(desc(prop)) %>%
  #head(10) %>%
  #filter(X_state %in% top_every_day_states) %>%
  ggplot() + 
  geom_bar(aes(X_state, prop, fill = smokday2), stat = "identity") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))'' + 
  xlab("State") + 
  ylab("Proportion") + 
  ggtitle("Proportion of Every Day Smokers Over All Smokers")


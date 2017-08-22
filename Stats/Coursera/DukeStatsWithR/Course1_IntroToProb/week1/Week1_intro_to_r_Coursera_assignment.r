#COURSERA STATS W/ R SPECIALIZATION
# - COURSE 1 - Introduction to Probability and Data
#   - WEEK 1

# Describe when a study's results can be generalized to the population at large and when causation can be inferred.
# Explain why random sampling allows for generalizability of results.
# Explain why random assignment allows for making causal conclusions.
# Describe a situation where cluster sampling is more efficient than simple random or stratified sampling.
# Explain how blinding can help eliminate the placebo effect and other biases.

#install.packages("devtools")
#install.packages("dplyr")
#install.packages("ggplot2")
#install.packages("shiny")
#install.packages("knitr")

library(devtools)
#install_github("StatsWithR/statsr")
library(statsr)

library(dplyr)
library(ggplot2)
library(shiny)
library(knitr)

'The Arbuthnot baptism counts for boys and girls and has 82 observations on 3 variables and refers to Dr. John Arbuthnot, an 18th
century physician, writer, and mathematician interested in the ratio of newborn boys to newborn girls, so he gathered the baptism 
records for children born in London for every year from 1629 to 1710.'
data(arbuthnot)

## inspect
dim(arbuthnot) #82 records 3 vars
#str(arbuthnot)
glimpse(arbuthnot)

## Get col names
names(arbuthnot)

# #what years does this go from?
range(arbuthnot$year) #1629-1710

## inspect girls data
summary(arbuthnot$girls)
str(arbuthnot$girls)

## plot girls data
plot(arbuthnot$year,arbuthnot$girls)
ggplot(arbuthnot) + geom_point(aes(year,girls))
'The amount of girls born has increased overall w/ a drop from 1640 to 1660'

'*********************************************************************************************************************'

## present --> counts of the total number of male + female births in the United States from 1940 to 2013.
data(present)

## inspect
dim(present) #74 records 3 vars, same vars
#str(arbuthnot)
glimpse(present)

## Calculate the total number of births for each year w/ a new variable + plot as a line
## Do so w/ tidyverse
present <- present %>% 
  mutate(
    total = boys + girls
  ) %>% as.data.frame

#present$total = present$boys + present$girls --> OLD

glimpse(present)

## plot YOY totals with a line

ggplot(present) + geom_line(aes(year,total))
'Total births have gone up overall, with a decrease in the 60s to late 70s'

## Re-create graph w/ lines + points
ggplot(present, aes(year, total)) +
  geom_line() +
  geom_point()

## use mutate() from tidyverse to create new variable via "PIPING" arbuthnot into mutate() + create "total" by summing boys + girls 
arbuthnot <- arbuthnot %>% 
  mutate(
    total = boys + girls
    )

## Calculate proportion of boys born each year + plot it
present <- present %>%
  mutate(
    propBoys = boys / total
  )
#present$propBoys <- present$boys / present$total -> OLD

glimpse(present)

## Plot proportion of boys births YOY
ggplot(present, aes(year, propBoys)) + geom_point() + geom_line()
'The proportion of boys has gone down over time'

## Create new boolean variable more_boys which contains TRUE if that year had more boys than girls + FALSE if not
present <- present %>%
  mutate(
    more_boys = ifelse(boys > girls, TRUE, FALSE)
  )
#present$more_boys <- ifelse(present$boys > present$girls, TRUE, FALSE) #old

## Show frequency table of when there are more boys born in a year than girls 
table(present$more_boys)
'For every single year in our dataset (74 yrs), there are more boys born than girls'

## Create proportion of boys to girls
present <- present %>%
  mutate(
    prop_boy_girl = boys / girls
  )
#present$prop_boy_girl  <- present$boys / present$girls --> OLD

## Plot this proportion of boys to girls YOY
ggplot(present, aes(year, prop_boy_girl)) + geom_point() + geom_line()
'The Boy to Girl ratio has decreased over time with a random increase in the 60s-70s
It is also the same graph shapeas ggplot of propBoys over year but w/ different y-axis values'

## Get the row (year) for the max total births
present[which.max(present$total),]
'The year 2007 had most births'

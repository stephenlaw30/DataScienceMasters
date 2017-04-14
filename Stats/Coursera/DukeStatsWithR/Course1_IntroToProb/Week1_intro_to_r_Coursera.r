#COURSERA STATS W/ R SPECIALIZATION
# - COURSE 1 - Introduction to Probability and Data
#   - WEEK 1

#Describe when a study's results can be generalized to the population at large and when causation can be inferred.
#Explain why random sampling allows for generalizability of results.
#Explain why random assignment allows for making causal conclusions.
#Describe a situation where cluster sampling is more efficient than simple random or stratified sampling.
#Explain how blinding can help eliminate the placebo effect and other biases.

setwd("C:/Users/Nimz/Dropbox/NewLearn/Coursera/R/DukeStatsWithR/Course1_IntroToProb")
install.packages("devtools")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("shiny")
install_github("StatsWithR/statsr")
library(devtools)
library(dplyr)
library(ggplot2)
library(shiny)
library(statsr)
install.packages("knitr")
library(knitr)

#get data for Arbuthnot's data describing male and female christenings (births) for London from 1629-1710.
data(arbuthnot)
str(arbuthnot)
dim(arbuthnot) #82 records 3 vars
#get col names
names(arbuthnot)
#what years does this go from?
range(arbuthnot$year) #1629-1710
summary(arbuthnot$girls)
str(arbuthnot$girls)
plot(arbuthnot$year,arbuthnot$girls)
#amount of girls born has increased overall w/ a drop from 1640 to 1660

#now plot w/ ggplot(data,aes(x-axis,y-axis)) + geom_point() [seperate layer of points on top of graph]
# - aes = aesthetic
# - geom = geometric
ggplot(data = arbuthnot, aes(x = year, y = girls)) + geom_point()


#Get data for Counts of the total number of male + female births in the United States from 1940 to 2013.
data(present)
str(present)
head(present)
#Calculate the total number of births for each year w/ a new variable + plot as a line
present$total = present$boys + present$girls
ggplot(data = present, aes(x = year, y = total)) + geom_line()
#Total births have gone up overall, w/ a decrease in the 60's to late 70's
#Re-create graph w/ lines + points
ggplot(data = present, aes(x = year, y = total)) +
  geom_line() +
  geom_point()

#use mutate() to create a new variable via PIPING arbuthnot into mutate() + create "total" by summing
# boys + girls 
arbuthnot <- arbuthnot %>% mutate(total = boys + girls)

#calculate the proportion of boys born each year + plot it
present$propBoys <- present$boys / present$total
ggplot(data = present, aes(x = year, y = propBoys)) + geom_point() + geom_line()
#proportion of boys has gone down over time

#Create new variable more_boys which contains TRUE if that year had more boys than girls + FALSE if not
present$more_boys <- ifelse(present$boys > present$girls, TRUE, FALSE)
table(present$more_boys)
#every year (74 yrs) there are more boys than girls

present$prop_boy_girl  <- present$boys / present$girls
ggplot(data = present, aes(x = year, y = prop_boy_girl)) + geom_point() + geom_line()
#Boy to Girl ratio has decreased over time with a random increase in the 60's-70's
#Same graph as ggplot of propBoys over year but w/ different y-axis

#get the row/year (1st agr in dataset[x,y]) for the max total births
present[which.max(present$total),]
#2007 had most births

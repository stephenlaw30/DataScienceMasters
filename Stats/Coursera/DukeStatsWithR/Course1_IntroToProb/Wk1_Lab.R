#COURSERA STATS W/ R SPECIALIZATION
# - COURSE 1 - Introduction to Probability and Data
#   - WEEK 1 Lab

#install.packages("devtools")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("shiny")
install_github("StatsWithR/statsr")

library(devtools)
library(dplyr)
library(ggplot2)
library(shiny)
library(statsr)


## Dataset 1: Dr. Arbuthnot's Baptism Records

data(arbuthnot)

'The Arbuthnot baptism counts for boys and girls and has 82 observations on 3 variables and refers to Dr. John Arbuthnot, an 18th
century physician, writer, and mathematician interested in the ratio of newborn boys to newborn girls, so he gathered the baptism 
records for children born in London for every year from 1629 to 1710.'

head(arbuthnot)
dim(arbuthnot) #3 variables
names(arbuthnot)
range(arbuthnot$year) #from 1629-1710

### Some Exploration
arbuthnot$boys #extract just boy counts
arbuthnot$girls #extract just girl counts

ggplot(data = arbuthnot, aes(x = year, y = girls)) + geom_point()

'There is initially an increase in the number of girls baptised, which peaks around 1640. After 1640 there is a decrease in the number 
of girls baptised, but the number begins to increase again in 1660. Overall the trend is an increase in the number of girls baptised'

#total baptisms each yr
arbuthnot$boys + arbuthnot$girls

#new variable TOTAL by piping data set into the MUTATE() function to creat the new variables
arbuthnot <- arbuthnot %>%
           mutate(total = boys + girls)
#arbuthnot$total <- arbuthnot$boys + arbuthnot$girls

ggplot(data = arbuthnot, aes(x = year, y = total)) + geom_line()
ggplot(data = arbuthnot, aes(x = year, y = total)) + geom_line() + geom_point()

'generate a plot of the proportion of boys born over time'
ggplot(data = arbuthnot, aes(x = year, y = boys/total)) + geom_line() + geom_point()

#new variables
arbuthnot <- arbuthnot %>%
         mutate(more_boys = boys > girls)

## Dataset 2: Present birth records
'Now for a similar analysis, but for present day birth records in the US'

data(present)
dim(present) ##3 variables
range(present$year) #from 1940-2013

'Calculate total number of births for each year and store these values in a new variable called `total` in `present` '

present <- present %>%
            mutate(total = boys + girls)
str(present)

'Calculate proportion of  boys born each year and store these values in a new variable called `prop_boys`'

present <- present %>%
  mutate(prop.boys = boys/total)
str(present)      

ggplot(present, aes(x = year, y = prop.boys)) + geom_line() + geom_point()

'Proportion of boys born in the US has decreased over time. Create a new variable `more_boys` which contains `TRUE` if that year had 
more boys than girls, or `FALSE` if that year did not. Based on this '

present <- present %>%
  mutate(more_boys = boys > girls)
str(present)  
table(present$more_boys)
  
'Every year there are more boys born than girls. Calculate the boy-to-girl ratio each year in a new variable `prop_boy_girl` '

present <- present %>%
  mutate(boy.girl_ratio = boys/girls)
head(present)

ggplot(present, aes(x = year, y = boy.girl_ratio)) + geom_line() + geom_point()

'There is initially a decrease in the boy-to-girl ratio, and then an increase between 1960 and 1970, followed by a decrease.'
present$year[which.max(present$total)]

'We see the most total number of births in the U.S in 2007'
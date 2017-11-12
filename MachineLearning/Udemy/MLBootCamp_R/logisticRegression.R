library(caTools)
library(tidyverse)
library(gridExtra)

train <- read.csv("./data/train.csv")
test <- read.csv("./data/test.csv")

#install.packages("Amelia") #missing data
library(Amelia) # 'missings map'

missmap(train, main = 'Training Missing', col = c("yellow","black"), legend = F)
# yellow = missing
# most missing = yellow

#more males + more 3rd class

# age is lower (20-30) more children than elderly

# most people there alone (no SibSp or Parch) = mainly men + 3rd class = labor workers?

# many low fares make sense b/c many lower class passengers

## look at average age by class
ggplot(train, aes(Pclass, Age)) + 
  geom_boxplot(aes(group = Pclass, fill = factor(Pclass), alpha = .4)) + 
  scale_y_continuous(breaks = seq(0,80,2)) + 
  theme_bw()

# then imputate, then remake graph
# 1st class = older (more time to get wealth), 3rd class = young workers, 2nd class = parents?



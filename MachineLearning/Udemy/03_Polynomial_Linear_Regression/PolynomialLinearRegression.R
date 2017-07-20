'Now we are building non-linear regression models (relationship between output and
inputs is NOT linear)

Business Problem:
- Want to predict salaries based on position title and the level
- We are in HR and are about to give an offer to a potential new employee
- We must negotiate a salary for an interviewee who has 25 yrs experience asking for
a minimum of $160k/yr.
- You in HR + call the previous employer to check that info about their previous salary
- All the info you get from HR is the simple table of salaries for 10 positions + levels'

setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/MachineLearning/Udemy/03_Polynomial_Linear_Regression')

# import data
salary <- read.csv('Position_Salaries.csv')
summary(salary)

library(ggplot2)
ggplot(salary) + 
  geom_point(aes(Level, Salary), colour = 'red') + # plot points
  ggtitle('Salary by Position Level')

'   - After plotting, we see a non-linear relationship between salary and position level
- However we know the prospective employee was a regional manager, and it usually
takes ~4 years to get from regional manager to partner (next level up)
- So this employer was between levels 6 and 7, so we can say he was at level 6.5
- Therefore, we can use regression to see if he was bluffing about his previous salary'

head(salary)

# notice that position is direclty equivalent to position (basically already encoded)
# only need to use 1 of these cols

new_salaries <- salary[,c('Level','Salary')]
head(new_salaries,10)

# library for splitting data
library(caTools)
set.seed(123)

# don't need to split or feature scale b/c this is such a small dataset (10 obs)

simpleModel1 <- lm(Salary ~ ., training)
summary(simpleModel1)
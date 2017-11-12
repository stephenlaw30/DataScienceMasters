# Decision Tree Regression

'Business Problem:
  - Want to predict salaries based on position title and the level
  - We are in HR and are about to give an offer to a potential new employee
  - We must negotiate a salary for an interviewee who has 25 yrs experience asking for
    a minimum of $160k/yr.
  - You are in HR + call the previous employer to check that info about their previous salary
  - All the info you get from HR is the simple table of salaries for 10 positions + levels'

#install.packages('dyplr')
library(dplyr)

salaries <- read.csv('Position_Salaries.csv')
salaries <- salaries[,2:3]

#*************Fitting Decision Tree Regression to the dataset***********
library(rpart)

# set minimum # of splits to 1 or else we end up w/ a straight line prediction (no splits)
dt_model = rpart(Salary ~ Level, salaries, control = rpart.control(minsplit = 1))

# Predicting a new result with Decision Tree Regression
# predicted salary is expected to be ~$130k for someone between Regional Manager + Partner
predictions <- predict(dt_model, data.frame(Level = 6.5))

# Visualising Decision Tree Regression result
library(ggplot2)

ggplot() + 
  # plot actual points
  geom_point(aes(salaries$Level, salaries$Salary), colour = 'blue') + 
  # plot predicted values from the model for the range of salaries by 0.01
  geom_line(aes(salaries$Level, predict(dt_model, salaries)), 
            colour = 'red') + 
  xlab('Levels') +
  ylab('Salary')
ggtitle('Truth or Bluff (Decision Tree Regression)')

'THIS IS A TRAP! Model has improved over one w/ no split, but from the info *added*
  (information entropy), when we add info after the splits, we take the *average* value
  w/in each resulting leaf. Since we have a single data point (the average), all our 
  predicted y-values would be horizontal over intervals of our in independent variable.

Therefore, for each interval in the independent variable, the decision tree is 
  calculating the average dependent variable (salary), which means it should be a 
  constant (straight line) over that interval

This is only plotting the average salaries according to the levels in units of 1.
  The diagonal increase from 7 to 8 is because they are being joined b/c we have no
  predictions to plot in that interval of the independent variable

For previous (linear + logistic regression), we could use their equation b/c the models
  were continous, and the decision tree is not

To visualize a non-continous model, we need to visualize the results in higher 
  resolution'

#
x_grid <- seq(min(salaries$Level), max(salaries$Level), 0.01)
ggplot() +
  # plot actual points
  geom_point(aes(salaries$Level, salaries$Salary), colour = 'blue') +
  # plot predicted values from the model for the range of salaries by 0.01
  geom_line(aes(x_grid, predict(dt_model, data.frame(Level = x_grid))),
            colour = 'red') +
  xlab('Levels') +
  ylab('Salary') + 
  ggtitle('Truth or Bluff (Decision Tree Regression)')

'Based on information entropy and information gain, our DT splits the
  whole range of IVs into intervals (i.e from 1-6.5, 6.5-8.5, etc)

The DT then considers the average y value for those x value in each 
  of the intervals

So between 6.5 and 8.5, we predict $250k for our new employee'

## Plotting the tree
#install.packages('rattle')
#install.packages("rpart.plot")
library(rattle)
fancyRpartPlot(dt_model)
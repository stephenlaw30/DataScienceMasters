# Decision Tree Regression

'Business Problem:
  - Want to predict salaries based on position title and the level
  - We are in HR and are about to give an offer to a potential new employee
  - We must negotiate a salary for an interviewee who has 25 yrs experience asking for
    a minimum of $160k/yr.
  - You are in HR + call the previous employer to check that info about their previous salary
  - All the info you get from HR is the simple table of salaries for 10 positions + levels'

install.packages('dyplr')
library(dplyr)

salaries <- read.csv('Position_Salaries.csv')
salaries <- salaries[,2:3]

#*************Fitting Decision Tree Regression to the dataset***********
library(rpart)

# set minimum # of splits to 1 or else we end up w/ a straight line prediction
dt_model = rpart(Salary ~ Level, salaries, control = rpart.control(minsplit = 1))

# Predicting a new result with Decision Tree Regression
# predicted salary is expected to be ~$130k for someone between Regional Manager + Partner
predictions <- predict(dt_model, data.frame(Level = 6.5))

# Visualising Decision Tree Regression result
library(ggplot2)

x_grid <- seq(min(salaries$Level), max(salaries$Level), 0.01)
dt_plot <- ggplot() + 
              # plot actual points
              geom_point(aes(salaries$Level, salaries$Salary), colour = 'blue') + 
              # plot predicted values from the model for the range of salaries by 0.01
              geom_line(aes(x_grid, predict(dt_model, data.frame(Level = x_grid))), 
                        colour = 'red') + 
              xlab('Levels') +
              ylab('Salary')
              ggtitle('Truth or Bluff (Decision Tree Regression)')

# Plotting the tree
install.packages('rattle')
library(rattle)
fancyRpartPlot(dt_model)
plot(dt_model)
text(dt_model)
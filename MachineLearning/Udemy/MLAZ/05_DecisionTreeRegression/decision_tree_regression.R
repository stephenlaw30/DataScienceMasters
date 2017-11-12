# Decision Tree Regression
install.packages('dyplr')
library(dplyr)

salaries <- read.csv('Position_Salaries.csv')
salaries <- salaries[,2:3]

#*************Fitting Decision Tree Regression to the dataset***********
library(rpart)

# set minimum # of splits to 1
dt_model = rpart(Salary ~ ., salaries, control = rpart.control(minsplit = 1))

# Predicting a new result with Decision Tree Regression
y_pred = predict(regressor, data.frame(Level = 6.5))

# Visualising the Decision Tree Regression results (higher resolution)
# install.packages('ggplot2')
library(ggplot2)

squared_plot <- ggplot(new_salaries) + 
  geom_point(aes(Level, Salary), colour = 'blue') + # plot points
  geom_line(aes(Level, y.pred), colour = 'red') + # plot regression line
  xlab('Levels') +
  ggtitle('Truth or Bluff (Squared Polynomial Regression)')

x_grid = seq(min(dataset$Level), max(dataset$Level), 0.01)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Level = x_grid))),
            colour = 'blue') +
  ggtitle('Truth or Bluff (Decision Tree Regression)') +
  xlab('Level') +
  ylab('Salary')

# Plotting the tree
plot(regressor)
text(regressor)
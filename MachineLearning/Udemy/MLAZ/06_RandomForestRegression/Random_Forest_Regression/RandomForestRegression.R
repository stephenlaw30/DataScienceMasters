## Random Forest Regression

'Business Problem:
  - Want to predict salaries based on position title and the level
  - We are in HR and are about to give an offer to a potential new employee
  - We must negotiate a salary for an interviewee who has 25 yrs experience asking for
    a minimum of $160k/yr.
  - You are in HR + call the previous employer to check that info about their previous salary
  - All the info you get from HR is the simple table of salaries for 10 positions + levels'

## Importing the dataset
salaries <- read.csv('Position_Salaries.csv')
new_salaries <- salaries[2:3]

'Remember Decision Tree regression is a NON-CONTINOUS model, so Random Forests of Decision Trees will be
as well'

#install.packages('randomForest')
library(randomForest)
set.seed(1234)

## Breiman's random forest w/ specified independent + dependent variables
rf_model <- randomForest(Level ~ Salary, new_salaries, ntree = 500)

# predictions
predictions1 <- predict(rf_model, data.frame(Level = 6.5))

'******RESULTS IN ERROR*************'

# documentation says put x as a data frame and y as vector
set.seed(1234)
rf_model_10 <- randomForest(x = new_salaries[1], 
                          y = new_salaries$Salary, ntree = 10)

# visualize results with line graph
library(ggplot2)
x_grid <- seq(min(new_salaries$Level), max(new_salaries$Level), 0.01)
ggplot() +
  geom_point(aes(new_salaries$Level,new_salaries$Salary), color = 'blue') + 
  geom_line(aes(x_grid, predict(rf_model_10, data.frame(Level = x_grid))),
            color = 'red')

#predict
predict_10 <- predict(rf_model_10, data.frame(Level = 6.5))
'only predicted $130k, which is way below what the employee sais their salary was, +
this is bad since we think he is bluffing when he is not, as we will see below'

# increase resolution
set.seed(1234)
rf_model_100 <- randomForest(x = new_salaries[1], 
                               y = new_salaries$Salary, ntree = 100)
ggplot() +
  geom_point(aes(new_salaries$Level,new_salaries$Salary), color = 'blue') + 
  geom_line(aes(x_grid, predict(rf_model_100, data.frame(Level = x_grid))),
            color = 'red')
'Now we have a lot more steps in this RF than we had w/ just 1 or 10 DTs, so we have 
more splits of the levels and therefore more intervals where y is the average of y 
values over these interval x values

More steps is intuitive because we had 100 trees voting on which step of salary the
level 6.5 should be, and then the RF takes the average of those 100 predictions

Each of those predictions becomes a vote of expected salary for that position

We get more steps b/c the whole range of levels is split into more intervals b/c the RF
is calculating many different averages of its DTs predictions in each interval'

#predict
predict_100 <- predict(rf_model_100, data.frame(Level = 6.5))

'Predicted just over $163k, which is good to show the employee was NOT bluffing and
was honest'

# increase resolution
set.seed(1234)
rf_model_500 <- randomForest(x = new_salaries[1], 
                             y = new_salaries$Salary, ntree = 500)
ggplot() +
  geom_point(aes(new_salaries$Level,new_salaries$Salary), color = 'blue') + 
  geom_line(aes(x_grid, predict(rf_model_500, data.frame(Level = x_grid))),
            color = 'red')

'More trees != more steps b/c the more trees we add, the more the average of the 
different DT predictions is converging to the same ultimate average + therefore 
converge to some certain shape of stairs'

# predictions
predictions_500 <- predict(rf_model_500, data.frame(Level = 6.5))

'Our prediction has barely changed at all, so this the best RF we can get and therefore
the best prediction we can make'
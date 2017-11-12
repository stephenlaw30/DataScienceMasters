'Now we are building non-linear regression models (relationship between output and
inputs is NOT linear)

Business Problem:
- Want to predict salaries based on position title and the level
- We are in HR and are about to give an offer to a potential new employee
- We must negotiate a salary for an interviewee who has 25 yrs experience asking for
a minimum of $160k/yr.
- You in HR + call the previous employer to check that info about their previous salary
- All the info you get from HR is the simple table of salaries for 10 positions + levels'

#install.packages('e1071')
library(e1071)

salary <- read.csv('Position_Salaries.csv')
head(salary)

'Support Vector Regression (SVR) is another NON-linear regression model'

# use 'type' arg to specify if we are doing SVM (support vector machine) for classification
#   w/ 'C-classification' or SVR (for regression) w/ 'eps-regression'
# also by default we are using the GUASSIAN KERNEL for our SVR model

svr_regressor <- svm(Salary ~ Level, salary, type = 'eps-regression')
summary(svr_regressor)
'
Parameters:
SVM-Type:  eps-regression 
SVM-Kernel:  radial 
cost:  1 
gamma:  1 
epsilon:  0.1 


Number of Support Vectors:  6'

'*************PREDICT RESULTS***********
  - We know the prospective employee was a regional manager, and it usually
        takes ~4 years to get from regional manager to partner (next level up)
- So this employer was between levels 6 and 7, so we can say he was at level 6.5
- Therefore, we can use regression to see if he was bluffing about his previous salary'

# predict salary for a Level of 6.5
prediction_svr <- predict(svr_regressor,data.frame(Level = 6.5))
prediction_svr # 177861.1

plot_prediction_svr <- predict(svr_regressor, salary)

library(ggplot2)
ggplot(salary) + 
  geom_point(aes(Level, Salary), colour = 'blue') + # plot points
  geom_line(aes(Level, plot_prediction_svr), colour = 'red') + # plot regression line
  xlab('Levels') +
  ggtitle('Truth or Bluff (SVR)')

# See our prediction at 6.5 is exactly on the model
# From all points up to the CEO, we are close (since it is an outlier)
# We don't need CEO salary for our problem, so we can ignore this for now   

'We predict his salary should have been ~$177k and now he is asking for less, which 
is good for us, and accurate

Now we can go forward with our negotiations on a good note, as this employee was honest'
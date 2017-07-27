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

# notice that position is directly equivalent to position (basically already encoded)
# only need to use 1 of these cols

new_salaries <- salary[,c('Level','Salary')]
head(new_salaries,10)

# library for splitting data
library(caTools)
set.seed(123)

# don't need to split or feature scale b/c this is such a small dataset (10 obs)

lin_reg <- lm(Salary ~ ., new_salaries)
summary(lin_reg)
'
Coefficients:
            Estimate Std. Error t value Pr(>|t|)   
(Intercept)  -195333     124790  -1.565  0.15615   
Level          80879      20112   4.021  0.00383 **
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 182700 on 8 degrees of freedom
Multiple R-squared:  0.669,	Adjusted R-squared:  0.6277 
F-statistic: 16.17 on 1 and 8 DF,  p-value: 0.003833'

# Level is a "good" predictor of salary, but it could be better (only 2 *'s)

'*******Improve model by adding POLYNOMIAL FEATURES (level^(up to any exponent)********

These will be additional indepenent variables that will compose a new matrix of features
  in some way to create a matrix to which we will apply a multiple linear regression 
  model to make the whole model a polynomial regression model

So, in short, a polynomial regression model is a multiple regression model that is composed 
  of 1 independent variable + additional polynomial terms of that independent variable'

# add new level
new_salaries$level_sq <- new_salaries$Level^2
head(new_salaries)
poly_reg <- lm(Salary ~., new_salaries)
summary(poly_reg)
'
Coefficients:
            Estimate Std. Error t value Pr(>|t|)   
(Intercept)   232167     115571   2.009  0.08451 . 
Level        -132871      48268  -2.753  0.02839 * 
level_sq       19432       4276   4.544  0.00265 **
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 98260 on 7 degrees of freedom
Multiple R-squared:  0.9162,	Adjusted R-squared:  0.8923 
F-statistic: 38.27 on 2 and 7 DF,  p-value: 0.0001703'

# R2 and Adj R2 has improved

y.pred <- predict(poly_reg, new_salaries)

squared_plot <- ggplot(new_salaries) + 
  geom_point(aes(Level, Salary), colour = 'blue') + # plot points
  geom_line(aes(Level, y.pred), colour = 'red') + # plot regression line
  xlab('Levels') +
  ggtitle('Truth or Bluff (Squared Polynomial Regression)')



'*******CUBED MODEL********'

new_salaries$level_cub <- new_salaries$Level^3
poly_reg_3 <- lm(Salary ~., new_salaries)
summary(poly_reg_3)
'
Coefficients:
             Estimate Std. Error t value Pr(>|t|)   
(Intercept) -121333.3    97544.8  -1.244  0.25994   
Level        180664.3    73114.5   2.471  0.04839 * 
level_sq     -48549.0    15081.0  -3.219  0.01816 * 
level_cub      4120.0      904.3   4.556  0.00387 **
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 50260 on 6 degrees of freedom
Multiple R-squared:  0.9812,	Adjusted R-squared:  0.9718 
F-statistic: 104.4 on 3 and 6 DF,  p-value: 1.441e-05'

# R2 and Adj R2 has improved

y.pred_3 <- predict(poly_reg_3, new_salaries)

cubed_plot <- ggplot(new_salaries) + 
  geom_point(aes(Level, Salary), colour = 'blue') + # plot points
  geom_line(aes(Level, y.pred_3), colour = 'red') + # plot regression line
  xlab('Levels') +
  ggtitle('Truth or Bluff (Cubed Polynomial Regression')


# might be overfit

# compare to simple linear regression
y.pred_lr <- predict(lin_reg, new_salaries)

ggplot(new_salaries) + 
  geom_point(aes(Level, Salary), colour = 'blue') + # plot points
  geom_line(aes(Level, y.pred_lr), colour = 'red') + # plot regression line
  xlab('Levels') + 
  ggtitle('Truth or Bluff (Linear Regression)')

# see that level 10 salary prediction is WAY off the actual salary (almost 50% less)
# according to this model, if we're hiring a new CEO, they would be furious that we'd suggest a salary of $600k,
#    when in actuality, it was ~$1M and should be much higher
# In our real situation, a level 6.5 is asking for $160k, and we'd predicted his salary was over $250k, which is good for us

squared_plot

# Now we fit the data a bit better, and we'd offer a lower salary than the level 6.5 is asking for

cubed_plot

# Now we're about closer to the actual values w/ our predictions, and would still offer < $160k for level 6.5 salary
# As we add more and more degrees, we have higher order of contact between the real f(x) for salaries and our 
#    expansion/prediction g(x)

new_salaries$level_quart <- new_salaries$Level^4
poly_reg_4 <- lm(Salary ~., new_salaries)
summary(poly_reg_4)
'
Coefficients:
             Estimate Std. Error t value Pr(>|t|)   
(Intercept)  184166.7    67768.0   2.718  0.04189 * 
Level       -211002.3    76382.2  -2.762  0.03972 * 
level_sq      94765.4    26454.2   3.582  0.01584 * 
level_cub    -15463.3     3535.0  -4.374  0.00719 **
level_quart     890.2      159.8   5.570  0.00257 **
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 20510 on 5 degrees of freedom
Multiple R-squared:  0.9974,	Adjusted R-squared:  0.9953 
F-statistic: 478.1 on 4 and 5 DF,  p-value: 1.213e-06'

y.pred_4 <- predict(poly_reg_4, new_salaries)

quartered_plot <- ggplot(new_salaries) + 
  geom_point(aes(Level, Salary), colour = 'blue') + # plot points
  geom_line(aes(Level, y.pred_4), colour = 'red') + # plot regression line
  xlab('Levels') +
  ggtitle('Truth or Bluff (Quartered(?) Polynomial Regression')

quartered_plot

# This will be our final model

'************TEST PREDICTIONS WITH DIFFERENT MODELS**********************'

## predict a single new result with Simple Linear Regression

single_prediction_lin_reg <- data.frame(Level = 6.5)

final_y_predict_lr <- predict(lin_reg, single_prediction_lin_reg)
# 330378.8 --> predicts that his salary was over $330k and now he's asking for less, which is good for us, but not accurate


## predict a single new result with Polynomial Linear Regression

single_prediction_poly_reg <- data.frame(Level = 6.5, level_sq = 6.5^2, level_cub = 6.5^3, level_quart = 6.5^4)

final_y_predict_poly <- predict(poly_reg_4, single_prediction_poly_reg)
# 158862.5 --> predicts that his salary was ~$159k and now he's asking for a bit more, which is good for him + 
#   not bad for us
# Now we can go forward with our negotiations on a good note, as this employee was honest 
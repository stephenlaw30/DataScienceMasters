'Business Problem - Venture Capatalism

Our VC has data on 50 companies, including extracts from their P&L for the given financial
year. So we know how much they spent on R&D, on Admin costs (salaries), and on Marketing.
Then we also know their profits and which state they operate in.

We want to be able to predict profits based on the expenses of a company, as well
as the state the operate in via a multiple linear regression model.

Therefore, the VC will now which new companies they would want to invest in.

This will also depend on if the VC is more concerned with each of the spends,
and which would yield more profits.'

setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/MachineLearning/Udemy/02_Multiple_Linear_Regression')

# library for splitting data
library(caTools)

# inspect
startups <- read.csv('50_Startups.csv')
head(startups)
summary(startups)
dim(startups)

# encode categorical data (State)
startups$State <- factor(startups$State, 
                         levels = c('New York', 'California', 'Florida'),
                         labels = c(1,2,3))

head(startups)

# split data
set.seed(123)
spl <- sample.split(startups$Profit, SplitRatio = .8) # 40 in train, 10 in test
training <- subset(startups, spl == T)
test <- subset(startups, spl == F)

dim(training)
dim(test)

# create regressor (the model) and do backwards elimination
regressor.all <- lm(Profit ~ ., training)
summary(regressor.all)

'Residuals:
   Min     1Q Median     3Q    Max 
-33128  -4865      5   6098  18065 

Coefficients:
Estimate Std. Error t value Pr(>|t|)    
(Intercept)      4.965e+04  7.637e+03   6.501 1.94e-07 ***
R.D.Spend        7.986e-01  5.604e-02  14.251 6.70e-16 ***
Administration  -2.942e-02  5.828e-02  -0.505    0.617    
Marketing.Spend  3.268e-02  2.127e-02   1.537    0.134    
State2           1.213e+02  3.751e+03   0.032    0.974    
State3           2.376e+02  4.127e+03   0.058    0.954    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 9908 on 34 degrees of freedom
Multiple R-squared:  0.9499,	Adjusted R-squared:  0.9425 
F-statistic:   129 on 5 and 34 DF,  p-value: < 2.2e-163 
F-statistic: 494.8 on 1 and 18 DF,  p-value: 1.524e-14

See that only R&D spend is significant, but State2 has highest p-value, and 
Administration costs seem to decrease profit as it increases

********MODEL 2**************'

regressor.RD <- lm(Profit ~ R.D.Spend, training)
summary(regressor.RD)

'Residuals:
   Min     1Q Median     3Q    Max 
-34334  -4894   -340   6752  17147 

Coefficients:
Estimate Std. Error t value Pr(>|t|)    
(Intercept) 4.902e+04  2.748e+03   17.84   <2e-16 ***
R.D.Spend   8.563e-01  3.357e-02   25.51   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 9836 on 38 degrees of freedom
Multiple R-squared:  0.9448,	Adjusted R-squared:  0.9434 
F-statistic: 650.8 on 1 and 38 DF,  p-value: < 2.2e-16


********PREDICTIONS**************

Now we need to use the model to train it on the test data'
y.pred.train <- predict(regressor.RD, training)
y.pred.test <- predict(regressor.RD, test)

# compare test w/ actuals
y.pred.test
test$Profit[0:10]

'Now that we have some predictions of profits based on our linear model, we can check
our accuracy of these predictions, and therefore of our model

*******VISUALIZE TRAINING SET RESULTS**********'
library(ggplot2)
ggplot(training) + 
  geom_point(aes(R.D.Spend, Profit), colour = 'green') + # plot points
  geom_line(aes(R.D.Spend, y.pred.train), colour = 'red') + # plot regression line
  xlab('R&D Spend ($)') +
  ylab('Profits ($)')
  ggtitle('Profits by Amount of R&D Spend (Training Set)')

ggplot() + 
  geom_point(aes(test$R.D.Spend, test$Profit), colour = 'green') + # plot points
  geom_line(aes(training$R.D.Spend, y.pred.train), colour = 'red') + # plot same regression line
  xlab('R&D Spend ($)') +
  ylab('Profits ($)')
ggtitle('Profits by Amount of R&D Spend (Test Set)')

'We wanted to use the same regression line for both graphs, since our 
regression model was created using the training set.

Looking at the test set plot, most of our predictions look good

********BACKWARDS ELIMINATION**************'

regressor.all <- lm(Profit ~ ., training)
summary(regressor.all)
# State 2 and 3 have the highest p-values, so they have minimal impact on profits,
# Remove both by removing "State" from the model to remove dummy variables

regressor.noState <- lm(Profit ~ R.D.Spend + Administration + Marketing.Spend, training)
summary(regressor.noState)
# now Admin is highest p-value

regressor.noStateAdmin <- lm(Profit ~ R.D.Spend + Marketing.Spend, training)
summary(regressor.noStateAdmin)
# See that Marketing spend now is *barely significant*. Should we remove it?
# this is an arbitrary choice, depending on the significance level
# remove it for now

summary(regressor.RD)
# so we only have 1 variable + its significant, but Adj R2 has decreased (.9468 -> .9434)
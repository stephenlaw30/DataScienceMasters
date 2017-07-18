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


simpleModel1 <- lm(Salary ~ YearsExperience, training)
summary(simpleModel1)
'Residuals:
Min      1Q  Median      3Q     Max 
-7325.1 -3814.4   427.7  3559.7  8884.6 

Coefficients:
Estimate Std. Error t value Pr(>|t|)    
(Intercept)        25592       2646   9.672 1.49e-08 ***
YearsExperience     9365        421  22.245 1.52e-14 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 5391 on 18 degrees of freedom
Multiple R-squared:  0.9649,	Adjusted R-squared:  0.963 
F-statistic: 494.8 on 1 and 18 DF,  p-value: 1.524e-14

So YearsExperience is very statistically significant (much lower than alpha 0.05 (3 *s as well).
This means there is a greater effect/impact on the dependent variable by the independent variable.

This signifies a strong positive linear relationship between these 2 variables.
Can see the high Coefficient for YearsExperience (9000+), which means that for 1 unit change in 
YearsExperience (1 year), we would have a 9500 unit change in Salary ($9k increase per year)

We also have a very good R2 and Adjusted R2


********PREDICTIONS**************

Now we need to use the model to train it on the test data'
y.pred.train <- predict(simpleModel1, training)
y.pred.test <- predict(simpleModel1, test)

'Now that we have some predictions of salaries based on our linear model, we can check
our accuracy of these predictions, and therefore of our model

*******VISUALIZE TRAINING SET RESULTS**********'
library(ggplot2)
ggplot(training) + 
  geom_point(aes(YearsExperience, Salary), colour = 'green') + # plot points
  geom_line(aes(YearsExperience, y.pred.train), colour = 'red') + # plot regression line
  xlab('Years of Experience') + 
  ggtitle('Salary by Years of Experience (Training Set)')

ggplot() + 
  geom_point(aes(test$YearsExperience, test$Salary), colour = 'green') + # plot points
  geom_line(aes(training$YearsExperience, y.pred.train), colour = 'red') + # plot same regression line
  xlab('Years of Experience') + 
  ylab('Salary') + 
  ggtitle('Salary by Years of Experience (Testing Set)')

'We wanted to use the same regression line for both graphs, since our 
regression model was created using the training set.

Looking at the test set plot, most of our predictions look good, with 
maybe 2 "far" points, at around 6 years and 8 years.'
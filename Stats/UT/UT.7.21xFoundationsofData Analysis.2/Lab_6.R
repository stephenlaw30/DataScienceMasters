'**********Course Week 6: Correlation and Regression Pre-Lab Examine the Data**************

LAB 6: MEDICAL SCHOOL QUALITY OF LIFE

In a 2015 study, Tempski and associates examined a measurement they called Quality of 
Life among medical school students in Brazilian medical schools. They borrowed measurement
scales from the World Health Organization, the Dundee Ready Education Environment Scale, and 
the Beck Depression Inventory to assess the dependent variable in potential relation to a 
number of predictor variables.

In this lab, you will use Regression Analysis to answer a question of interest

1a. In a Multiple Linear Regression model, not only can we compare overall model fit, 
but for each predictor we can also find the ______.'

# slope and significance

'1b. Which measure, asked for after we run our Multiple Linear Regression model, tells us
the unique proportion of variance accounted for by each predictor?'

# the part (or semi-partial) correlation squared value

'********Lab Prep*********'

library(SDSFoundations)
res <- TempskiResilience

'2. 2 of the following questions will be answered in this lab using Linear Regression. Select 
the questions that can be answered with this method.'

# Of the 4 measures of Quality of Life (Physical Health, Psychological, Social 
#     Relationships, and Environment), which has the greatest impact on Med School Quality of Life?
# What is the overall proportion of varaince explained by the predictors in the model?

'*********Analyze the Data***********

********PRIMARY RESEARCH QUESTIONS**********

  1. For students in the Basic Sciences program, of the 4 measures of Quality of Life (Physical 
        Health, Psychological, Social Relationships, and Environment), which has the greatest 
        impact on Med School Quality of Life?
  2. What is the overall proportion of variance accounted for by all 4 scales?

Break this question down into the different descriptive statistics needed to construct an answer. 

1. Subset the data for students in the Basic Sciences Program.'

table(res$Group)
bas.sci <- res[res$Group == 'Basic Sciences',]

'2. Determine the variables of interest and the outcome variable.'

names(bas.sci)
# outcome = MS.QoL
# variables of interest = WHOQOL.PH, WHOQOL.PSY, WHOQOL.SOC, WHOQOL.ENV'

'3. Run a Multiple Linear Regression.'

whoModel <- lm(MS.QoL ~ WHOQOL.PH + WHOQOL.PSY + WHOQOL.SOC + WHOQOL.ENV, bas.sci)
summary(whoModel)
'Residuals:
    Min      1Q  Median      3Q     Max 
-4.7116 -0.7307  0.1265  0.8432  3.6141 

Coefficients:
Estimate Std. Error t value Pr(>|t|)    
(Intercept) 2.466823   0.307790   8.015 9.43e-15 ***
WHOQOL.PH   0.013953   0.005683   2.455   0.0145 *  
WHOQOL.PSY  0.026523   0.005957   4.452 1.07e-05 ***
WHOQOL.SOC  0.005132   0.003975   1.291   0.1974    
WHOQOL.ENV  0.020544   0.005231   3.927 9.94e-05 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 1.303 on 454 degrees of freedom
Multiple R-squared:  0.3097,	Adjusted R-squared:  0.3036 
F-statistic: 50.91 on 4 and 454 DF,  p-value: < 2.2e-16'

library(car)
vif(whoModel)
' WHOQOL.PH WHOQOL.PSY WHOQOL.SOC WHOQOL.ENV 
  2.126661   2.459209   1.522653   1.573503 '

#tolerance
1/vif(whoModel)
' WHOQOL.PH WHOQOL.PSY WHOQOL.SOC WHOQOL.ENV 
 0.4702207  0.4066349  0.6567485  0.6355245 '

#residual vs. fitted
plot(whoModel, which = 1)
# have linearity and homoscedasticity (mostly)

#cook's distance plot
cutoff <- 4/(whoModel$df)
plot(whoModel, which = 4, cook.levels = cutoff, id.n = 5)

'*********Put model into context***************'

# standardized beta for every coefficient in a model
lmBeta(whoModel) 
' WHOQOL.PH WHOQOL.PSY WHOQOL.SOC WHOQOL.ENV 
0.13961019 0.27225462 0.06212142 0.19208898 '

# unique proportion of variance accounted for by each variable
round(100*pCorr(whoModel),2) # 8.23
'           Partial_Corr Partial_Corr_sq Part_Corr Part_Corr_sq
WHOQOL.PH         11.45            1.31      9.57         0.92
WHOQOL.PSY        20.45            4.18     17.36         3.01
WHOQOL.SOC         6.05            0.37      5.03         0.25
WHOQOL.ENV        18.13            3.29     15.31         2.34

Provide the intitial bivariate Pearson Correlation Coefficients for the following 
variables and the outcome of Med School Quality of Life. Round to 4 decimal places:'

'Provide the t-statistic for the predictors in the Multiple Linear Regression for 
the following variables predicting Med School Quality of Life. Round to 3 decimal places:'

'What are the Overall Model statistics for the prediction of Med School Quality of life?
3a. Overall Model F-value (Round to 2 decimal places.)'

'3b. Overall Model R-squared (Round to 4 decimal places)'

'4a. Which of the following coefficeints in the model would be considered the best predictor 
of Med School Quality of Life?'

# Psychological QoL

'4b. What is the amount of unique proportion of variance accounted for in the prediction
of Med School Quality of Life by the best predictor (the correct answer above)?'

# 3.0%

'Our primary research question investigated the predictive impact of several Quality of Life 
items (Physical Health, Psychological, Social Relationships, and Environment) on the outcome of
Med School Quality of Life score for Basic Sciences enrolled students. The model showed a Significant
overall effect (F(4, 454) = 50.91, p < 0.05), the 4 predictor variables accounted for 30.97%
of the variance in the outcome of Med School Quality of Life. The best predictor of Med School 
Quality of Life was the Psychological QoL scale (t(454) = 4.452, p < 0.05). As Psychological QoL 
scale increases one unit, Med School Quality of Life increased by 0.0265 (Standardized beta = 0.2723)
units. Although significant, and the best predictor in the model, Psychological QoL could only 
uniquely account for 3.0% of the variance in the outcome.
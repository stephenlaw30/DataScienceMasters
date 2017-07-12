'**********Course Week 6: Correlation and Regression Pre-Lab Examine the Data**************

Pre-lab 6: Medical School Quality of Life

In a 2015 study, Tempski and associates examined a measurement they called "Quality of Life" among 
medical school students in Brazilian medical schools. They borrowed measurement scales from the
World Health Organization, the Dundee Ready Education Environment Scale, and the Beck Depression
Inventory to assess the dependent variable in potential relation to a number of predictor variables.

*****Primary research questions******

  1) Can you confirm the claim that Beck Depression Inventory score is a significant predictor 
      of Overall Quality of Life among students enrolled in the Clinical Sciences program?
  2) For students enrolled in the Clinical Sciences program, examine the effects of 
      DREEM: Social Self Perception, DREEM: Academic Self Perception, Resilience, BDI, 
      and Age on Med School Quality of Life'

library(SDSFoundations)
res <- TempskiResilience

'1a. How many observations are in the intial dataset?'

# 1350

'1b. The first listed student with a Med School Quality of Life score of 10 is how many years old?'

head(res[res$QoL==10,]) 

# 21

'1c. Of the first 10 participants, how many have a Med School Quality of Life over 5?'

sum(res$MS.QoL[0:10] > 5) # 7

'Check the Variables of Interest

2a. Which variable tells us the Med School quality of life?'

# MS.QoL, which is quantitative

'2b. Is there just one predictor variable in the model for the second research question?'

# No

'2c. How many variables will be used as predictors in the model for the second research question?'

# 5 --> DREEM.S.SP, DREEM.A.SP, Resilience, BDI, Age

'Reflect on the Method

Which method should we be using for this analysis and why?

3a. We will use Multiple Linear Regression to answer our Second Primary Research Question. Why?'

# We want to examine multiple predictors of a single quantitative outcome.

'3b. For both question models, we will need to examine diagnostic plots. Why?'

# We need to assess the assumptions of the model, and look for potential outliers.

'****************Prepare for the Analysis*************

Break this analysis into its required steps

1. Subset out just students in the Clinical Sciences program.'

names(res)
clin.sci <- res[res$Group == 'Clinical Sciences',]

'2. Run a basic correlation matrix for Research Question 1.'

cor(clin.sci$BDI,clin.sci$QoL) # -0.3746403

install.packages('psych')
library(psych)

vars <- c('BDI','QoL')
corr.test(clin.sci[,vars])

'Correlation matrix 
      BDI   QoL
BDI  1.00 -0.37
QoL -0.37  1.00

Sample Size 
[1] 491

Probability values (Entries above the diagonal are adjusted for multiple tests.) 
    BDI QoL
BDI   0   0
QoL   0   0'

corr.test(clin.sci[,vars])$r
'           BDI        QoL
BDI  1.0000000 -0.3746403
QoL -0.3746403  1.0000000'

corr.test(clin.sci[,vars])$p
'    BDI QoL
BDI   0   0
QoL   0   0'

'REMEMBER THE PEARSON CORRELATION COEFFICIENT VALUE IS TESTED AGAINST A T-DISTRIBUTION, SO IT HAS
AN UNDERLYING T-TEST ASSOCIATED WITH IT'

corr.test(clin.sci[,vars])$t
'          BDI       QoL
BDI       Inf -8.935305
QoL -8.935305       Inf

3. Run the model for Research Question 1 and examine.'

clin.sci.model <- lm(QoL~BDI, clin.sci)
summary(clin.sci.model)

'lm(formula = QoL ~ BDI, data = clin.sci)

Residuals:
    Min      1Q  Median      3Q     Max 
-4.6587 -0.6587  0.0687  0.7962  2.6138 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept)  8.544521   0.088521  96.526   <2e-16 ***
BDI         -0.068137   0.007626  -8.935   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 1.159 on 489 degrees of freedom
Multiple R-squared:  0.1404,	Adjusted R-squared:  0.1386 
F-statistic: 79.84 on 1 and 489 DF,  p-value: < 2.2e-16'

confint(clin.sci.model) # confident intervals

'                  2.5 %      97.5 %
(Intercept)  8.37059347  8.71844843
BDI         -0.08311937 -0.05315364'

'************#Diagnostics*********'

#residual vs. fitted
plot(clin.sci.model, which = 1)
# have linearity and homoscedasticity 
# observations w/ numeric labels are the row #'s of outliers --> 1055, 871, 1107

#cooks distance plot
cutoff <- 4/(clin.sci.model$df) # cutoff of influence for cook's distance is 4 / dF in the LM model
plot(clin.sci.model, which = 4, cook.levels = cutoff)
# see the rows of data points that are highly influential/high outliers --> 96, 742, 1055

# get top 5 influential points
plot(clin.sci.model, which = 4, cook.levels = cutoff, id.n = 5)

'4. Run a basic correlation matrix for Research Question 2.'

names(clin.sci)
vars <- c('MS.QoL','DREEM.S.SP','DREEM.A.SP','Resilience', 'BDI', 'Age')
corr.test(clin.sci[,vars])$r

'                MS.QoL  DREEM.S.SP  DREEM.A.SP Resilience         BDI         Age
MS.QoL      1.00000000  0.54744658  0.40488523  0.3175923 -0.40809301 -0.07208173
DREEM.S.SP  0.54744658  1.00000000  0.57218064  0.4257209 -0.52053588 -0.04819259
DREEM.A.SP  0.40488523  0.57218064  1.00000000  0.4819358 -0.32875516 -0.09025951
Resilience  0.31759228  0.42572085  0.48193583  1.0000000 -0.56656655  0.04014430
BDI        -0.40809301 -0.52053588 -0.32875516 -0.5665665  1.00000000 -0.02372227
Age        -0.07208173 -0.04819259 -0.09025951  0.0401443 -0.02372227  1.00000000

5. Run the model for Research Question 2 and examine.'

clin.sci.model2 <- lm(MS.QoL ~ DREEM.S.SP + DREEM.A.SP + Resilience + BDI + Age, clin.sci)
summary(clin.sci.model2)

'Call:
lm(formula = MS.QoL ~ DREEM.S.SP + DREEM.A.SP + Resilience + 
BDI + Age, data = clin.sci)

Residuals:
Min      1Q  Median      3Q     Max 
-4.5697 -0.7056  0.0725  0.8409  3.9567 

Coefficients:
Estimate Std. Error t value Pr(>|t|)    
(Intercept)  4.674e+00  7.650e-01   6.110 2.05e-09 ***
DREEM.S.SP   1.394e-01  1.801e-02   7.739 5.87e-14 ***
DREEM.A.SP   3.670e-02  1.428e-02   2.571 0.010439 *  
Resilience   4.345e-05  6.135e-03   0.007 0.994353    
BDI         -3.636e-02  1.067e-02  -3.409 0.000707 ***
Age         -2.904e-02  2.352e-02  -1.235 0.217592    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 1.229 on 485 degrees of freedom
Multiple R-squared:  0.3337,	Adjusted R-squared:  0.3269 
F-statistic: 48.59 on 5 and 485 DF,  p-value: < 2.2e-16'

confint(clin.sci.model2) # confident intervals

'                   2.5 %      97.5 %
(Intercept)  3.170622049  6.17671584
DREEM.S.SP   0.103999969  0.17477991
DREEM.A.SP   0.008652434  0.06475334
Resilience  -0.012011893  0.01209879
BDI         -0.057318060 -0.01540232
Age         -0.075260330  0.01717907

6. Follow up Research Question 2 with contextual analysis.'

'************#Diagnostics*********'

# Variance Inflation Factor to check for multicollinearity
install.packages('car')
library(car)
vif(clin.sci.model2)
'DREEM.S.SP DREEM.A.SP Resilience        BDI        Age 
  1.823375   1.698128   1.731791   1.737641   1.018183'

#tolerance
1/vif(clin.sci.model2)
'DREEM.S.SP DREEM.A.SP Resilience        BDI        Age 
 0.5484335  0.5888836  0.5774369  0.5754930  0.9821422 '

#residual vs. fitted
plot(clin.sci.model2, which = 1)
# have linearity and homoscedasticity 
# observations w/ numeric labels are the row #'s of outliers --> 599, 897, 803

#cook's distance plot
cutoff <- 4/(clin.sci.model2$df) # cutoff of influence for cook's distance is 4 / dF in the LM model
plot(clin.sci.model2, which = 4, cook.levels = cutoff, id.n = 5)
# see the top 5 rows of data points that are highly influential/high outliers --> 127, 599, 653, 733, 1196

'*********Put model into context***************'

# standardized beta for every coefficient in a model
lmBeta(clin.sci.model2) 
'  DREEM.S.SP    DREEM.A.SP    Resilience           BDI           Age 
 0.3873277406  0.1241752275  0.0003453895 -0.1665514046 -0.0461722487'

# unique proportion of variance accounted for by each variable
round(pCorr(clin.sci.model2), 4)
'           Partial_Corr Partial_Corr_sq Part_Corr Part_Corr_sq
DREEM.S.SP       0.3315          0.1099    0.2868       0.0823
DREEM.A.SP       0.1160          0.0134    0.0953       0.0091
Resilience       0.0003          0.0000    0.0003       0.0000
BDI             -0.1530          0.0234   -0.1263       0.0160
Age             -0.0560          0.0031   -0.0458       0.0021

1. What does the summary() function do?'

# provides the output from the linear model in the console

'2. What is the purpose of the following code option in cor()?

  use = "pairwise.complete.obs"'

# It allows for all complete data to be used in the correlations

'3. What kind of diagnostic plot is provided from the following code?

  plot(ov_mod, which=1)'

# A Residuals vs. Fitted plot

'4. What does the function lmBeta() do?'

# Provides the Standardized Betas for the model

'5. You want to run a correlation matrix, and then get the p-value for each 
bivariate correlation. You run the following code. What caused the error?

  vars <- c(MS.QoL, DREEM.S.SP, DREEM.A.SP, Resilience, BDI, Age)
  cor.test(clin[,vars], use="pairwise.complete.obs")

  Warning messages:
    Error in cor.test.default(clin[, vars], use = "pairwise.complete.obs") : ,
    argument "y" is missing, with no default'

# The function is called corr.test rather than cor.test

'1a) What is the inital correlation coefficient between overall Quality of Life 
and Beck Depression Inventory? (Round to three decimal places.)'

vars <- c('BDI','QoL')
round(cor(clin.sci[,vars]),3) # -0.375

'1b) What is the t-value of the Simple Regression slope for Beck Depression 
Inventory? (Round to three decimal places.)'

round(corr.test(clin.sci[,vars])$t,3)
'          BDI       QoL
BDI       Inf         -8.935
QoL       -8.935      Inf

******Research Question 2************:

2a) What is the R-squared, Adjusted R-squared, and F values for the overall model? (Report 
as a %, and round to 2 decimal places.)'

summary(clin.sci.model2) 

# 33.37%
# 32.69%
# 48.59

'3a) The Standardized Beta for DREEM Social Self Perception is (Round to three decimal places):'

round(lmBeta(clin.sci.model2),3)
'DREEM.S.SP DREEM.A.SP Resilience        BDI        Age 
     0.387      0.124      0.000     -0.167     -0.046 '

'3b) This means that as DREEM Social Self Perception increases by ______ standard 
deviation(s), the outcome of Med School Quality of Life increases 
by ______(Round to three decimal places):'

# 1 and 0.387

'3c) What amount of unique variance can be accounted for in the model by DREEM 
Social Self Perception? (Report as a percentage and round to two decimal places.)'

round(100*pCorr(clin.sci.model2),2) # 8.23
'           Partial_Corr Partial_Corr_sq Part_Corr Part_Corr_sq
DREEM.S.SP        33.15           10.99     28.68         8.23
DREEM.A.SP        11.60            1.34      9.53         0.91
Resilience         0.03            0.00      0.03         0.00
BDI              -15.30            2.34    -12.63         1.60
Age               -5.60            0.31     -4.58         0.21'

'4) According to the results from the full Multiple Regression Model, what is the best 
predictor of Med School Quality of Life, among Clinical Science students?'

summary(clin.sci.model2)

# DREEM Social Self Perception

'To answer our primary research questions about Clinical Sciences med students, we conducted 
2 primary tests: a simple + multiple linear regression. First, we investigated the claimed effect
of Beck Depression Inventory score on Overall Quality of Life. There was a negative correlation
between Beck Depression Inventory score and Overall Quality of Life. The corresponding model showed a
significant simple slope for Beck Depression Inventory (t(489) = 8.935), p < 0.05) indicating that
as the Beck Depression Inventory score increases, the Overall Quality of Life score decreases

The multiple linear regression examined the impact of DREEM: Social Self Perception, DREEM: 
Academic Self Perception, Resilience, BDI, and Age on Med School Quality of Life. Overall, 
the model was significant (F(5,485) = 48.59, p < .05), and could account for 33.37% of the 
variance in the outcome (Adjusted R2 = 32.69%). The best predictor of Med School Quality of Life was
DREEM: Social Self Perception which could account for a unique proportion of variance in the outcome of
8.23%'
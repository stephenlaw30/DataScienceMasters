'***********Course Week 6: Correlation and Regression Problem Set Question 1*********

For clinical science students, after controlling for Gender and Age, what predictor has a greater 
impact on BDI score - State or Trait anxiety?'

res <- TempskiResilience
clin.sci <- res[res$Group == 'Clinical Sciences',]

'After running the full model, with all predictors:
1a. What was the overall model fit (R-squared value)? Report as a percentage and round to 2 
decimal places.'

model1 <- lm(BDI~Female+Age+State.Anxiety+Trait.anxiety,clin.sci)
summary(model1)

# 54.04

'1b. What was the overall model F-statisic? Round to 1 decimal place.'

# 142.8

'1c. How many of the varaibles in the model show a significant effect for the prediction of the 
BDI score?'

# 2 --> Both anxieties

'1d. What are the Standardized Beta scores for the anxieties?'

round(lmBeta(model1),3)
'       Female           Age State.Anxiety Trait.anxiety 
       -0.021        -0.035         0.177         0.608 '

'1f. What was the proportion of variance that each Anxiety could uniquely account 
for in the prediction of BDI? Report as a percentage and round to 2 decimal places.'

round(100*pCorr(model1),2)
'              Partial_Corr Partial_Corr_sq Part_Corr Part_Corr_sq
Female               -3.09            0.10     -2.09         0.04
Age                  -5.08            0.26     -3.45         0.12
State.Anxiety        18.87            3.56     13.03         1.70
Trait.anxiety        54.79           30.02     44.40        19.72

1h. After controlling for Age and Gender, what was the best predictor of BDI?'

# Trait Anxiety
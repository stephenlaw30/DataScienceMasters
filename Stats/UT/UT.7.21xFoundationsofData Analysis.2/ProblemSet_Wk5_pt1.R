'******Course Week 5: Hypothesis Testing (More Than Two Group Means)****
Problem Set Question 1

Do low-budget movies make a different percentage of their profits domestically 
han movies with medium- or high-budgets? 

1. Suppose films w/ budgets < $100M are considered "low-budget"; $100M-$150M are "medium-budget", 
and $150+ are "high-budget."  
2. Create a new categorical variable in the dataset that defines each film under these criteria.'

library(SDSFoundations)
film <- FilmData

film$BudgetCategory <- ifelse(film$Budget < 100, "Low",
                              ifelse((film$Budget >= 100) & (film$Budget < 150), "Medium",
                                     "High"))
table(film$BudgetCategory)
'  High    Low Medium 
    25     67     58 

1b. Calculate the mean percent domestic for each group (report as percentages 
rounded to one decimal place.)'

aggregate(Pct.Dom~BudgetCategory,film,mean)
'  BudgetCategory   Pct.Dom
1           High 0.3758571 = 37.6
2            Low 0.4461940 = 44.6
3         Medium 0.3858293 = 38.6

1c. What is the F-statistic for this test? (Round to 1 decimal place.)'

BudCat.model <- aov(film$Pct.Dom~film$BudgetCategory)
summary(BudCat.model)
'                     Df Sum Sq Mean Sq F value  Pr(>F)    
film$BudgetCategory   2 0.1607 0.08034   7.604 0.00072 ***
Residuals           147 1.5531 0.01057                    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
1 observation deleted due to missingness

1d. What are the Numerator degrees of freedom?'

# 2

'1e. What are the Numerator degrees of freedom?'

# 147

'1e. What is the p-value of the test? (Round to 3 decimal places.)'

# 0.001

'1f. What is the appropriate conclusion for this test?'

# The mean percent gross earned domestically is NOT equal across all budget groups.

'1g. Run a Tukey HSD post-hoc analysis and chose the correct adjusted p-values for each 
pairwise comparison listed below.'

TukeyHSD(BudCat.model)
'                    diff         lwr         upr     p adj
Low-High     0.070336887  0.02243871  0.11823507 0.0019196
Medium-High  0.009972125 -0.04345850  0.06340275 0.8980433
Medium-Low  -0.060364762 -0.10862066 -0.01210887 0.0099261

Low vs. High'

# 0.002

'Low vs. Medium'

# 0.001

'Medium vs. High'

# 0.898

'1h. What is the appropriate conclusion for the post-hoc analysis?'

# Low-budget films earn a greater percentage of their profit domestically 
# than either medium-budget or high-budget films.
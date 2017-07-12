'***********Course Week 5: Hypothesis Testing (More Than Two Group Means)************

****************Lab 5: Top Grossing Films*********

Like most Americans, people in Austin are fascinated with cinema. The American film industry has captured the 
attention of audiences around the world, making film a multibillion-dollar-a-year industry. Most of the top-grossing 
films of all-time have been produced by the same 5 major studios: 20th-Century Fox, Paramount, Sony Pictures, 
Universal Pictures and Warner Bros. This data set focuses on the 151 films made by these studios that made the list 
of the 245 top-grossing films of all times, as determined by source Box Office Mojo. For each of the films, data 
includes film genre, MPAA rating, measures of film critic and user rankings, and production outcomes such as budget, 
time in theaters and amount grossed.'

library(SDSFoundations)
film <- FilmData

'1a. What is the goal of an ANOVA analysis?'

# to determine if significant mean differences exist between multiple groups

'1b. Two specific group means can be said to be significantly different if:'

# a Tukey HSD pairwise comparison shows p < 0.05 (or the identified level of significance)

'2. 2 of the following questions will be answered in this lab using ANOVA. Select the questions
that can be answered with this method.'

# Which studio(s) earn a greater percentage of their earnings domestically?
# Which studio(s) are more successful in keeping their films in the theaters longer?

'*******Primary Research Questions********

1. Are some studios more successful in keeping their films in the theaters longer?
2. Do some studios earn a greater percentage of their earnings domestically than others?

Break this question down into the different descriptive statistics  
you will need to construct your answer.

For each lab question:

1. ID the number of films in each studio group.'

table(film$Studio)
' Fox Par. Sony Uni.   WB 
  41   24   19   27   40 '

'2. Find the mean and standard deviation of the variable of interest for each group.'

head(film)
aggregate(Days~Studio,film,mean)
'  Studio     Days
1    Fox 154.5122
2   Par. 142.3750
3   Sony 113.7368
4   Uni. 130.3704
5     WB 145.8500'
aggregate(Days~Studio,film,sd)
'  Studio     Days
1    Fox 36.18433
2   Par. 44.92584
3   Sony 28.44652
4   Uni. 32.19430
5     WB 29.73865'

aggregate(Pct.Dom~Studio,film,mean)
'  Studio   Pct.Dom
1    Fox 0.4104878
2   Par. 0.4342500
3   Sony 0.3601053
4   Uni. 0.4399259
5     WB 0.3956250'
aggregate(Pct.Dom~Studio,film,sd)
'  Studio    Pct.Dom
1    Fox 0.11437529
2   Par. 0.10549562
3   Sony 0.09074806
4   Uni. 0.11277238
5     WB 0.09800044

3. Create boxplots to help visualize group differences and check test assumptions.'

library(ggplot2)
ggplot(film, aes(Studio, Days)) + 
  geom_jitter(aes(colour = Studio)) +
  geom_boxplot(aes(fill = Studio, group = Studio), 
               outlier.colour = "black", alpha = 0.5) +
  scale_colour_brewer(palette = "Paired") +
  scale_fill_brewer(palette = "Paired") +
  xlab('Studio') + 
  ylab('Days') +
  ggtitle('Average Days in Theater by Studio') +
  guides(fill=F)

ggplot(film, aes(Studio, Pct.Dom)) + 
  geom_jitter(aes(colour = Studio)) +
  geom_boxplot(aes(fill = Studio, group = Studio), 
               outlier.colour = "black", alpha = 0.5) +
  scale_colour_brewer(palette = "Paired") +
  scale_fill_brewer(palette = "Paired") +
  xlab('Studio') + 
  ylab('Days') +
  ggtitle('Average Domestic Earnings % by Studio') +
  guides(fill=F)

'4. Run ANOVA.'

Days.model <- aov(film$Days~film$Studio)
summary(Days.model)
'             Df Sum Sq Mean Sq F value   Pr(>F)    
film$Studio   4  25641    6410   5.354 0.000473 ***
Residuals   146 174799    1197                     
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
'

DomesticPerc.model <- aov(film$Pct.Dom~film$Studio)
summary(DomesticPerc.model)
'             Df Sum Sq Mean Sq F value Pr(>F)  
film$Studio   4 0.0938 0.02345   2.097 0.0842 .
Residuals   146 1.6327 0.01118                 
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1 

5. If the F statistic is significant, run a Tukey HSD test to determine 
which groups are different.'

TukeyHSD(Days.model)
'                diff        lwr         upr     p adj
Par.-Fox  -12.137195 -36.701360  12.4269694 0.6510905
Sony-Fox  -40.775353 -67.300009 -14.2506968 0.0003672 *************
Uni.-Fox  -24.141825 -47.829559  -0.4540910 0.0434270 *
WB-Fox     -8.662195 -29.902632  12.5782422 0.7923196
Sony-Par. -28.638158 -57.987250   0.7109344 0.0595011 
Uni.-Par. -12.004630 -38.817324  14.8080644 0.7299469
WB-Par.     3.475000 -21.202277  28.1522771 0.9951088
Uni.-Sony  16.633528 -11.986042  45.2530981 0.4963966
WB-Sony    32.113158   5.483715  58.7426006 0.0095337 ***
WB-Uni.    15.479630  -8.325382  39.2846409 0.3797660'


'The number of top-grossing films produced by each studio were:'

table(film$Studio)

'2a. Sony films were in theaters for the shortest period of time. How many 
days were they in theaters, on average? (round to 1 decimal place)'

aggregate(Days~Studio,film,mean) # 113.7

'2b. Fox films were in theaters for the longest period of time. How many 
days were they in theaters, on average? (round to 1 decimal place)'

# 154.5

'2c. What was the F statistic for this hypothesis test? (round to 2 decimal places)'

summary(Days.model) #5.35

'2d. We can conclude that _______ films are in theaters longer, on average, than 
films made by both Sony and Universal.'

TukeyHSD(Days.model) # Fox

'Research Question 2

3a. Universal films earned the largest percentage of earnings domestically, 
with a group mean of _______%. (round to 0 decimal places)'

aggregate(Pct.Dom~Studio,film,mean) # 0.4399259 = 44%

'3b. Sony films earned the smallest percentage of their earnings 
domestically, with a group mean of _______%. (round to 0 decimal places)'

# 0.3601053 = 36%

'3c. What was the F-statistic for this hypothesis test? (round to 1 decimal place)'

summary(DomesticPerc.model) # 2.097 = 2.1

'Tukey Results

3d. How many group means were significantly different from each other?'

TukeyHSD(DomesticPerc.model) # 0

'4. Which of the following observations allow you to confirm that the distributions 
were nearly Normal?'

# The boxplots were not highly skewed.

'This analysis examined 151 top-grossing ???lms produced by 5 major studios. Visual 
examination of the data through boxplots shows no violation of the approximate equality 
of variance assumption across the 5 major studios. Analysis DID reveal a di???erence in 
the number of days a ???lm spent in the theater, by studio (F(4,146) = 5.354, p < .05). In a 
Tukey HSD test, Fox films stayed in the theater significantly longer (155 days) than both
Universal (130 days) and Sony Studios (114 days). Sony studios was also significantly lower than
Warner Brothers studios (146 days). An additional analysis did NOT reveal a significant 
difference in the percentage of earnings domestically, across the 5 different studios 
(F(4,146) = 2.097, p = 0.084).'
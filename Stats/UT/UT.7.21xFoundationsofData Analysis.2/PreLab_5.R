'***********Course Week 5: Hypothesis Testing (More Than Two Group Means)************

****************Pre-Lab 5: Top Grossing Films*********

Like most Americans, people in Austin are fascinated with cinema. The American film industry has captured the 
attention of audiences around the world, making film a multibillion-dollar-a-year industry. Most of the top-grossing 
films of all-time have been produced by the same 5 major studios: 20th-Century Fox, Paramount, Sony Pictures, 
Universal Pictures and Warner Bros. This data set focuses on the 151 films made by these studios that made the list 
of the 245 top-grossing films of all times, as determined by source Box Office Mojo. For each of the films, data 
includes film genre, MPAA rating, measures of film critic and user rankings, and production outcomes such as budget, 
time in theaters and amount grossed.

**********Primary Research Questions********
  1. Does a film's rating (PG, PG-13, or R) impact its cost to produce?
  2. Does a film's rating (PG, PG-13, or R) influence its IMDB score?'

library(SDSFoundations)
film <- FilmData

'1a. What numerical rank does Titanic hold among highest-grossing films?'

head(film) # 2

'1b. What is the name of the highest ranked film made by Universal Studios?'

table(film$Studio)
head(film[film$Studio == 'Uni.',])

# Jurassic Park

'1c. What was the lowest IMDB rating given to a film that ranked in the top 10 grossing films 
of all time?'

film[film$Rank > 0 & film$Rank < 11,]

# Titanic = 7.6

'2a. Which variable tells us whether a film is rated PG, PG-13 or R?'

# Rating (categorical)
  
'2b. Which variable tells us the average score the film received on IMDB?'

# IMDB - quantitative

'2c. Which variable tells us how much it cost to produce the film?'

# Budget - quantitative

'*****Which method should we be using for this analysis and why?*********

3a. We will use ANOVA to help us answer each of these questions. Why?'

#We want to determine if the category to which a film belongs has an impact on some other 
#   quantitative measure.

'3b. We will conduct post-hoc tests, specifically Tukey's HSD, if the result of either
ANOVA is significant. Why?'

# We want to locate which group means are different from each other.

'Break this analysis into its required steps:

For each ANOVA:

  - 1. Identify the number of films in each rating group (PG, PG-13, R).'

table(film$Rating)
'  PG   PG13    R 
    39   94   18 '
film.pg <- film[film$Rating == 'PG',] 
film.pg13 <- film[film$Rating == 'PG13',]
film.r <- film[film$Rating == 'R',]

'2. Compute the mean and standard deviation of the variable of interest for each group.'

film.pg.cost.mu <- mean(film.pg$Budget)
film.pg.cost.sig <- sd(film.pg$Budget)
film.pg.imdb.mu <- mean(film.pg$IMDB)
film.pg.imdb.sig <- sd(film.pg$IMDB)

film.pg13.cost.mu <- mean(film.pg13$Budget)
film.pg13.cost.sig <- sd(film.pg13$Budget)
film.pg13.imdb.mu <- mean(film.pg13$IMDB)
film.pg13.imdb.sig <- sd(film.pg13$IMDB)

film.r.cost.mu <- mean(film.r$Budget, na.rm = T)
film.r.cost.sig <- sd(film.r$Budget, na.rm = T)
film.r.imdb.mu <- mean(film.r$IMDB, na.rm = T)
film.r.imdb.sig <- sd(film.r$IMDB, na.rm = T)

'3. Create boxplots to help visualize group differences and check test assumptions.'

library(ggplot2)
ggplot(film, aes(Rating, Budget)) + 
  geom_jitter(aes(colour = Rating)) +
  geom_boxplot(aes(fill = Rating, group = Rating), 
               outlier.colour = "black", alpha = 0.5) +
  scale_colour_brewer(palette = "Paired") +
  scale_fill_brewer(palette = "Paired") +
  xlab('MPAA Rating') + 
  ggtitle('Film Budgets by Rating')
  guides(fill=F)

aggregate(Budget~Rating,film,mean)
aggregate(Budget~Rating,film,sd)

ggplot(film, aes(Rating, IMDB)) + 
  geom_jitter(aes(colour = Rating)) +
  geom_boxplot(aes(fill = Rating, group = Rating), 
               outlier.colour = "black", alpha = 0.5) +
  scale_colour_brewer(palette = "Paired") +
  scale_fill_brewer(palette = "Paired") +
  xlab('MPAA Rating') + 
  ylab('Average IMDB Score')
  ggtitle('Film IMDB Scores by Rating')
  guides(fill=F)

aggregate(IMDB~Rating,film,mean)
aggregate(IMDB~Rating,film,sd)


'4. Run ANOVA.'
IMDB.model <- aov(film$IMDB~film$Rating)
'Call:
   aov(formula = film$IMDB ~ film$Rating)

Terms:
                film$Rating Residuals
Sum of Squares      0.44906 109.39492
Deg. of Freedom           2       148

Residual standard error: 0.8597412
Estimated effects may be unbalanced'

summary(IMDB.model)
'             Df Sum Sq Mean Sq F value Pr(>F)
film$Rating   2   0.45  0.2245   0.304  0.738
Residuals   148 109.39  0.7392'

Budget.model <- aov(film$Budget~film$Rating)
'Call:
   aov(formula = film$Budget ~ film$Rating)

Terms:
film$Rating Residuals
Sum of Squares      79852.1  446994.4
Deg. of Freedom           2       147

Residual standard error: 55.14325
Estimated effects may be unbalanced
1 observation deleted due to missingness'

summary(Budget.model)
'             Df Sum Sq Mean Sq F value   Pr(>F)    
film$Rating   2  79852   39926   13.13 5.67e-06 ***
Residuals   147 446994    3041                     
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
1 observation deleted due to missingness'

'5. If the F statistic is significant, run a Tukey HSD test to 
determine which groups are different'

TukeyHSD(Budget.model)
'Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = film$Budget ~ film$Rating)

$`film$Rating`
             diff       lwr        upr     p adj
PG13-PG  51.99755  27.12917 76.8659209 0.0000060 **********
R-PG     17.95234 -19.99271 55.8973842 0.5031892
R-PG13  -34.04521 -68.45570  0.3652895 0.0531681

1. What does aov stand for?'

# analysis of variance

'2. Which of the following comes closest to what it sounds like to "read aloud" this line of code?

aggregate(Budget~Rating,film,mean)'

# For all the cases in film, take the variable Budget and, given the Rating group, find the mean

'3. If group differences are present, what should be true about the output of this 
line of code?

aggregate(Budget~Rating,film,mean)'

# The average budget for each group should be different.

'4. If we are to satisfy the assumptions of ANOVA, what should be true about the 
output of this line of code?

aggregate(Budget~Rating,film,sd)'

# The largest standard deviation should be no more than twice the smallest standard deviation.

'5. Suppose we wanted to test if each type of Genre had the same level of Ratings. 
What has caused the error below?

film <- FilmData
modelRating <- aov(film$Rating~film$Genre)

Warning messages:
  1: In model.response(mf, "numeric") : using type = "numeric" with a factor response will be ignored
2: In Ops.factor(y, z$residuals) : - not meaningful for factors'

# We should have run a Chi Square Test of Independence (2 categorical variables)

'1a. How many films of each rating are in the dataset?'
table(film$Rating)
'  PG PG13    R 
  39   94   18 '

'**********Research Question 1

2a. What is the average cost, in millions of dollars, to make each type of 
film? (no decimal places)'

film.pg.cost.mu
film.pg13.cost.mu
film.r.cost.mu

aggregate(Budget~Rating,film,mean)

'2b. Was the assumption of equal variability met?'

film.pg.cost.sig
film.pg13.cost.sig
film.r.cost.sig

aggregate(Budget~Rating,film,sd) # YES

'ANOVA Results

2c. F-statistic (rounded to one decimal place):'
summary(Budget.model) # 13.13

'Tukey Test Results

2d. The average budget for a PG-13 film was significantly higher than the 
budget for a(n) ________ rated film.'

TukeyHSD(Budget.model) # PG

'2e. The difference between a PG-13 film and a(n) ________ rated film was almost, 
but not quite significant, at p = 0.053.'

# R

'Research Question 2

3a. What is the average IMDB score for each type of film? (Round to 1 decimal place)'

film.pg.imdb.mu
film.pg13.imdb.mu
film.r.imdb.mu

aggregate(IMDB~Rating,film,mean)

'ANOVA Results

3b. What is the F statistic, rounded to 1 decimal place?'

summary(IMDB.model)


'Tukey Test Results - Was a Tukey test necessary for this analysis?'

# No

'This analysis examined 151 top-grossing films produced by 5 major studios. 
The average cost of a film was found to vary depending on its MPAA rating (F = 13.1, p < .05). 
In a Tukey HSD test, PG13 films were shown to cost significantly more on average ($127M) 
than PG films ($75M). PG-13 films fell just shy of costing significantly more than R rated 
films (p=.053). The average IMDB score of a film does not appear to vary with MPAA rating 
(F = 0.3, p = .74). The average ratings for all 3 categories of film were close to 7 on a scale 
of 1-10. '
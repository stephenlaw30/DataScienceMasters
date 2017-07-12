'*******Course Week 4: Hypothesis Testing (Categorical Data)**********

**********Pre-Lab 4: Austin City Limits*************

Known as the "Live Music Capital of the World," Austin, Tx is also home to the longest-running music 
series in American television history, Austin City Limits. This dataset includes data on a sample of 
musicians that performed live on the PBS television series Austin City Limits over the last 10 years.  

Data on each artist include measures of commercial popularity, such as the number of social media 
followers on Twitter or Facebook, and their success in winning a Grammy Music Award.

***********Primary Research Questions*******************

  1. Are there an equal number of male and female performers on Austin City Limits?
  2. Are male performers just as likely to have had a Top 10 hit as female performers?

************Check the Data*********'

library(SDSFoundations)
acl <- AustinCityLimits

'1a. In what year did Allen Toussaint play at Austin City Limits + how old was he?'

head(acl,15) # 2009 + 75

'1c. How many variables for Allen Toussaint have missing data?'

acl[acl$Artist == 'Allen Toussaint',] # 1

'*******Check the Variables of Interest***********

Find the variables we need to answer the question.

2a. Which variable tells us whether the performer is male or female?'

# Gender

'2b. Which variable tells us whether the artist has had a Top 10 hit?'

# BB.wk.top10 (binary categorical)

'***********Reflect on the Method************

Which method should we be using for this analysis and why?'

'3a. We will use a Chi Square Goodness of Fit test to check whether there were an equal # of male and 
female performers. Why?'

# We want to see if the distribution of a categorical variable matches a proposed distribution model.

'3b. We will use a Chi Square Test of Independence to determine if male + female performers were equally 
likely to have had a Top 10 hit. Why?'

# We want to determine if there is an association between two categorical variables.

'*********Break this analysis into its required steps:********************

Goodness of Fit Test:
1. Make a table of counts for gender.'

gender.tbl <- table(acl$Gender) # F = 35   M = 81

'2. Create a vector of the expected proportions.'

edexp.gender <- c(.5,.5)

'3. Check the expected counts assumption.'

chisq.test(gender.tbl, p = edexp.gender)$expected

# F  M 
# 58 58 

'4. Run the chi square test.'

chisq.test(gender.tbl, p = edexp.gender)

'	Chi-squared test for given probabilities

data:  gender.tbl
X-squared = 18.241, df = 1, p-value = 1.946e-05

5. Interpret the chi square statistic and p-value.'

'W/ assumption alpha = 0.05 and dF = 1, our chi-squared critical value is 3.8414, and our chi-squared
is much higher at 18.241, so we reject the null that there is no difference between expected and observed'


'*************Test of Independence:***************
1. Create a two-way table for gender and Top 10 hits.'

gender.top10.tbl <- table(acl$Gender,acl$BB.wk.top10)

'     0  1
  F   15 18
  M   38 32

2. Check the expected counts assumption.'

chisq.test(gender.top10.tbl, correct = FALSE)$expected

'           0        1
  F 16.98058 16.01942
  M 36.01942 33.98058

3. Run the chi square test.'

chisq.test(gender.top10.tbl, correct = FALSE)

'Pearsons Chi-squared test

data:  gender.top10.tbl
X-squared = 0.70023, df = 1, p-value = 0.4027'


'1. If we wanted to test the hypothesis that the performers were 30% female and 70% male, 
what would the code look like? (Note that categorical values are referenced in alphabetical order).'

# ExpGender <- c(.30,.70)

' 2. Suppose the following values were returned for the "check expected counts" assumption in 
our goodness of fit test. Would the assumption be violated?

  F M
  3 29'

# Yes, because there are fewer than 5 expected Females.

'3. Which line of code is not necessary for a test of independence because there is no particular 
distribution model being tested?'

# ExpGender_top10 <- c(.25, .25, .25, .25)

'4. How many dF should there be for our test of independence? Remember, performers have either had
(or not had) a Top 10 hit.'

# 1

'Suppose we wanted to test whether there was an even distribution among the seasons. What caused the following 
error below? (You may want to examine the dataset in R for help.)

acl <- AustinCityLimits
season_counts <- table(acl$Season)
ExpSeason <- c(1/4, 1/4, 1/4, 1/4)
chisq.test(season_counts, p = ExpSeason)

Error in chisq.test(season_counts, p = ExpSeason) : x and p must have the same number of elements'

# There are not 4 seasons in our dataset, although line 3 suggests that there are.

'First we examined whether there were an equal number of male and female artists on Austin City Limits. 
In our sample, there were 81 males and 25 females.. A chi square goodness-of-fit test showed that this 
difference was statistically significant (chi square = 18.24, df = 1, p < .05). There are more
males than females on the show. Second, we asked whether male and female artists were equally likely to 
have had a Top 10 hit. Approximately 55% of female artists had a Top 10 hit, and 46% of male artists had
a Top 10 hit. This difference was NOT statistically significant. A chi square test of independence found 
top 10 hits to be independent of gender (chi square = 0.700, df = 1, p = .403). The assumptions for each test
were met. 
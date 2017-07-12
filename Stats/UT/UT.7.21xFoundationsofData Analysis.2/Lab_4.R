'*******Course Week 4: Hypothesis Testing (Categorical Data)**********

********************Lab 4: Austin City Limits***************

Known as the "Live Music Capital of the World," Austin, TX is also home to the longest-running music series
in American television history, Austin City Limits. This dataset includes data on a sample of musicians that 
performed live on the PBS television series Austin City Limits over the last 10 years. Data on each artist 
include measures of commercial popularity, such as the number of social media followers on Twitter or 
Facebook, and their success in winning a Grammy Music Award.

In this lab, you will use Chi Square Tests to answer a question of interest.

1a. In Chi Square Goodness of Fit test, a proposed distribution model is compared to an observed marginal distribution.

1b. 2 categorical variables are said to be independent if their conditional distribution matches the distribution of 
expected counts, when the variables are assumed not to be related.'

library(SDSFoundations)
acl <- AustinCityLimits

'What kind of test are we supposed to use?
  - Are each of the four musical genres equally represented on Austin City Limits?'
#     - goodness-of-fit

  '- Are some genres more likely to draw a large (100K+) Twitter following than others?'
#     - test of independence

'*************Primary Research Questions***********
  1. Are each of the four musical genres equally represented on Austin City Limits?   
  2. Are some genres more likely to draw a large (100K+) Twitter following than others?

Analysis - Break this question down into the different descriptive statistics needed to construct an answer.  

Goodness of Fit Test:
  1. Create a table to show the counts of each genre.'
table(acl$Genre)
'Country        Jazz/Blues   Rock/Folk/Indie Singer-Songwriter 
  18                13                68                17
  
  2. Create a vector of expected proportions + Check the expected counts assumption.'

exp <- c(obs.total/4)
# 29

'  4. Run a chi square test.'

obs.country <- sum(acl$Genre == 'Country')
obs.jazz <- sum(acl$Genre == 'Jazz/Blues')
obs.rock <- sum(acl$Genre == 'Rock/Folk/Indie')
obs.ss <- sum(acl$Genre == 'Singer-Songwriter')

obs.total <- sum(obs.country,obs.jazz,obs.rock,obs.ss)

obs <- c(obs.country,obs.jazz,obs.rock,obs.ss)

chisq.test(obs)

'	Chi-squared test for given probabilities

data:  obs
X-squared = 70.414, df = 3, p-value = 3.481e-15'

'5. Interpret the chi square statistic and p-value.'

# The observed counts of each artist are significantly different than expected


'Test of Independence:
  1. Create a two-way table for genre and Twitter following.'
table(acl$Genre,acl$Twitter.100k)
'                    0  1
  Country           11  6
  Jazz/Blues         9  2
  Rock/Folk/Indie   33 26
  Singer-Songwriter  6 10

  2. Check the expected counts assumption.'
obs.yes.country <- sum(acl$Twitter.100k[acl$Genre == 'Country'], na.rm = T)
obs.yes.jazz <- sum(acl$Twitter.100k[acl$Genre == 'Jazz/Blues'], na.rm = T)
obs.yes.rock <- sum(acl$Twitter.100k[acl$Genre == 'Rock/Folk/Indie'], na.rm = T)
obs.yes.ss <- sum(acl$Twitter.100k[acl$Genre == 'Singer-Songwriter'], na.rm = T)

obs.no.country <- sum(!acl$Twitter.100k[acl$Genre == 'Country'], na.rm = T)
obs.no.jazz <- sum(!acl$Twitter.100k[acl$Genre == 'Jazz/Blues'], na.rm = T)
obs.no.rock <- sum(!acl$Twitter.100k[acl$Genre == 'Rock/Folk/Indie'], na.rm = T)
obs.no.ss <- sum(!acl$Twitter.100k[acl$Genre == 'Singer-Songwriter'], na.rm = T)

obs.country <- sum(obs.yes.country + obs.no.country)
obs.jazz <- sum(obs.yes.jazz + obs.no.jazz)
obs.rock <- sum(obs.yes.rock + obs.no.rock)
obs.ss <- sum(obs.yes.ss + obs.no.ss)

obs.yes.ttl <- sum(obs.yes.country,obs.yes.jazz,obs.yes.rock,obs.yes.ss)
obs.no.ttl <- sum(obs.no.country,obs.no.jazz,obs.no.rock,obs.no.ss)

obs.ttl <- obs.yes.ttl + obs.no.ttl

exp.yes.country <- round((obs.country*obs.yes.ttl)/obs.ttl,2)
exp.yes.jazz <- round((obs.jazz*obs.yes.ttl)/obs.ttl,2)
exp.yes.rock <- round((obs.rock*obs.yes.ttl)/obs.ttl,2)
exp.yes.ss <- round((obs.ss*obs.yes.ttl)/obs.ttl,2)

exp.no.country <- round((obs.country*obs.no.ttl)/obs.ttl,2)
exp.no.jazz <- round((obs.jazz*obs.no.ttl)/obs.ttl,2)
exp.no.rock <- round((obs.rock*obs.no.ttl)/obs.ttl,2)
exp.no.ss <- round((obs.ss*obs.no.ttl)/obs.ttl,2)

'  3. Run a chi square test.'
chi<- sum(round((obs.yes.country - exp.yes.country)^2/exp.yes.country,2),
        round((obs.yes.jazz - exp.yes.jazz)^2/exp.yes.jazz,2),
        round((obs.yes.rock - exp.yes.rock)^2/exp.yes.rock,2),
        round((obs.yes.ss - exp.yes.ss)^2/exp.yes.ss,2),
        round((obs.no.country - exp.no.country)^2/exp.no.country,2),
        round((obs.no.jazz - exp.no.jazz)^2/exp.no.jazz,2),
        round((obs.no.rock - exp.no.rock)^2/exp.no.rock,2),
        round((obs.no.ss - exp.no.ss)^2/exp.no.ss,2))

# 5.71

chisq.test(acl$Genre,acl$Twitter.100k)
'	Pearsons Chi-squared test

data:  acl$Genre and acl$Twitter.100k
X-squared = 5.6919, df = 3, p-value = 0.1276

  4. Interpret the chi square statistic and p-value.'

# These two variables are NOT independent

'Goodness of Fit Test

1a. What was the expected count of artists for each genre?'

#29

'1b. What was the Chi-square statistic?'

# 70.41

'1c. How many degrees of freedom?'

# 3

'1d. What was the p-value?'

# 3.481e-15 < .05

'Test of Independence

2a. Using the data from your two-way table, compute the proportion of artists in each genre with 100K+ Twitter 
followers.'

round(obs.yes.country/obs.country,3) # 0.353
round(obs.yes.jazz/obs.jazz,3) # 0.182
round(obs.yes.rock/obs.rock,3) # 0.441
round(obs.yes.ss/obs.ss,3) # 0.625

'2b. What was the Chi-square statistic?'

# 5.69

'2c. How many degrees of freedom?'

# 3

'2d. What was the p-value?'

# 0.1276 > .05

'We should REJECT the hypothesis that each genre is equally represented at ACL Live.

We should FAIL TO REJECT the hypothesis that genre is independent of Twitter followers.

First we examined whether genres were represented equally at Austin City Limits. In our sample, 
there were 18 country, 13 jazz/blues, 68 rock/folk/indie, and 17 singer/songwriter acts. A Chi-square goodness
of fit test showed that this difference was statistically significant. (Chi-square = 70.41, df = 3, p < 0.05). 
There is a higher representation of rock/folk/indie artists than other artists on the show.

Second, we asked whether some genres were likely to draw more Twitter (over 100K). A Chi-square test of independence
revealed there was NO significant finding -- a large Twitter following was independent of genre (Chi-square = 5.69,
df = 3, p-value = 0.1276).'
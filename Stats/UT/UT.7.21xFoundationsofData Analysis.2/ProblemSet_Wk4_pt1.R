'******Course Week 4: Hypothesis Testing (Categorical Data) Problem Set Question 1***********

You want to know if the proportion of female performers on Austin City Limits Live has changed in the past 
2 years. 

1. Create a new variable in the dataset called "Recent" that is equal to a 1 for rows from years 2012 or 
2013 and is equal to 0 for all other rows.'

library(SDSFoundations)
acl <- AustinCityLimits

acl$Recent <- as.integer(acl$Year == 2012 | acl$Year == 2013)

#acl$Recent[acl$Year < 2012] <- 0 
#acl$Recent[acl$Year >= 2012] <- 1

'2. Make a table that shows the number of male and female performers in "recent" and non-recent years.'
table(acl$Gender,acl$Recent)
'     0  1
  F   23 12
  M   65 16'

'1a. How many female performers have been on the show in the past two years (2012 and 2013)?'

# 12

'1b. What is the appropriate method to test if representation by female performers is different 
before 2012 compared to since 2012?'

# Chi-Square Test of Independence

obs.bef12.female <- sum(!acl$Recent[acl$Gender == 'F'], na.rm = T)
obs.bef12.male <- sum(!acl$Recent[acl$Gender == 'M'], na.rm = T)

obs.aft12.female <- sum(acl$Recent[acl$Gender == 'F'], na.rm = T)
obs.aft12.male <- sum(acl$Recent[acl$Gender == 'M'], na.rm = T)

obs.female <- sum(obs.bef12.female + obs.aft12.female)
obs.male <- sum(obs.bef12.male + obs.aft12.male)

obs.bef12.ttl <- sum(obs.bef12.female,obs.bef12.male)
obs.aft12.ttl <- sum(obs.aft12.female,obs.aft12.male)

obs.ttl <- obs.bef12.ttl + obs.aft12.ttl

exp.bef12.female <- round((obs.female*obs.bef12.ttl)/obs.ttl,2)
exp.bef12.male <- round((obs.male*obs.bef12.ttl)/obs.ttl,2)

exp.aft12.female <- round((obs.female*obs.aft12.ttl)/obs.ttl,2)
exp.aft12.male <- round((obs.male*obs.aft12.ttl)/obs.ttl,2)

'1c. Report expected counts for the following performer groups.
  - Females before 2012 = 26.55
  - Females in 2012 and 2013 = 45.39
  - Males before 2012 = 61.45
  - Males in 2012 and 2013 = 19.55

1d. What is the Chi Square statistic?'

chi<- round(sum(((obs.bef12.female - exp.bef12.female)^2/exp.bef12.female),
          ((obs.aft12.female - exp.aft12.female)^2/exp.aft12.female),
          ((obs.bef12.male - exp.bef12.male)^2/exp.bef12.male),
          ((obs.aft12.male - exp.aft12.male)^2/exp.aft12.male)),2)

# 2.82

chisq.test(acl$Recent,acl$Gender)
'	Pearsons Chi-squared test with Yates continuity correction

data:  acl$Gender and acl$Recent
X-squared = 2.081, df = 1, p-value = 0.1491


1e. What is the p-value for the test? (Round to 2 decimal places.)'

# 0.09???????????????

'1f. What is the appropriate conclusion for this test, assuming ?? = 0.05?'

# We fail to reject the null hypothesis; gender is independent of performance before or after 2012.
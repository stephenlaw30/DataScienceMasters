'Pre-Lab 4: Austin City Limits

Known as the "Live Music Capital of the World," Austin, TX is also home to the longest-running music series in American television 
history, Austin City Limits. This dataset includes data on a sample of musicians that performed live on the PBS television series Austin
City Limits over the last 10 years. Data on each artist include measures of commercial popularity, such as the number of social media 
followers on Twitter or Facebook, and their success in winning a Grammy Music Award. 

**Primary Research Question** - For artists age 30 or older, do female artists play different kinds of music on Austin City Limits than 
male artists?'

setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UT/UT.7.11xFoundationsofData Analysis.1')
setwd('C:/Users/Nimz/Dropbox/DataScienceMasters/Stats/UT/UT.7.11xFoundationsofData Analysis.1')

library(SDSFoundations)
acl <- read.csv("AustinCityLimits.csv")

dim(acl) #116 obs of 14 vars
str(acl)
table(head(acl$Grammy,10)) #4 grammy winners
subset(acl,Age > 60) #Jazz/Blues for 1st female artist over 60

'We will generate a contingency table of genre and gender to help us with this analysis because it will show us how many male and female
artists played each type of music. We will then compare marginal and conditional probabilities to determine if female and male artists 
tend to play different kinds of music because we want to determine if two categorical variables are independent or not.

1. Create a subset of the data for artists age 30 or older.'
older <- subset(acl, Age >= 30)

'2. Create a table to show marginal distribution for each variable.  '
gender.tbl <- table(older$Gender)
genre.tbl <- table(older$Genre)

'3. Create a contingency table to show the conditional distribution for gender and genre.  '
contingency.tbl <- table(older$Gender, older$Genre)

'4. Make a bar chart to better visualize how many male and female artists played in each genre.'
library(ggplot2)
#ggplot(older) + geom_bar(aes(x=Genre,y=value))
barplot(contingency.tbl, legend=T, beside=T)

'5. Calculate P(A):  the probability of each type of music (genre) being played.'
prop.table(table(older$Genre))

'6. Calculate P(A|B):  the probability of each genre, given the artist's gender.'
prop.table(contingency.tbl,1) #1 references the first variable (gender) listed in the contingency table code. 

'6. Calculate P(C|D):  the probability of the artist's gender given the genre'
prop.table(contingency.tbl,2) #2 references the 2nd variable (genre) listed in the contingency table code. 

# proportion of jazz musicians that were male = 7 male jazz / 11 ttl jazz
# proportion of males that were jazz musicians = 7 male jazz / 77 ttl males
#probability that a randomly selected artist from the dataset performed rock/folk/indie music
prop.table(table(older$Genre)) #0.5980392

#probability that a randomly selected female artist performed rock/folk/indie music
prop.table(contingency.tbl,1) #0.32000000

'For genre and gender to be independent, P(rock) = P(rock | a gender)'

'The music played on Austin City Limits was grouped into 4 genres, Country, Jazz, Rock and Singer-Songwriter. We wanted to examine only 
those artists who were age 30 or older. Rock was the most frequently played genre, performed by 59.8% of Austin City Limits artists. 
Among female artists, however, only 32% played Rock. This difference between the marginal and conditional (59% vs 32%) probabilities 
suggests that gender and genre ARE indeed independent. This difference was also evident in the bar plots, where it was evident that 
females were more likely to perform in the singer/songwriter category than their male counterparts.
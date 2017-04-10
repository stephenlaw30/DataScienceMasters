'Lab 4: Austin City Limits

Known as the "Live Music Capital of the World," Austin, TX is also home to the longest-running music series in American television 
history, Austin City Limits. This dataset includes data on a sample of musicians that performed live on the PBS television series Austin
City Limits over the last 10 years. Data on each artist include measures of commercial popularity, such as the number of social media 
followers on Twitter or Facebook, and their success in winning a Grammy Music Award. '


setwd('C:/Users/snewns/Dropbox/DataScienceMasters/Stats/UT/UT.7.11xFoundationsofData Analysis.1')
setwd('C:/Users/Nimz/Dropbox/DataScienceMasters/Stats/UT/UT.7.11xFoundationsofData Analysis.1')

library(SDSFoundations)
acl <- read.csv("AustinCityLimits.csv")

#The probability an event will occur, given that a *different* event has also occurred, is known as a conditional probability

#for 2 events, A and B, to be considered independent: P(A)=P(A|B)
  
'**Primary Research Question** - Among male artists, is there an association between winning a Grammy and the genre of music played?

. Subset the data (males only).'
males <- subset(acl, Gender == 'M')

#2. Create a table to show the marginal distributions for Genre and Grammy.
genre <- table(males$Genre)
grammy  <- table(males$Grammy)

#3. Create a contingency table to show the conditional distribution for Genre and Grammy.
cont.tbl <- table(males$Grammy,males$Genre)

#4. Make a bar chart to better visualize how many artists in each Genre received a Grammy.
barplot(cont.tbl, legend = T, beside = T)

#5. Calculate P(A):  the probability of winning a Grammy.
prop.table(grammy)

#6. Calculate P(A|B): the probability of winning Grammy, given the artist's Genre.
prop.table(cont.tbl,1)

#probability of  the artist's Genre, given winning a Grammy
prop.table(cont.tbl,2)


'35 male artists won a Grammy, 46 male artists did not win a Grammy. The probability that a randomly selected artist was a Grammy winner
was 0.432. To determine the probability of winning a Grammy if the artist was a singer-songwriter, divide 2 by 7. To determine the 
probability a randomly-selected Grammy winner was a singer-songwriter, divide 2 by 35.

the probability that a randomly selected male artist from each of the following genres won a Grammy'
prop.table(cont.tbl,2)

#see that winning a Grammy is not independent of Genre.

'There is an association between winning a Grammy and the Genre of music an artist plays. The probability of winning a Grammy, 
regardless of Genre, is 41.21%. However, examination of a contingency table containing both Grammy and Genre showed that the conditional
probability of winning a Grammy changes by genre. If an artist is Country, the conditional probability of winning a Grammy is 69.64 %,
while if an artist is a Singer/Songwrite, the conditional probability of winning a Grammy is 28.6%. They should be the same, regardless
of genre. Visual examination of the barplot shows the conditional probabilities of winning a Grammy are not equal across Genres.
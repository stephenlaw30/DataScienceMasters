'You want to see if artist popularity on Facebook (whether or not they have 100k or more likes) has anything to do with age.'

setwd('C:/Users/Nimz/Dropbox/DataScienceMasters/Stats/UT/UT.7.11xFoundationsofData Analysis.1')

library(SDSFoundations)
acl <- read.csv("AustinCityLimits.csv")

#1.  Generate a table to show the number of artists that are "popular" and those that are not.
table(acl$Facebook.100k) #85 are popular

#2.  Generate a table to show the number of "popular" artists within each age group.
table(acl$Facebook.100k,acl$Age.Group) #Thirties has highest # of popular artists
prop.table(table(acl$Facebook.100k,acl$Age.Group),2)
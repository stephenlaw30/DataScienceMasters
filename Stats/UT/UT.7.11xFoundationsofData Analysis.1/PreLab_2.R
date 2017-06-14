library(SDSFoundations)
animaldata <- AnimalData

str(animaldata)
head(animaldata,10)
#We have 24 variables, 4 of the 1st 10 animals were adopted, and the 1st owner-surrendered animal was not neutered.


'Primary Research Question - How many days do animals spend in the shelter before they are adopted?

We will use descriptive statistics to answer this question of interest b/c we want to describe the distribution of a quantitative 
variable. We should generate a histogram of the distribution before we calculate descriptive measures of center and spread because we need 
to check the shape of the distribution.'

#Pull out only adopted animals
adopted <- animaldata[animaldata$Outcome.Type=="Adoption",]

#Visualize and describe this variable
library(ggplot2)
ggplot(adopted) + geom_histogram(aes(x = Days.Shelter),binwidth = 5,boundary = 5)

'Data is positively (right) skewed, so the measure of center to report is the median (13) and the measure of spread to report is the 
IQR (31 or 30)'
summary(adopted$Days.Shelter)
fivenum(adopted$Days.Shelter)
spread <- 38 - 8

#How many days was the animal who took the longest to be adopted in the shelter? = 211 days
animaldata[which.max(adopted$Days.Shelter),]

#z-score = 5.08842
(211-mean(adopted$Days.Shelter))/sd(adopted$Days.Shelter)

'We NOT report a z-score for this animal, even though we can calculate one because the distribution is skewed and the z-score is based
on the NORMAL distribution with a mean and standard deviation.

CONCLUSION - On average, animals spent fewer than 2 weeks in the shelter before being adopted (median = 13 days, IQR = 30 days). The 
length of time was highly skewed to the right, however. The longest period of time an animal was in the shelter was 211 days before 
being adopted. This animal was a 2-year-old dog that entered the shelter injured. The middle 50% of the distribution were adopted 
between 8 and 38 days.'
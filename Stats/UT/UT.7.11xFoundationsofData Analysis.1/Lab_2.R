'Have you ever been curious about how long it takes for an animal to be adopted?  To investigate questions like this, we 
contacted the Austin Animal Shelter and they provided us with info about 473 cats and dogs.  Included in the dataset are 
info about how animals arrived at the shelter, their sex, breed, age, weight, and the number of days spent in the shelter.  '

library(SDSFoundations)
animaldata <- AnimalData

'1a. In this lab you will use descriptive stats to answer a question of interest. We calculate descriptive stats because 
they can tell us what the distribution of a variable looks like, and the mean and SD are examples of descriptive stats

A question that can be answered with descriptive statistics is "How much do adult cats and dogs at the shelter weigh?"

**Primary Research Question** - Compare the weight of adult cats and dogs at the shelter. How typical would it be to find
a 13-pound cat?  What about a 13-pound dog?

Break this question down into the different descriptive stats to construct an answer.

* 1. Create a table to show how many adult (at intake) cats and dogs are in the dataset. 
  * An animal is considered an adult if it is at least 1 year of age. 
* 2. Make a histogram of weight for both adult dogs and cats. 
* 3. Calculate the appropriate measures of center and spread for each distribution.
* 4. Find the z-score for a 13-pound cat.
* 5. Find the quartile for a 13-pound dog.'

str(animaldata)
adultAnimals <- subset(animaldata, Age.Intake >= 1)
table(adultAnimals$Age.Intake)

table(adultAnimals$Animal.Type)

'There are 226 adult dogs and 56 adult cats are in the shelter.'

adultDogs <- subset(adultAnimals, Animal.Type == 'Dog')
adultCats <- subset(adultAnimals, Animal.Type == 'Cat')

library(ggplot2)
ggplot(adultDogs) + geom_histogram(aes(x = Weight))
ggplot(adultCats) + geom_histogram(aes(x = Weight))

'The distribution of weight for adult dogs is right/positively skewed and the distribution of weight for adult cats is 
approximately normal, so the measure of center used to describe the average weight of the adult cats is the mean.

The average/mean adult cat weight in pounds (rounded to 1 decimal place) is 8.6 and the SD is 1.9, so the Z-score of a 
13-lb cat would be (13 - 8.6)/1.9 = 2.315789 = 2.3'

fivenum(adultCats$Weight)
mean(adultCats$Weight) #8.603571
sd(adultCats$Weight) #1.911517

'So, to best describe the location of a 13 pound adult cat in the shelter distribution, we would say it is more than 2
standard deviations above the mean (z-score > 2).

The proportion of adult cats that weigh more than 13 pounds, according to your data, is 0.0107241 = 0.0107 = 1.07% of cats' 
zScore.cat <- 2.3
1-pnorm(zScore.cat)

'Looking now at the descriptive statistics for the weight of adult dogs in the shelter, quartile 1 would contain a 13-lb
adult dog, so approximately 75% of adult dogs in the shelter weigh more than 13 pounds.'

fivenum(adultDogs$Weight)
mean(adultDogs$Weight)
sd(adultDogs$Weight)
(13 - 35.67) / 23.47
zScore.dog <- -0.97
1-pnorm(zScore.dog)

'0.8339768 = 0.833 = 83.3% of adult dogs in the shelter weigh more than 13 pounds

**Primary Research Question** - Compare the weight of adult cats and dogs at the shelter. How typical would it be to find
a 13-pound cat? What about a 13-pound dog?
The distribution of adult cats in the shelter is roughly symmetric with a mean of 8.6 pounds and a SD of 1.9 pounds. About
95% of adult cats at the shelter weigh between 4.8 and 12.4 pounds (2 SDs). The distribution of adult dogs in the shelter 
is positively skewed, with a median of 35.3 pounds and an IQR of 40.4 pounds. Half of the dogs at the shelter do weigh
much more, including one that weighs  131 lbs. As the 2 distributions are to be *compared*, and 1 distribution is skewed, 
the data shows that the median weight for both groups is 8.5 for cats and 35.3 for dogs. 

A 13-pound cat would NOT be typical at the shelter. On the other hand, about 75% of all dogs at the shelter weigh more 
than 13 pounds. Overall, the distributions of weights for adult cats and adult dogs at the shelter differ both in shape 
and in measures of center and spread. Cats generally weigh less and have less variation in their weights than dogs, while 
dogs tend to weigh more and have more variability.'
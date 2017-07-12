setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/Stats/Udacity/DataAnalystNanoDegree/IntroToInferentialStats/Final/winequality')

# load in libraries
library(ggplot2)

# load in data
red <- read.csv('winequality-red.csv', sep = ';')
white <- read.csv('winequality-white.csv',sep = ';')

summary(red$alcohol)
summary(white$alcohol)

# create factor for wine color for a combined data set
red$isRed <- 1
white$isRed <- 0

# combine data frames
wine <- rbind(red,white)
wine$isRed <- as.factor(wine$isRed)

# inspect
head(wine)
summary(wine)

#***************DOES HIGHER ALCOHOLIC WINE HAVE HIGHER QUALITY?

#h(0) = all wines have same quality (is = mean)
#h(a) = quality is different if alcohol is higher than average
# check population
ggplot(wine) + geom_histogram(aes(x = (quality)),
                              bins = 6,
                              fill = 'purple', 
                              colour = 'black') + 
  ggtitle('Distribution of Wine Quality Scores') + 
  xlab('Quality') + 
  ylab('Count')

# population parameters
mu <- mean(wine$quality) # 5.818378
sigma <- sd(wine$quality) # 0.8732553

# create sample wines with above average alcohol content
set.seed(15)
highAlcQuality <- wine$quality[wine$alcohol > mean(wine$alcohol)]

ggplot() +
  #geom_histogram(aes(x = log(wine$alcohol)), fill = 'blue') +
  geom_histogram(aes(x = highAlcQuality), 
                 bins = 6, 
                 fill = 'dark red', 
                 colour = 'black') + 
  ggtitle('Distribution of Quality of Above-Average Alcohol Content Wine') + 
  xlab('Quality') +
  ylab('Count')

# sample statistics
x <- mean(highAlcQuality) # 6.184963
stdErr <- sigma/sqrt(length(highAlcQuality)) # 0.01592747

# calculate margin of error for z-critical score of 1.96 for 95% confidence
margErr <- 1.96*stdErr # 0.03121784

z <- (x - mu)/(stdErr) # 23.01594
#reject Null that higher alcoholic wine is the same quality as below average or average
# i.e. it's significantly different in quality (greater b/c positive z-score)

'*************************************************************************'


ggplot() + 
  geom_point(aes(x = red$alcohol, y = red$quality), 
             shape = 21, colour = "black", fill = "red", size = 3, stroke = 1) + 
  geom_point(aes(x = white$alcohol, y = white$quality), 
             shape = 21, colour = 'black', fill = "white", size = 2, stroke = 1) + 
  ggtitle('Wine Alcohol Content vs. Wine Quality') + 
  xlab('Alcohol Content') + 
  ylab('Quality')

cor(wine$alcohol,wine$quality) # 0.4443185 = mildly positive linear relationship
cor(wine$alcohol,wine$quality)^2 # 0.1974189 = 19.74% of variation in quality is due to variation in alcohol %

'.	Even if 2 variables appear to be related after looking at the data, it could just be due to chance
.	The actual population might not have this relationship
.	Or vice versa, where the population has a relationship but a sample from it does not
.	Things like this happen due to sampling error, which can be reduced w/ larger sample sizes
'
#test w/ a linear regression model
summary(lm(quality~alcohol,wine))
#see that alcohol is very significant w/ a very small p-value, so this relationship is statistically significant,
# but is not very strong, as there are plenty of other factors which may as well be affecting quality of the wine
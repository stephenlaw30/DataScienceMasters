#Lesson 1 - Diamonds

setwd("C:/Users/snewns/Dropbox/NewLearn/UDEMY/R/RProgrammingAZ")
diamonds <- read.csv("Mispriced-Diamonds.csv")

dim(diamonds) #53490 diamonds/obs w/ 3 vars
names(diamonds)
str(diamonds) #a number, a factors (8 lvls), and an int ($'s)
summary(diamonds) #no NA's, that's good

#Clarity
# - I1-I3     --> inclusions in the diamond = not pure
# - S1-S3     --> slight inclusions
# - VS1-VS3   --> VERY slight inclusions
# - VVS1-VVS3 --> vERY VERY slight inclusions
# - IF        --> Internal flawless
# - I1        --> Flawless = BEST/MOST DESIRED

#Does a better clarity always equal a higher price? Or are there mispricings in the marketplace?
library(ggplot2)
ggplot(diamonds,aes(carat,price)) + geom_point() #geom_point = add layer of points to plot layer
#See a slight positive linear relationship between carat and price (more carats = higher price) w/ some
# outliers of a higher price

#add clarity to plot
ggplot(diamonds, aes(x = carat, y = price, colour = clarity)) + geom_point()
#Now see that I1 seems to be the most expensive, which is what we'd expect, see an outlier for VS2
#But the scatterplot is cluttered + has points that aren't statistically significant to the right

#Clear up with an alpha arg in geom_point()
ggplot(diamonds, aes(x = carat, y = price, colour = clarity)) + geom_point(alpha = 0.1)

#Filter out non-sig observations/rows (carat > 2.5)
ggplot(diamonds[diamonds$carat < 2.5,], aes(x = carat, y = price, 
                                            colour = clarity)) + geom_point(alpha = 0.1)

#Now add the averages for the different clarities
ggplot(diamonds[diamonds$carat < 2.5,], aes(x = carat, y = price, colour = clarity)) + 
  geom_point(alpha = 0.1) + 
  geom_smooth()

#See that IF is highest as we want it, but wherever lines cross = mispricings (at start and end of 
# prices)
#can also see confidence band (gray backgroudn around lines) getting wider at some points = less 
# confidence
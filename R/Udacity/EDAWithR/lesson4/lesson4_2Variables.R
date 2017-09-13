# 2 continous variables = inspect w/ scatterplot
setwd("C:/Users/NEWNSS/Dropbox/DataScienceMasters/R/Udacity/EDAWithR/lesson4")
fb <- read.csv('pseudo_facebook.tsv', sep = '\t')

library(ggplot2)
ggplot(fb) + 
  geom_point(aes(age,friend_count))
#qplot(age,friend_count,data = fb)

# ugly plot, but younger users have most friends, then w/ a spike of older users,
# 1 random spike between 60-75
# users lied about age --> age 69 and age 100 (teens or fake accounts)


# set limit to Facebook's minimum age and the max believeable age
ggplot(fb) + 
  geom_point(aes(age,friend_count)) + 
  xlim(13,90)

# some points are spread out, some are stacked on top of each other (OVERPLOTTED = difficult to tell how many
#   points are in each region)
# remedy w/ alpha argument
ggplot(fb) + 
  geom_point(aes(age,friend_count), alpha = 0.05) + 
  xlim(13,90)
# can see bulk of users have < 1000 friends

# age = continous, but we only have int values, so perfectly-lined up columns aren't a true reflection of age
# use geom_jitter to space them out/add noise
ggplot(fb) + 
  geom_jitter(aes(age,friend_count), alpha = 0.05) + 
  xlim(13,90)
# more disperse distribution --> spike around age 70 (age 69)
# also friend counts for younger users seem lower than thought before (from 1st plot)
# alpha of 0.05 = takes 20 circles to make a point completely dark

# transform y-axis to get a better view of the data
?coord_trans
ggplot(fb) + 
  geom_point(aes(age,friend_count), alpha = 0.05, na.rm = T) + 
  xlim(13,90) + 
  coord_trans(y = "sqrt")

# to do the same w/ jitter, need to specify we only want to jitter "age" + be careful bc some users have 0 friends
# if we add noise to friend_counts, might get negative values, which causes imaginary square roots
# set jitter position parameter to jitter w/ min value of 0
ggplot(fb) + 
  geom_point(aes(age,friend_count), alpha = 0.05, position = position_jitter(h = 0)) + 
  xlim(13,90) + 
  coord_trans(y = "sqrt")

# explore relationship between friends_initiated and age
ggplot(fb) + 
  geom_point(aes(age,friendships_initiated), alpha = 0.05, position = position_jitter(h = 0)) + 
  xlim(13,90) + 
  coord_trans(y = "sqrt")
# see the same spikes



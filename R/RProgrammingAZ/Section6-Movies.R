setwd("C:/Users/Nimz/Dropbox/NewLearn/UDEMY/R/RProgrammingAZ")
movies  <- read.csv("Movie-Ratings.csv")

summary(movies)

#convert year to factor
movies$Year.of.release <- as.factor(movies$Year.of.release)
str(movies)

colnames(movies) <- c("Film", "Genre", "criticRating", "audienceRating", "budgetInMillions", "Year")

library(ggplot2)
ggplot(data = movies, aes(x = criticRating, y = audienceRating, colour = Genre)) +
  geom_point() +
  xlab("Critics Rating") + 
  ylab("Audience Rating") +
  ggtitle("Critic Rating vs. Audience Rating by Genre") + 
  labs(caption = 'Doesnt look like genre has any affect on differences between Audience and Critic Rating')

ggplot(data = movies, aes(x = criticRating, y = audienceRating, colour = Genre, size = budgetInMillions)) +
  geom_point() +
  xlab("Critics Rating") + 
  ylab("Audience Rating") +
  ggtitle("Critic Rating vs. Audience Rating by Genre") + 
  labs(caption = 'Audience seems less forgiving than critics to big budget movies, and to movies overall (mostly 
have ratings above the diagonal)')


#*********************************** LAYERS
p <- ggplot(data = movies, aes(x = criticRating, y = audienceRating, colour = Genre, 
                               size = budgetInMillions))
#***********************************override aes
p + geom_point(aes(colour = budgetInMillions))


#slide 2 chart
p + geom_point(aes(x = budgetInMillions)) + 
  xlab("Budget in Millions $")

#***********************************MAPPING
r <- ggplot(data = movies, aes(x = criticRating, y = audienceRating))
r + geom_point(aes(colour = Genre))
r + geom_point(aes(size = budgetInMillions))

#***********************************SETTING
r + geom_point(colour = "DarkGreen")
r + geom_point(size = 10)

s <-  ggplot(data = movies, aes(x = budgetInMillions))
s + geom_histogram(binwidth = 10)
s + geom_histogram(binwidth = 10, fill = "green")
s + geom_histogram(binwidth = 10, aes(fill = Genre))
#chart 3 w/ black border
s + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black")

#***********************************#density
s + geom_density(aes(fill = Genre))
s + geom_density(aes(fill = Genre), position = "Stack")

#***********************************histogram
t <-  ggplot(data = movies, aes(x = audienceRating))
t + geom_histogram(binwidth = 10, fill = "White", colour = "Blue")
#see mean is around 50-60, which makes sense since 50 would be 'average' between 0 and 100, sort of
# normally distributed

u <-  ggplot(data = movies)
u + geom_histogram(binwidth = 10, aes(x = audienceRating), fill = "White", colour = "Blue")
u + geom_histogram(binwidth = 10, aes(x = criticRating), fill = "White", colour = "Blue")
#critic rating is much more uniformly rated compared to audience, since they are less biased since
# they use their professional experience and assessment of all aspects of filmaking

#***********************************skeleton plot
v <- ggplot()

w <- ggplot(data = movies, aes(x = criticRating, y = audienceRating, colour = Genre))
w + geom_point() + geom_smooth()
w + geom_point() + geom_smooth(fill = NA)
#Can try to see how the critic and audience ratings are related, it seems a general upward trend,
# so maybe a small positive correlation
#Ex: If critic tends to rate a Romantic movie arond 25, then the audince has a slight bump in ratings
# to about 62.5 (peak)
#Ex: If movie critics give both an action movie and a comedy movie similar ratings, the fact that the 
# line for action is above comedy indicates that users would give the action movie higher ratings 
# compared to the comedy movie, even though critics gave them the same score

x <- ggplot(data = movies, aes(x = Genre, y = audienceRating, colour = Genre))
x + geom_boxplot()
x + geom_boxplot(size = 1.2)
x + geom_boxplot(size = 1.2) + geom_jitter() #jitter throws points around randomly to help the eye

#put boxes overtop of jittered points and make them transparent w/ alpha arg
x + geom_jitter() + geom_boxplot(size = 1.2, alpha = 0.5)
#drama, romance, and thriller have the highest ratings, but thrillers have a higher probability of
# having a higher rating due to the high mean and the smaller box (lower variance of scores), meanwhile
# adventure and drama tend to have the largest variety of scores, and horror has a low variance, but
# also low average rating

y <- ggplot(data = movies, aes(x = Genre, y = criticRating, colour = Genre))
y + geom_jitter() + geom_boxplot(size = 1.2, alpha = 0.5)
#incredibly large variance in all genres, with thriller having highest average, and horror having
# lowest average, similar to audience ratings

z <- ggplot(data = movies, aes(x = Genre, y = budgetInMillions, colour = Genre))
z + geom_jitter() + geom_boxplot(size = 1.2, alpha = 0.5)
#horror and drama have the lowest averages, and also a low variane, so its easier to predict, while
# action and adventure have a large variance and the largest averages

a <- ggplot(data = movies, aes(x = budgetInMillions))
a + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black")
#still a bit hard to read

#make a histogram for each of the genres via facets --> facet_grid(rows~col)
a + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black") +
  facet_grid(Genre~.)
#all are very small since they're using the same x-axis, which we can ignore w/ scales arg
a + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black") +
  facet_grid(Genre~., scales = "free")
#can now see the skewness in some, like the couple of random humps for action movies, and the right
# skewness of comedy, drama, horror, romance, and thriller, and the random distribution of adventure


a + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black") +
  facet_grid(.~Genre)
a + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black") +
  facet_grid(.~Genre, scales = "free")


b <- ggplot(movies, aes(x = criticRating, y = audienceRating, colour = Genre))
b + geom_point(size = 3) +
  facet_grid(Genre~.)
#now each genre has its own row/scatterplot
#b + geom_point(size = 3) +
#  facet_grid(.~Genre)

b + geom_point(size = 3) +
  facet_grid(.~Year)
#make scatter plots where each column is a year
# + geom_point(size = 3) +
#  facet_grid(Year~.)

#split up each genre scatterplot by year
b + geom_point(size = 3) +
  facet_grid(Genre~Year)


b + geom_point(size = 3) +
  facet_grid(Genre~Year) + 
  geom_smooth(fill = NA)

b + geom_point(aes(size = budgetInMillions)) +
  facet_grid(Genre~Year) + 
  geom_smooth(fill = NA)

#zoom into chart to keep it between 0 and 100 for ratings (ignore fill for
# geom_smooth if used (CI's))
w <- ggplot(data = movies, 
            aes(x = criticRating, y = audienceRating, size = budgetInMillions, colour = Genre)) 
w + geom_point() +
  xlim(50,100) + 
  ylim(50,100)

#this doesn't work well w/ histograms
a <- ggplot(data = movies, aes(x = budgetInMillions)) 
a + geom_histogram(binwidth = 10, aes(fill = Genre, colour = "Black")) + 
  ylim(50,100)
a + geom_histogram(binwidth = 10, aes(fill = Genre, colour = "Black")) + 
  ylim(0,50)
#it zooms in but also cuts out data

#zoome w/ coord_cartesian, which adds a new layer to zoom in
a + geom_histogram(binwidth = 10, aes(fill = Genre, colour = "Black")) + 
  coord_cartesian(ylim = c(0,50))

b <- ggplot(movies, aes(x = criticRating, y = audienceRating, colour = Genre))
b + geom_point(aes(size = budgetInMillions)) +
  facet_grid(Genre~Year) + 
  geom_smooth() +
  coord_cartesian(ylim = c(0,100))
#most seem statistically insignificant, except for romantic in 2011, but as action seems to have similar ratings 
# from audience and critics, and in comedy always seems to be rated "okay" throughout the years, but have
# been steadily improving, while horror seems to have the widest variance in audience ratings, and drama used to 
# in 2007 and 2008, been has been sitting above 50 for the past 3 years, 
#Action - risky, comedy - play it safe

#themes
a <- ggplot(data = movies, aes(x = budgetInMillions)) 
b <- a + geom_histogram(binwidth = 10, aes(fill = Genre), colour = "Black")
b + xlab("Money") + 
  ylab("# of movies") + 
  ggtitle("Movie Budget Distribution") +
  theme(axis.title.x = element_text(colour = "DarkGreen", size = 30), #axis title
        axis.title.y = element_text(colour = "Red", size = 20),
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20),
        legend.title = element_text(size = 30),
        legend.text = element_text(size = 20),
        legend.position = c(1,1), #put in top right 
        legend.justification = c(1,1),  #anchor in top right of chart area -> (0,0 would be bottom left)
        plot.title = element_text(colour = "DarkRed", size = 40, ?family = 'Times New Roman'))
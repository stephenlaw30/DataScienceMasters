setwd("C:/Users/Nimz/Dropbox/NewLearn/UDEMY/R/RProgrammingAZ")
movies <- read.csv("Section6-Homework-Data.csv")
str(movies)
colnames(movies) <- c("releaseDayOfWeek","Director","Genre","Movie","releaseDate","Studio","adjustedGrossInMillions",
                      "budgetinMillions","grossInMillions","ratingIMDB","ratingMovieLens","overseasProfitInMillions",
                      "overseasProfitMargin","usProfitInMillions","usProfitMargin","runtimeInMinutes",
                      "usGrossInMillions","usGrossMargin")
str(movies)

library(ggplot2)
install.packages("extrafont")

library(extrafont)
font_import()


pl <- ggplot(data = movies, aes(x = Genre, y = usGrossMargin, colour = Studio, size = budgetinMillions))
pl + geom_boxplot()

summary(movies$Genre)
table(movies$Studio)

filteredGenres <- subset(movies, Genre %in% c("action","adventure","animation","comedy","drama"))
filteredMovies <- subset(filteredGenres, Studio %in% c("Buena Vista Studios","Fox","Paramount Pictures","Sony",
                                                    "Universal","WB"))
windowsFonts(Times=windowsFont("TT Times New Roman"))
pl <- ggplot(data = filteredMovies, aes(x = Genre, y = usGrossMargin))
pl + geom_jitter(aes(size = budgetinMillions, colour = Studio)) +
  geom_boxplot(alpha = 0.5) +
  ggtitle("Domestic Gross % by Genre") +
  theme(text = element_text(family = "Comic Sans MS"),
        axis.title.x = element_text(colour = "Blue", size = 30), #axis title
        axis.title.y = element_text(colour = "Blue", size = 30),
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20),
        legend.title = element_text(size = 30),
        legend.text = element_text(size = 20),
        plot.title = element_text(hjust = 0.5, size = 40))
  
minutesStudying <- c(30,45,180,95,130,140,30,80,60,110,0,80)
grade <- c(74,68,87,90,94,84,92,88,82,93,65,90)

df <- data.frame(cbind(minutesStudying,grade))

cor(df$minutesStudying,df$grade) #0.5967026 = 0.597

'proportion of variation in exam grade explained by taking minutes studying into account is (r**2) = (0.597**2) = 
0.356409 = 0.356 = 36%'

library(ggplot2)
ggplot(df) + geom_point(aes(x = minutesStudying, y = grade))

#high grade, not study long = 30,92

#remove and plot again

new.df <- df[!df$grade == 92,]

cor(new.df$minutesStudying,new.df$grade) #0.7374439 = 0.737

ggplot(new.df) + geom_point(aes(x = minutesStudying, y = grade))


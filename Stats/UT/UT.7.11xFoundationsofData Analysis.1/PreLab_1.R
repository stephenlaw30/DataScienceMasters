library(SDSFoundations)

bike <- BikeData

head(bike,10)

#age of 7th rider
bike$age[7]

#3 of first 10 riders ride daily

#speed of 1st female who cycles less than once per month = 8.1

#types of variables
str(bike)

#student = categorical
#cyc_freq = categorical
#distance = numerical

'How many of the cyclists in the data frame were students? How often do they ride? And what was the average distance that they rode?'
table(bike$student) #@15 students
table(bike$cyc_freq[bike$student == 1]) #8 ride daily, 6 couple time per week
mean(bike$distance[bike$student == 1]) #6.257857 miles 

student <- bike[bike$student == 1,]
nrow(student)
distance <- student$distance
mean(distance)

str(student)
str(distance)
library(SDSFoundations)

bike <- BikeData
'
1. Make a table to show how many daily riders are in the original dataset.
2. Create a new datafile that includes only the daily riders.
3. Make a table to show the number of male and female daily riders.
4. Make a vector of the ages of these daily riders.
5. Find the mean age for men and for women daily riders.'

daily <- bike[bike$cyc_freq == "Daily",]
str(daily)
table(daily$gender)
mean(daily$age)
mean(daily$age[daily$gender=="F"])
mean(daily$age[daily$gender=="M"])4

'Can you compare the average age of the male daily riders and the female daily riders?  (Hint: Can you subset the datafile again to
separate the males and the females?)'
males <- bike[bike$gender == "M",]
females <- bike[bike$gender == "F",]

'How would you create a datafile that only includes male daily riders that are age 30 or older?   '
olderMales <- males[males$age >= 30,]
dailyOlderMales <- olderMales[olderMales$cyc_freq == "Daily",]
dim(dailyOlderMales)
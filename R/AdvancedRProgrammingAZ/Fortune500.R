#setwd("C:/Users/Nimz/Dropbox/NewLearn/UDEMY/R/AdvancedRProgrammingAZ")
setwd("C:/Users/snewns/Dropbox/NewLearn/UDEMY/R/AdvancedRProgrammingAZ")

fortune <- read.csv("Future-500.csv")
str(fortune)
summary(fortune)

library(ggplot2)

pl <- ggplot(data = fortune, aes(x = Revenue, y = Expenses))
pl + geom_point()

fortune$Inception <- as.factor(fortune$Inception)
fortune$ID <- as.factor(fortune$ID)
summary(fortune)

#gsub(pattern, what to replace with, where to find) -> one instance
fortune$Expenses <- gsub(" Dollars","",fortune$Expenses)
fortune$Revenue <- gsub("\\$","",fortune$Revenue)
str(fortune)

fortune$Expenses <- gsub(",","",fortune$Expenses)
fortune$Revenue <- gsub(",","",fortune$Revenue)
str(fortune)

fortune$Expenses <- as.numeric(fortune$Expenses)
fortune$Revenue <- as.numeric(fortune$Revenue)
str(fortune)
summary(fortune)

fortune$Growth <- gsub("%","",fortune$Growth)
str(fortune)
fortune$Growth <- as.numeric(fortune$Growth)
str(fortune)

#get T/F is row has no NA's
complete.cases(fortune)

#get dataset of all records that have an NA somewhere
fortune[!complete.cases(fortune),]
#6 records

#reload data where all blank spaces are replaced w/ NA's via na.strings()
finance <- read.csv("Future-500.csv", na.strings = c(""))
head(finance, 25)
#See new NA values --> if surrounded by <>'s, then this is a factor

#repeat earlier cleanings
finance$Inception <- as.factor(finance$Inception)
finance$ID <- as.factor(finance$ID)
finance$Expenses <- gsub(" Dollars","",finance$Expenses)
finance$Revenue <- gsub("\\$","",finance$Revenue)
finance$Expenses <- gsub(",","",finance$Expenses)
finance$Revenue <- gsub(",","",finance$Revenue)
finance$Expenses <- as.numeric(finance$Expenses)
finance$Revenue <- as.numeric(finance$Revenue)
finance$Growth <- gsub("%","",finance$Growth)
finance$Growth <- as.numeric(finance$Growth)
str(finance)
head(finance, 25)

finance[!complete.cases(finance),]
finance[finance$Revenue == 9746272,]
#returns rows w/ NA in Revenue --> ignore w/ which()
finance[which(finance$Revenue == 9746272),]
#just 1 row, good

finance[is.na(finance$Expenses),]
#3 records --> need to perform imputation by median of JUST those in the same industry

finance[is.na(finance$Industry),]
#remove these 2 --> could research, but not for now

finance <- finance[!is.na(finance$Industry),]

#reset row #'s
#option 1: rownames(finance) <- 1:nrow(finance)
rownames(finance) <- NULL

finance[!complete.cases(finance),]
#we also have some missing states we can deduce what they are from the city
finance[is.na(finance$State),]
finance[is.na(finance$State) & finance$City == "San Francisco","State"] <- "CA"
#check
finance[c(82,265),]

finance[is.na(finance$State) & finance$City == "New York","State"] <- "NY"
#check
finance[c(11,377),]

finance[!complete.cases(finance),]
#now to do median imputation for the # of employees --> get median for # of employees in retail
median(finance[finance$Industry == "Retail","Employees"], na.rm = TRUE)
med_retail_employees <- median(finance[finance$Industry == "Retail","Employees"], na.rm = TRUE) 
#Add this to the missing row's col
finance[is.na(finance$Employee) & finance$Industry == "Retail","Employees"] <- med_retail_employees
#check
finance[3,]

#do for financial services
median(finance[finance$Industry == "Retail","Employees"], na.rm = TRUE)
med_financial_employees <- median(finance[finance$Industry == "Financial Services","Employees"], na.rm = TRUE) 
#Add this to the missing row's col
finance[is.na(finance$Employee) & finance$Industry == "Financial Services","Employees"] <- med_financial_employees
#check
finance[330,]

#now for growth
median(finance[finance$Industry == "Construction","Revenue"], na.rm = TRUE)
med_construction_rev <- median(finance[finance$Industry == "Construction","Revenue"], na.rm = TRUE) 
#Add this to the missing row's col
finance[is.na(finance$Revenue) & finance$Industry == "Construction","Revenue"] <- med_construction_rev
#check
finance[c(8,42),]

#now for expenses that DON'T HAVE PROFIT**********************
median(finance[finance$Industry == "Construction","Expenses"], na.rm = TRUE)
med_construction_exp <- median(finance[finance$Industry == "Construction","Expenses"], na.rm = TRUE) 
#Add this to the missing row's col
finance[is.na(finance$Expenses) & finance$Industry == "Construction" & is.na(finance$Profit)
        ,"Expenses"] <- med_construction_exp
#check
finance[c(8,42),]

finance[!complete.cases(finance),]
#can solve missing profits and Expenses via simple arithmetic
finance[is.na(finance$Profit),"Profit"] <- finance[is.na(finance$Profit),"Revenue"] - 
                                              finance[is.na(finance$Profit),"Expenses"]
#check
finance[c(8,42),]

finance[is.na(finance$Expenses),"Expenses"] <- finance[is.na(finance$Expenses),"Revenue"] - 
  finance[is.na(finance$Expenses),"Profit"]
#check
finance[15,]

#now try plots again
pl <- ggplot(data = finance, aes(x = Revenue, y = Expenses))
pl + geom_point()

pl2 <- ggplot(data = finance, aes(x = Revenue, y = Expenses, colour = Industry, size = Profit))
pl2 + geom_point()
'biggest bubbles have a large amount of revenue --> see bubbles get larger as they get lower down
  on the y-axis, and also as they get larger on the x-axis *(duh)
Also see the IT Services has the largest revenues and profits, and Financial Services has large
  profits and low expenses, and also construction and software has some lower revenue'

pl3 <- ggplot(data = finance, aes(x = Revenue, y = Expenses, 
                                colour = Industry))
pl3 + geom_point() +
  geom_smooth(fill = NA, size=1.2)
'See that Construction profits are decreasing, as more revenue = more expenses, with the same happening to Financial Services
  to an extent, while as revenue increases for other industries, expenses tend to
  decrease, showing an increase in profit
Expenses start to decrease around $10M'

#boxplot
pl4 <- ggplot(data = finance, aes(x = Industry, y = Growth, colour = Industry))
pl4 + geom_jitter() + 
  geom_boxplot(size = 1, alpha = 0.5,
               outlier.color = NA) #outlier.color = NA b/c outliers are duplicated w/ jitter
  

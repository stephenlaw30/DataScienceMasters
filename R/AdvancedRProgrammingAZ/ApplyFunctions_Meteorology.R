setwd("C:/Users/Nimz/Dropbox/DataScienceMasters/R/AdvancedRProgrammingAZ/Weather Data")

'Need:

* table with annual averages of each observed metric for every city
* table showing how much temperatures fluctuate each month from min to max %, with min temperature as the base
* table showing annual minimums of each observed metric for every city
* table showing annual maximums of each observed metric for every city
* table showing in which months the annual maximimums of each metric were observed in every city'

chicago_cel <- read.csv("Chicago-C.csv", row.names = 1) #takes row names from 1st col in CSV
chicago_far <- read.csv("Chicago-F.csv", row.names = 1)
str(chicago_far)

newYork_cel <- read.csv("NewYork-C.csv", row.names = 1)
newYork_far <- read.csv("NewYork-F.csv", row.names = 1)

houston_cel <- read.csv("Houston-C.csv", row.names = 1)
houston_far <- read.csv("Houston-F.csv", row.names = 1)

sanFran_cel <- read.csv("SanFrancisco-C.csv", row.names = 1)
sanFran_far <- read.csv("SanFrancisco-F.csv", row.names = 1)

#Chi, Hour, SF measured from 1980-2010, NY from 1960-1990, so all 30-yr periods

#convert data frames to matrix
chicago_far <- as.matrix(chicago_far)
newYork_far <- as.matrix(newYork_far)
houston_far <- as.matrix(houston_far)
sanFran_far <- as.matrix(sanFran_far)

#put all matrices into a list
weather <- list(chicago_far, newYork_far, houston_far, sanFran_far)
weather

#give list indices proper names
weather <- list(chicago = chicago_far, newYork = newYork_far, houston = houston_far, sanFran = sanFran_far)

#access houston as part/subset of the list
weather[3]

#access houston matrix component only, not the list part
weather[[3]]
# OR
weather$houston

#get mean of rows in Houston
apply(weather$houston, 1, mean)

#get max of rows in Houston
apply(weather$houston, 1, max)

#get mean of cols in Houston
apply(weather$houston, 2, mean)

#get mean of cols in Houston
apply(weather$houston, 2, max)

#apply - to use on matrix rows or cols
#tapply - to use on a vector to extract subgroups and apply function to them
#by  - same concept as GROUP BY in SQL, for data frames
#eapply - use on an environment
#lapply - to apply function to all elements of a list
#sapply - version of lapply to simplify results so that it's not presented as a list and as a vector or matric
#vapply - pre-specified return values (V)
#replicate - run a function severalt imes, usually used with generation of random variables
#mapply - multivariate version of sapply so arguments can be recycled
#rapply - recursive version of lapply

#1) table with annual averages of each observed metric for every city
apply(weather$chicago, 1, mean)
apply(weather$newYork, 1, mean)
apply(weather$houston, 1, mean)
apply(weather$sanFran, 1, mean)

#same as above w/ loops
output <- NULL
for (i in 1:5){
  output[i] <- mean(chicago_far[i,])
}
output
names(output) <- rownames(chicago_far)
output

#almost anything we can make with a loop can be made with a function from the apply family

#***************lapply - returns list from a list or vector***************

#transport Chicago rows + cols w/ transpose function t()
t(chicago_far)

#tranpose all matrices in weather
lapply(weather, t)

#ex 2
rbind(chicago_far, newRow = 1:12)

#list, function, optional parameter
lapply(weather, rbind, newRow = 1:12)

#ex 3 - get list of names vectors for each city with means of the rows for each city
lapply(weather, rowMeans)

#combine lapply w/ []
weather[[1]][1,1]
weather$chicago[1,1]

#extract avg high temp in jan for all cities
lapply(weather, "[", 1, 1)
#by default, lapply iterates over all components of "weather", so it goes weather[[1]], weather[[2]], weather[[3]]....
#our "[" function would be the *second* set of []'s --> [1,1], and we pass in 1,1 as optional parameters  

#get 1st row for each city
lapply(weather, "[", 1,)

#get just march data
lapply(weather, "[", , 3)

#apply/add own functions
lapply(weather, function(x) x[1,]) #extract component x from weather + apply custom function to component to get 1st row from matrix
lapply(weather, function(x) x[,1]) #extract component x from weather + apply custom function to component to get Jan col from matrix
lapply(weather, function(x) x[5,]) #extract component x from weather + apply custom function to component to get 5th row from matrix
lapply(weather, function(x) x[,12]) #extract component x from weather + apply custom function to component to get Dec col from matrix
lapply(weather, function(x) x[,1]) #extract component x from weather + apply custom function to component to get Jan col from matrix

#get avg high temp and subtract avg low temp
lapply(weather, function(z) z[1,] - z[2,])

#get relative change in temp
lapply(weather, function(z) round((z[1,] - z[2,])/z[2,],4)*100)

#see chicago fluctuates almost 78% from avg. high to avg. low temps in January throughout the 30 years

#sapply is a simplified lapply that returns a vector or a matrix (wrapper of lapply)
sapply(weather, function(z) z[1,] - z[2,])
sapply(weather, function(z) round((z[1,] - z[2,])/z[2,],4)*100)

#see we get a matrices

#get avg. high temp for july
lapply(weather, function(z) z[1,7]) #lapply(weather, "[", 1, 7)
sapply(weather, function(z) z[1,7]) #sapply(weather, "[", 1, 7)

#get a named vector from sapply

#get avg. high temp for q4
lapply(weather, function(z) z[1,10:12]) 
sapply(weather, function(z) z[1,10:12])

deliverable1 <- round(sapply(weather, rowMeans),2)  #<-- DELIVERABLE 1
deliverable2 <- sapply(weather, function(z) round((z[1,] - z[2,])/z[2,],4)*100) #<-- DELIVERABLE 2

#nesting apply functions
# no functions to get max or min of every single row like rowSum or rowCols

#get max of each row for chicago
apply(chicago_far, 1, max)

#now get for each list element (matrix)
sapply(weather, function(z) apply(z,1,max)) #<- deliverable 4
#get min
sapply(weather, function(z) apply(z,1,min)) #<-- deliverable 3

#deliverable 5 --> table showing in which months the annual maximimums of each metric were observed in every city

'APPLY the which max to each ROW (1) in a matrix and apply this to each element in the list
* To each component of weather, z, and then to each ROW of z, x, we apply the which.max function to get the row index, and then return
that rows name'

sapply(weather, function(z) apply(z, 1, function(x) names(which.max(x)))) #<-- deliverable 5









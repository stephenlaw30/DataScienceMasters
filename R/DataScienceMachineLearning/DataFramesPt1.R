#*************BASICS***************#

#think of DF's as an Excel spreadsheet w/ row + col names
state.x77
USPersonalExpenditure
women

#see all built-in data sets
data()
WorldPhones

#see top + bottom of DF
head(state.x77)
tail(state.x77)

#get structure (+ data it contains) + summary (for each col in DF)
str(state.x77)
summary(state.x77)

#create own from w/ vectors
days <- c('M', 'T', 'W', 'H', 'F')
temp <- c(22.2,21,23,24.3,25)
rain <- c(T,T,F,F,T)
df1 <- data.frame(days,temp,rain)
str(df1)
summary(df1)

#**************SELECTION + INDEXING**************
#df[row,col]
df1[1,]
df1[,1]

#get all values from rain col
df1['rain'] #index = 3

#get 1st 5 values of 2 cols
df1[1:5,c('days','temp')]

#grab all values of a col
df1$days
df1$temp
df1$rain

#***DIFFERENCE --> bracket notation = returned in DF form, $ = vector form

#get subset of DF based on condition
subset(df1,subset=rain==TRUE)
subset(df1,subset=temp>23)

#sort order of DF on a col
sorted.temp <- order(df1['temp'])
#returns INDEX #'s of the records, NOT the values
#get the values based on the sorted indexes
df1[sorted.temp,]

#DESC
desc.temp <- order(-df1['temp'])
df1[desc.temp,]

#*************OVERVIEW OF DF OPERATIONS**************
#DF = workhorse of R
empty <- data.frame() #empty vector
c1 <- 1:10
c2 <- letters[1:10]

#data.frame(column names arg = col data)
df <- data.frame(col.name.1=c1,col.name.2=c2) 

d2 <- read.csv('somefile.csv')
setwd('C:\\Users\\snewns\\Dropbox\\NEW LEARN\\UDEMY\\R\\DataScienceMachineLearning')
write.csv(df,file='saved_df.csv')
df2 <- read.csv('saved_df.csv')
#notice that the index from the 1st DF is saved into the CSV as a col, x
  #can drop it or keep it

#how many rows + cols + what names?
nrow(df)
ncol(df)
colnames(df)
rownames(df)
str(df)
summary(df)

#reference a single cell in a df
df[[5,2]] #row 5 col 2
df[[5,'col.name.2']]

#use this to reassign cell values
df[[2,'col.name.1']] <- 9999

#to return a row, use single brackets
df[1,]

#return a col
head(mtcars)
mtcars$mpg
mtcars[,'mpg']
mtcars[,1]
mtcars[['mpg']] #2 sets of brackets returns a vector

#single bracket returns a data frame
mtcars['mpg']
mtcars[1]

#get 2 cols back as a dataframe
head(mtcars[c('mpg','cyl')])
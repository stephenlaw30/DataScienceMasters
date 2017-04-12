Section2Notes_RMatrices

#1:10
v <- 1:10
#matrix(v)
matrix(v,nrow=2) #specify # of rows

matrix(1:12,byrow=FALSE,nrow=4) #fill in matrix by COLS w/ 4 rows
matrix(1:12,byrow=T,nrow=4) #fill in matrix by Rows w/ 4 rows

goog <- c(450,451,452,445,468)
msft <- c(230,231,232,233,220)

stocks <- c(goog,msft) #combine 2 vectors into a single vector
print(stocks)
#put that vector into a matrix by row (Google = 1st row, MS = 2nd)
stocks.matrix <- matrix(stocks,byrow=T,nrow=2) 
print(stocks.matrix)
#name the rows + cols
days <- c('m', 't', 'w', 'h', 'f')
stock.names <- c('GOOG','MSFT')
colnames(stocks.matrix) <- days
rownames(stocks.matrix) <- stock.names
print(stocks.matrix)

#*****MATRIX ARITHMETIC***********
mat <- matrix(1:25,byrow=T,nrow=5)
mat * 2 #multiply each element by 2 (same w/ divide, exponent)
1/mat #reciprical of every element in matrix
mat > 15 #everywhere where matrix element > 15
mat[mat>15] #return vector of every value > 15
mat + mat
mat/mat
#This isn't TRUE Matrix multiplication --> need % signs
mat %*% mat

#**********MATRIX OPERATIONS*********
#sum the cols together
colSums(stocks.matrix)
rowSums(stocks.matrix)
rowMeans(stocks.matrix) #avg. stock price for the week
colMeans(stocks.matrix) #avg. stock price of both for the wk

#new stock for Facebook
FB <- c(111,112,113,120,145)
#add it to matrix into a new tech stock matrix
tech.stocks <- rbind(stocks.matrix,FB)
avg <- rowMeans(tech.stocks) #wkly avg of all stocks
#add averages in new col
tech.stocks <- cbind(tech.stocks,avg)

#**********MATRIX SELECTION + INDEXING*********
mat2 <- matrix(1:50,byrow=T,nrow=5) #5X10 Matrix
mat2[1,] #grab 1st row
mat2[,1] #grab 1st col
mat2[1:3,] #grab 1st 3 rows
mat2[1:2,1:3] #grab 1st 2 row + 1st 3 cols (top-left rectangle)
mat2[,9:10]
mat2[2:3,5:6]

#**********FACTOR AND CATEGORICAL MATRICES*********
animal <- c('d','c','d','c','c')
id <- c(1,2,3,4,5)
factor(animal) #get the levels of the vector = CATEGORIES
categ.animals <- factor(animal)
#NOMINAL categorical var = NO ORDER (dogs vs cats)
#ORDINAL categorical var = HAS AN ORDER (temperature)
ord.cat <- c('cold','warm','hot') #example of ordinal cat var
#can pass in levels arg to make an order
temps <- c('cold','warm','hot','hot','hot','cold','warm')
fact.temp <- factor(temps,ordered=T,levels=c('cold','warm','hot'))
summary(fact.temp) #count of each level/order
summary(temps)



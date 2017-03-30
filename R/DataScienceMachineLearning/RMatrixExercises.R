#Ex 1: Create 2 vectors, where A is (1,2,3) + B is (4,5,6). 
#With these, use cbind() or rbind() to create a 2X3 matrix from them
a <- c(1,2,3)
b <- c(4,5,6)
new <- rbind(a,b)
new

#2 - create 3X3 matrix, mat, using 1:9 + specifying nrow 
mat <- matrix(1:9,nrow=3)
mat

#3 confirm mat is a matrix
is.matrix(mat)

#4 create 5X5 from 1:25 in mat2 w/ top row = 1:5
mat2 <- matrix(1:25,byrow=T,nrow=5)

#5 grab subsection of mat2 for 7-8/12,13
mat2[2:3,2:3]

#6 grab subsection of mat2 for 19,20/24,45
mat2[4:5,4:5]

#7 sum all elements in mat2
sum(mat2)

#use runif() to create a 4X5 of 20 random #'s
help(runif)
matrix(runif(20),nrow=4)
  
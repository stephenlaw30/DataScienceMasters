install.packages("arules")
install.packages("arulesViz")
install.packages("bitops")
install.packages("ca")
install.packages("caTools")
install.packages("e1071")
install.packages("MASS")
install.packages("rgl")
install.packages("RODBC")
install.packages("tree")
install.packages("rpart")
install.packages("XML")
install.packages("rJava")
install.packages("RJDBC")
install.packages("DBI")

# see all objects saved so far
x <- c(1,6,2)
y <- c(1,4,3)
ls()

# create 2x2 matrix of #'s filled in by col 1st
matrix(c(1,2,3,4), nrow = 2, ncol = 2)

# create 2x2 matrix of #'s filled in by row 1st
(x <- matrix(c(1,2,3,4), nrow = 2, ncol = 2, byrow = T))

sqrt(x)

# generate random values from normal distribution
x <- rnorm(50) # default mean = 0, SD = 1
y <- x + rnorm(50,mean=50,sd=.1)

# check correlation coefficient R
cor(x,y)

set.seed(123)
y <- rnorm(100)
mean(y)
var(y)

# calculate SD
sqrt(var(y))
sd(y)

# basic plot
x <- rnorm(100)
y <- rnorm(100)
plot(x,y,xlab="this is the x-axis",ylab="this is the y-axis",main="plot of x and y")

# save to pdf
pdf("figure.pdf")
jpeg("figure.jpeg")

# signal to R that we're done w/ the plot
dev.off()

# sequence
x <- seq(-pi,pi,length = 50) # equally spaced

# contour plot to plot 3D data
y <- x
z <- outer(x,y,function(x,y)cos(y)/(1+x^2))
contour(x,y,z)

?contour

contour(x,y,z, nlevels = 45, add = T) 

za <- (z - t(z))/2 # matrix z minus transpose of matrix z, halved
contour(x,y,za, nlevels = 15)

# image produces color-coded plot whose colors depend on z values = HEATMAP
image(x,y,za)

# persp() produces 3D plots w/ args = theta + phi to control angles at which plot is viewed
persp(x,y,za)
persp(x,y,za, theta = 30)
persp(x,y,za, theta = 30, phi = 20)
persp(x,y,za, theta = 30, phi = 70)
persp(x,y,za, theta = 30, phi = 40)

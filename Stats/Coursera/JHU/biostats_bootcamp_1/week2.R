library(rgl)
library(mvtnorm)

# matrix entered col-wise
sigma <- matrix(c(8,.25*8,.25*8,8),2,2)

xvals <- seq(-10,10,length=100)
yvals <- seq(-10,10,length=100)
# expand.grid = create df from all combos of supplied vectors/factors
zvals <- apply(expand.grid(xvals,yvals), 1, 
               ## function to create density function + a random # generator for given matrix
                  # dmvnorm = provides density function + a random # generator for the 
                  #   multivariate normal distribution w/ mean = mean arg + covariance matrix sigma
               function(w) dmvnorm(w, mean=c(0,0), sigma=sigma))

# from rgl --> draw plots of surfaces + planes in a 3D space
persp3d(xvals,yvals,zvals, col="lightblue")
planes3d(0,1,0,-5, col=grey(.8))
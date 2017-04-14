'Problem Set 6.3: Yellowstone

Yellowstone National Park began a project to restore its native wolf population in the mid 90s. Below are the number 
of wolves soon after the start of the project:
  
Year	  Years since Project Began	  Number of Wolves
1996	  1	                          25
1998	  3	                          45

Researchers fit a linear model to the wolf data. Using this model, 10 wolves were being added to the park each year.
According to their linear model, the size of the original wolf population when the project began was 15. Another 
researcher assumed that the wolves would experience exponential growth because there were no predators. He fit an
exponential model to this data, and the growth factor for this model is 1.34164 and the annual growth rate of these 
wolves each year, according to this model, is 0.34164, or 34%. Assuming exponential growth, the initial number of
wolves when the project began is 18.6339.'

years <- c(1996,1998)
yearsSinceStart <- c(1,3)
wolves <- c(25,45)

wolf <- as.data.frame(cbind(years,yearsSinceStart,wolves))

expFit(wolf$yearsSinceStart,wolf$wolves) 
' a =  18.6339 
 b =  1.34164 = growth factor --> 1 - 1.34164 = 0.34164 = growth rate
R-squared =  1

By 2002, there were 147 wolves in Yellowstone. '
#linear
15 + 10*7 #=85

#exponential
18.6339*(1.34164)^7 #= 145.7994

'The exponential model is determined to fit the data better. Using the best-fitting exponential model, 9.7 years must 
pass before there are more than 325 wolves in Yellowstone.
  * 325 = 18.6339*(1.34164)^t --> 325/18.6339 = (1.34164)^t --> log(325/18.6339) = t*log(1.34164) -->
    log(325/18.6339)/log(1.34164) = t = 9.727503'
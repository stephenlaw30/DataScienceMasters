#make vector
temps <- c(71, 72, 68, 73, 69, 75, 76)
#add names to vector
names(temps) <- c('M', 'T', 'W', 'H', 'F', 'A', 'U')
#temps
  #M  T  W  H  F  A  U 
  #71 72 68 73 69 75 76 

stock.prices <- c(23, 27, 23, 21, 34)
wkday <- c("Mon", "Tue", "Wed", "Thu", "Fri")
names(stock.prices) <- wkday
#stock.prices
  #Mon Tue Wed Thu Fri 
  #23  27  23  21  34 
mean(stock.prices)
over.23 <- stock.prices > 23
#over.23
  #Mon   Tue   Wed   Thu   Fri 
  #FALSE  TRUE FALSE FALSE  TRUE 
stock.prices[over.23]
  #Tue Fri 
  #27  34 

max.price <- stock.prices == max(stock.prices)
stock.prices[max.price]
  #Fri 
  #34 
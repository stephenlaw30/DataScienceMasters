mu <- 74
sd <- 13
n <- 36 #large enough to have normal distribution from a sample

stdErr <- sd/sqrt(n)

zScore <- (77-mu)/stdErr

marginOfErr <- zScore*stdErr
marginOfErr <- 1.38*2.17


lowerCI <- 74 - marginOfErr  
upperCI <-  74 + marginOfErr

#CI of sample mean = 77
77-(1.96*(stdErr))
77+(1.96*(stdErr))

'This 95% Ci gives results consistent w/ the earlier z-score, as it shows that the population mean from which the sample 
was drawn could be 74 (w/in 72 and 81) + similarly, the z-score of the sample mean places it clearly w/in the expected 
sample mean values for a known population mean of 74.'


data<- c(180, 200, 190,	230,	80,	160, 170, 130,	140, 220, 110, 120,	100, 170)
mu <- mean(data)
sd <- 48.5
n <- length(data)
se <- sd/sqrt(n)
zscore <- (mu)/se
marginOfErr95 <- 1.96*se
mu-marginOfErr95
mu+marginOfErr95
#FDA average caloric content of vanilla yogurt = 150 calories + this CI supports this claim

#generate vector of 10000 draws of cards and assign values to each
cards = integer(10000)
values = integer(10000)

for (i in 1:length(cards)) {
  cards[i] <- sample(1:13,1,replace=T)
  
  #assign values
  if(cards[i] <= 10) {
    values[i] <- cards[i]
  } else {
    values[i] <- 10
  }
}

values <- as.vector(read.csv('values.csv')[,2])
samples <- as.vector(read.csv('samples.csv')[,2])

#plot histogram w/ mean and median
library(ggplot2)
ggplot() + 
  aes(x=values) + 
  geom_histogram(binwidth = 1, boundary = 2, color = 'white', aes(fill = ..count..)) +
  geom_vline(aes(xintercept=mean(values)),
             color="blue", linetype="dashed", size=1) + 
  geom_vline(aes(xintercept=median(values)),
             color="red", linetype="dashed", size=1)

#sum sample values
samples = integer(10000)

for (i in 1:length(samples)) {
  
  cardVector <- c(sample(1:13,3,replace=F))
  #print(cardVector)}
  for (j in 1:length(cardVector)) {
    if(cardVector[j] <= 10) {
      cardVector[j] <- cardVector[j]
    } else {
      cardVector[j] <- 10
    }
  }
  samples[i] <- sum(cardVector)
}

summary(samples)
sd(samples)

write.csv(values,'values.csv')
write.csv(samples,'samples.csv')

library(ggplot2)
ggplot() + 
  aes(x=samples) + 
  geom_histogram(binwidth = 1, boundary = 1, color = 'white', aes(fill = ..count..)) +
  geom_vline(aes(xintercept=mean(samples)),
             color="blue", linetype="dashed", size=1) + 
  geom_vline(aes(xintercept=median(samples)),
             color="red", linetype="dashed", size=1)

'Within what range will you expect approximately 90% of your draw values to fall? '
# z-table = 1.28
# z = obs - mean(samples) / sd(samples)
# 90% between 5% and 95% --> -1.645 and 1.645

#(-1.645*sd(values)) + mean(values)
#(1.645*sd(values)) + mean(values)
#90% of draw values to fall between 1.326022 and 27.89599

(-1.645*sd(samples)) + mean(samples)
(1.645*sd(samples)) + mean(samples)
#90% of sample sum values to fall between 11.45121 and 27.79472

'What is the approximate probability that you will get a draw value of at least 20?'
# z = obs - mean(samples) / sd(samples)
(20 - mean(samples)) / sd(samples)
#z = 0.06530069 --> .7764 = 77.64% at most 20 --> 1 - .7764 = 0.2236 = 22.36% at least 20
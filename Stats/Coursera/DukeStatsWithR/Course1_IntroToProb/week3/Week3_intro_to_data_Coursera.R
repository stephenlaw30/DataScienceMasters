'********************************Hot Hands********************************

Basketball players who make several baskets in succession are described as having a *hot hand*. 
Fans and players have long believed in the hot hand phenomenon, which refutes the assumption that 
each shot is independent of the next. However, a 1985 paper collected evidence that contradicted 
this belief and showed that successive shots are independent events. This paper started a great 
controversy that continues to this day, as you can see by Googling *hot hand basketball*.

Goals for this lab:
  (1) to think about the effects of independent and dependent events
  (2) to learn how to simulate shooting streaks in R
  (3) to compare a simulation to actual data in order to determine if the hot hand phenomenon 
        appears to be real.'

library(statsr)
library(dplyr)
library(ggplot2)

### Data
'Our investigation will focus on the performance of 1 player: Kobe Bryant, against the Orlando Magic
in the 2009 NBA finals where he earned MVP and many spectators commented on how he appeared to show 
a hot hand'

data(kobe_basket)
glimpse(kobe_basket)
head(kobe_basket)
# 133 rows (shots), 6 variables

'Just looking at strings of hits + misses, it can be difficult to gauge whether or not it seems like
Kobe was shooting with a hot hand. 1 way we can approach this is by considering the belief that hot 
hand shooters tend to go on shooting streaks = # of consecutive baskets made until a miss occurs.

For example, in Game 1 Kobe had the following sequence of hits and misses from 
his 9 shot attempts in the 1st quarter: H M | M | H H M | M | M | M

Within the 9 shot attempts, there are 6 streaks separated by a "|" w/ lengths = 1,0,2,0,0,0'

## A streak length of 1 means one \_\_\_ followed by one miss.
# hit

## A streak length of 0 means one \_\_\_ which must occur after a miss that ended the preceeding streak.
# miss

'Counting streak lengths manually for all 133 shots would get tedious, so use the custom function
calc_streak() to calculate them + store the results in a data frame `kobe_streak` as `length`'

kobe_streak <- calc_streak(kobe_basket$shot)

# look at the distribution of these streak lengths
ggplot(kobe_streak) + 
  geom_histogram(aes(length), binwidth = 1)

IQR(kobe_streak$length)
summary(kobe_streak)

# distribution of Kobe's streaks is unimodal and right skewed
# typical length of a streak is 0 since the median of the distribution is at 0
# IQR of the distribution is 1. 
# longest streak of baskets = 4, shortest = 0
  
## Compared to What?
'We`ve shown that Kobe had some long shooting streaks, but are they long enough to support the
belief that he had hot hands? What can we compare them to?

Return to the idea of *independence*. 2 processes = independent if the outcome of 1 process doesn`t 
effect the outcome of the 2nd 

If each shot a player takes = an independent process, having made/missed a 1st shot will not affect 
the probability that you make/miss your 2nd shot.

A shooter with a hot hand will have shots that are *NOT* independent of one another. Specifically, if the 
shooter makes his 1st shot, the hot hand model says he will have a *higher* probability of making his 2nd shot.

Suppose for a moment that the hot hand model IS valid for Kobe. During his career, the % of time Kobe makes 
a basket = ~45%, or in probability notation, P(shot 1 = H) = 0.45

If he makes the 1st shot and has a hot hand (*NOT* independent shots), the probability he makes his 2nd shot 
should go up to, let`s say, 60% = P(shot 2 = H | shot 1 = H) = .6

As a result of these increased probabilites, you`d expect Kobe to have longer streaks. Compare this to the 
skeptical perspective where Kobe does *not* have a hot hand, where each shot is independent of the next. If he 
hit his 1st shot, the probability that he makes the 2nd is still 0.45 = P(shot 2 = H | shot 1 = H) = .45

In other words, making the 1st shot did nothing to effect the probability he`d make his 2nd shot. If Kobe`s shots
ARE independent, he`d have the same probability of hitting every shot regardless of his past shots: 45%.

How do we tell if Kobe`s shooting streaks are long enough to indicate that he has hot hands? *We can compare his streak 
lengths to someone without hot hands: an independent shooter*

## Simulations in R

While we don`t have any data from a shooter we know to have independent shots, that sort of data is very easy to 
simulate in R. In a SIMULATION, you set the GROUND RULES of a RANDOM PROCESS + then the CPU uses random numbers to 
generate an outcome that adheres to those rules. As a simple example, you can simulate flipping a fair coin w/:'

coin_outcomes <- c("heads", "tails")
sample(coin_outcomes, size = 1, replace = TRUE)

'A vector `coin_outcomes` can be thought of as a hat w/ 2 slips of paper in it: `heads` or `tails` 
sample() draws 1 slip from the hat and tells us if it was a head or a tail. 

Adjust size argument to governs how many samples to draw + `replace = TRUE` indicates we put the slip of paper back 
in the hat before drawing again)'

sim_fair_coin <- sample(coin_outcomes, 100, TRUE)
table(sim_fair_coin)

'Since there are only 2 elements in `outcomes`, the probability we "flip" a coin + it lands heads = 0.5. 
If trying to simulate an unfair coin that only lands heads 20% of the time, adjust for this by adding an argument 
called `prob`, which provides a vector of 2 probability weights.'

# P(H) = .2, P(T) = .8
sim_fair_coin <- sample(coin_outcomes, 100, TRUE, c(.2,.8))
table(sim_fair_coin)

'In a sense, we`ve shrunken the size of the slip of `heads` paper making it less likely to be drawn + increased the 
size of the slip of `tails` paper, making it more likely to be drawn. 

When we simulated the fair coin, both slips of paper were the same size (default if prob is unspecified)'

## Simulating the Independent Shooter

## simulate a single shot from an independent shooter with shooting % of 50%

shot_outcomes <- c("H", "M")
independent_shooter <- sample(shot_outcomes, 1, TRUE)

# To make a valid comparison between Kobe and our simulated independent shooter, align both their shooting % + 
# the number of attempted shots over 133 sample shots

sim_basket <- sample(shot_outcomes, 133, TRUE, c(.45,.55))

'W/ the results of the simulation saved, we have the data necessary to compare Kobe to our independent shooter.

Both data sets represent the results of 133 shot attempts, each w/ the same shooting % of 45% + we know our simulated
data is from a shooter has independent shots. (does not have a hot hand)'

### Comparing Kobe Bryant to the Independent Shooter

sim_streak <- calc_streak(sim_basket)

# plot distribution of simulated streak lengths of the independent shooter. 
ggplot(sim_streak) + 
  geom_histogram(aes(length), binwidth = 1)
summary(sim_streak)

# similar to Kobe in shape, lower median, same IQR, same min, larger max

'If you were to run the simulation of the independent shooter a 2nd time, we`d expect its streak distribution to 
be somewhat similar to the distribution from 1st

Kobe`s distribution looks very similar. Therefore, there doesn`t appear to be evidence for Kobe`s hot hand.
# dependent/paired samples
m.d <- 3.56
s.d <- 4.19
n <- 9

se.d <- s.d/sqrt(9)

t <- (m.d - 0)/se.d

t.crit <- 2.036

t < -t.crit | t > t.crit


rat.x1 <- 78
rat.s1 <- 12.56
rat.n1 <- 10
rat.x2 <- 66
rat.s2 <- 12.04
rat.n2 <- 16

rat.se <- sqrt((rat.s1^2)/rat.n1 + (rat.s2^2)/rat.n2)

rat.t <- (rat.x1 - rat.x2)/rat.se


gum <- c(79,95,85,82)
noGum <- c(80,94,87,84)
diff <- gum - noGum
n <- 4

x.d <- mean(diff)

stdDevOfDifferences <- sd(diff)

se <- stdDevOfDifferences/sqrt(n)

t <- (x.d - 0)/se
t.crit <- 2.036

t < -t.crit | t > t.crit # chewing gum did not result in acc decrease
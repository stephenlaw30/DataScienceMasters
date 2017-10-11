# Calculate probability of absolute value of Z > 2
(pnorm(2,0,lower.tail = F)*2) # only 1-sided hypothesis

# probability of absolute value of t w/ 50 dF freedom > 2
pt(2, 50, lower.tail = F)*2

# lower dF
pt(2, 10, lower.tail = F)*2

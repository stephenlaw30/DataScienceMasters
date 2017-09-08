setwd('C:/Users/NEWNSS/Dropbox/DataScienceMasters/Stats/LSR/sample-master')
load('zeppo.Rdata')
grades
mean(grades)
#higher than class average of 67.5

x_bar <- mean(grades)

sig_true <- 9.5
mu_null <- 6.75

n = length(grades)
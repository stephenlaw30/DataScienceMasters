'Here is a list of 10 data values sorted from smallest to largest, but 5 data values are missing.  The missing values
are represented by A, B, C, D, and E.

2     A     3     B     6     C     9     D     15     E

Using the statistics below, find the missing values for the data set.  

Mean = 8     Median = 6.5     Mode = 2     Range = 16     IQR = 10

Hint:  You should not start by using the mean; save that for the end.'

known <- 2+3+6+9+15
total <- 8*10
unknown <- total - known

'2 appears at least once since it is the mode, and since we are sorted it must be between the given 2 and given 3, so
A = 2. And range is the max - min, so min = 2 and range = 16, so max = 18, so E = 18. Then, since the Median is 6.5, 
and would be between the 5th value, 6, and the 6th value, C, so C = 7.

Then the quartile 1 would be 
25% of the way through the range, which is between values 2 and 3, which is 2.5. So, with the IQR being 10, we know 
that quartile 3 = IQR + quartile 1, which is 10 + 2.5 = 12.5. This is then between the 7th and 8th value (75%), so we
have (9 + D) / 2 = 12.5, which gives 9 + D = 25, which gives
between the median and the max and the median and the min, which give (6.5 + 2)/2 = 4.25 and 

2     2     3     B     6     C     9     D     15     18'

known <- 2+2+3+6+7+9+15+18
unknown <- total - known

'test w/ 4
2     2     3     4     6     7     9     D     15     18'
known1 <- 2+2+3+6+7+9+15+18+4
unknown1 <- total - known1
(2+2+3+4+6+7+9+14+15+18)/10
values1 <- c(2,2,3,4,6,7,9,14,15,18)
fivenum(values1)
mean(values1)

'test w/ 5
2     2     3     5     6     7     9     D     15     18'
known2 <- 2+2+3+5+6+7+9+15+18
unknown2 <- total - known2
(2+2+3+4+6+7+9+13+15+18)/10
values2 <- c(2,2,3,5,6,7,9,13,15,18)
fivenum(values2)
mean(values2)


valuesInc <- values2+2
summary(valuesInc)

valuesDBl <- values2*2
summary(valuesDBl)

'If each value in the dataset were increased by 2, the Mean, Median, and Mode would change, and if each value in the 
dataset were multiplied by 2, then Range, IQR, Mean, Median, and Mode would change.'
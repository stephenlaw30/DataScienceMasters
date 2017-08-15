## Given an array, X, of N integers and an array, W, representing the respective weights of X's elements, calculate and print the weighted mean of X's elements.
# weighted mean = sum of (x*w) / sum of w 

## Answer should be rounded to a scale of  1decimal place (i.e. 12.3 format).

## Input Format
#	The first line contains an integer, N, denoting the number of elements in arrays X and W. 
#	The second line contains N space-separated integers describing the respective elements of array X. 
#	The third line contains N space-separated integers describing the respective elements of array W.

## Constraints
# 5 <= N <= 50
# 0 < Xi <= 100, where Xi is the ith element of array X.
# 0 < Wi <- 100, where wi is the ith element of array W.

##Output Format
# Print the weighted mean on a new line. Your answer should be rounded to a scale of 1 decimal place (i.e. 12.3 format).

# Get inputs
n = int(input())
x = input()
w = input()

# convert input to INT's
x = [int(x) for x in x.split()] 
w = [int(x) for x in w.split()]

# initiate variable for weighted mean numerator
num = 0;

# sum up list 'w' for weighted mean denominator
den = sum(w);

# sum of element-wise list multiplication
for i in range(0,len(x)):
    num += x[i]*w[i]

# calculate weighted mean
mean_weighted = num/den

print(mean_weighted)




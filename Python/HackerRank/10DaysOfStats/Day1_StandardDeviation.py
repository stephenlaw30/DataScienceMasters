## Given an array, X, of N integers, calculate and print the standard deviation. 
## Answer should be rounded to a scale of  1decimal place (i.e. 12.3 format)
## Error Margin of +/- 0.1 will be tolerated

## Input Format
#	The first line contains an integer, N, denoting the number of elements in array X 
#	The second line contains N space-separated integers describing the respective elements of array X. 

## Constraints
# 5 <= N <= 100
# 0 < Xi <= 10**5, where Xi is the ith element of array X.

##Output Format
# Print the standard deviation on a new line. Your answer should be rounded to a scale of 1 decimal place (i.e. 12.3 format).

# Get inputs
n = int(input());
x = input();

# convert input to INT's
x = [int(x) for x in x.split()];

# get mean of array
mean_num = 0;
for i in range(0,n):
    mean_num += x[i]
	
u = mean_num / n

# initiate variables for calculation
num = 0;
den = n;

# sum of squared variances 
for i in range(0,n):
    num += (x[i] - u)**2

# calculate standard deviation via square roor (**0.5) with rounding to 1st decimal
stdDev = round((num/den)**0.5,1)

print(stdDev)
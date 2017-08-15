## Given an array, X, of N integers, calculate the quartiles. It is guaranteed they integers.

## Input Format
#	The first line contains an integer, N, denoting the number of elements in array X 
#	The second line contains N space-separated integers describing the respective elements of array X. 

## Constraints
# 5 <= N <= 50
# 0 < Xi <= 100, where Xi is the ith element of array X.

##Output Format
# Print the quartiles on their own lines.

# Get inputs
n = int(input());
x = input();

# convert input to INT's
x = [int(x) for x in x.split()];

# sort list
x = sorted(x)

# If number of elements in array is odd
if n % 2 != 0:
  
  # q2/median is the middle element
  q2 = x[(n-1)//2]
  
  # get index to split array down middle
  for i in (i for i,n in enumerate(x) if n == q2):
    splitIndex = i;
  
  # get q1 from 1st half of array
  firstHalf = x[:splitIndex]
  m = len(firstHalf)

  if m % 2 != 0:
    q1 = firstHalf[(m-1)//2]
  else:
    q1 = ((firstHalf[(m//2)-1])+(firstHalf[(m//2)]))//2;

  # get q3 from 2nd half of array
  secondHalf = x[splitIndex+1:]
  o = len(secondHalf)

  if o % 2 != 0:
    q3 = secondHalf[(o-1)//2]
  else:
    q3 = ((secondHalf[(o//2)-1])+(secondHalf[(o//2)]))//2;  

  print(q1)
  print(q2)
  print(q3)
  
# If number of elements in array is even
else:
  
  # median = average of middle 2 elements
  q2 = ((x[(n//2)-1])+(x[(n//2)]))//2;
  
  # split array into 2 equal halves
  splitIndex = n//2;

  # get q1 from 1st half of array
  firstHalf = x[:splitIndex]
  m = len(firstHalf)

  if m % 2 != 0:
    q1 = firstHalf[(m-1)//2]
  else:
    q1 = ((firstHalf[(m//2)-1])+(firstHalf[(m//2)]))//2;

  # get q3 from 2nd half of array
  secondHalf = x[splitIndex:]
  o = len(secondHalf)

  if o % 2 != 0:
    q3 = secondHalf[(o-1)//2]
  else:
    q3 = ((secondHalf[(o//2)-1])+(secondHalf[(o//2)]))//2;  

  print(q1)
  print(q2)
  print(q3)